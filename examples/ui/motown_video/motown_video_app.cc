// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <iostream>

#include "examples/ui/motown_video/motown_video_app.h"

#include "examples/ui/motown_video/motown_video_view.h"
#include "mojo/public/cpp/application/connect.h"

namespace examples {

MotownVideoApp::MotownVideoApp() {}

MotownVideoApp::~MotownVideoApp() {}

void MotownVideoApp::CreateView(
    const std::string& connection_url,
    mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
    mojo::InterfaceRequest<mojo::ServiceProvider> services) {
  new MotownVideoView(mojo::CreateApplicationConnector(shell()),
                      view_owner_request.Pass(),
                      "http://clips.vorwaerts-gmbh.de/big_buck_bunny.ogv");
}

}  // namespace examples
