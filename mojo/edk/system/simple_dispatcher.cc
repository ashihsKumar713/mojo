// Copyright 2013 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/edk/system/simple_dispatcher.h"

#include "base/logging.h"

namespace mojo {
namespace system {

SimpleDispatcher::SimpleDispatcher() {}

SimpleDispatcher::~SimpleDispatcher() {}

void SimpleDispatcher::OnHandleSignalsStateChangeNoLock(
    const HandleSignalsState& old_state,
    const HandleSignalsState& new_state) {
  mutex().AssertHeld();
  awakable_list_.OnStateChange(old_state, new_state);
}

void SimpleDispatcher::CancelAllStateNoLock() {
  mutex().AssertHeld();
  awakable_list_.CancelAndRemoveAll();
}

MojoResult SimpleDispatcher::AddAwakableImplNoLock(
    Awakable* awakable,
    uint64_t context,
    bool persistent,
    MojoHandleSignals signals,
    HandleSignalsState* signals_state) {
  mutex().AssertHeld();

  HandleSignalsState state(GetHandleSignalsStateImplNoLock());
  if (signals_state)
    *signals_state = state;
  if (state.satisfies(signals)) {
    if (persistent)
      awakable_list_.Add(awakable, context, persistent, signals);
    return MOJO_RESULT_ALREADY_EXISTS;
  }
  if (!state.can_satisfy(signals)) {
    if (persistent)
      awakable_list_.Add(awakable, context, persistent, signals);
    return MOJO_RESULT_FAILED_PRECONDITION;
  }

  awakable_list_.Add(awakable, context, persistent, signals);
  return MOJO_RESULT_OK;
}

void SimpleDispatcher::RemoveAwakableImplNoLock(
    bool match_context,
    Awakable* awakable,
    uint64_t context,
    HandleSignalsState* signals_state) {
  mutex().AssertHeld();
  awakable_list_.Remove(match_context, awakable, context);
  if (signals_state)
    *signals_state = GetHandleSignalsStateImplNoLock();
}

}  // namespace system
}  // namespace mojo
