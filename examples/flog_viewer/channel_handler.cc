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
std::shared_ptr<ChannelHandler> ChannelHandler::CreateHandler(
    const std::string& type_name,
    const std::string& format,
    const EntryPrologPrinter& entry_prolog_printer) {
  std::shared_ptr<ChannelHandler> handler;

  // When implementing a new handler, add logic here for creating an instance.

  if (!handler) {
    handler = std::make_shared<handlers::Default>(format);
  }

  handler->entry_prolog_printer_ = entry_prolog_printer;

  return handler;
}

ChannelHandler::ChannelHandler() {}

ChannelHandler::~ChannelHandler() {}

std::shared_ptr<Accumulator> ChannelHandler::GetAccumulator() {
  return nullptr;
}

void ChannelHandler::PrintEntryProlog(const FlogEntryPtr& entry) {
  entry_prolog_printer_(entry);
}

}  // namespace examples
}  // namespace flog
}  // namespace mojo
