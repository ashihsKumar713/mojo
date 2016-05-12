// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/view_provider_app.h"

#include <utility>

#include "base/command_line.h"
#include "base/logging.h"

namespace mojo {
namespace ui {

class ViewProviderApp::DelegatingViewProvider : public mojo::ui::ViewProvider {
 public:
  DelegatingViewProvider(ViewProviderApp* app,
                         const std::string& view_provider_url)
      : app_(app), view_provider_url_(view_provider_url) {}

  ~DelegatingViewProvider() override {}

 private:
  // |ViewProvider|:
  void CreateView(
      mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
      mojo::InterfaceRequest<mojo::ServiceProvider> services,
      mojo::InterfaceHandle<mojo::ServiceProvider> exposed_services) override {
    app_->CreateView(this, view_provider_url_, view_owner_request.Pass(),
                     services.Pass(), std::move(exposed_services));
  }

  ViewProviderApp* app_;
  std::string view_provider_url_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(DelegatingViewProvider);
};

ViewProviderApp::ViewProviderApp() {}

ViewProviderApp::~ViewProviderApp() {}

void ViewProviderApp::Initialize(mojo::ApplicationImpl* app_impl) {
  app_impl_ = app_impl;

  auto command_line = base::CommandLine::ForCurrentProcess();
  command_line->InitFromArgv(app_impl_->args());
  logging::LoggingSettings settings;
  settings.logging_dest = logging::LOG_TO_SYSTEM_DEBUG_LOG;
  logging::InitLogging(settings);
}

bool ViewProviderApp::ConfigureIncomingConnection(
    mojo::ApplicationConnection* connection) {
  connection->AddService<mojo::ui::ViewProvider>(this);
  return true;
}

void ViewProviderApp::Create(
    const mojo::ConnectionContext& connection_context,
    mojo::InterfaceRequest<mojo::ui::ViewProvider> request) {
  bindings_.AddBinding(
      new DelegatingViewProvider(this, connection_context.connection_url),
      request.Pass());
}

void ViewProviderApp::CreateView(
    DelegatingViewProvider* provider,
    const std::string& view_provider_url,
    mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
    mojo::InterfaceRequest<mojo::ServiceProvider> services,
    mojo::InterfaceHandle<mojo::ServiceProvider> exposed_services) {
  CreateView(view_provider_url, view_owner_request.Pass(), services.Pass(),
             exposed_services.Pass());
}

}  // namespace ui
}  // namespace mojo
