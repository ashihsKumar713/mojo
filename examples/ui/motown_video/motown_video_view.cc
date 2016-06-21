// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <iomanip>

#include "examples/ui/motown_video/motown_video_view.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/services/geometry/cpp/geometry_util.h"
#include "mojo/services/media/audio/interfaces/audio_server.mojom.h"
#include "mojo/services/media/audio/interfaces/audio_track.mojom.h"
#include "mojo/services/media/common/cpp/timeline.h"
#include "mojo/services/media/control/interfaces/media_factory.mojom.h"

#ifndef GL_GLEXT_PROTOTYPES
#define GL_GLEXT_PROTOTYPES
#endif

#include <GLES2/gl2.h>
#include <GLES2/gl2extmojo.h>

#include <cmath>

#include "base/bind.h"
#include "mojo/public/cpp/system/time.h"
#include "mojo/services/geometry/cpp/geometry_util.h"

namespace examples {

namespace {
constexpr uint32_t kVidImageResourceId = 1;
constexpr uint32_t kRootNodeId = mojo::gfx::composition::kSceneRootNodeId;
}  // namespace

MotownVideoView::MotownVideoView(
    mojo::InterfaceHandle<mojo::ApplicationConnector> app_connector_in,
    mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
    const std::string& origin_url)
    : GLView(app_connector_in.Pass(),
             view_owner_request.Pass(),
             "Motown Video"),
      input_handler_(GetViewServiceProvider(), this) {
  mojo::media::MediaFactoryPtr factory;
  ConnectToService(app_connector(), "mojo:media_factory", GetProxy(&factory));

  mojo::media::AudioServerPtr audio_service;
  ConnectToService(app_connector(), "mojo:audio_server",
                   GetProxy(&audio_service));
  mojo::media::AudioTrackPtr audio_track;
  mojo::media::MediaRendererPtr audio_renderer;
  audio_service->CreateTrack(GetProxy(&audio_track), GetProxy(&audio_renderer));

  mojo::media::MediaRendererPtr video_renderer;
  mojo::InterfaceRequest<mojo::media::MediaRenderer> video_renderer_request =
      mojo::GetProxy(&video_renderer);
  video_renderer_.Bind(video_renderer_request.Pass());

  mojo::media::SeekingReaderPtr reader;
  factory->CreateNetworkReader(origin_url, GetProxy(&reader));
  factory->CreatePlayer(reader.Pass(), audio_renderer.Pass(),
                        video_renderer.Pass(), GetProxy(&media_player_));

  media_player_->Pause();

  HandleStatusUpdates();
}

MotownVideoView::~MotownVideoView() {}

void MotownVideoView::OnEvent(mojo::EventPtr event,
                              const OnEventCallback& callback) {
  MOJO_DCHECK(event);
  switch (event->action) {
    case mojo::EventType::POINTER_DOWN:
      MOJO_DCHECK(event->pointer_data);
      if (Contains(progress_bar_rect_, event->pointer_data->x,
                   event->pointer_data->y)) {
        media_player_->Seek((event->pointer_data->x - progress_bar_rect_.x) *
                            metadata_->duration / progress_bar_rect_.width);
        if (state_ != State::kPlaying) {
          media_player_->Play();
        }
      } else {
        TogglePlayPause();
      }
      break;
    case mojo::EventType::KEY_PRESSED:
      MOJO_DCHECK(event->key_data);
      if (!event->key_data || !event->key_data->is_char) {
        break;
      }
      switch (event->key_data->character) {
        case ' ':
          TogglePlayPause();
          break;
      }
      break;
    default:
      break;
  }
  callback.Run(false);
}

void MotownVideoView::OnDraw() {
  DCHECK(properties());

  // Update the contents of the scene.
  auto update = mojo::gfx::composition::SceneUpdate::New();

  const mojo::Size& view_size = *properties()->view_layout->size;
  if (view_size.width == 0 || view_size.height == 0) {
    update->nodes.insert(kRootNodeId, mojo::gfx::composition::Node::New());
  } else {
    auto children = mojo::Array<uint32_t>::New(0);

    mojo::Size video_size = video_renderer_.GetSize();
    if (video_size.width == 0 || video_size.height == 0) {
      // No video. Position the progress bar to stretch across the view with
      // margins.
      progress_bar_rect_.x = kMargin;
      progress_bar_rect_.y = kMargin;
      progress_bar_rect_.width = view_size.width - kMargin - kMargin;
      progress_bar_rect_.height = kProgressBarHeight;
    } else {
      // Yes video! Shrink to fit the video horizontally, if necessary,
      // otherwise center it.
      float width_scale = static_cast<float>(view_size.width) /
                          static_cast<float>(video_size.width);
      float height_scale = static_cast<float>(view_size.height) /
                           static_cast<float>(video_size.height);
      float scale = std::min(width_scale, height_scale);
      float translate_x = 0.0f;

      if (scale > 1.0f) {
        scale = 1.0f;
        translate_x = (view_size.width - video_size.width) / 2.0f;
      }

      mojo::TransformPtr transform = mojo::Translate(
          mojo::CreateScaleTransform(scale, scale), translate_x, kMargin);

      // Use the transform to position the progress bar under the video.
      mojo::PointF progress_bar_left;
      progress_bar_left.x = 0.0f;
      progress_bar_left.y = video_size.height;
      progress_bar_left = TransformPoint(*transform, progress_bar_left);

      mojo::PointF progress_bar_right;
      progress_bar_right.x = video_size.width;
      progress_bar_right.y = video_size.height;
      progress_bar_right = TransformPoint(*transform, progress_bar_right);

      progress_bar_rect_.x = progress_bar_left.x;
      progress_bar_rect_.y = progress_bar_left.y + kMargin;
      progress_bar_rect_.width = progress_bar_right.x - progress_bar_left.x;
      progress_bar_rect_.height = kProgressBarHeight;

      // Create the image node and apply the transform to it to scale and
      // position it properly.
      auto video_node = MakeVideoNode(update);
      video_node->content_transform = transform.Pass();
      update->nodes.insert(children.size() + 1, video_node.Pass());
      children.push_back(children.size() + 1);
    }

    // Show progress bar, a blue rectangle on top of a gray rectangle, based on
    // the geometry established above.
    update->nodes.insert(children.size() + 1,
                         MakeRectNode(progress_bar_rect_.Clone(),
                                      CreateColor(0xaa, 0xaa, 0xaa)));
    children.push_back(children.size() + 1);

    mojo::RectFPtr progress_rect = progress_bar_rect_.Clone();
    progress_rect->width *= progress();

    update->nodes.insert(
        children.size() + 1,
        MakeRectNode(progress_rect.Pass(), CreateColor(0x55, 0x55, 0xff)));
    children.push_back(children.size() + 1);

    if (state_ == State::kPlaying) {
      // Show pause symbol consisting of two gray rectangle nodes side-by-side.
      mojo::RectF rect;
      rect.x = (view_size.width - kSymbolWidth) / 2.0f;
      rect.y = progress_bar_rect_.y + progress_bar_rect_.height +
               kSymbolVerticalSpacing;
      rect.width = kSymbolWidth / 3.0f;
      rect.height = kSymbolHeight;

      update->nodes.insert(
          children.size() + 1,
          MakeRectNode(rect.Clone(), CreateColor(0xaa, 0xaa, 0xaa)));
      children.push_back(children.size() + 1);

      rect.x = (view_size.width + kSymbolWidth / 3.0f) / 2.0f;

      update->nodes.insert(
          children.size() + 1,
          MakeRectNode(rect.Clone(), CreateColor(0xaa, 0xaa, 0xaa)));
      children.push_back(children.size() + 1);
    } else {
      // Show a play symbol consisting of gray downward-skewed rectangle node
      // partially obscured by an black upward-skewed rectangle node.
      mojo::RectF rect;
      rect.x = 0;
      rect.y = 0;
      rect.width = kSymbolWidth;
      rect.height = kSymbolHeight;

      auto skewed_down =
          MakeRectNode(rect.Clone(), CreateColor(0xaa, 0xaa, 0xaa));

      mojo::TransformPtr transform = mojo::CreateTranslationTransform(
          view_size.width / 2.0f - kSymbolWidth / 2.0f,
          progress_bar_rect_.y + progress_bar_rect_.height +
              kSymbolVerticalSpacing);
      transform->matrix[4] = kSymbolHeight / 2.0f / kSymbolWidth;

      skewed_down->content_transform = transform.Pass();

      update->nodes.insert(children.size() + 1, skewed_down.Pass());
      children.push_back(children.size() + 1);

      auto skewed_up = MakeRectNode(rect.Clone(), CreateColor(0, 0, 0));

      transform = mojo::CreateTranslationTransform(
          (view_size.width - kSymbolWidth) / 2.0f,
          progress_bar_rect_.y + progress_bar_rect_.height +
              kSymbolVerticalSpacing + kSymbolHeight);
      transform->matrix[4] = -kSymbolHeight / 2.0f / kSymbolWidth;

      skewed_up->content_transform = transform.Pass();

      update->nodes.insert(children.size() + 1, skewed_up.Pass());
      children.push_back(children.size() + 1);
    }

    // Create the root node.
    auto root = MakeRectNode(CreateRectF(view_size), CreateColor(0, 0, 0));
    root->child_node_ids = children.Pass();
    update->nodes.insert(kRootNodeId, root.Pass());
  }

  scene()->Update(update.Pass());

  // Publish the scene.
  scene()->Publish(CreateSceneMetadata());

  // Loop!
  Invalidate();
}

mojo::gfx::composition::NodePtr MotownVideoView::MakeRectNode(
    mojo::RectFPtr content_rect,
    mojo::gfx::composition::ColorPtr color) {
  auto rect_node = mojo::gfx::composition::Node::New();
  rect_node->hit_test_behavior = mojo::gfx::composition::HitTestBehavior::New();
  rect_node->op = mojo::gfx::composition::NodeOp::New();
  rect_node->op->set_rect(mojo::gfx::composition::RectNodeOp::New());
  rect_node->op->get_rect()->content_rect = content_rect.Pass();
  rect_node->op->get_rect()->color = color.Pass();

  return rect_node.Pass();
}

mojo::gfx::composition::NodePtr MotownVideoView::MakeVideoNode(
    const mojo::gfx::composition::SceneUpdatePtr& update) {
  mojo::Size video_size = video_renderer_.GetSize();

  if (video_size.width == 0 || video_size.height == 0) {
    return mojo::gfx::composition::Node::New();
  }

  mojo::gfx::composition::ResourcePtr vid_resource = DrawVideoTexture(
      video_size, frame_tracker().frame_info().presentation_time);
  DCHECK(vid_resource);
  update->resources.insert(kVidImageResourceId, vid_resource.Pass());

  auto video_node = mojo::gfx::composition::Node::New();
  video_node->hit_test_behavior =
      mojo::gfx::composition::HitTestBehavior::New();
  video_node->op = mojo::gfx::composition::NodeOp::New();
  video_node->op->set_image(mojo::gfx::composition::ImageNodeOp::New());
  video_node->op->get_image()->content_rect = CreateRectF(video_size);
  video_node->op->get_image()->image_resource_id = kVidImageResourceId;

  return video_node.Pass();
}

mojo::gfx::composition::ResourcePtr MotownVideoView::DrawVideoTexture(
    const mojo::Size& size,
    int64_t presentation_time) {
  mojo::GLContext::Scope gl_scope(gl_context());

  std::unique_ptr<mojo::GLTexture> gl_texture =
      gl_renderer()->GetTexture(gl_scope, size);

  EnsureBuffer(size);

  video_renderer_.GetRgbaFrame(
      buffer_.get(), size,
      mojo::media::Timeline::ns_from_us(presentation_time));

  glBindTexture(GL_TEXTURE_2D, gl_texture->texture_id());
  glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, size.width, size.height, 0, GL_RGBA,
               GL_UNSIGNED_BYTE, buffer_.get());

  return gl_renderer()->BindTextureResource(gl_scope, std::move(gl_texture));
}

void MotownVideoView::EnsureBuffer(const mojo::Size& size) {
  if (!buffer_ || buffer_size_ != size) {
    buffer_ =
        std::unique_ptr<uint8_t[]>(new uint8_t[size.height * size.width * 4]);
    buffer_size_ = size;
    memset(buffer_.get(), 0, size.height * size.width * 4);
  }
}

void MotownVideoView::HandleStatusUpdates(
    uint64_t version,
    mojo::media::MediaPlayerStatusPtr status) {
  if (status) {
    // Process status received from the player.
    if (status->timeline_transform) {
      timeline_function_ =
          status->timeline_transform.To<mojo::media::TimelineFunction>();
    }

    previous_state_ = state_;
    if (status->end_of_stream) {
      state_ = State::kEnded;
    } else if (timeline_function_.subject_delta() == 0) {
      state_ = State::kPaused;
    } else {
      state_ = State::kPlaying;
    }

    metadata_ = status->metadata.Pass();

    if (metadata_ && !metadata_shown_) {
      MOJO_DLOG(INFO) << "duration   " << std::fixed << std::setprecision(1)
                      << double(metadata_->duration) / 1000000000.0
                      << " seconds";
      MOJO_DLOG(INFO) << "title      "
                      << (metadata_->title ? metadata_->title : "<none>");
      MOJO_DLOG(INFO) << "artist     "
                      << (metadata_->artist ? metadata_->artist : "<none>");
      MOJO_DLOG(INFO) << "album      "
                      << (metadata_->album ? metadata_->album : "<none>");
      MOJO_DLOG(INFO) << "publisher  "
                      << (metadata_->publisher ? metadata_->publisher
                                               : "<none>");
      MOJO_DLOG(INFO) << "genre      "
                      << (metadata_->genre ? metadata_->genre : "<none>");
      MOJO_DLOG(INFO) << "composer   "
                      << (metadata_->composer ? metadata_->composer : "<none>");
      metadata_shown_ = true;
    }
  }

  // Request a status update.
  media_player_->GetStatus(
      version,
      [this](uint64_t version, mojo::media::MediaPlayerStatusPtr status) {
        HandleStatusUpdates(version, status.Pass());
      });
}

void MotownVideoView::TogglePlayPause() {
  switch (state_) {
    case State::kPaused:
      media_player_->Play();
      break;
    case State::kPlaying:
      media_player_->Pause();
      break;
    case State::kEnded:
      media_player_->Seek(0);
      media_player_->Play();
      break;
    default:
      break;
  }
}

float MotownVideoView::progress() const {
  if (!metadata_ || metadata_->duration == 0) {
    return 0.0f;
  }

  // Apply the timeline function to the current time.
  int64_t position = timeline_function_(mojo::media::Timeline::local_now());

  if (position < 0) {
    position = 0;
  }

  if (metadata_ && static_cast<uint64_t>(position) > metadata_->duration) {
    position = metadata_->duration;
  }

  return position / static_cast<float>(metadata_->duration);
}

}  // namespace examples
