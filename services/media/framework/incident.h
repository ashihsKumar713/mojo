// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_FACTORY_INCIDENT_H_
#define MOJO_SERVICES_MEDIA_FACTORY_INCIDENT_H_

#include <functional>
#include <vector>

namespace mojo {
namespace media {

// The Incident class provides a facility for executing code as the consequence
// of some occurrence. This can be useful for building state machines and
// otherwise dealing with asynchronous operations.
//
// Incident is not a thread-safe class and has no ability to make a thread wait
// or to execute code on a particular thread.
//
// Incidents rely heavily on std::function, so they shouldn't be used in
// enormous numbers.
//
// An Incident can be in one of two states: initial state or occurred state.
//
// Code can be executed when an incident occurs:
//
//     incident.When([]() {
//       // Do something...
//     });
//
// The behavior of the When method depends on the incident's state. In initial
// state, the consequence is added to a list to be executed when the incident
// occurs. In occurred state, When executes the consequence immediately (before
// When returns).
//
// An Incident occurs when its Occur (or Run) method is invoked and the Incident
// is in the initial state. All registered consequences of the Incident are
// executed during the call to Occur in the order they were added. Subsequent
// calls to Occur are ignored until the Incident is reset.
//
// The Reset method ensures that the Incident is in its initial state and that
// the list of consequences is cleared (without running the consequences).
class Incident {
 public:
  Incident();

  ~Incident();

  // Determines if this Incident has occurred due to a past call to Occur.
  bool occurred() { return occurred_; }

  // Executes the consequence when this Incident occurs. If this Incident hasn't
  // occurred when this method is called, a copy of the consequence is held
  // until this Incident occurs or is reset. If this Incident has occurred when
  // this method is called, the consequence is executed immediately and no copy
  // of the consequence is held.
  void When(const std::function<void()>& consequence) {
    if (occurred_) {
      consequence();
    } else {
      consequences_.push_back(consequence);
    }
  }

  // If this Incident is in inital state (!occurred()), this method makes this
  // Incident occur, executing and deleting all its consequences. Otherwise,
  // does nothing.
  void Occur();

  // Resets this Incident to initial state and clears the list of consequences.
  void Reset() {
    occurred_ = false;
    consequences_.clear();
  }

  // Calls Occur. This method makes an Incident convertible to
  // mojo::Callback<void()>.
  void Run() { Occur(); }

 private:
  bool occurred_ = false;
  std::vector<std::function<void()>> consequences_;
};

}  // namespace media
}  // namespace mojo

#endif  // MOJO_SERVICES_MEDIA_FACTORY_EVENT_H_