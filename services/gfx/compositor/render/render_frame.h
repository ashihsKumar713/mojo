// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_RENDER_RENDER_FRAME_H_
#define SERVICES_GFX_COMPOSITOR_RENDER_RENDER_FRAME_H_

#include "base/macros.h"
#include "base/memory/ref_counted.h"
#include "mojo/services/gfx/composition/interfaces/scheduling.mojom.h"
#include "skia/ext/refptr.h"
#include "third_party/skia/include/core/SkRect.h"

class SkCanvas;
class SkPicture;

namespace compositor {

// Describes a frame to be rendered.
//
// Render objects are thread-safe, immutable, and reference counted.
// They have no direct references to the scene graph.
class RenderFrame : public base::RefCountedThreadSafe<RenderFrame> {
 public:
  // Contains metadata about a particular |RenderFrame| used for tracing
  // and statistics.
  class Metadata {
   public:
    Metadata(const mojo::gfx::composition::FrameInfo& frame_info,
             int64_t composition_time);
    ~Metadata();

    const mojo::gfx::composition::FrameInfo& frame_info() const {
      return frame_info_;
    }
    int64_t composition_time() const { return composition_time_; }

   private:
    mojo::gfx::composition::FrameInfo frame_info_;
    int64_t composition_time_;
  };

  // Creates an empty render frame with no content.
  RenderFrame(const Metadata& metadata, const SkIRect& viewport);

  // Creates render frame backed by a picture.
  RenderFrame(const Metadata& metadata,
              const SkIRect& viewport,
              const skia::RefPtr<SkPicture>& picture);

  // Gets metadata about the frame.
  const Metadata& metadata() const { return metadata_; }

  // Gets the frame's viewport in pixels.
  const SkIRect& viewport() const { return viewport_; }

  // Gets the underlying picture to rasterize, or null if the frame is empty.
  const skia::RefPtr<SkPicture>& picture() const { return picture_; }

  // Draws the contents of the frame to a canvas.
  void Draw(SkCanvas* canvas) const;

 private:
  friend class base::RefCountedThreadSafe<RenderFrame>;
  friend class RenderFrameBuilder;

  ~RenderFrame();

  Metadata metadata_;
  SkIRect viewport_;
  skia::RefPtr<SkPicture> picture_;

  DISALLOW_COPY_AND_ASSIGN(RenderFrame);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_RENDER_RENDER_FRAME_H_
