// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <string>

#include "base/bind.h"
#include "base/macros.h"
#include "base/memory/scoped_ptr.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/data_pipe_utils/data_pipe_utils.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/ui/content_viewer_app.h"
#include "mojo/ui/ganesh_view.h"
#include "third_party/skia/include/core/SkBitmap.h"
#include "third_party/skia/include/core/SkCanvas.h"
#include "third_party/skia/include/core/SkImage.h"
#include "third_party/skia/include/core/SkSurface.h"
#include "ui/gfx/codec/png_codec.h"

namespace examples {

namespace {
constexpr uint32_t kContentImageResourceId = 1;
constexpr uint32_t kRootNodeId = mojo::gfx::composition::kSceneRootNodeId;
}  // namespace

class PNGView : public mojo::ui::GaneshView {
 public:
  PNGView(mojo::InterfaceHandle<mojo::ApplicationConnector> app_connector,
          mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
          const skia::RefPtr<SkImage>& image)
      : GaneshView(app_connector.Pass(),
                   view_owner_request.Pass(),
                   "PNGViewer"),
        image_(image) {
    DCHECK(image_);
  }

  ~PNGView() override {}

 private:
  // |GaneshView|:
  void OnPropertiesChanged(
      uint32_t old_scene_version,
      mojo::ui::ViewPropertiesPtr old_properties) override {
    UpdateScene();
  }

  void UpdateScene() {
    if (!properties())
      return;

    auto update = mojo::gfx::composition::SceneUpdate::New();

    const mojo::Size& size = *properties()->view_layout->size;
    if (size.width > 0 && size.height > 0) {
      mojo::RectF bounds;
      bounds.width = size.width;
      bounds.height = size.height;

      mojo::gfx::composition::ResourcePtr content_resource =
          ganesh_renderer()->DrawCanvas(
              size, base::Bind(&PNGView::DrawContent, base::Unretained(this)));
      DCHECK(content_resource);
      update->resources.insert(kContentImageResourceId,
                               content_resource.Pass());

      auto root_node = mojo::gfx::composition::Node::New();
      root_node->op = mojo::gfx::composition::NodeOp::New();
      root_node->op->set_image(mojo::gfx::composition::ImageNodeOp::New());
      root_node->op->get_image()->content_rect = bounds.Clone();
      root_node->op->get_image()->image_resource_id = kContentImageResourceId;
      update->nodes.insert(kRootNodeId, root_node.Pass());
    } else {
      auto root_node = mojo::gfx::composition::Node::New();
      update->nodes.insert(kRootNodeId, root_node.Pass());
    }

    scene()->Update(update.Pass());

    auto metadata = mojo::gfx::composition::SceneMetadata::New();
    metadata->version = scene_version();
    scene()->Publish(metadata.Pass());
  }

  void DrawContent(const mojo::skia::GaneshContext::Scope& ganesh_scope,
                   const mojo::Size& size,
                   SkCanvas* canvas) {
    canvas->clear(SK_ColorBLACK);

    int32_t w, h;
    if (size.width * image_->height() < size.height * image_->width()) {
      w = size.width;
      h = image_->height() * size.width / image_->width();
    } else {
      w = image_->width() * size.height / image_->height();
      h = size.height;
    }
    canvas->drawImageRect(
        image_.get(), SkRect::MakeWH(image_->width(), image_->height()),
        SkRect::MakeXYWH((size.width - w) / 2, (size.height - h) / 2, w, h),
        nullptr);
  }

  skia::RefPtr<SkImage> image_;

  DISALLOW_COPY_AND_ASSIGN(PNGView);
};

class PNGContentViewProviderApp : public mojo::ui::ViewProviderApp {
 public:
  PNGContentViewProviderApp(skia::RefPtr<SkImage> image) : image_(image) {
    DCHECK(image_);
  }

  ~PNGContentViewProviderApp() override {}

  void CreateView(
      const std::string& connection_url,
      mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
      mojo::InterfaceRequest<mojo::ServiceProvider> services,
      mojo::InterfaceHandle<mojo::ServiceProvider> exposed_services) override {
    new PNGView(mojo::CreateApplicationConnector(app_impl()->shell()),
                view_owner_request.Pass(), image_);
  }

 private:
  skia::RefPtr<SkImage> image_;

  DISALLOW_COPY_AND_ASSIGN(PNGContentViewProviderApp);
};

class PNGContentViewerApp : public mojo::ui::ContentViewerApp {
 public:
  PNGContentViewerApp() {}

  ~PNGContentViewerApp() override {}

  mojo::ui::ViewProviderApp* LoadContent(
      const std::string& content_handler_url,
      mojo::URLResponsePtr response) override {
    std::string data;
    mojo::common::BlockingCopyToString(response->body.Pass(), &data);
    SkBitmap bitmap;
    if (!::gfx::PNGCodec::Decode(
            reinterpret_cast<const unsigned char*>(data.data()), data.length(),
            &bitmap) ||
        bitmap.empty()) {
      LOG(ERROR) << "Could not decode PNG.";
      return nullptr;
    }

    return new PNGContentViewProviderApp(
        skia::AdoptRef(SkImage::NewFromBitmap(bitmap)));
  }

 private:
  DISALLOW_COPY_AND_ASSIGN(PNGContentViewerApp);
};

}  // namespace examples

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(new examples::PNGContentViewerApp());
  return runner.Run(application_request);
}
