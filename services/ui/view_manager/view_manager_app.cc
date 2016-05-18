// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_manager_app.h"

#include <string>
#include <vector>

#include "base/command_line.h"
#include "base/logging.h"
#include "base/trace_event/trace_event.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/common/tracing_impl.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/public/cpp/application/service_provider_impl.h"
#include "services/ui/view_manager/view_manager_impl.h"

namespace view_manager {

ViewManagerApp::ViewManagerApp() : app_impl_(nullptr) {}

ViewManagerApp::~ViewManagerApp() {}

void ViewManagerApp::Initialize(mojo::ApplicationImpl* app_impl) {
  app_impl_ = app_impl;

  auto command_line = base::CommandLine::ForCurrentProcess();
  command_line->InitFromArgv(app_impl_->args());
  logging::LoggingSettings settings;
  settings.logging_dest = logging::LOG_TO_SYSTEM_DEBUG_LOG;
  logging::InitLogging(settings);

  tracing_.Initialize(app_impl_);

  // Connect to compositor.
  mojo::gfx::composition::CompositorPtr compositor;
  mojo::ConnectToService(app_impl_->shell(), "mojo:compositor_service",
                         GetProxy(&compositor));
  compositor.set_connection_error_handler(base::Bind(
      &ViewManagerApp::OnCompositorConnectionError, base::Unretained(this)));

  // Create the registry.
  registry_.reset(new ViewRegistry(compositor.Pass()));
}

bool ViewManagerApp::ConfigureIncomingConnection(
    mojo::ServiceProviderImpl* service_provider_impl) {
  service_provider_impl->AddService<mojo::ui::ViewManager>([this](
      const mojo::ConnectionContext& connection_context,
      mojo::InterfaceRequest<mojo::ui::ViewManager> view_manager_request) {
    DCHECK(registry_);
    view_managers_.AddBinding(new ViewManagerImpl(registry_.get()),
                              view_manager_request.Pass());
  });
  return true;
}

void ViewManagerApp::OnCompositorConnectionError() {
  LOG(ERROR) << "Exiting due to compositor connection error.";
  Shutdown();
}

void ViewManagerApp::Shutdown() {
  app_impl_->Terminate();
}

}  // namespace view_manager
