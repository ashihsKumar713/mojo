// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_SHADOWS_SHADOWS_VIEW_H_
#define EXAMPLES_SHADOWS_SHADOWS_VIEW_H_

#include <memory>

#include "examples/shadows/shadows_renderer.h"
#include "mojo/ui/choreographer.h"
#include "mojo/ui/gl_view.h"

namespace examples {

class ShadowsView : public mojo::ui::GLView,
                    public mojo::ui::ChoreographerDelegate {
 public:
  ShadowsView(mojo::InterfaceHandle<mojo::ApplicationConnector> app_connector,
              mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request);

  ~ShadowsView() override;

 private:
  // |GLView|:
  void OnPropertiesChanged(uint32_t old_scene_version,
                           mojo::ui::ViewPropertiesPtr old_properties) override;

  // |ChoreographerDelegate|:
  void OnDraw(const mojo::gfx::composition::FrameInfo& frame_info,
              const base::TimeDelta& time_delta) override;

  void Render(const mojo::GLContext::Scope& gl_scope, const mojo::Size& size);

  mojo::ui::Choreographer choreographer_;

  mojo::Size size_;
  std::unique_ptr<ShadowsRenderer> renderer_;

  DISALLOW_COPY_AND_ASSIGN(ShadowsView);
};

}  // namespace examples

#endif  // EXAMPLES_SHADOWS_SHADOWS_VIEW_H_
