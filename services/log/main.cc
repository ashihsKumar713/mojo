// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <stdio.h>

#include <utility>

#include "mojo/application/application_runner_chromium.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/services/log/interfaces/log.mojom.h"
#include "services/log/log_impl.h"

namespace mojo {
namespace log {

// Provides the mojo.log.Log service.  Binds a new Log implementation for each
// Log interface request.
class LogApp : public ApplicationDelegate {
 public:
  LogApp() {}
  ~LogApp() override {}

 private:
  // |ApplicationDelegate| override:
  bool ConfigureIncomingConnection(
      ServiceProviderImpl* service_provider_impl) override {
    service_provider_impl->AddService<Log>(
        [](const ConnectionContext& connection_context,
           InterfaceRequest<Log> log_request) {
          LogImpl::Create(connection_context, std::move(log_request),
                          [](const std::string& message) {
                            fprintf(stderr, "%s\n", message.c_str());
                          });
        });
    return true;
  }

  MOJO_DISALLOW_COPY_AND_ASSIGN(LogApp);
};

}  // namespace log
}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(new mojo::log::LogApp());
  return runner.Run(application_request);
}
