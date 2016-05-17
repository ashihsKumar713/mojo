// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/ganesh_view.h"

#include "base/logging.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/skia/ganesh_texture_surface.h"
#include "third_party/skia/include/core/SkCanvas.h"

namespace mojo {
namespace ui {

GaneshView::GaneshView(
    mojo::ApplicationImpl* app_impl,
    mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
    const std::string& label)
    : BaseView(app_impl, view_owner_request.Pass(), label),
      ganesh_renderer_(
          new mojo::skia::GaneshContext(mojo::GLContext::CreateOffscreen(
              mojo::ApplicationConnectorPtr::Create(
                  mojo::CreateApplicationConnector(app_impl->shell()))
                  .get()))) {}

GaneshView::~GaneshView() {}

}  // namespace ui
}  // namespace mojo
