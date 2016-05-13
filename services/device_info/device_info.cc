// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <cstdlib>
#include <memory>

#include "mojo/common/binding_set.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/services/device_info/interfaces/device_info.mojom.h"

namespace mojo {
namespace services {
namespace device_info {

// This is a native Mojo application which implements |DeviceInfo| interface for
// Linux.
class DeviceInfo : public ApplicationDelegate, public mojo::DeviceInfo {
 public:
  // We look for the 'DISPLAY' environment variable. If present, then we assume
  // it to be a desktop, else we assume it to be a commandline
  void GetDeviceType(const GetDeviceTypeCallback& callback) override {
    callback.Run(getenv("DISPLAY") ? DeviceInfo::DeviceType::DESKTOP
                                   : DeviceInfo::DeviceType::HEADLESS);
  }

  // |ApplicationDelegate| override.
  bool ConfigureIncomingConnection(
      ServiceProviderImpl* service_provider_impl) override {
    service_provider_impl->AddService<mojo::DeviceInfo>(
        [this](const ConnectionContext& connection_context,
               InterfaceRequest<mojo::DeviceInfo> device_info_request) {
          binding_.AddBinding(this, device_info_request.Pass());
        });
    return true;
  }

 private:
  mojo::BindingSet<mojo::DeviceInfo> binding_;
};

}  // namespace device_info
}  // namespace services
}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunner runner(
      std::unique_ptr<mojo::services::device_info::DeviceInfo>(
          new mojo::services::device_info::DeviceInfo()));
  return runner.Run(application_request);
}
