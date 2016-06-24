// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// NOTE(vtl): Some of these tests are inherently flaky (e.g., if run on a
// heavily-loaded system). Sorry. |test::EpsilonTimeout()| may be increased to
// increase tolerance and reduce observed flakiness (though doing so reduces the
// meaningfulness of the test).

#include "mojo/edk/system/wait_set_dispatcher.h"

#include <thread>

#include "mojo/edk/platform/test_stopwatch.h"
#include "mojo/edk/platform/thread_utils.h"
#include "mojo/edk/system/mock_simple_dispatcher.h"
#include "mojo/edk/system/test/timeouts.h"
#include "testing/gtest/include/gtest/gtest.h"

using mojo::platform::test::Stopwatch;
using mojo::platform::ThreadSleep;
using mojo::util::MakeRefCounted;

namespace mojo {
namespace system {
namespace {

// Helper to check if an array of |MojoWaitSetResult|s has a result |r| for the
// given cookie, in which case:
//    - |r.wait_result| must equal |wait_result|.
//    - If |wait_result| is |MOJO_RESULT_OK| or
//      |MOJO_RESULT_FAILED_PRECONDITION|, then
//        - |r.signals_state.satisfied_signals & signals| must equal
//          |signals_state.satisfied_signals & signals|, and
//        - |r.signals_state.satisfiable & signals| must equal
//          |signals_state.satisfiable_signals & signals|.
//    - Otherwise, |r.signals_state| must equals |signals_state|.
// (This doesn't check that the result is unique; you should check |num_results|
// versus the expect number and exhaustively check every expected result.)
bool CheckHasResult(uint32_t num_results,
                    const MojoWaitSetResult* results,
                    uint64_t cookie,
                    MojoHandleSignals signals,
                    MojoResult wait_result,
                    const MojoHandleSignalsState& signals_state) {
  for (uint32_t i = 0; i < num_results; i++) {
    if (results[i].cookie == cookie) {
      EXPECT_EQ(wait_result, results[i].wait_result) << cookie;
      EXPECT_EQ(0u, results[i].reserved) << cookie;
      if (wait_result == MOJO_RESULT_OK ||
          wait_result == MOJO_RESULT_FAILED_PRECONDITION) {
        EXPECT_EQ(signals_state.satisfied_signals & signals,
                  results[i].signals_state.satisfied_signals & signals)
            << cookie;
        EXPECT_EQ(signals_state.satisfiable_signals & signals,
                  results[i].signals_state.satisfiable_signals & signals)
            << cookie;
      } else {
        EXPECT_EQ(signals_state.satisfied_signals,
                  results[i].signals_state.satisfied_signals)
            << cookie;
        EXPECT_EQ(signals_state.satisfiable_signals,
                  results[i].signals_state.satisfiable_signals)
            << cookie;
      }
      return true;
    }
  }
  return false;
}

TEST(WaitSetDispatcherTest, Basic) {
  static constexpr auto kR = MOJO_HANDLE_SIGNAL_READABLE;
  static constexpr auto kW = MOJO_HANDLE_SIGNAL_WRITABLE;

  static constexpr auto kIndefinite = MOJO_DEADLINE_INDEFINITE;
  static constexpr auto k10ms = static_cast<MojoDeadline>(10 * 1000u);

  auto d = WaitSetDispatcher::Create(WaitSetDispatcher::kDefaultCreateOptions);

  // These will be members of our wait set.
  auto d_member0 = MakeRefCounted<test::MockSimpleDispatcher>(kW, kR | kW);
  auto d_member1 = MakeRefCounted<test::MockSimpleDispatcher>(kR, kR);

  // Add |d_member0|, for something not satisfied, but satisfiable.
  static constexpr uint64_t kCookie0 = 0x123456789abcdef0ULL;
  static constexpr auto kSignals0 = kR;
  EXPECT_EQ(MOJO_RESULT_OK, d->WaitSetAdd(NullUserPointer(), d_member0.Clone(),
                                          kSignals0, kCookie0));

  // Add |d_member1|, for something satisfied.
  static constexpr uint64_t kCookie1 = 0x23456789abcdef01ULL;
  static constexpr auto kSignals1 = kR;
  EXPECT_EQ(MOJO_RESULT_OK, d->WaitSetAdd(NullUserPointer(), d_member1.Clone(),
                                          kSignals1, kCookie1));

  // Can add |d_member0| again (satisfied), with a different cookie.
  static constexpr uint64_t kCookie2 = 0x3456789abcdef012ULL;
  static constexpr auto kSignals2 = kW;
  EXPECT_EQ(MOJO_RESULT_OK, d->WaitSetAdd(NullUserPointer(), d_member0.Clone(),
                                          kSignals2, kCookie2));

  // Adding something with the same cookie yields "already exists".
  EXPECT_EQ(MOJO_RESULT_ALREADY_EXISTS,
            d->WaitSetAdd(NullUserPointer(), d_member1.Clone(), kR, kCookie2));

  // Can remove something based on a cookie.
  EXPECT_EQ(MOJO_RESULT_OK, d->WaitSetRemove(kCookie0));

  // Trying to remove the same cookie again should fail.
  EXPECT_EQ(MOJO_RESULT_NOT_FOUND, d->WaitSetRemove(kCookie0));

  // Can re-add it (still not satisfied, but satisfiable).
  EXPECT_EQ(MOJO_RESULT_OK,
            d->WaitSetAdd(NullUserPointer(), d_member0.Clone(), kR, kCookie0));

  // Wait. Recall:
  //   - |kCookie0| is for |d_member0| and is not satisfied (but satisfiable).
  //   - |kCookie1| is for |d_member1| and is satisfied.
  //   - |kCookie2| is for |d_member0| and is satisfied.
  {
    uint32_t num_results = 10u;
    MojoWaitSetResult results[10] = {};
    uint32_t max_results = static_cast<uint32_t>(-1);
    EXPECT_EQ(MOJO_RESULT_OK,
              d->WaitSetWait(k10ms, MakeUserPointer(&num_results),
                             MakeUserPointer(results),
                             MakeUserPointer(&max_results)));
    EXPECT_EQ(2u, num_results);
    EXPECT_EQ(2u, max_results);

    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie1, kSignals1,
                               MOJO_RESULT_OK,
                               d_member1->GetHandleSignalsState()));
    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie2, kSignals2,
                               MOJO_RESULT_OK,
                               d_member0->GetHandleSignalsState()));
  }

  // Do the same, but test the "indefinite" (forever) wait code path and only
  // allow one result.
  {
    uint32_t num_results = 1u;
    MojoWaitSetResult results[1] = {};
    uint32_t max_results = static_cast<uint32_t>(-1);
    EXPECT_EQ(MOJO_RESULT_OK,
              d->WaitSetWait(kIndefinite, MakeUserPointer(&num_results),
                             MakeUserPointer(results),
                             MakeUserPointer(&max_results)));
    EXPECT_EQ(1u, num_results);
    EXPECT_EQ(2u, max_results);

    // We should have *one* of the results.
    EXPECT_TRUE(
        CheckHasResult(num_results, results, kCookie1, kSignals1,
                       MOJO_RESULT_OK, d_member1->GetHandleSignalsState()) ||
        CheckHasResult(num_results, results, kCookie2, kSignals2,
                       MOJO_RESULT_OK, d_member0->GetHandleSignalsState()));
  }

  // Change the state of |d_member0|. This makes |kCookie0| satisfied.
  d_member0->SetSatisfiedSignals(kR | kW);

  // Wait.
  {
    uint32_t num_results = 3u;
    MojoWaitSetResult results[3] = {};
    uint32_t max_results = static_cast<uint32_t>(-1);
    EXPECT_EQ(MOJO_RESULT_OK,
              d->WaitSetWait(k10ms, MakeUserPointer(&num_results),
                             MakeUserPointer(results),
                             MakeUserPointer(&max_results)));
    EXPECT_EQ(3u, num_results);
    EXPECT_EQ(3u, max_results);

    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie0, kSignals0,
                               MOJO_RESULT_OK,
                               d_member0->GetHandleSignalsState()));
    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie1, kSignals1,
                               MOJO_RESULT_OK,
                               d_member1->GetHandleSignalsState()));
    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie2, kSignals2,
                               MOJO_RESULT_OK,
                               d_member0->GetHandleSignalsState()));
  }

  // Change the state of |d_member0| in two steps. |kCookie0| remains satisfied,
  // but |kCookie2| becomes unsatisfiable.
  d_member0->SetSatisfiedSignals(kR);
  d_member0->SetSatisfiableSignals(kR);

  // Wait.
  {
    uint32_t num_results = 10u;
    MojoWaitSetResult results[10] = {};
    uint32_t max_results = static_cast<uint32_t>(-1);
    EXPECT_EQ(MOJO_RESULT_OK,
              d->WaitSetWait(k10ms, MakeUserPointer(&num_results),
                             MakeUserPointer(results),
                             MakeUserPointer(&max_results)));
    EXPECT_EQ(3u, num_results);
    EXPECT_EQ(3u, max_results);

    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie0, kSignals0,
                               MOJO_RESULT_OK,
                               d_member0->GetHandleSignalsState()));
    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie1, kSignals1,
                               MOJO_RESULT_OK,
                               d_member1->GetHandleSignalsState()));
    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie2, kSignals2,
                               MOJO_RESULT_FAILED_PRECONDITION,
                               d_member0->GetHandleSignalsState()));
  }

  // Can close a dispatcher that's "in" the wait set. This should make
  // |kCookie1| "cancelled".
  EXPECT_EQ(MOJO_RESULT_OK, d_member1->Close());

  // Wait.
  {
    uint32_t num_results = 10u;
    MojoWaitSetResult results[10] = {};
    // Try passing null for |max_results|.
    EXPECT_EQ(MOJO_RESULT_OK,
              d->WaitSetWait(k10ms, MakeUserPointer(&num_results),
                             MakeUserPointer(results), NullUserPointer()));
    EXPECT_EQ(3u, num_results);

    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie0, kSignals0,
                               MOJO_RESULT_OK,
                               d_member0->GetHandleSignalsState()));
    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie1, kSignals1,
                               MOJO_RESULT_CANCELLED,
                               MojoHandleSignalsState()));
    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie2, kSignals2,
                               MOJO_RESULT_FAILED_PRECONDITION,
                               d_member0->GetHandleSignalsState()));
  }

  // Wait with zero |num_results| (in which case a null |results| is OK).
  {
    uint32_t num_results = 0u;
    uint32_t max_results = static_cast<uint32_t>(-1);
    EXPECT_EQ(MOJO_RESULT_OK,
              d->WaitSetWait(k10ms, MakeUserPointer(&num_results),
                             NullUserPointer(), MakeUserPointer(&max_results)));
    EXPECT_EQ(0u, num_results);
    EXPECT_EQ(3u, max_results);
  }

  // Can remove something whose dispatcher has been closed.
  EXPECT_EQ(MOJO_RESULT_OK, d->WaitSetRemove(kCookie1));

  // Can close the wait set when it's not empty.
  EXPECT_EQ(MOJO_RESULT_OK, d->Close());

  EXPECT_EQ(MOJO_RESULT_OK, d_member0->Close());
}

TEST(WaitSetDispatcherTest, TimeOut) {
  Stopwatch stopwatch;

  auto d = WaitSetDispatcher::Create(WaitSetDispatcher::kDefaultCreateOptions);

  // Wait with timeout without any entries.
  {
    uint32_t num_results = 1u;
    MojoWaitSetResult results[1] = {{456u}};
    uint32_t max_results = 789u;
    stopwatch.Start();
    EXPECT_EQ(MOJO_RESULT_DEADLINE_EXCEEDED,
              d->WaitSetWait(
                  2 * test::EpsilonTimeout(), MakeUserPointer(&num_results),
                  MakeUserPointer(results), MakeUserPointer(&max_results)));
    MojoDeadline elapsed = stopwatch.Elapsed();
    EXPECT_GT(elapsed, test::EpsilonTimeout());
    EXPECT_LT(elapsed, 3 * test::EpsilonTimeout());
    // The inputs should be untouched.
    EXPECT_EQ(1u, num_results);
    EXPECT_EQ(456u, results[0].cookie);
    EXPECT_EQ(789u, max_results);
  }

  auto d_member = MakeRefCounted<test::MockSimpleDispatcher>(
      MOJO_HANDLE_SIGNAL_NONE, MOJO_HANDLE_SIGNAL_READABLE);
  EXPECT_EQ(MOJO_RESULT_OK, d->WaitSetAdd(NullUserPointer(), d_member.Clone(),
                                          MOJO_HANDLE_SIGNAL_READABLE, 123u));

  // Wait with timeout with an unsatisfied (but satisfiable) entry.
  {
    uint32_t num_results = 1u;
    MojoWaitSetResult results[1] = {{456u}};
    uint32_t max_results = 789u;
    stopwatch.Start();
    EXPECT_EQ(MOJO_RESULT_DEADLINE_EXCEEDED,
              d->WaitSetWait(
                  2 * test::EpsilonTimeout(), MakeUserPointer(&num_results),
                  MakeUserPointer(results), MakeUserPointer(&max_results)));
    MojoDeadline elapsed = stopwatch.Elapsed();
    EXPECT_GT(elapsed, test::EpsilonTimeout());
    EXPECT_LT(elapsed, 3 * test::EpsilonTimeout());
    // The inputs should be untouched.
    EXPECT_EQ(1u, num_results);
    EXPECT_EQ(456u, results[0].cookie);
    EXPECT_EQ(789u, max_results);
  }

  EXPECT_EQ(MOJO_RESULT_OK, d->Close());
  EXPECT_EQ(MOJO_RESULT_OK, d_member->Close());
}

TEST(WaitSetDispatcherTest, BasicThreaded1) {
  static constexpr auto kNone = MOJO_HANDLE_SIGNAL_NONE;
  static constexpr auto kR = MOJO_HANDLE_SIGNAL_READABLE;
  static constexpr auto kW = MOJO_HANDLE_SIGNAL_WRITABLE;

  const auto epsilon = test::EpsilonTimeout();

  auto d = WaitSetDispatcher::Create(WaitSetDispatcher::kDefaultCreateOptions);

  // These will be members of our wait set.
  auto d_member0 = MakeRefCounted<test::MockSimpleDispatcher>(kNone, kR | kW);
  auto d_member1 = MakeRefCounted<test::MockSimpleDispatcher>(kNone, kR);

  // Add |d_member0|.
  static constexpr uint64_t kCookie0 = 123u;
  static constexpr auto kSignals0 = kR;
  EXPECT_EQ(MOJO_RESULT_OK, d->WaitSetAdd(NullUserPointer(), d_member0.Clone(),
                                          kSignals0, kCookie0));

  // Add |d_member1|.
  static constexpr uint64_t kCookie1 = 456u;
  static constexpr auto kSignals1 = kR;
  EXPECT_EQ(MOJO_RESULT_OK, d->WaitSetAdd(NullUserPointer(), d_member1.Clone(),
                                          kSignals1, kCookie1));

  // Can add |d_member0| again with a different cookie.
  static constexpr uint64_t kCookie2 = 789u;
  static constexpr auto kSignals2 = kW;
  EXPECT_EQ(MOJO_RESULT_OK, d->WaitSetAdd(NullUserPointer(), d_member0.Clone(),
                                          kSignals2, kCookie2));

  // We'll wait on the main thread, and do stuff on another thread.

  {
    // Trigger |kCookie0|.
    std::thread t([epsilon, d_member0]() {
      // Sleep to try to ensure that waiting has started.
      ThreadSleep(epsilon);
      d_member0->SetSatisfiedSignals(kR);
    });

    uint32_t num_results = 10u;
    MojoWaitSetResult results[10] = {};
    uint32_t max_results = static_cast<uint32_t>(-1);
    EXPECT_EQ(MOJO_RESULT_OK,
              d->WaitSetWait(3 * epsilon, MakeUserPointer(&num_results),
                             MakeUserPointer(results),
                             MakeUserPointer(&max_results)));
    EXPECT_EQ(1u, num_results);
    EXPECT_EQ(1u, max_results);

    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie0, kSignals0,
                               MOJO_RESULT_OK,
                               d_member0->GetHandleSignalsState()));

    t.join();
  }

  // Untrigger |kCookie0|.
  d_member0->SetSatisfiedSignals(kNone);

  {
    // Make |kCookie2| unsatisfiable.
    std::thread t([epsilon, d_member0]() {
      // Sleep to try to ensure that waiting has started.
      ThreadSleep(epsilon);
      d_member0->SetSatisfiableSignals(kR);
    });

    uint32_t num_results = 10u;
    MojoWaitSetResult results[10] = {};
    EXPECT_EQ(MOJO_RESULT_OK,
              d->WaitSetWait(3 * epsilon, MakeUserPointer(&num_results),
                             MakeUserPointer(results), NullUserPointer()));
    EXPECT_EQ(1u, num_results);

    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie2, kSignals2,
                               MOJO_RESULT_FAILED_PRECONDITION,
                               d_member0->GetHandleSignalsState()));

    t.join();
  }

  {
    // Trigger |kCookie1|.
    std::thread t(
        [epsilon, d_member1]() { d_member1->SetSatisfiedSignals(kR); });

    // Sleep to try to ensure that |kCookie1| has been triggered.
    ThreadSleep(epsilon);

    uint32_t num_results = 10u;
    MojoWaitSetResult results[10] = {};
    EXPECT_EQ(MOJO_RESULT_OK,
              d->WaitSetWait(3 * epsilon, MakeUserPointer(&num_results),
                             MakeUserPointer(results), NullUserPointer()));
    EXPECT_EQ(2u, num_results);

    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie1, kSignals1,
                               MOJO_RESULT_OK,
                               d_member1->GetHandleSignalsState()));
    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie2, kSignals2,
                               MOJO_RESULT_FAILED_PRECONDITION,
                               d_member0->GetHandleSignalsState()));

    t.join();
  }

  // Make |kCookie0| satisfiable again.
  d_member0->SetSatisfiableSignals(kR | kW);
  // Untrigger |kCookie1|.
  d_member1->SetSatisfiedSignals(kNone);

  {
    // Cancel |kCookie0| and |kCookie2| by closing |d_member0|.
    std::thread t([epsilon, d_member0]() {
      // Sleep to try to ensure that waiting has started.
      ThreadSleep(epsilon);
      EXPECT_EQ(MOJO_RESULT_OK, d_member0->Close());
    });

    uint32_t num_results = 10u;
    MojoWaitSetResult results[10] = {};
    EXPECT_EQ(MOJO_RESULT_OK,
              d->WaitSetWait(3 * epsilon, MakeUserPointer(&num_results),
                             MakeUserPointer(results), NullUserPointer()));
    EXPECT_EQ(2u, num_results);

    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie0, kSignals0,
                               MOJO_RESULT_CANCELLED,
                               MojoHandleSignalsState()));
    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie2, kSignals2,
                               MOJO_RESULT_CANCELLED,
                               MojoHandleSignalsState()));

    t.join();
  }

  EXPECT_EQ(MOJO_RESULT_OK, d_member1->Close());
  EXPECT_EQ(MOJO_RESULT_OK, d->Close());
}

TEST(WaitSetDispatcherTest, BasicThreaded2) {
  static constexpr auto kNone = MOJO_HANDLE_SIGNAL_NONE;
  static constexpr auto kR = MOJO_HANDLE_SIGNAL_READABLE;
  static constexpr auto kW = MOJO_HANDLE_SIGNAL_WRITABLE;

  const auto epsilon = test::EpsilonTimeout();

  Stopwatch stopwatch;

  auto d = WaitSetDispatcher::Create(WaitSetDispatcher::kDefaultCreateOptions);
  auto d_member = MakeRefCounted<test::MockSimpleDispatcher>(kNone, kR | kW);

  static constexpr uint64_t kCookie0 = 123u;
  static constexpr auto kSignals0 = kR;
  static constexpr uint64_t kCookie1 = 456u;
  static constexpr auto kSignals1 = kW;
  static constexpr uint64_t kCookie2 = 789u;
  static constexpr auto kSignals2 = kR | kW;

  // We'll wait on the main thread, and do stuff on another thread.

  {
    // Add |kCookie0|.
    std::thread t0([epsilon, d, d_member]() {
      // Sleep to try to ensure that waiting has started.
      ThreadSleep(epsilon);
      EXPECT_EQ(MOJO_RESULT_OK,
                d->WaitSetAdd(NullUserPointer(), d_member.Clone(), kSignals0,
                              kCookie0));
    });
    // Trigger |kCookie0| after |2 * epsilon| on another thread.
    stopwatch.Start();
    std::thread t1([epsilon, d_member]() {
      ThreadSleep(2 * epsilon);
      d_member->SetSatisfiedSignals(kR);
    });

    uint32_t num_results = 10u;
    MojoWaitSetResult results[10] = {};
    uint32_t max_results = static_cast<uint32_t>(-1);
    EXPECT_EQ(MOJO_RESULT_OK,
              d->WaitSetWait(3 * epsilon, MakeUserPointer(&num_results),
                             MakeUserPointer(results),
                             MakeUserPointer(&max_results)));
    MojoDeadline elapsed = stopwatch.Elapsed();
    EXPECT_GT(elapsed, epsilon);
    EXPECT_LT(elapsed, 3 * epsilon);
    EXPECT_EQ(1u, num_results);
    EXPECT_EQ(1u, max_results);
    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie0, kSignals0,
                               MOJO_RESULT_OK,
                               d_member->GetHandleSignalsState()));

    t1.join();
    t0.join();
  }

  // Untrigger |kCookie0|.
  d_member->SetSatisfiedSignals(kNone);

  {
    // Remove |kCookie0|.
    std::thread t0([epsilon, d]() {
      // Sleep to try to ensure that waiting has started.
      ThreadSleep(epsilon);
      EXPECT_EQ(MOJO_RESULT_OK, d->WaitSetRemove(kCookie0));
    });
    // Add |kCookie1|.
    std::thread t1([epsilon, d, d_member]() {
      // Sleep to try to ensure that waiting has started.
      ThreadSleep(epsilon);
      EXPECT_EQ(MOJO_RESULT_OK,
                d->WaitSetAdd(NullUserPointer(), d_member.Clone(), kSignals1,
                              kCookie1));
    });
    // Add |kCookie2|.
    std::thread t2([epsilon, d, d_member]() {
      // Sleep to try to ensure that waiting has started.
      ThreadSleep(epsilon);
      EXPECT_EQ(MOJO_RESULT_OK,
                d->WaitSetAdd(NullUserPointer(), d_member.Clone(), kSignals2,
                              kCookie2));
    });
    // Trigger |kCookie1| and |kCookie2| after |2 * epsilon| on another thread.
    stopwatch.Start();
    std::thread t3([epsilon, d_member]() {
      ThreadSleep(2 * epsilon);
      d_member->SetSatisfiedSignals(kW);
    });

    uint32_t num_results = 10u;
    MojoWaitSetResult results[10] = {};
    EXPECT_EQ(MOJO_RESULT_OK,
              d->WaitSetWait(3 * epsilon, MakeUserPointer(&num_results),
                             MakeUserPointer(results), NullUserPointer()));
    MojoDeadline elapsed = stopwatch.Elapsed();
    EXPECT_GT(elapsed, epsilon);
    EXPECT_LT(elapsed, 3 * epsilon);
    EXPECT_EQ(2u, num_results);
    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie1, kSignals1,
                               MOJO_RESULT_OK,
                               d_member->GetHandleSignalsState()));
    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie2, kSignals2,
                               MOJO_RESULT_OK,
                               d_member->GetHandleSignalsState()));

    t3.join();
    t2.join();
    t1.join();
    t0.join();
  }

  // Untrigger |kCookie1| and |kCookie2|.
  d_member->SetSatisfiedSignals(kNone);

  {
    // Make |kCookie1| unsatisfiable (|kCookie2| remains satisfiable but not
    // satisfied).
    std::thread t([epsilon, d_member]() {
      // Sleep to try to ensure that waiting has started.
      ThreadSleep(epsilon);
      d_member->SetSatisfiableSignals(kR);
    });

    uint32_t num_results = 10u;
    MojoWaitSetResult results[10] = {};
    EXPECT_EQ(MOJO_RESULT_OK,
              d->WaitSetWait(3 * epsilon, MakeUserPointer(&num_results),
                             MakeUserPointer(results), NullUserPointer()));
    EXPECT_EQ(1u, num_results);
    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie1, kSignals1,
                               MOJO_RESULT_FAILED_PRECONDITION,
                               d_member->GetHandleSignalsState()));

    t.join();
  }

  EXPECT_EQ(MOJO_RESULT_OK, d_member->Close());
  EXPECT_EQ(MOJO_RESULT_OK, d->Close());
}

// TODO(vtl): Test waiting on multiple threads.
// TODO(vtl): Stress tests.

// TODO(vtl): Test options validation for "create" and "add" (not that there's
// much to test).

}  // namespace
}  // namespace system
}  // namespace mojo
