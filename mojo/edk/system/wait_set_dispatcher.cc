// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/edk/system/wait_set_dispatcher.h"

#include <utility>

#include "base/logging.h"
#include "mojo/edk/system/configuration.h"
#include "mojo/edk/system/options_validation.h"

using mojo::util::MutexLocker;
using mojo::util::RefPtr;

namespace mojo {
namespace system {

WaitSetDispatcher::Entry::Entry(MojoHandleSignals signals, uint64_t cookie)
    : signals(signals), cookie(cookie) {}

WaitSetDispatcher::Entry::~Entry() {}

// static
constexpr MojoHandleRights WaitSetDispatcher::kDefaultHandleRights;

// static
const MojoCreateWaitSetOptions WaitSetDispatcher::kDefaultCreateOptions = {
    static_cast<uint32_t>(sizeof(MojoCreateWaitSetOptions)),
    MOJO_CREATE_WAIT_SET_OPTIONS_FLAG_NONE};

// static
MojoResult WaitSetDispatcher::ValidateCreateOptions(
    UserPointer<const MojoCreateWaitSetOptions> in_options,
    MojoCreateWaitSetOptions* out_options) {
  const MojoCreateWaitSetOptionsFlags kKnownFlags =
      MOJO_CREATE_WAIT_SET_OPTIONS_FLAG_NONE;

  *out_options = kDefaultCreateOptions;
  if (in_options.IsNull())
    return MOJO_RESULT_OK;

  UserOptionsReader<MojoCreateWaitSetOptions> reader(in_options);
  if (!reader.is_valid())
    return MOJO_RESULT_INVALID_ARGUMENT;

  if (!OPTIONS_STRUCT_HAS_MEMBER(MojoCreateWaitSetOptions, flags, reader))
    return MOJO_RESULT_OK;
  if ((reader.options().flags & ~kKnownFlags))
    return MOJO_RESULT_UNIMPLEMENTED;
  out_options->flags = reader.options().flags;

  // Checks for fields beyond |flags|:

  // (Nothing here yet.)

  return MOJO_RESULT_OK;
}

// static
MojoResult WaitSetDispatcher::ValidateWaitSetAddOptions(
    UserPointer<const MojoWaitSetAddOptions> in_options,
    MojoWaitSetAddOptions* out_options) {
  const MojoWaitSetAddOptionsFlags kKnownFlags =
      MOJO_WAIT_SET_ADD_OPTIONS_FLAG_NONE;
  static const MojoWaitSetAddOptions kDefaultOptions = {
      static_cast<uint32_t>(sizeof(MojoWaitSetAddOptions)),
      MOJO_WAIT_SET_ADD_OPTIONS_FLAG_NONE};

  *out_options = kDefaultOptions;
  if (in_options.IsNull())
    return MOJO_RESULT_OK;

  UserOptionsReader<MojoWaitSetAddOptions> reader(in_options);
  if (!reader.is_valid())
    return MOJO_RESULT_INVALID_ARGUMENT;

  if (!OPTIONS_STRUCT_HAS_MEMBER(MojoWaitSetAddOptions, flags, reader))
    return MOJO_RESULT_OK;
  if ((reader.options().flags & ~kKnownFlags))
    return MOJO_RESULT_UNIMPLEMENTED;
  out_options->flags = reader.options().flags;

  // Checks for fields beyond |flags|:

  // (Nothing here yet.)

  return MOJO_RESULT_OK;
}

Dispatcher::Type WaitSetDispatcher::GetType() const {
  return Type::WAIT_SET;
}

bool WaitSetDispatcher::SupportsEntrypointClass(
    EntrypointClass entrypoint_class) const {
  return (entrypoint_class == EntrypointClass::NONE ||
          entrypoint_class == EntrypointClass::WAIT_SET);
}

WaitSetDispatcher::WaitSetDispatcher() {}

WaitSetDispatcher::~WaitSetDispatcher() {}

void WaitSetDispatcher::CloseImplNoLock() {
  mutex().AssertHeld();

  CookieToEntryMap entries;
  std::swap(entries_, entries);
  possibly_triggered_head_ = nullptr;
  possibly_triggered_tail_ = nullptr;
  possibly_triggered_count_ = 0u;

  // We want to remove the awakables outside the lock, so we have to unlock
  // |mutex()|. Note that while unlocked, |Awake()| may get called.
  // TODO(vtl): This is pretty terrible, but changing it would require pretty
  // invasive changes in many other places. We really count on |Dispatcher| not
  // doing anything interesting after calling |CloseImplNoLock()|, and since
  // |CloseImplNoLock()| is allowed to do nothing all the lock invariants are
  // satisfied.
  DCHECK(is_closed_no_lock());
  mutex().Unlock();

  for (auto& p : entries) {
    const auto& entry = p.second;
    if (entry->dispatcher)
      entry->dispatcher->RemoveAwakableWithContext(this, entry->cookie,
                                                   nullptr);
  }

  // The caller of |CloseImplNoLock()| expects |mutex()| to be locked, so we
  // have to re-lock it (even though it really should do nothing afterwards).
  mutex().Lock();
}

RefPtr<Dispatcher>
WaitSetDispatcher::CreateEquivalentDispatcherAndCloseImplNoLock(
    MessagePipe* /*message_pipe*/,
    unsigned /*port*/) {
  mutex().AssertHeld();
  NOTREACHED();
  return nullptr;
}

MojoResult WaitSetDispatcher::WaitSetAddImpl(
    UserPointer<const MojoWaitSetAddOptions> options,
    RefPtr<Dispatcher>&& dispatcher,
    MojoHandleSignals signals,
    uint64_t cookie) {
  Entry* entry = nullptr;
  {
    MutexLocker locker(&mutex());
    if (is_closed_no_lock())
      return MOJO_RESULT_INVALID_ARGUMENT;
    if (is_busy_)
      return MOJO_RESULT_BUSY;
    MojoWaitSetAddOptions validated_options;
    MojoResult result = ValidateWaitSetAddOptions(options, &validated_options);
    if (result != MOJO_RESULT_OK)
      return result;
    if (entries_.find(cookie) != entries_.end())
      return MOJO_RESULT_ALREADY_EXISTS;
    if (entries_.size() >= GetConfiguration().max_wait_set_num_entries)
      return MOJO_RESULT_RESOURCE_EXHAUSTED;
    // Note: We'll have to set the entry's dispatcher later.
    entry = new Entry(signals, cookie);
    entries_[cookie] = std::unique_ptr<Entry>(entry);

    is_busy_ = true;
  }

  HandleSignalsState signals_state;
  MojoResult result = dispatcher->AddAwakableUnconditional(
      this, signals, cookie, &signals_state);

  // Can't use |MutexLocker|, since we need to do some work outside the lock
  // in some code paths.
  mutex().Lock();
  DCHECK(is_busy_);
  is_busy_ = false;

  // Note: We may have been closed while |mutex()| was unlocked, so we have to
  // check again!
  if (is_closed_no_lock()) {
    // Warning: In this case, |entry| has been invalidated, since it was owned
    // by |entries_|.
    DCHECK(entries_.empty());
    mutex().Unlock();
    if (result == MOJO_RESULT_OK || result == MOJO_RESULT_ALREADY_EXISTS) {
      // We have to remove ourself from the target dispatcher's awakable list.
      dispatcher->RemoveAwakableWithContext(this, cookie, nullptr);
    }
    return MOJO_RESULT_INVALID_ARGUMENT;
  }

  DCHECK(entries_.find(cookie) != entries_.end());
  DCHECK_EQ(entries_[cookie].get(), entry);

  if (result == MOJO_RESULT_ALREADY_EXISTS) {
    // It was added, but the wait condition is already satisfied.
    AddPossiblyTriggeredNoLock(entry, Entry::TriggerState::POSSIBLY_SATISFIED);
  } else if (result == MOJO_RESULT_FAILED_PRECONDITION) {
    // The condition is never-satisfiable. Leave a zombie entry (i.e., leave
    // |dispatcher| null).
    mutex().Unlock();
    return MOJO_RESULT_OK;
  } else if (result != MOJO_RESULT_OK) {
    size_t num_erased = entries_.erase(cookie);
    DCHECK_EQ(num_erased, 1u);
    mutex().Unlock();
    return result;
  }

  // Update the entry to actually have the dispatcher.
  entry->dispatcher = std::move(dispatcher);

  mutex().Unlock();
  return MOJO_RESULT_OK;
}

MojoResult WaitSetDispatcher::WaitSetRemoveImpl(uint64_t cookie) {
  RefPtr<Dispatcher> dispatcher;
  {
    MutexLocker locker(&mutex());
    if (is_closed_no_lock())
      return MOJO_RESULT_INVALID_ARGUMENT;
    if (is_busy_)
      return MOJO_RESULT_BUSY;
    auto it = entries_.find(cookie);
    if (it == entries_.end())
      return MOJO_RESULT_NOT_FOUND;

    Entry* entry = it->second.get();
    // We'll remove ourself from the target dispatcher's awakable list outside
    // the lock.
    dispatcher = std::move(entry->dispatcher);

    if (entry->trigger_state != Entry::TriggerState::NOT_TRIGGERED)
      RemovePossiblyTriggeredNoLock(entry);

    // Note: This invalidates |entry|.
    entries_.erase(it);
  }

  if (dispatcher)
    dispatcher->RemoveAwakableWithContext(this, cookie, nullptr);
  return MOJO_RESULT_OK;
}

MojoResult WaitSetDispatcher::WaitSetWaitImpl(
    MojoDeadline deadline,
    UserPointer<uint32_t> num_results,
    UserPointer<MojoWaitSetResult> results,
    UserPointer<uint32_t> max_results) {
  MutexLocker locker(&mutex());
  if (is_closed_no_lock())
    return MOJO_RESULT_INVALID_ARGUMENT;

  // TODO(vtl)
  NOTIMPLEMENTED();
  return MOJO_RESULT_UNIMPLEMENTED;
}

bool WaitSetDispatcher::Awake(uint64_t context,
                              AwakeReason reason,
                              const HandleSignalsState& signals_state) {
  MutexLocker locker(&mutex());

  if (is_closed_no_lock()) {
    // See |CloseImplNoLock()|: This case may occur while we're unlocked in
    // |CloseImplNoLock()| (after that, we will have been removed from all the
    // awakable lists, so |Awake()| should no longer be called). We may as well
    // return false here, which will automatically remove ourselves from the
    // awakable list (|CloseImplNoLock()| will call
    // |RemoveAwakableWithContext()| anyway, but that's OK).
    return false;
  }

  auto it = entries_.find(context);
  DCHECK(it != entries_.end());
  const auto& entry = it->second;
  switch (reason) {
    case AwakeReason::SATISFIED:
      if (entry->trigger_state == Entry::TriggerState::NOT_TRIGGERED) {
        AddPossiblyTriggeredNoLock(entry.get(),
                                   Entry::TriggerState::POSSIBLY_SATISFIED);
      }
      return true;
    case AwakeReason::UNSATISFIABLE:
      // Never satisfiable.
      if (entry->trigger_state == Entry::TriggerState::NOT_TRIGGERED) {
        AddPossiblyTriggeredNoLock(entry.get(),
                                   Entry::TriggerState::NEVER_SATISFIABLE);
      } else {
        if (entry->trigger_state == Entry::TriggerState::POSSIBLY_SATISFIED) {
          entry->trigger_state = Entry::TriggerState::NEVER_SATISFIABLE;
        } else {
          // It's possible to get repeated "never satisfiable" triggers, but we
          // shouldn't get anything after "closed".
          DCHECK_NE(static_cast<int>(entry->trigger_state),
                    static_cast<int>(Entry::TriggerState::CLOSED));
        }
      }
      // Due to some action on some other thread, it may become satisfiable
      // again, so continue to be awoken.
      return true;
    case AwakeReason::CANCELLED:
      if (entry->trigger_state == Entry::TriggerState::NOT_TRIGGERED) {
        AddPossiblyTriggeredNoLock(entry.get(), Entry::TriggerState::CLOSED);
      } else {
        // We should only ever get at most one "closed".
        DCHECK_NE(static_cast<int>(entry->trigger_state),
                  static_cast<int>(Entry::TriggerState::CLOSED));
        entry->trigger_state = Entry::TriggerState::CLOSED;
      }
      entry->dispatcher = nullptr;
      return false;
  }
  return false;
}

void WaitSetDispatcher::AddPossiblyTriggeredNoLock(
    Entry* entry,
    Entry::TriggerState new_trigger_state) {
  DCHECK_EQ(static_cast<int>(entry->trigger_state),
            static_cast<int>(Entry::TriggerState::NOT_TRIGGERED));
  DCHECK(!entry->possibly_triggered_previous);
  DCHECK(!entry->possibly_triggered_next);
  DCHECK_NE(static_cast<int>(new_trigger_state),
            static_cast<int>(Entry::TriggerState::NOT_TRIGGERED));

  entry->trigger_state = new_trigger_state;
  possibly_triggered_count_++;

  if (!possibly_triggered_tail_) {
    DCHECK(!possibly_triggered_head_);
    possibly_triggered_head_ = entry;
    possibly_triggered_tail_ = entry;
    return;
  }

  Entry* old_tail = possibly_triggered_tail_;
  entry->possibly_triggered_previous = old_tail;
  DCHECK(!old_tail->possibly_triggered_next);
  old_tail->possibly_triggered_next = entry;
  possibly_triggered_tail_ = entry;
}

void WaitSetDispatcher::RemovePossiblyTriggeredNoLock(Entry* entry) {
  DCHECK_NE(static_cast<int>(entry->trigger_state),
            static_cast<int>(Entry::TriggerState::NOT_TRIGGERED));
  entry->trigger_state = Entry::TriggerState::NOT_TRIGGERED;
  possibly_triggered_count_--;

  if (!entry->possibly_triggered_previous) {
    DCHECK_EQ(entry, possibly_triggered_head_);
    possibly_triggered_head_ = entry->possibly_triggered_next;
  } else {
    entry->possibly_triggered_previous->possibly_triggered_next =
        entry->possibly_triggered_next;
  }

  if (!entry->possibly_triggered_next) {
    DCHECK_EQ(entry, possibly_triggered_tail_);
    possibly_triggered_tail_ = entry->possibly_triggered_previous;
  } else {
    entry->possibly_triggered_next->possibly_triggered_previous =
        entry->possibly_triggered_previous;
  }

  entry->possibly_triggered_previous = nullptr;
  entry->possibly_triggered_next = nullptr;
}

}  // namespace system
}  // namespace mojo
