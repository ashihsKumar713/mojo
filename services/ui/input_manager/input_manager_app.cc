// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/input_manager/input_manager_app.h"

#include "base/command_line.h"
#include "base/logging.h"
#include "base/trace_event/trace_event.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/common/tracing_impl.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/service_provider_impl.h"
#include "services/ui/input_manager/input_associate.h"

namespace input_manager {

InputManagerApp::InputManagerApp() : app_impl_(nullptr) {}

InputManagerApp::~InputManagerApp() {}

void InputManagerApp::Initialize(mojo::ApplicationImpl* app_impl) {
  app_impl_ = app_impl;

  auto command_line = base::CommandLine::ForCurrentProcess();
  command_line->InitFromArgv(app_impl_->args());
  logging::LoggingSettings settings;
  settings.logging_dest = logging::LOG_TO_SYSTEM_DEBUG_LOG;
  logging::InitLogging(settings);

  tracing_.Initialize(app_impl->shell(), &app_impl->args());
}

bool InputManagerApp::ConfigureIncomingConnection(
    mojo::ServiceProviderImpl* service_provider_impl) {
  service_provider_impl->AddService<mojo::ui::ViewAssociate>([this](
      const mojo::ConnectionContext& connection_context,
      mojo::InterfaceRequest<mojo::ui::ViewAssociate> view_associate_request) {
    input_associates_.AddBinding(new InputAssociate(),
                                 view_associate_request.Pass());
  });
  return true;
}

}  // namespace input_manager
