// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/services/ozone_drm_gpu/interfaces/ozone_drm_gpu.mojom.h"
#include "mojo/services/ozone_drm_host/interfaces/ozone_drm_host.mojom.h"
#include "ui/ozone/platform/drm/mojo/drm_gpu_delegate.h"
#include "ui/ozone/platform/drm/mojo/drm_gpu_impl.h"
#include "ui/ozone/platform/drm/mojo/drm_host_delegate.h"
#include "ui/ozone/platform/drm/mojo/drm_host_impl.h"
#include "ui/ozone/public/ipc_init_helper_mojo.h"

namespace ui {

class DrmIpcInitHelperMojo : public IpcInitHelperMojo {
 public:
  DrmIpcInitHelperMojo();
  ~DrmIpcInitHelperMojo();

  void HostInitialize(mojo::ApplicationImpl* application) override;
  bool HostConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override;

  void GpuInitialize(mojo::ApplicationImpl* application) override;
  bool GpuConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override;

 private:
  mojo::OzoneDrmHostPtr ozone_drm_host_;
  mojo::OzoneDrmGpuPtr ozone_drm_gpu_;
};

DrmIpcInitHelperMojo::DrmIpcInitHelperMojo() {}

DrmIpcInitHelperMojo::~DrmIpcInitHelperMojo() {}

void DrmIpcInitHelperMojo::HostInitialize(mojo::ApplicationImpl* application) {
  mojo::ConnectToService(application->shell(), "mojo:native_viewport_service",
                         GetProxy(&ozone_drm_gpu_));
  new MojoDrmHostDelegate(ozone_drm_gpu_.get());
}

void DrmIpcInitHelperMojo::GpuInitialize(mojo::ApplicationImpl* application) {
  mojo::ConnectToService(application->shell(), "mojo:native_viewport_service",
                         GetProxy(&ozone_drm_host_));
  new MojoDrmGpuDelegate(ozone_drm_host_.get());
}

bool DrmIpcInitHelperMojo::HostConfigureIncomingConnection(
    mojo::ApplicationConnection* connection) {
  connection->GetServiceProviderImpl().AddService<mojo::OzoneDrmHost>(
      [](const mojo::ConnectionContext& connection_context,
         mojo::InterfaceRequest<mojo::OzoneDrmHost> request) {
        new MojoDrmHostImpl(request.Pass());
      });
  return true;
}

bool DrmIpcInitHelperMojo::GpuConfigureIncomingConnection(
    mojo::ApplicationConnection* connection) {
  connection->GetServiceProviderImpl().AddService<mojo::OzoneDrmGpu>(
      [](const mojo::ConnectionContext& connection_context,
         mojo::InterfaceRequest<mojo::OzoneDrmGpu> request) {
        new MojoDrmGpuImpl(request.Pass());
      });
  return true;
}

// static
IpcInitHelperOzone* IpcInitHelperOzone::Create() {
  return new DrmIpcInitHelperMojo();
}

}  // namespace ui
