// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_NATIVE_VIEWPORT_APP_DELEGATE_H_
#define SERVICES_NATIVE_VIEWPORT_APP_DELEGATE_H_

#include <algorithm>

#include "base/bind.h"
#include "base/command_line.h"
#include "base/macros.h"
#include "base/message_loop/message_loop.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/common/tracing_impl.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/services/native_viewport/cpp/args.h"
#include "services/gles2/gpu_impl.h"
#include "services/native_viewport/native_viewport_impl.h"
#include "ui/events/event_switches.h"
#include "ui/gl/gl_surface.h"

namespace native_viewport {

class NativeViewportAppDelegate
    : public mojo::ApplicationDelegate,
      public mojo::InterfaceFactory<mojo::NativeViewport>,
      public mojo::InterfaceFactory<mojo::Gpu> {
 public:
  NativeViewportAppDelegate();
  ~NativeViewportAppDelegate() override;

  // mojo::ApplicationDelegate implementation.
  void Initialize(mojo::ApplicationImpl* application) override;

  bool ConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override;

  // mojo::InterfaceFactory<mojo::NativeViewport> implementation.
  void Create(const mojo::ConnectionContext& connection_context,
              mojo::InterfaceRequest<mojo::NativeViewport> request) override;

  // mojo::InterfaceFactory<mojo::Gpu> implementation.
  void Create(const mojo::ConnectionContext& connection_context,
              mojo::InterfaceRequest<mojo::Gpu> request) override;

 private:
  void InitLogging(mojo::ApplicationImpl* application);

  mojo::ApplicationImpl* application_;
  scoped_refptr<gles2::GpuState> gpu_state_;
  bool is_headless_;
  mojo::TracingImpl tracing_;

  DISALLOW_COPY_AND_ASSIGN(NativeViewportAppDelegate);
};

}  // namespace native_viewport

#endif
