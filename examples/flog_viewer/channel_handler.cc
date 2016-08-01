// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "examples/flog_viewer/channel_handler.h"

#include "examples/flog_viewer/flog_viewer.h"
#include "examples/flog_viewer/handlers/default.h"

namespace mojo {
namespace flog {
namespace examples {

// static
std::shared_ptr<ChannelHandler> ChannelHandler::Create(
    const std::string& type_name,
    const std::string& format) {
  ChannelHandler* handler = nullptr;

  // When implementing a new handler, add logic here for creating an instance.

  if (handler == nullptr) {
    handler = new handlers::Default(format);
  }

  return std::unique_ptr<ChannelHandler>(handler);
}

ChannelHandler::ChannelHandler() {}

ChannelHandler::~ChannelHandler() {}

void ChannelHandler::HandleMessage(uint32_t entry_index,
                                   const FlogEntryPtr& entry,
                                   Message* message) {
  entry_index_ = entry_index;
  entry_ = &entry;
  HandleMessage(message);
  entry_index_ = 0;
  entry_ = nullptr;
}

std::shared_ptr<Accumulator> ChannelHandler::GetAccumulator() {
  return nullptr;
}

}  // namespace examples
}  // namespace flog
}  // namespace mojo
