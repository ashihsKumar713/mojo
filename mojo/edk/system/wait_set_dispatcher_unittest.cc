// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/edk/system/wait_set_dispatcher.h"

#include "mojo/edk/system/mock_simple_dispatcher.h"
#include "testing/gtest/include/gtest/gtest.h"

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
                               MOJO_RESULT_CANCELLED,
                               MojoHandleSignalsState()));
    EXPECT_TRUE(CheckHasResult(num_results, results, kCookie2, kSignals2,
                               MOJO_RESULT_FAILED_PRECONDITION,
                               d_member0->GetHandleSignalsState()));
  }

  // Can remove something whose dispatcher has been closed.
  EXPECT_EQ(MOJO_RESULT_OK, d->WaitSetRemove(kCookie1));

  // Can close the wait set when it's not empty.
  EXPECT_EQ(MOJO_RESULT_OK, d->Close());

  EXPECT_EQ(MOJO_RESULT_OK, d_member0->Close());
}

// TODO(vtl): Test options validation for "create" and "add" (not that there's
// much to test).

}  // namespace
}  // namespace system
}  // namespace mojo
