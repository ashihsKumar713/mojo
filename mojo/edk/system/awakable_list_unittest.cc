// Copyright 2013 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// NOTE(vtl): Some of these tests are inherently flaky (e.g., if run on a
// heavily-loaded system). Sorry. |test::EpsilonTimeout()| may be increased to
// increase tolerance and reduce observed flakiness (though doing so reduces the
// meaningfulness of the test).

#include "mojo/edk/system/awakable_list.h"

#include "mojo/edk/platform/thread_utils.h"
#include "mojo/edk/system/handle_signals_state.h"
#include "mojo/edk/system/test/timeouts.h"
#include "mojo/edk/system/waiter.h"
#include "mojo/edk/system/waiter_test_utils.h"
#include "testing/gtest/include/gtest/gtest.h"

using mojo::platform::ThreadSleep;

namespace mojo {
namespace system {
namespace {

TEST(AwakableListTest, BasicCancel) {
  MojoResult result;
  uint64_t context;

  // Cancel immediately after thread start.
  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread(&result, &context);
    awakable_list.Add(thread.waiter(), 1, MOJO_HANDLE_SIGNAL_READABLE);
    thread.Start();
    awakable_list.CancelAll();
    // Double-remove okay:
    awakable_list.Remove(false, thread.waiter(), 0);
  }  // Join |thread|.
  EXPECT_EQ(MOJO_RESULT_CANCELLED, result);
  EXPECT_EQ(1u, context);

  // Cancel before after thread start.
  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread(&result, &context);
    awakable_list.Add(thread.waiter(), 2, MOJO_HANDLE_SIGNAL_WRITABLE);
    awakable_list.CancelAll();
    thread.Start();
  }  // Join |thread|.
  EXPECT_EQ(MOJO_RESULT_CANCELLED, result);
  EXPECT_EQ(2u, context);

  // Cancel some time after thread start.
  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread(&result, &context);
    awakable_list.Add(thread.waiter(), 3, MOJO_HANDLE_SIGNAL_READABLE);
    thread.Start();
    ThreadSleep(2 * test::EpsilonTimeout());
    awakable_list.CancelAll();
  }  // Join |thread|.
  EXPECT_EQ(MOJO_RESULT_CANCELLED, result);
  EXPECT_EQ(3u, context);
}

TEST(AwakableListTest, BasicAwakeSatisfied) {
  MojoResult result;
  uint64_t context;

  // Awake immediately after thread start.
  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread(&result, &context);
    awakable_list.Add(thread.waiter(), 1, MOJO_HANDLE_SIGNAL_READABLE);
    thread.Start();
    awakable_list.OnStateChange(
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_NONE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE),
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_READABLE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE));
    awakable_list.Remove(false, thread.waiter(), 0);
  }  // Join |thread|.
  EXPECT_EQ(MOJO_RESULT_OK, result);
  EXPECT_EQ(1u, context);

  // Awake before after thread start.
  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread(&result, &context);
    awakable_list.Add(thread.waiter(), 2, MOJO_HANDLE_SIGNAL_WRITABLE);
    awakable_list.OnStateChange(
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_NONE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE),
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_WRITABLE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE));
    awakable_list.Remove(false, thread.waiter(), 0);
    // Double-remove okay:
    awakable_list.Remove(false, thread.waiter(), 0);
    thread.Start();
  }  // Join |thread|.
  EXPECT_EQ(MOJO_RESULT_OK, result);
  EXPECT_EQ(2u, context);

  // Awake some time after thread start.
  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread(&result, &context);
    awakable_list.Add(thread.waiter(), 3, MOJO_HANDLE_SIGNAL_READABLE);
    thread.Start();
    ThreadSleep(2 * test::EpsilonTimeout());
    awakable_list.OnStateChange(
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_NONE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE),
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_READABLE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE));
    awakable_list.Remove(false, thread.waiter(), 0);
  }  // Join |thread|.
  EXPECT_EQ(MOJO_RESULT_OK, result);
  EXPECT_EQ(3u, context);
}

TEST(AwakableListTest, BasicAwakeUnsatisfiable) {
  MojoResult result;
  uint64_t context;

  // Awake (for unsatisfiability) immediately after thread start.
  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread(&result, &context);
    awakable_list.Add(thread.waiter(), 1, MOJO_HANDLE_SIGNAL_READABLE);
    thread.Start();
    awakable_list.OnStateChange(
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_NONE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE),
        HandleSignalsState(MOJO_HANDLE_SIGNAL_NONE,
                           MOJO_HANDLE_SIGNAL_WRITABLE));
    awakable_list.Remove(false, thread.waiter(), 0);
  }  // Join |thread|.
  EXPECT_EQ(MOJO_RESULT_FAILED_PRECONDITION, result);
  EXPECT_EQ(1u, context);

  // Awake (for unsatisfiability) before after thread start.
  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread(&result, &context);
    awakable_list.Add(thread.waiter(), 2, MOJO_HANDLE_SIGNAL_WRITABLE);
    awakable_list.OnStateChange(
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_NONE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE),
        HandleSignalsState(MOJO_HANDLE_SIGNAL_READABLE,
                           MOJO_HANDLE_SIGNAL_READABLE));
    awakable_list.Remove(false, thread.waiter(), 0);
    thread.Start();
  }  // Join |thread|.
  EXPECT_EQ(MOJO_RESULT_FAILED_PRECONDITION, result);
  EXPECT_EQ(2u, context);

  // Awake (for unsatisfiability) some time after thread start.
  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread(&result, &context);
    awakable_list.Add(thread.waiter(), 3, MOJO_HANDLE_SIGNAL_READABLE);
    thread.Start();
    ThreadSleep(2 * test::EpsilonTimeout());
    awakable_list.OnStateChange(
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_NONE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE),
        HandleSignalsState(MOJO_HANDLE_SIGNAL_NONE,
                           MOJO_HANDLE_SIGNAL_WRITABLE));
    awakable_list.Remove(false, thread.waiter(), 0);
    // Double-remove okay:
    awakable_list.Remove(false, thread.waiter(), 0);
  }  // Join |thread|.
  EXPECT_EQ(MOJO_RESULT_FAILED_PRECONDITION, result);
  EXPECT_EQ(3u, context);
}

TEST(AwakableListTest, MultipleAwakables) {
  MojoResult result1;
  MojoResult result2;
  MojoResult result3;
  MojoResult result4;
  uint64_t context1;
  uint64_t context2;
  uint64_t context3;
  uint64_t context4;

  // Cancel two awakables.
  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread1(&result1, &context1);
    awakable_list.Add(thread1.waiter(), 1, MOJO_HANDLE_SIGNAL_READABLE);
    thread1.Start();
    test::SimpleWaiterThread thread2(&result2, &context2);
    awakable_list.Add(thread2.waiter(), 2, MOJO_HANDLE_SIGNAL_WRITABLE);
    thread2.Start();
    ThreadSleep(2 * test::EpsilonTimeout());
    awakable_list.CancelAll();
  }  // Join threads.
  EXPECT_EQ(MOJO_RESULT_CANCELLED, result1);
  EXPECT_EQ(1u, context1);
  EXPECT_EQ(MOJO_RESULT_CANCELLED, result2);
  EXPECT_EQ(2u, context2);

  // Awake one awakable, cancel other.
  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread1(&result1, &context1);
    awakable_list.Add(thread1.waiter(), 3, MOJO_HANDLE_SIGNAL_READABLE);
    thread1.Start();
    test::SimpleWaiterThread thread2(&result2, &context2);
    awakable_list.Add(thread2.waiter(), 4, MOJO_HANDLE_SIGNAL_WRITABLE);
    thread2.Start();
    ThreadSleep(2 * test::EpsilonTimeout());
    awakable_list.OnStateChange(
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_NONE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE),
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_READABLE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE));
    awakable_list.Remove(false, thread1.waiter(), 0);
    awakable_list.CancelAll();
  }  // Join threads.
  EXPECT_EQ(MOJO_RESULT_OK, result1);
  EXPECT_EQ(3u, context1);
  EXPECT_EQ(MOJO_RESULT_CANCELLED, result2);
  EXPECT_EQ(4u, context2);

  // Cancel one awakable, awake other for unsatisfiability.
  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread1(&result1, &context1);
    awakable_list.Add(thread1.waiter(), 5, MOJO_HANDLE_SIGNAL_READABLE);
    thread1.Start();
    test::SimpleWaiterThread thread2(&result2, &context2);
    awakable_list.Add(thread2.waiter(), 6, MOJO_HANDLE_SIGNAL_WRITABLE);
    thread2.Start();
    ThreadSleep(2 * test::EpsilonTimeout());
    awakable_list.OnStateChange(
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_NONE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE),
        HandleSignalsState(MOJO_HANDLE_SIGNAL_NONE,
                           MOJO_HANDLE_SIGNAL_READABLE));
    awakable_list.Remove(false, thread2.waiter(), 0);
    awakable_list.CancelAll();
  }  // Join threads.
  EXPECT_EQ(MOJO_RESULT_CANCELLED, result1);
  EXPECT_EQ(5u, context1);
  EXPECT_EQ(MOJO_RESULT_FAILED_PRECONDITION, result2);
  EXPECT_EQ(6u, context2);

  // Cancel one awakable, awake other for unsatisfiability.
  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread1(&result1, &context1);
    awakable_list.Add(thread1.waiter(), 7, MOJO_HANDLE_SIGNAL_READABLE);
    thread1.Start();

    ThreadSleep(1 * test::EpsilonTimeout());

    // Should do nothing.
    awakable_list.OnStateChange(
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_NONE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE),
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_NONE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE));

    test::SimpleWaiterThread thread2(&result2, &context2);
    awakable_list.Add(thread2.waiter(), 8, MOJO_HANDLE_SIGNAL_WRITABLE);
    thread2.Start();

    ThreadSleep(1 * test::EpsilonTimeout());

    // Awake #1.
    awakable_list.OnStateChange(
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_NONE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE),
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_READABLE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE));
    awakable_list.Remove(false, thread1.waiter(), 0);

    ThreadSleep(1 * test::EpsilonTimeout());

    test::SimpleWaiterThread thread3(&result3, &context3);
    awakable_list.Add(thread3.waiter(), 9, MOJO_HANDLE_SIGNAL_WRITABLE);
    thread3.Start();

    test::SimpleWaiterThread thread4(&result4, &context4);
    awakable_list.Add(thread4.waiter(), 10, MOJO_HANDLE_SIGNAL_READABLE);
    thread4.Start();

    ThreadSleep(1 * test::EpsilonTimeout());

    // Awake #2 and #3 for unsatisfiability.
    awakable_list.OnStateChange(
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_NONE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE),
        HandleSignalsState(MOJO_HANDLE_SIGNAL_NONE,
                           MOJO_HANDLE_SIGNAL_READABLE));
    awakable_list.Remove(false, thread2.waiter(), 0);
    awakable_list.Remove(false, thread3.waiter(), 0);

    // Cancel #4.
    awakable_list.CancelAll();
  }  // Join threads.
  EXPECT_EQ(MOJO_RESULT_OK, result1);
  EXPECT_EQ(7u, context1);
  EXPECT_EQ(MOJO_RESULT_FAILED_PRECONDITION, result2);
  EXPECT_EQ(8u, context2);
  EXPECT_EQ(MOJO_RESULT_FAILED_PRECONDITION, result3);
  EXPECT_EQ(9u, context3);
  EXPECT_EQ(MOJO_RESULT_CANCELLED, result4);
  EXPECT_EQ(10u, context4);
}

TEST(AwakableListTest, RemoveMatchContext) {
  MojoResult result;
  uint64_t context;

  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread(&result, &context);
    awakable_list.Add(thread.waiter(), 1, MOJO_HANDLE_SIGNAL_READABLE);
    awakable_list.Add(thread.waiter(), 2, MOJO_HANDLE_SIGNAL_READABLE);
    thread.Start();
    awakable_list.Remove(true, thread.waiter(), 2);
    awakable_list.OnStateChange(
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_NONE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE),
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_READABLE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE));
    awakable_list.Remove(true, thread.waiter(), 1);
    // Double-remove okay:
    awakable_list.Remove(true, thread.waiter(), 1);
  }  // Join |thread|.
  EXPECT_EQ(MOJO_RESULT_OK, result);
  EXPECT_EQ(1u, context);

  // Try the same thing, but remove "1" before the awake instead.
  {
    AwakableList awakable_list;
    test::SimpleWaiterThread thread(&result, &context);
    awakable_list.Add(thread.waiter(), 1, MOJO_HANDLE_SIGNAL_READABLE);
    awakable_list.Add(thread.waiter(), 2, MOJO_HANDLE_SIGNAL_READABLE);
    thread.Start();
    awakable_list.Remove(true, thread.waiter(), 1);
    awakable_list.OnStateChange(
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_NONE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE),
        HandleSignalsState(
            MOJO_HANDLE_SIGNAL_READABLE,
            MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE));
    awakable_list.Remove(true, thread.waiter(), 2);
  }  // Join |thread|.
  EXPECT_EQ(MOJO_RESULT_OK, result);
  EXPECT_EQ(2u, context);
}

class KeepAwakable : public Awakable {
 public:
  KeepAwakable() : awake_count(0) {}

  bool Awake(uint64_t context,
             AwakeReason reason,
             const HandleSignalsState& signals_state) override {
    awake_count++;
    return true;
  }

  int awake_count;

  MOJO_DISALLOW_COPY_AND_ASSIGN(KeepAwakable);
};

class RemoveAwakable : public Awakable {
 public:
  RemoveAwakable() : awake_count(0) {}

  bool Awake(uint64_t /*context*/,
             AwakeReason /*reason*/,
             const HandleSignalsState& /*signals_state*/) override {
    awake_count++;
    return false;
  }

  int awake_count;

  MOJO_DISALLOW_COPY_AND_ASSIGN(RemoveAwakable);
};

TEST(AwakableListTest, KeepAwakablesReturningTrue) {
  KeepAwakable keep0;
  KeepAwakable keep1;
  RemoveAwakable remove0;
  RemoveAwakable remove1;
  RemoveAwakable remove2;

  AwakableList remove_all;
  remove_all.Add(&remove0, 0, MOJO_HANDLE_SIGNAL_WRITABLE);
  remove_all.Add(&remove1, 0, MOJO_HANDLE_SIGNAL_WRITABLE);

  remove_all.OnStateChange(
      HandleSignalsState(MOJO_HANDLE_SIGNAL_NONE, MOJO_HANDLE_SIGNAL_WRITABLE),
      HandleSignalsState(MOJO_HANDLE_SIGNAL_WRITABLE,
                         MOJO_HANDLE_SIGNAL_WRITABLE));
  EXPECT_EQ(remove0.awake_count, 1);
  EXPECT_EQ(remove1.awake_count, 1);

  remove_all.OnStateChange(
      HandleSignalsState(MOJO_HANDLE_SIGNAL_NONE, MOJO_HANDLE_SIGNAL_WRITABLE),
      HandleSignalsState(MOJO_HANDLE_SIGNAL_WRITABLE,
                         MOJO_HANDLE_SIGNAL_WRITABLE));
  EXPECT_EQ(remove0.awake_count, 1);
  EXPECT_EQ(remove1.awake_count, 1);

  AwakableList remove_first;
  remove_first.Add(&remove2, 0, MOJO_HANDLE_SIGNAL_WRITABLE);
  remove_first.Add(&keep0, 0, MOJO_HANDLE_SIGNAL_WRITABLE);
  remove_first.Add(&keep1, 0, MOJO_HANDLE_SIGNAL_WRITABLE);

  remove_first.OnStateChange(
      HandleSignalsState(MOJO_HANDLE_SIGNAL_NONE, MOJO_HANDLE_SIGNAL_WRITABLE),
      HandleSignalsState(MOJO_HANDLE_SIGNAL_WRITABLE,
                         MOJO_HANDLE_SIGNAL_WRITABLE));
  EXPECT_EQ(keep0.awake_count, 1);
  EXPECT_EQ(keep1.awake_count, 1);
  EXPECT_EQ(remove2.awake_count, 1);

  remove_first.OnStateChange(
      HandleSignalsState(MOJO_HANDLE_SIGNAL_NONE, MOJO_HANDLE_SIGNAL_WRITABLE),
      HandleSignalsState(MOJO_HANDLE_SIGNAL_WRITABLE,
                         MOJO_HANDLE_SIGNAL_WRITABLE));
  EXPECT_EQ(keep0.awake_count, 2);
  EXPECT_EQ(keep1.awake_count, 2);
  EXPECT_EQ(remove2.awake_count, 1);

  remove_first.Remove(false, &keep0, 0);
  remove_first.Remove(false, &keep1, 0);
}

}  // namespace
}  // namespace system
}  // namespace mojo
