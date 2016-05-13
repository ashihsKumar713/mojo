// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_UI_LAUNCHER_LAUNCHER_APP_H_
#define SERVICES_UI_LAUNCHER_LAUNCHER_APP_H_

#include <memory>
#include <unordered_map>

#include "mojo/common/binding_set.h"
#include "mojo/common/tracing_impl.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "services/ui/launcher/launch_instance.h"
#include "services/ui/launcher/launcher.mojom.h"

namespace launcher {

class LauncherApp : public mojo::ApplicationDelegate, public Launcher {
 public:
  LauncherApp();
  ~LauncherApp() override;

 private:
  // |ApplicationDelegate|:
  void Initialize(mojo::ApplicationImpl* app_impl) override;
  bool ConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override;

  // |Launcher|:
  void Launch(const mojo::String& application_url) override;

  void OnLaunchTermination(uint32_t id);

  mojo::ApplicationImpl* app_impl_;
  mojo::TracingImpl tracing_;

  mojo::BindingSet<Launcher> bindings_;
  std::unordered_map<uint32_t, std::unique_ptr<LaunchInstance>>
      launch_instances_;
  uint32_t next_id_;

  DISALLOW_COPY_AND_ASSIGN(LauncherApp);
};

}  // namespace launcher

#endif  // SERVICES_UI_LAUNCHER_LAUNCHER_APP_H_
