// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/native_viewport/app_delegate.h"

#include <vector>

#include "gpu/config/gpu_util.h"

namespace native_viewport {

NativeViewportAppDelegate::NativeViewportAppDelegate() : is_headless_(false) {}

NativeViewportAppDelegate::~NativeViewportAppDelegate() {}

void NativeViewportAppDelegate::InitLogging(
    mojo::ApplicationImpl* application) {
  std::vector<const char*> args;
  for (auto& a : application->args()) {
    args.push_back(a.c_str());
  }

  base::CommandLine::Reset();
  base::CommandLine::Init(args.size(), args.data());

  logging::LoggingSettings settings;
  settings.logging_dest = logging::LOG_TO_SYSTEM_DEBUG_LOG;
  logging::InitLogging(settings);
}

void NativeViewportAppDelegate::Initialize(mojo::ApplicationImpl* application) {
  application_ = application;

  InitLogging(application);
  tracing_.Initialize(application->shell(), &application->args());

  // Apply the switch for kTouchEvents to CommandLine (if set). This allows
  // redirecting the mouse to a touch device on X for testing.
  base::CommandLine* command_line = base::CommandLine::ForCurrentProcess();
  const std::string touch_event_string("--" +
                                       std::string(switches::kTouchDevices));
  auto touch_iter = std::find(application->args().begin(),
                              application->args().end(), touch_event_string);
  if (touch_iter != application->args().end() &&
      ++touch_iter != application->args().end()) {
    command_line->AppendSwitchASCII(touch_event_string, *touch_iter);
  }

  gpu::ApplyGpuDriverBugWorkarounds(command_line);

  if (application->HasArg(mojo::kUseTestConfig))
    gfx::GLSurface::InitializeOneOffForTests();
  else if (application->HasArg(mojo::kUseOSMesa))
    gfx::GLSurface::InitializeOneOff(gfx::kGLImplementationOSMesaGL);
  else
    gfx::GLSurface::InitializeOneOff();

  is_headless_ = application->HasArg(mojo::kUseHeadlessConfig);
}

bool NativeViewportAppDelegate::ConfigureIncomingConnection(
    mojo::ServiceProviderImpl* service_provider_impl) {
  service_provider_impl->AddService<mojo::NativeViewport>([this](
      const mojo::ConnectionContext& connection_context,
      mojo::InterfaceRequest<mojo::NativeViewport> native_viewport_request) {
    if (!gpu_state_.get())
      gpu_state_ = new gles2::GpuState();
    new NativeViewportImpl(application_->shell(), is_headless_, gpu_state_,
                           native_viewport_request.Pass());
  });

  service_provider_impl->AddService<mojo::Gpu>(
      [this](const mojo::ConnectionContext& connection_context,
             mojo::InterfaceRequest<mojo::Gpu> gpu_request) {
        if (!gpu_state_.get())
          gpu_state_ = new gles2::GpuState();
        new gles2::GpuImpl(gpu_request.Pass(), gpu_state_);
      });

  return true;
}

}  // namespace native_viewport
