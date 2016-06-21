// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_UI_MOTOWN_VIDEO_MOTOWN_VIDEO_VIEW_H_
#define EXAMPLES_UI_MOTOWN_VIDEO_MOTOWN_VIDEO_VIEW_H_

#include <memory>
#include <queue>

#include "mojo/services/media/common/cpp/timeline_function.h"
#include "mojo/services/media/common/cpp/video_renderer.h"
#include "mojo/services/media/control/interfaces/media_player.mojom.h"
#include "mojo/ui/gl_view.h"
#include "mojo/ui/input_handler.h"

namespace examples {

class MotownVideoView : public mojo::ui::GLView,
                        public mojo::ui::InputListener {
 public:
  MotownVideoView(
      mojo::InterfaceHandle<mojo::ApplicationConnector> app_connector,
      mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
      const std::string& origin_url);

  ~MotownVideoView() override;

 private:
  static constexpr float kMargin = 3.0f;
  static constexpr float kProgressBarHeight = 5.0f;
  static constexpr float kSymbolVerticalSpacing = 20.0f;
  static constexpr float kSymbolWidth = 30.0f;
  static constexpr float kSymbolHeight = 40.0f;
  enum class State { kPaused, kPlaying, kEnded };

  // |GLView|:
  void OnDraw() override;

  // |InputListener|:
  void OnEvent(mojo::EventPtr event, const OnEventCallback& callback) override;

  // Creates a rectangle node.
  mojo::gfx::composition::NodePtr MakeRectNode(
      mojo::RectFPtr content_rect,
      mojo::gfx::composition::ColorPtr color);

  // Creates a node for the video.
  mojo::gfx::composition::NodePtr MakeVideoNode(
      const mojo::gfx::composition::SceneUpdatePtr& update);

  mojo::gfx::composition::ResourcePtr DrawVideoTexture(
      const mojo::Size& size,
      int64_t presentation_time);

  mojo::RectFPtr CreateRectF(const mojo::Size& size) {
    auto rectF = mojo::RectF::New();
    rectF->x = 0.0f;
    rectF->y = 0.0f;
    rectF->width = size.width;
    rectF->height = size.height;
    return rectF;
  }

  mojo::gfx::composition::ColorPtr CreateColor(uint8_t red,
                                               uint8_t green,
                                               uint8_t blue,
                                               uint8_t alpha = 0xff) {
    auto color = mojo::gfx::composition::Color::New();
    color->red = red;
    color->green = green;
    color->blue = blue;
    color->alpha = alpha;
    return color;
  }

  bool Contains(const mojo::RectF& rect, float x, float y) {
    return rect.x <= x && rect.y <= y && rect.x + rect.width >= x &&
           rect.y + rect.height >= y;
  }

  // Ensures that buffer_ points to a buffer of the indicated size.
  void EnsureBuffer(const mojo::Size& size);

  // Handles a status update from the player. When called with the default
  // argument values, initiates status updates.
  void HandleStatusUpdates(
      uint64_t version = mojo::media::MediaPlayer::kInitialStatus,
      mojo::media::MediaPlayerStatusPtr status = nullptr);

  // Toggles between play and pause.
  void TogglePlayPause();

  // Returns progress in the range 0.0 to 1.0.
  float progress() const;

  mojo::ui::InputHandler input_handler_;
  std::unique_ptr<uint8_t[]> buffer_;
  mojo::Size buffer_size_;
  mojo::media::VideoRenderer video_renderer_;
  mojo::media::MediaPlayerPtr media_player_;
  State previous_state_ = State::kPaused;
  State state_ = State::kPaused;
  mojo::media::TimelineFunction timeline_function_;
  mojo::media::MediaMetadataPtr metadata_;
  mojo::RectF progress_bar_rect_;
  bool metadata_shown_ = false;

  DISALLOW_COPY_AND_ASSIGN(MotownVideoView);
};

}  // namespace examples

#endif  // EXAMPLES_UI_MOTOWN_VIDEO_MOTOWN_VIDEO_VIEW_H_
