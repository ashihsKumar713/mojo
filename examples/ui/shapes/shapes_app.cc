// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "examples/ui/shapes/shapes_app.h"

#include "examples/ui/shapes/shapes_view.h"
#include "mojo/public/cpp/application/connect.h"

namespace examples {

ShapesApp::ShapesApp() {}

ShapesApp::~ShapesApp() {}

void ShapesApp::CreateView(
    const std::string& connection_url,
    mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
    mojo::InterfaceRequest<mojo::ServiceProvider> services,
    mojo::InterfaceHandle<mojo::ServiceProvider> exposed_services) {
  new ShapesView(mojo::CreateApplicationConnector(app_impl()->shell()),
                 view_owner_request.Pass());
}

}  // namespace examples
