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

WaitSetDispatcher::Entry::Entry(RefPtr<Dispatcher>&& dispatcher,
                                MojoHandleSignals signals,
                                uint64_t cookie)
    : dispatcher(std::move(dispatcher)), signals(signals), cookie(cookie) {}

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
  triggered_head_ = nullptr;
  triggered_tail_ = nullptr;
  triggered_count_ = 0u;

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
      entry->dispatcher->RemoveAwakable(true, this, entry->cookie, nullptr);
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
  // This will be owned by |entries_|, so it should only be used under
  // |mutex()|.
  Entry* entry = nullptr;
  {
    MutexLocker locker(&mutex());
    if (is_closed_no_lock())
      return MOJO_RESULT_INVALID_ARGUMENT;
    MojoWaitSetAddOptions validated_options;
    MojoResult result = ValidateWaitSetAddOptions(options, &validated_options);
    if (result != MOJO_RESULT_OK)
      return result;
    if (entries_.find(cookie) != entries_.end())
      return MOJO_RESULT_ALREADY_EXISTS;
    if (entries_.size() >= GetConfiguration().max_wait_set_num_entries)
      return MOJO_RESULT_RESOURCE_EXHAUSTED;
    entry = new Entry(dispatcher.Clone(), signals, cookie);
    entries_[cookie] = std::unique_ptr<Entry>(entry);
  }

  // Note: We can only call into another dispatcher outside the lock. This means
  // that *we* may be closed at any time!

  // We add ourself as a persistent awakable, which means that even if the
  // condition is already satisfied or never-satisfiable we'll still be added.
  MojoResult result =
      dispatcher->AddAwakable(this, cookie, true, signals, nullptr);

  MutexLocker locker(&mutex());

  // Everywhere below, if |entry| is used, its validity must be justified. E.g.,
  // us being closed invalidates |entry|.

  if (is_closed_no_lock()) {
    // WARNING: |entry| is invalid here.

    // We need to remove ourself from the target dispatcher's awakable list.
    // Regardless of |result|, it's OK to just call |RemoveAwakable()|.
    dispatcher->RemoveAwakable(true, this, cookie, nullptr);

    return MOJO_RESULT_INVALID_ARGUMENT;
  }

  // |entry| is valid: Since we weren't closed and the entry is still not marked
  // as ready, nothing should have removed it from |entries_|.
  DCHECK_EQ(entries_[cookie].get(), entry);

  if (result == MOJO_RESULT_INVALID_ARGUMENT) {
    // The target dispatcher was closed, so we weren't added to its awakable
    // list. This means that user code has a race condition in this case. We
    // could try to keep the entry around and signal it as "cancelled", but it's
    // simpler to just say that the target dispatcher was bad in the first
    // place.
    entries_.erase(cookie);
    return MOJO_RESULT_INVALID_ARGUMENT;
  }

  // In all other cases, we were added.
  DCHECK(result == MOJO_RESULT_OK || result == MOJO_RESULT_ALREADY_EXISTS ||
         result == MOJO_RESULT_FAILED_PRECONDITION);

  DCHECK(!entry->ready);
  entry->ready = true;

  return MOJO_RESULT_OK;
}

MojoResult WaitSetDispatcher::WaitSetRemoveImpl(uint64_t cookie) {
  RefPtr<Dispatcher> dispatcher;
  {
    MutexLocker locker(&mutex());
    if (is_closed_no_lock())
      return MOJO_RESULT_INVALID_ARGUMENT;
    auto it = entries_.find(cookie);
    if (it == entries_.end())
      return MOJO_RESULT_NOT_FOUND;

    Entry* entry = it->second.get();
    if (!entry->ready) {
      // |WaitSetAddImpl()| isn't done yet so, as far as user code is concerned,
      // the entry with this cookie hasn't been added yet.
      return MOJO_RESULT_NOT_FOUND;
    }

    // We'll remove ourself from the target dispatcher's awakable list outside
    // the lock.
    dispatcher = std::move(entry->dispatcher);

    if (entry->is_triggered)
      RemoveTriggeredNoLock(entry);

    // Note: This invalidates |entry|.
    entries_.erase(it);
  }

  if (dispatcher)
    dispatcher->RemoveAwakable(true, this, cookie, nullptr);
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

void WaitSetDispatcher::Awake(uint64_t context,
                              AwakeReason reason,
                              const HandleSignalsState& signals_state) {
  MutexLocker locker(&mutex());

  if (is_closed_no_lock()) {
    // See |CloseImplNoLock()|: This case may occur while we're unlocked in
    // |CloseImplNoLock()| (after that, we will have been removed from all the
    // awakable lists, so |Awake()| should no longer be called).
    return;
  }

  auto it = entries_.find(context);
  DCHECK(it != entries_.end());
  const auto& entry = it->second;
  // Once we get "cancelled", we should never be awoken again.
  DCHECK(entry->dispatcher);
  switch (reason) {
    case AwakeReason::CANCELLED:
      if (!entry->is_triggered)
        AddTriggeredNoLock(entry.get());
      entry->dispatcher = nullptr;
      break;
    case AwakeReason::SATISFIED:
    case AwakeReason::UNSATISFIABLE:
      // We shouldn't see these since we're used as a persistent |Awakable|.
      NOTREACHED();
      break;
    case AwakeReason::INITIALIZE:
      DCHECK(entry->signals_state.equals(HandleSignalsState()));
    // Fall through.
    case AwakeReason::CHANGED:
      // Record the state for anyone waiting.
      entry->signals_state = signals_state;
      if (entry->signals_state.satisfies(entry->signals) ||
          !entry->signals_state.can_satisfy(entry->signals)) {
        if (!entry->is_triggered)
          AddTriggeredNoLock(entry.get());
      } else {
        if (entry->is_triggered)
          RemoveTriggeredNoLock(entry.get());
      }
      break;
  }
}

void WaitSetDispatcher::AddTriggeredNoLock(Entry* entry) {
  DCHECK(!entry->is_triggered);
  DCHECK(!entry->triggered_previous);
  DCHECK(!entry->triggered_next);

  entry->is_triggered = true;
  triggered_count_++;

  if (!triggered_tail_) {
    DCHECK(!triggered_head_);
    triggered_head_ = entry;
    triggered_tail_ = entry;
    return;
  }

  Entry* old_tail = triggered_tail_;
  entry->triggered_previous = old_tail;
  DCHECK(!old_tail->triggered_next);
  old_tail->triggered_next = entry;
  triggered_tail_ = entry;
}

void WaitSetDispatcher::RemoveTriggeredNoLock(Entry* entry) {
  DCHECK(entry->is_triggered);
  entry->is_triggered = false;
  triggered_count_--;

  if (!entry->triggered_previous) {
    DCHECK_EQ(entry, triggered_head_);
    triggered_head_ = entry->triggered_next;
  } else {
    entry->triggered_previous->triggered_next = entry->triggered_next;
  }

  if (!entry->triggered_next) {
    DCHECK_EQ(entry, triggered_tail_);
    triggered_tail_ = entry->triggered_previous;
  } else {
    entry->triggered_next->triggered_previous = entry->triggered_previous;
  }

  entry->triggered_previous = nullptr;
  entry->triggered_next = nullptr;
}

}  // namespace system
}  // namespace mojo
