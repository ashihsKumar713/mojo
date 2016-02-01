// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/edk/embedder/platform_channel_pair.h"

#include <errno.h>
#include <poll.h>
#include <signal.h>
#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>

#include <deque>
#include <utility>
#include <vector>

#include "base/logging.h"
#include "build/build_config.h"
#include "mojo/edk/embedder/platform_channel_utils.h"
#include "mojo/edk/platform/platform_handle.h"
#include "mojo/edk/platform/scoped_platform_handle.h"
#include "mojo/edk/system/test/scoped_test_dir.h"
#include "mojo/edk/test/test_utils.h"
#include "mojo/edk/util/scoped_file.h"
#include "mojo/public/cpp/system/macros.h"
#include "testing/gtest/include/gtest/gtest.h"

using mojo::platform::PlatformHandle;
using mojo::platform::ScopedPlatformHandle;

namespace mojo {
namespace embedder {
namespace {

void WaitReadable(PlatformHandle h) {
  struct pollfd pfds = {};
  pfds.fd = h.fd;
  pfds.events = POLLIN;
  CHECK_EQ(poll(&pfds, 1, -1), 1);
}

class PlatformChannelPairTest : public testing::Test {
 public:
  PlatformChannelPairTest() {}
  ~PlatformChannelPairTest() override {}

  void SetUp() override {
    // Make sure |SIGPIPE| isn't being ignored.
    struct sigaction action = {};
    action.sa_handler = SIG_DFL;
    ASSERT_EQ(0, sigaction(SIGPIPE, &action, &old_action_));
  }

  void TearDown() override {
    // Restore the |SIGPIPE| handler.
    ASSERT_EQ(0, sigaction(SIGPIPE, &old_action_, nullptr));
  }

 private:
  struct sigaction old_action_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(PlatformChannelPairTest);
};

TEST_F(PlatformChannelPairTest, NoSigPipe) {
  PlatformChannelPair channel_pair;
  ScopedPlatformHandle server_handle = channel_pair.handle0.Pass();
  ScopedPlatformHandle client_handle = channel_pair.handle1.Pass();

  // Write to the client.
  static const char kHello[] = "hello";
  EXPECT_EQ(static_cast<ssize_t>(sizeof(kHello)),
            write(client_handle.get().fd, kHello, sizeof(kHello)));

  // Close the client.
  client_handle.reset();

  // Read from the server; this should be okay.
  char buffer[100] = {};
  EXPECT_EQ(static_cast<ssize_t>(sizeof(kHello)),
            read(server_handle.get().fd, buffer, sizeof(buffer)));
  EXPECT_STREQ(kHello, buffer);

  // Try reading again.
  ssize_t result = read(server_handle.get().fd, buffer, sizeof(buffer));
  // We should probably get zero (for "end of file"), but -1 would also be okay.
  EXPECT_TRUE(result == 0 || result == -1);
  if (result == -1)
    PLOG(WARNING) << "read (expected 0 for EOF)";

  // Test our replacement for |write()|/|send()|.
  result = PlatformChannelWrite(server_handle.get(), kHello, sizeof(kHello));
  EXPECT_EQ(-1, result);
  if (errno != EPIPE)
    PLOG(WARNING) << "write (expected EPIPE)";

  // Test our replacement for |writev()|/|sendv()|.
  struct iovec iov[2] = {{const_cast<char*>(kHello), sizeof(kHello)},
                         {const_cast<char*>(kHello), sizeof(kHello)}};
  result = PlatformChannelWritev(server_handle.get(), iov, 2);
  EXPECT_EQ(-1, result);
  if (errno != EPIPE)
    PLOG(WARNING) << "write (expected EPIPE)";
}

TEST_F(PlatformChannelPairTest, SendReceiveData) {
  PlatformChannelPair channel_pair;
  ScopedPlatformHandle server_handle = channel_pair.handle0.Pass();
  ScopedPlatformHandle client_handle = channel_pair.handle1.Pass();

  for (size_t i = 0; i < 10; i++) {
    std::string send_string(1 << i, 'A' + i);

    EXPECT_EQ(static_cast<ssize_t>(send_string.size()),
              PlatformChannelWrite(server_handle.get(), send_string.data(),
                                   send_string.size()));

    WaitReadable(client_handle.get());

    char buf[10000] = {};
    std::deque<ScopedPlatformHandle> received_handles;
    ssize_t result = PlatformChannelRecvmsg(client_handle.get(), buf,
                                            sizeof(buf), &received_handles);
    EXPECT_EQ(static_cast<ssize_t>(send_string.size()), result);
    EXPECT_EQ(send_string, std::string(buf, static_cast<size_t>(result)));
    EXPECT_TRUE(received_handles.empty());
  }
}

TEST_F(PlatformChannelPairTest, SendReceiveFDs) {
  mojo::system::test::ScopedTestDir test_dir;

  static const char kHello[] = "hello";

  PlatformChannelPair channel_pair;
  ScopedPlatformHandle server_handle = channel_pair.handle0.Pass();
  ScopedPlatformHandle client_handle = channel_pair.handle1.Pass();

// Reduce the number of FDs opened on OS X to avoid test flake.
#if defined(OS_MACOSX)
  const size_t kNumHandlesToSend = kPlatformChannelMaxNumHandles / 2;
#else
  const size_t kNumHandlesToSend = kPlatformChannelMaxNumHandles;
#endif

  for (size_t i = 1; i < kNumHandlesToSend; i++) {
    // Make |i| files, with the j-th file consisting of j copies of the digit
    // |c|.
    const char c = '0' + (i % 10);
    std::vector<ScopedPlatformHandle> platform_handles;
    for (size_t j = 1; j <= i; j++) {
      util::ScopedFILE fp(test_dir.CreateFile());
      ASSERT_TRUE(fp);
      ASSERT_EQ(j, fwrite(std::string(j, c).data(), 1, j, fp.get()));
      platform_handles.push_back(test::PlatformHandleFromFILE(std::move(fp)));
      ASSERT_TRUE(platform_handles.back().is_valid());
    }

    // Send the FDs (+ "hello").
    struct iovec iov = {const_cast<char*>(kHello), sizeof(kHello)};
    // We assume that the |sendmsg()| actually sends all the data.
    EXPECT_EQ(static_cast<ssize_t>(sizeof(kHello)),
              PlatformChannelSendmsgWithHandles(
                  server_handle.get(), &iov, 1,
                  reinterpret_cast<PlatformHandle*>(platform_handles.data()),
                  platform_handles.size()));

    WaitReadable(client_handle.get());

    char buf[10000] = {};
    std::deque<ScopedPlatformHandle> received_handles;
    // We assume that the |recvmsg()| actually reads all the data.
    EXPECT_EQ(static_cast<ssize_t>(sizeof(kHello)),
              PlatformChannelRecvmsg(client_handle.get(), buf, sizeof(buf),
                                     &received_handles));
    EXPECT_STREQ(kHello, buf);
    EXPECT_EQ(i, received_handles.size());

    for (size_t j = 0; !received_handles.empty(); j++) {
      util::ScopedFILE fp(test::FILEFromPlatformHandle(
          std::move(received_handles.front()), "rb"));
      received_handles.pop_front();
      ASSERT_TRUE(fp);
      rewind(fp.get());
      char read_buf[kNumHandlesToSend];
      size_t bytes_read = fread(read_buf, 1, sizeof(read_buf), fp.get());
      EXPECT_EQ(j + 1, bytes_read);
      EXPECT_EQ(std::string(j + 1, c), std::string(read_buf, bytes_read));
    }
  }
}

TEST_F(PlatformChannelPairTest, AppendReceivedFDs) {
  mojo::system::test::ScopedTestDir test_dir;

  static const char kHello[] = "hello";

  PlatformChannelPair channel_pair;
  ScopedPlatformHandle server_handle = channel_pair.handle0.Pass();
  ScopedPlatformHandle client_handle = channel_pair.handle1.Pass();

  const std::string file_contents("hello world");

  {
    util::ScopedFILE fp(test_dir.CreateFile());
    ASSERT_TRUE(fp);
    ASSERT_EQ(file_contents.size(),
              fwrite(file_contents.data(), 1, file_contents.size(), fp.get()));
    std::vector<ScopedPlatformHandle> platform_handles;
    platform_handles.push_back(test::PlatformHandleFromFILE(std::move(fp)));
    ASSERT_TRUE(platform_handles.back().is_valid());

    // Send the FD (+ "hello").
    struct iovec iov = {const_cast<char*>(kHello), sizeof(kHello)};
    // We assume that the |sendmsg()| actually sends all the data.
    EXPECT_EQ(static_cast<ssize_t>(sizeof(kHello)),
              PlatformChannelSendmsgWithHandles(
                  server_handle.get(), &iov, 1,
                  reinterpret_cast<PlatformHandle*>(platform_handles.data()),
                  platform_handles.size()));
  }

  WaitReadable(client_handle.get());

  // Start with an invalid handle in the deque.
  std::deque<ScopedPlatformHandle> received_handles;
  received_handles.push_back(ScopedPlatformHandle());

  char buf[100] = {};
  // We assume that the |recvmsg()| actually reads all the data.
  EXPECT_EQ(static_cast<ssize_t>(sizeof(kHello)),
            PlatformChannelRecvmsg(client_handle.get(), buf, sizeof(buf),
                                   &received_handles));
  EXPECT_STREQ(kHello, buf);
  ASSERT_EQ(2u, received_handles.size());
  EXPECT_FALSE(received_handles[0].is_valid());
  EXPECT_TRUE(received_handles[1].is_valid());

  {
    util::ScopedFILE fp(
        test::FILEFromPlatformHandle(std::move(received_handles[1]), "rb"));
    ASSERT_TRUE(fp);
    rewind(fp.get());
    char read_buf[100];
    size_t bytes_read = fread(read_buf, 1, sizeof(read_buf), fp.get());
    EXPECT_EQ(file_contents.size(), bytes_read);
    EXPECT_EQ(file_contents, std::string(read_buf, bytes_read));
  }
}

}  // namespace
}  // namespace embedder
}  // namespace mojo
