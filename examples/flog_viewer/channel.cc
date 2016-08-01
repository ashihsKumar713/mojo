// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "examples/flog_viewer/channel.h"
#include "examples/flog_viewer/formatting.h"

namespace mojo {
namespace flog {
namespace examples {

// static
std::shared_ptr<Channel> Channel::Create(
    uint32_t log_id,
    uint32_t channel_id,
    uint32_t creation_entry_index,
    std::unique_ptr<ChannelHandler> handler) {
  return std::shared_ptr<Channel>(new Channel(
      log_id, channel_id, creation_entry_index, std::move(handler)));
}

Channel::Channel(uint32_t log_id,
                 uint32_t channel_id,
                 uint32_t creation_entry_index,
                 std::unique_ptr<ChannelHandler> handler)
    : log_id_(log_id),
      channel_id_(channel_id),
      creation_entry_index_(creation_entry_index),
      handler_(std::move(handler)) {}

Channel::~Channel() {}

void Channel::PrintAccumulator(std::ostream& os) const {
  std::shared_ptr<Accumulator> accumulator = handler()->GetAccumulator();
  if (!accumulator) {
    os << "NO ACCUMULATOR" << std::endl;
    return;
  }

  accumulator->Print(os);
}

}  // namespace examples
}  // namespace flog
}  // namespace mojo
