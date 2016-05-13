// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/launcher/launcher_app.h"

#include "base/command_line.h"
#include "base/logging.h"
#include "base/trace_event/trace_event.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/common/tracing_impl.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_impl.h"

namespace launcher {

LauncherApp::LauncherApp() : app_impl_(nullptr), next_id_(0u) {}

LauncherApp::~LauncherApp() {}

void LauncherApp::Initialize(mojo::ApplicationImpl* app_impl) {
  app_impl_ = app_impl;

  auto command_line = base::CommandLine::ForCurrentProcess();
  command_line->InitFromArgv(app_impl_->args());
  logging::LoggingSettings settings;
  settings.logging_dest = logging::LOG_TO_SYSTEM_DEBUG_LOG;
  logging::InitLogging(settings);

  tracing_.Initialize(app_impl_);
  TRACE_EVENT0("launcher", __func__);

  for (size_t i = 0; i < command_line->GetArgs().size(); ++i) {
    Launch(command_line->GetArgs()[i]);
  }
}

bool LauncherApp::ConfigureIncomingConnection(
    mojo::ServiceProviderImpl* service_provider_impl) {
  // Only present the launcher interface to the shell.
  if (service_provider_impl->connection_context().remote_url.empty()) {
    service_provider_impl->AddService<Launcher>(
        [this](const mojo::ConnectionContext& connection_context,
               mojo::InterfaceRequest<Launcher> launcher_request) {
          bindings_.AddBinding(this, launcher_request.Pass());
        });
  }
  return true;
}

void LauncherApp::Launch(const mojo::String& application_url) {
  uint32_t next_id = next_id_++;
  std::unique_ptr<LaunchInstance> instance(new LaunchInstance(
      app_impl_, application_url, base::Bind(&LauncherApp::OnLaunchTermination,
                                             base::Unretained(this), next_id)));
  instance->Launch();
  launch_instances_.emplace(next_id, std::move(instance));
}

void LauncherApp::OnLaunchTermination(uint32_t id) {
  launch_instances_.erase(id);
  if (launch_instances_.empty()) {
    app_impl_->Terminate();
  }
}

}  // namespace launcher
