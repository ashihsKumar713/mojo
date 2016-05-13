// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/application/application_runner_chromium.h"
#include "mojo/common/binding_set.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/services/authentication/interfaces/authentication.mojom.h"
#include "mojo/services/network/interfaces/network_service.mojom.h"
#include "services/authentication/google_authentication_impl.h"

namespace authentication {

class GoogleAccountManagerApp : public mojo::ApplicationDelegate {
 public:
  GoogleAccountManagerApp() {}
  ~GoogleAccountManagerApp() override {}

  void Initialize(mojo::ApplicationImpl* app) override {
    mojo::ConnectToService(app->shell(), "mojo:network_service",
                           GetProxy(&network_service_));
    mojo::ConnectToService(app->shell(), "mojo:files", GetProxy(&files_));

    app_url_ = app->url();
  }

  bool ConfigureIncomingConnection(
      mojo::ServiceProviderImpl* service_provider_impl) override {
    service_provider_impl->AddService<AuthenticationService>(
        [this](const mojo::ConnectionContext& connection_context,
               mojo::InterfaceRequest<AuthenticationService> request) {
          mojo::files::Error error = mojo::files::Error::INTERNAL;
          mojo::files::DirectoryPtr directory;
          files_->OpenFileSystem("app_persistent_cache", GetProxy(&directory),
                                 [&error](mojo::files::Error e) { error = e; });
          CHECK(files_.WaitForIncomingResponse());
          if (mojo::files::Error::OK != error) {
            LOG(FATAL) << "Unable to initialize accounts DB";
          }
          new authentication::GoogleAuthenticationServiceImpl(
              request.Pass(), app_url_, network_service_, directory);
        });
    return true;
  }

 private:
  mojo::NetworkServicePtr network_service_;
  mojo::files::FilesPtr files_;
  std::string app_url_;

  DISALLOW_COPY_AND_ASSIGN(GoogleAccountManagerApp);
};

}  // namespace authentication

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(
      new authentication::GoogleAccountManagerApp());
  return runner.Run(application_request);
}
