// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/gl_view.h"

#include "base/logging.h"
#include "mojo/public/cpp/application/connect.h"

namespace mojo {
namespace ui {

GLView::GLView(mojo::ApplicationImpl* app_impl,
               mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
               const std::string& label)
    : BaseView(app_impl, view_owner_request.Pass(), label),
      gl_renderer_(mojo::GLContext::CreateOffscreen(
          ApplicationConnectorPtr::Create(
              mojo::CreateApplicationConnector(app_impl->shell()))
              .get())) {}

GLView::~GLView() {}

}  // namespace ui
}  // namespace mojo
