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

TEST(WaitSetDispatcherTest, Basic) {
  auto d = WaitSetDispatcher::Create(WaitSetDispatcher::kDefaultCreateOptions);

  // These will be members of our wait set.
  auto d_member0 = MakeRefCounted<test::MockSimpleDispatcher>(
      MOJO_HANDLE_SIGNAL_NONE,
      MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_WRITABLE);
  auto d_member1 = MakeRefCounted<test::MockSimpleDispatcher>(
      MOJO_HANDLE_SIGNAL_READABLE, MOJO_HANDLE_SIGNAL_READABLE);

  // Add |d_member0|, for something not satisfied, but satisfiable.
  const uint64_t kCookie0 = 0x123456789abcdef0ULL;
  EXPECT_EQ(MOJO_RESULT_OK,
            d->WaitSetAdd(NullUserPointer(), d_member0.Clone(),
                          MOJO_HANDLE_SIGNAL_READABLE, kCookie0));

  // Add |d_member1|, for something satisfied.
  const uint64_t kCookie1 = 0x23456789abcdef01ULL;
  EXPECT_EQ(MOJO_RESULT_OK,
            d->WaitSetAdd(NullUserPointer(), d_member1.Clone(),
                          MOJO_HANDLE_SIGNAL_READABLE, kCookie1));

  // Can add |d_member0| again, with a different cookie.
  const uint64_t kCookie2 = 0x3456789abcdef012ULL;
  EXPECT_EQ(MOJO_RESULT_OK,
            d->WaitSetAdd(NullUserPointer(), d_member0.Clone(),
                          MOJO_HANDLE_SIGNAL_WRITABLE, kCookie2));

  // Adding something with the same cookie yields "already exists".
  EXPECT_EQ(MOJO_RESULT_ALREADY_EXISTS,
            d->WaitSetAdd(NullUserPointer(), d_member1.Clone(),
                          MOJO_HANDLE_SIGNAL_READABLE, kCookie2));

  // Can remove something based on a cookie.
  EXPECT_EQ(MOJO_RESULT_OK, d->WaitSetRemove(kCookie0));

  // Trying to remove the same cookie again should fail.
  EXPECT_EQ(MOJO_RESULT_NOT_FOUND, d->WaitSetRemove(kCookie0));

  // Can re-add it.
  EXPECT_EQ(MOJO_RESULT_OK,
            d->WaitSetAdd(NullUserPointer(), d_member0.Clone(),
                          MOJO_HANDLE_SIGNAL_READABLE, kCookie0));

  // TODO(vtl): Test waiting here.

  // Can close a dispatcher that's "in" the wait set.
  EXPECT_EQ(MOJO_RESULT_OK, d_member1->Close());

  // TODO(vtl): Test waiting here.

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
