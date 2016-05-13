// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/macros.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/service_provider_impl.h"
#include "mojo/services/files/interfaces/files.mojom.h"
#include "services/files/files_impl.h"

namespace mojo {
namespace files {

class FilesApp : public ApplicationDelegate {
 public:
  FilesApp() {}
  ~FilesApp() override {}

 private:
  // |ApplicationDelegate| override:
  bool ConfigureIncomingConnection(
      ServiceProviderImpl* service_provider_impl) override {
    service_provider_impl->AddService<Files>(
        [](const ConnectionContext& connection_context,
           InterfaceRequest<Files> files_request) {
          new FilesImpl(connection_context, files_request.Pass());
        });
    return true;
  }

  DISALLOW_COPY_AND_ASSIGN(FilesApp);
};

}  // namespace files
}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(new mojo::files::FilesApp());
  return runner.Run(application_request);
}
