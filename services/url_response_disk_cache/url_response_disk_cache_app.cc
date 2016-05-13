// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/url_response_disk_cache/url_response_disk_cache_app.h"

#include "base/command_line.h"
#include "services/url_response_disk_cache/url_response_disk_cache_impl.h"

namespace mojo {

URLResponseDiskCacheApp::URLResponseDiskCacheApp(
    scoped_refptr<base::TaskRunner> task_runner,
    URLResponseDiskCacheDelegate* delegate)
    : task_runner_(task_runner), delegate_(delegate) {}

URLResponseDiskCacheApp::~URLResponseDiskCacheApp() {
}

void URLResponseDiskCacheApp::Initialize(ApplicationImpl* app) {
  base::CommandLine command_line(app->args());
  bool force_clean = command_line.HasSwitch("clear");
  db_ = URLResponseDiskCacheImpl::CreateDB(task_runner_, force_clean);
}

bool URLResponseDiskCacheApp::ConfigureIncomingConnection(
    ApplicationConnection* connection) {
  connection->GetServiceProviderImpl().AddService<URLResponseDiskCache>([this](
      const ConnectionContext& connection_context,
      InterfaceRequest<URLResponseDiskCache> request) {
    new URLResponseDiskCacheImpl(task_runner_, delegate_, db_,
                                 connection_context.remote_url, request.Pass());
  });
  return true;
}

}  // namespace mojo
