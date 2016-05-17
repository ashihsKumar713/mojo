// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_UI_VIEW_PROVIDER_APP_H_
#define MOJO_UI_VIEW_PROVIDER_APP_H_

#include <string>

#include "mojo/common/strong_binding_set.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/service_provider_impl.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/services/ui/views/interfaces/view_provider.mojom.h"

namespace mojo {
namespace ui {

// Abstract implementation of a simple application that offers a ViewProvider.
// Subclasses must provide a function to create the necessary Views.
//
// It is not necessary to use this class to implement all ViewProviders.
// This class is merely intended to make the simple apps easier to write.
class ViewProviderApp : public ApplicationDelegate {
 public:
  ViewProviderApp();
  ~ViewProviderApp() override;

  ApplicationImpl* app_impl() { return app_impl_; }

  // |ApplicationDelegate|:
  void Initialize(ApplicationImpl* app) override;
  bool ConfigureIncomingConnection(
      ServiceProviderImpl* service_provider_impl) override;

  // Called by the ViewProvider to create a view.
  // This method may be called multiple times in the case where the
  // view provider is asked to create multiple view instances.
  //
  // The |view_provider_url| is the connection URL of the view provider request.
  //
  // The |view_owner_request| should be attached to the newly created view
  // and closed or left pending if the view could not be created.
  //
  // The |services| parameter is used to receive services from the view
  // on behalf of the caller.
  //
  // The |exposed_services| parameters is used to provide services to
  // the view from the caller.
  virtual void CreateView(
      const std::string& view_provider_url,
      InterfaceRequest<ViewOwner> view_owner_request,
      InterfaceRequest<ServiceProvider> services,
      InterfaceHandle<ServiceProvider> exposed_services) = 0;

 private:
  class DelegatingViewProvider;

  void CreateView(DelegatingViewProvider* provider,
                  const std::string& view_provider_url,
                  InterfaceRequest<ViewOwner> view_owner_request,
                  InterfaceRequest<ServiceProvider> services,
                  InterfaceHandle<ServiceProvider> exposed_services);

  ApplicationImpl* app_impl_ = nullptr;
  StrongBindingSet<ViewProvider> bindings_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(ViewProviderApp);
};

}  // namespace ui
}  // namespace mojo

#endif  // MOJO_UI_VIEW_PROVIDER_APP_H_
