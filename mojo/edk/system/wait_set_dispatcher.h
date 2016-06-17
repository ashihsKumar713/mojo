// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_EDK_SYSTEM_WAIT_SET_DISPATCHER_H_
#define MOJO_EDK_SYSTEM_WAIT_SET_DISPATCHER_H_

#include <map>
#include <memory>

#include "mojo/edk/system/awakable.h"
#include "mojo/edk/system/dispatcher.h"
#include "mojo/edk/util/ref_ptr.h"
#include "mojo/edk/util/thread_annotations.h"
#include "mojo/public/cpp/system/macros.h"

namespace mojo {
namespace system {

// This is the |Dispatcher| implementation for wait sets (created by the Mojo
// primitive |MojoCreateWaitSet()|). This class is thread-safe.
// TODO(vtl): We rely on |Dispatcher| itself never acquiring any other mutex
// under |mutex()|. We should specify (and double-check) this requirement.
class WaitSetDispatcher final : public Dispatcher, public Awakable {
 public:
  // The default/standard rights for a wait set handle. Note that they are not
  // transferrable.
  // TODO(vtl): Figure out if these are the correct rights. (E.g., we currently
  // don't have get/set options functions ... but maybe we should?)
  static constexpr MojoHandleRights kDefaultHandleRights =
      MOJO_HANDLE_RIGHT_READ | MOJO_HANDLE_RIGHT_WRITE |
      MOJO_HANDLE_RIGHT_GET_OPTIONS | MOJO_HANDLE_RIGHT_SET_OPTIONS;

  // The default options to use for |MojoCreateWaitSet()|. (Real uses should
  // obtain this via |ValidateCreateOptions()| with a null |in_options|; this is
  // exposed directly for testing convenience.)
  static const MojoCreateWaitSetOptions kDefaultCreateOptions;

  // Validates and/or sets default options for |MojoCreateWaitSetOptions|. If
  // non-null, |in_options| must point to a struct of at least
  // |in_options->struct_size| bytes. |out_options| must point to a (current)
  // |MojoCreateWaitSetOptions| and will be entirely overwritten on success (it
  // may be partly overwritten on failure).
  static MojoResult ValidateCreateOptions(
      UserPointer<const MojoCreateWaitSetOptions> in_options,
      MojoCreateWaitSetOptions* out_options);

  // Like |ValidateCreateOptions()|, but for |MojoWaitSetAddOptions|.
  static MojoResult ValidateWaitSetAddOptions(
      UserPointer<const MojoWaitSetAddOptions> in_options,
      MojoWaitSetAddOptions* out_options);

  static util::RefPtr<WaitSetDispatcher> Create(
      const MojoCreateWaitSetOptions& /*validated_options*/) {
    return AdoptRef(new WaitSetDispatcher());
  }

  // |Dispatcher| public methods:
  Type GetType() const override;
  bool SupportsEntrypointClass(EntrypointClass entrypoint_class) const override;

 private:
  // Represents an entry in the wait set.
  struct Entry {
    enum class TriggerState {
      NOT_TRIGGERED,
      POSSIBLY_SATISFIED,
      NEVER_SATISFIABLE,
      CLOSED
    };

    Entry(MojoHandleSignals signals, uint64_t cookie);
    ~Entry();

    const MojoHandleSignals signals;
    const uint64_t cookie;
    // There are two cases when |dispatcher| is null for an |Entry| in
    // |WaitSetDispatcher::entries_|:
    //   - The wait set was closed in the middle of |WaitSetAddImpl()|;
    //     |entries_| will be cleared out on closing, but |WaitSetAddImpl()|
    //     must detect this and actually remove the dispatcher (which only it
    //     knows about) from the "target" dispatcher's awakable list.
    //   - It's an entry whose dispatcher was closed.
    util::RefPtr<Dispatcher> dispatcher;
    TriggerState trigger_state = TriggerState::NOT_TRIGGERED;

    // Only meaningful if |trigger_state| is not |TriggerState::NOT_TRIGGERED|.
    // This is used to maintain a doubly linked list of entries that are
    // possibly satisfied. |possibly_triggered_previous| and
    // |possibly_triggered_next| are null if |this| is equal to
    // |WaitSetDispatcher::possibly_triggered_head_| and
    // |...::possibly_triggered_tail_|, respectively.
    Entry* possibly_triggered_previous = nullptr;
    Entry* possibly_triggered_next = nullptr;
  };

  WaitSetDispatcher();
  ~WaitSetDispatcher() override;

  // |Dispatcher| protected methods:
  void CloseImplNoLock() override;
  util::RefPtr<Dispatcher> CreateEquivalentDispatcherAndCloseImplNoLock(
      MessagePipe* message_pipe,
      unsigned port) override;
  MojoResult WaitSetAddImpl(UserPointer<const MojoWaitSetAddOptions> options,
                            util::RefPtr<Dispatcher>&& dispatcher,
                            MojoHandleSignals signals,
                            uint64_t cookie) override;
  MojoResult WaitSetRemoveImpl(uint64_t cookie) override;
  MojoResult WaitSetWaitImpl(MojoDeadline deadline,
                             UserPointer<uint32_t> num_results,
                             UserPointer<MojoWaitSetResult> results,
                             UserPointer<uint32_t> max_results) override;

  // |Awakable| implementation:
  bool Awake(MojoResult result, uint64_t context) override;

  void AddPossiblyTriggeredNoLock(Entry* entry,
                                  Entry::TriggerState new_trigger_state)
      MOJO_EXCLUSIVE_LOCKS_REQUIRED(mutex());
  void RemovePossiblyTriggeredNoLock(Entry* entry)
      MOJO_EXCLUSIVE_LOCKS_REQUIRED(mutex());

  // Set when in the middle of a wait set operation (i.e., |WaitSet...Impl()|)
  // with |mutex()| *unlocked*; if attempted (on a different thread), other wait
  // set operations should report "busy". Note: Even if |is_busy_| is true, the
  // wait set may still be closed.
  bool is_busy_ MOJO_GUARDED_BY(mutex()) = false;

  // Map of cookies to entries.
  using CookieToEntryMap = std::map<uint64_t, std::unique_ptr<Entry>>;
  CookieToEntryMap entries_ MOJO_GUARDED_BY(mutex());

  // Intrusive "doubly linked list" (via cookies) of entries that are possibly
  // satisfied.
  Entry* possibly_triggered_head_ MOJO_GUARDED_BY(mutex()) = nullptr;
  Entry* possibly_triggered_tail_ MOJO_GUARDED_BY(mutex()) = nullptr;
  // Size of the above list.
  size_t possibly_triggered_count_ MOJO_GUARDED_BY(mutex()) = 0u;

  MOJO_DISALLOW_COPY_AND_ASSIGN(WaitSetDispatcher);
};

}  // namespace system
}  // namespace mojo

#endif  // MOJO_EDK_SYSTEM_WAIT_SET_DISPATCHER_H_
