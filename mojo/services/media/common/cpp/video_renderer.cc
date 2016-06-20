// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <limits>

#include "mojo/services/media/common/cpp/timeline.h"
#include "mojo/services/media/common/cpp/video_renderer.h"

namespace mojo {
namespace media {

VideoRenderer::VideoRenderer()
    : renderer_binding_(this),
      consumer_binding_(this),
      control_site_binding_(this),
      timeline_consumer_binding_(this) {}

VideoRenderer::~VideoRenderer() {}

void VideoRenderer::Bind(InterfaceRequest<MediaRenderer> renderer_request) {
  renderer_binding_.Bind(renderer_request.Pass());
}

void VideoRenderer::GetRgbaFrame(uint8_t* rgba_buffer,
                                 size_t width,
                                 size_t height,
                                 int64_t reference_time) {
  MaybeApplyPendingTimelineChange(reference_time);
  MaybePublishEndOfStream();

  int64_t presentation_time = current_timeline_function_(reference_time);

  // Discard empty and old packets. We keep one packet around even if it's old,
  // so we can show an old frame instead of no frame when we starve.
  while (!packet_queue_.empty() &&
         (!packet_queue_.front().packet_->payload ||
          packet_queue_.front().packet_->payload->length == 0 ||
          (packet_queue_.size() > 1 &&
           packet_queue_.front().packet_->pts < presentation_time))) {
    // TODO(dalesat): Add hysteresis.
    packet_queue_.pop();
  }

  // TODO(dalesat): Detect starvation.

  if (packet_queue_.empty()) {
    memset(rgba_buffer, 0, width * height * 4);
  } else {
    const MediaPacketPtr& packet = packet_queue_.front().packet_;
    converter_.ConvertFrame(
        rgba_buffer, width, height,
        shared_buffer_.PtrFromOffset(packet->payload->offset),
        packet->payload->length);
  }
}

void VideoRenderer::GetSupportedMediaTypes(
    const GetSupportedMediaTypesCallback& callback) {
  VideoMediaTypeSetDetailsPtr video_details = VideoMediaTypeSetDetails::New();
  video_details->min_width = 1;
  video_details->max_width = std::numeric_limits<uint32_t>::max();
  video_details->min_height = 1;
  video_details->max_height = std::numeric_limits<uint32_t>::max();
  MediaTypeSetPtr supported_type = MediaTypeSet::New();
  supported_type->medium = MediaTypeMedium::VIDEO;
  supported_type->details = MediaTypeSetDetails::New();
  supported_type->details->set_video(video_details.Pass());
  supported_type->encodings = Array<String>::New(1);
  supported_type->encodings[0] = MediaType::kVideoEncodingUncompressed;
  Array<MediaTypeSetPtr> supported_types = Array<MediaTypeSetPtr>::New(1);
  supported_types[0] = supported_type.Pass();
  callback.Run(supported_types.Pass());
}

void VideoRenderer::SetMediaType(MediaTypePtr media_type) {
  MOJO_DCHECK(media_type);
  MOJO_DCHECK(media_type->details);
  const VideoMediaTypeDetailsPtr& details = media_type->details->get_video();
  MOJO_DCHECK(details);

  converter_.SetMediaType(media_type);
}

void VideoRenderer::GetConsumer(
    InterfaceRequest<MediaConsumer> consumer_request) {
  consumer_binding_.Bind(consumer_request.Pass());
}

void VideoRenderer::GetTimelineControlSite(
    InterfaceRequest<MediaTimelineControlSite> control_site_request) {
  control_site_binding_.Bind(control_site_request.Pass());
}

void VideoRenderer::SetBuffer(ScopedSharedBufferHandle buffer,
                              const SetBufferCallback& callback) {
  shared_buffer_.InitFromHandle(buffer.Pass());
  callback.Run();
}

void VideoRenderer::SendPacket(MediaPacketPtr packet,
                               const SendPacketCallback& callback) {
  MOJO_DCHECK(packet);
  if (packet->end_of_stream) {
    MOJO_DLOG(INFO) << "END_OF_STREAM";
    end_of_stream_pts_ = packet->pts;
  }

  packet_queue_.emplace(packet.Pass(), callback);
}

void VideoRenderer::Prime(const PrimeCallback& callback) {
  callback.Run();
}

void VideoRenderer::Flush(const FlushCallback& callback) {
  while (!packet_queue_.empty()) {
    packet_queue_.pop();
  }
  callback.Run();
}

void VideoRenderer::GetStatus(uint64_t version_last_seen,
                              const GetStatusCallback& callback) {
  if (version_last_seen < status_version_) {
    CompleteGetStatus(callback);
  } else {
    pending_status_callbacks_.push_back(callback);
  }
}

void VideoRenderer::GetTimelineConsumer(
    InterfaceRequest<TimelineConsumer> timeline_consumer_request) {
  timeline_consumer_binding_.Bind(timeline_consumer_request.Pass());
}

void VideoRenderer::SetTimelineTransform(
    int64_t subject_time,
    uint32_t reference_delta,
    uint32_t subject_delta,
    int64_t effective_reference_time,
    int64_t effective_subject_time,
    const SetTimelineTransformCallback& callback) {
  // At most one of the effective times must be specified.
  MOJO_DCHECK(effective_reference_time == kUnspecifiedTime ||
              effective_subject_time == kUnspecifiedTime);
  // effective_subject_time can only be used if we're progressing already.
  MOJO_DCHECK(effective_subject_time == kUnspecifiedTime ||
              current_timeline_function_.subject_delta() != 0);
  MOJO_DCHECK(reference_delta != 0);

  if (subject_time != kUnspecifiedTime &&
      end_of_stream_pts_ != kUnspecifiedTime) {
    end_of_stream_pts_ = kUnspecifiedTime;
    end_of_stream_published_ = false;
  }

  if (effective_subject_time != kUnspecifiedTime) {
    // Infer effective_reference_time from effective_subject_time.
    effective_reference_time =
        current_timeline_function_.ApplyInverse(effective_subject_time);

    if (subject_time == kUnspecifiedTime) {
      // Infer subject_time from effective_subject_time.
      subject_time = effective_subject_time;
    }
  } else {
    if (effective_reference_time == kUnspecifiedTime) {
      // Neither effective time was specified. Effective time is now.
      effective_reference_time = Timeline::local_now();
    }

    if (subject_time == kUnspecifiedTime) {
      // Infer subject_time from effective_reference_time.
      subject_time = current_timeline_function_(effective_reference_time);
    }
  }

  // Eject any previous pending change.
  ClearPendingTimelineFunction(false);

  // Queue up the new pending change.
  pending_timeline_function_ = TimelineFunction(
      effective_reference_time, subject_time, reference_delta, subject_delta);

  set_timeline_transform_callback_ = callback;
}

void VideoRenderer::ClearPendingTimelineFunction(bool completed) {
  pending_timeline_function_ =
      TimelineFunction(kUnspecifiedTime, kUnspecifiedTime, 1, 0);
  if (!set_timeline_transform_callback_.is_null()) {
    set_timeline_transform_callback_.Run(completed);
    set_timeline_transform_callback_.reset();
  }
}

void VideoRenderer::MaybeApplyPendingTimelineChange(int64_t reference_time) {
  if (pending_timeline_function_.reference_time() == kUnspecifiedTime ||
      pending_timeline_function_.reference_time() > reference_time) {
    return;
  }

  current_timeline_function_ = pending_timeline_function_;
  pending_timeline_function_ =
      TimelineFunction(kUnspecifiedTime, kUnspecifiedTime, 1, 0);

  if (!set_timeline_transform_callback_.is_null()) {
    set_timeline_transform_callback_.Run(true);
    set_timeline_transform_callback_.reset();
  }

  SendStatusUpdates();
}

void VideoRenderer::MaybePublishEndOfStream() {
  if (!end_of_stream_published_ && end_of_stream_pts_ != kUnspecifiedTime &&
      current_timeline_function_(Timeline::local_now()) >= end_of_stream_pts_) {
    end_of_stream_published_ = true;
    SendStatusUpdates();
  }
}

void VideoRenderer::SendStatusUpdates() {
  ++status_version_;

  std::vector<GetStatusCallback> pending_status_callbacks;
  pending_status_callbacks_.swap(pending_status_callbacks);

  for (const GetStatusCallback& pending_status_callback :
       pending_status_callbacks) {
    CompleteGetStatus(pending_status_callback);
  }
}

void VideoRenderer::CompleteGetStatus(const GetStatusCallback& callback) {
  MediaTimelineControlSiteStatusPtr status =
      MediaTimelineControlSiteStatus::New();
  status->timeline_transform =
      TimelineTransform::From(current_timeline_function_);
  status->end_of_stream =
      end_of_stream_pts_ != kUnspecifiedTime &&
      current_timeline_function_(Timeline::local_now()) >= end_of_stream_pts_;
  callback.Run(status_version_, status.Pass());
}

VideoRenderer::PacketAndCallback::PacketAndCallback(
    MediaPacketPtr packet,
    const SendPacketCallback& callback)
    : packet_(packet.Pass()), callback_(callback) {
  MOJO_DCHECK(packet_);
  MOJO_DCHECK(!callback.is_null());
}

VideoRenderer::PacketAndCallback::~PacketAndCallback() {
  callback_.Run(MediaConsumer::SendResult::CONSUMED);
}

}  // namespace media
}  // namespace mojo
