// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_LAUNCHER_LAUNCH_INSTANCE_H_
#define SERVICES_UI_LAUNCHER_LAUNCH_INSTANCE_H_

#include <memory>

#include "base/callback.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/gfx/composition/interfaces/compositor.mojom.h"
#include "mojo/services/native_viewport/interfaces/native_viewport.mojom.h"
#include "mojo/services/native_viewport/interfaces/native_viewport_event_dispatcher.mojom.h"
#include "mojo/services/ui/views/interfaces/view_manager.mojom.h"

namespace launcher {

class LauncherViewTree;

class LaunchInstance : public mojo::NativeViewportEventDispatcher {
 public:
  LaunchInstance(mojo::ApplicationImpl* app_impl,
                 const std::string& app_url,
                 mojo::gfx::composition::Compositor* compositor,
                 mojo::ui::ViewManager* view_manager,
                 const base::Closure& shutdown_callback);
  ~LaunchInstance() override;

  void Launch();

 private:
  // |NativeViewportEventDispatcher|:
  void OnEvent(mojo::EventPtr event,
               const mojo::Callback<void()>& callback) override;

  void InitViewport();
  void OnViewportConnectionError();
  void OnViewportCreated(mojo::ViewportMetricsPtr metrics);
  void OnViewportMetricsChanged(mojo::ViewportMetricsPtr metrics);
  void RequestUpdatedViewportMetrics();

  mojo::ApplicationImpl* app_impl_;
  std::string app_url_;

  mojo::gfx::composition::Compositor* compositor_;
  mojo::ui::ViewManager* view_manager_;
  base::Closure shutdown_callback_;

  mojo::NativeViewportPtr viewport_;
  mojo::Binding<NativeViewportEventDispatcher>
      viewport_event_dispatcher_binding_;

  std::unique_ptr<LauncherViewTree> view_tree_;

  mojo::ui::ViewOwnerPtr client_view_owner_;

  DISALLOW_COPY_AND_ASSIGN(LaunchInstance);
};

}  // namespace launcher

#endif  // SERVICES_UI_LAUNCHER_LAUNCH_INSTANCE_H_
