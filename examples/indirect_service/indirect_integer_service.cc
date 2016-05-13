// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <memory>

#include "examples/indirect_service/indirect_service_demo.mojom.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/public/cpp/bindings/strong_binding.h"

namespace mojo {
namespace examples {

class IndirectIntegerServiceImpl : public IndirectIntegerService,
                                   public IntegerService {
 public:
  IndirectIntegerServiceImpl(InterfaceRequest<IndirectIntegerService> request)
      : binding_(this, request.Pass()) {}

  ~IndirectIntegerServiceImpl() override {
   for (auto itr = bindings_.begin(); itr < bindings_.end(); itr++)
     delete *itr;
  }

  // IndirectIntegerService

  void Set(InterfaceHandle<IntegerService> service) override {
    integer_service_ = IntegerServicePtr::Create(std::move(service));
  }

  void Get(InterfaceRequest<IntegerService> service) override {
    bindings_.push_back(new Binding<IntegerService>(this, service.Pass()));
  }

  // IntegerService

  void Increment(const Callback<void(int32_t)>& callback) override {
    if (integer_service_.get())
      integer_service_->Increment(callback);
  }

private:
  IntegerServicePtr integer_service_;
  std::vector<Binding<IntegerService>*> bindings_;
  StrongBinding<IndirectIntegerService> binding_;
};

class IndirectIntegerServiceAppDelegate : public ApplicationDelegate {
 public:
  bool ConfigureIncomingConnection(
      ApplicationConnection* connection) override {
    connection->GetServiceProviderImpl().AddService<IndirectIntegerService>(
        [](const ConnectionContext& connection_context,
           InterfaceRequest<IndirectIntegerService> request) {
          new IndirectIntegerServiceImpl(request.Pass());
        });
    return true;
  }
};

}  // namespace examples
}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunner runner(
      std::unique_ptr<mojo::examples::IndirectIntegerServiceAppDelegate>(
          new mojo::examples::IndirectIntegerServiceAppDelegate()));
  return runner.Run(application_request);
}
