// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_COMMON_CPP_VIDEO_RENDERER_H_
#define MOJO_SERVICES_MEDIA_COMMON_CPP_VIDEO_RENDERER_H_

#include <memory>
#include <queue>

#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/media/common/cpp/mapped_shared_buffer.h"
#include "mojo/services/media/common/cpp/timeline_function.h"
#include "mojo/services/media/common/cpp/video_converter.h"
#include "mojo/services/media/common/interfaces/media_transport.mojom.h"
#include "mojo/services/media/core/interfaces/media_renderer.mojom.h"

namespace mojo {
namespace media {

// Implements MediaRenderer for an app that wants to show video.
class VideoRenderer : public MediaRenderer,
                      public MediaConsumer,
                      public MediaTimelineControlSite,
                      public TimelineConsumer {
 public:
  VideoRenderer();

  ~VideoRenderer() override;

  void Bind(InterfaceRequest<MediaRenderer> renderer_request);

  // Gets an RGBA video frame corresponding to the specified reference time.
  // |width| and |height| refer to |rgba_buffer|.
  void GetRgbaFrame(uint8_t* rgba_buffer,
                    size_t width,
                    size_t height,
                    int64_t reference_time);

 private:
  struct PacketAndCallback {
    PacketAndCallback(MediaPacketPtr packet,
                      const SendPacketCallback& callback);

    ~PacketAndCallback();

    MediaPacketPtr packet_;
    SendPacketCallback callback_;
  };

  // MediaRenderer implementation.
  void GetSupportedMediaTypes(
      const GetSupportedMediaTypesCallback& callback) override;

  void SetMediaType(MediaTypePtr media_type) override;

  void GetConsumer(InterfaceRequest<MediaConsumer> consumer_request) override;

  void GetTimelineControlSite(
      InterfaceRequest<MediaTimelineControlSite> control_site_request) override;

  // MediaConsumer implementation.
  void SetBuffer(ScopedSharedBufferHandle buffer,
                 const SetBufferCallback& callback) override;

  void SendPacket(MediaPacketPtr packet,
                  const SendPacketCallback& callback) override;

  void Prime(const PrimeCallback& callback) override;

  void Flush(const FlushCallback& callback) override;

  // MediaTimelineControlSite implementation.
  void GetStatus(uint64_t version_last_seen,
                 const GetStatusCallback& callback) override;

  void GetTimelineConsumer(
      InterfaceRequest<TimelineConsumer> timeline_consumer_request) override;

  // TimelineConsumer implementation.
  void SetTimelineTransform(
      int64_t subject_time,
      uint32_t reference_delta,
      uint32_t subject_delta,
      int64_t effective_reference_time,
      int64_t effective_subject_time,
      const SetTimelineTransformCallback& callback) override;

  // Clears the pending timeline function and calls its associated callback
  // with the indicated completed status.
  void ClearPendingTimelineFunction(bool completed);

  // Apply a pending timeline change if there is one an it's due.
  void MaybeApplyPendingTimelineChange(int64_t reference_time);

  // Publishes end-of-stream as needed.
  void MaybePublishEndOfStream();

  // Sends status updates to waiting callers of GetStatus.
  void SendStatusUpdates();

  // Calls the callback with the current status.
  void CompleteGetStatus(const GetStatusCallback& callback);

  Binding<MediaRenderer> renderer_binding_;
  Binding<MediaConsumer> consumer_binding_;
  Binding<MediaTimelineControlSite> control_site_binding_;
  Binding<TimelineConsumer> timeline_consumer_binding_;
  MappedSharedBuffer shared_buffer_;
  std::queue<PacketAndCallback> packet_queue_;
  TimelineFunction current_timeline_function_;
  TimelineFunction pending_timeline_function_;
  SetTimelineTransformCallback set_timeline_transform_callback_;
  int64_t end_of_stream_pts_ = kUnspecifiedTime;
  bool end_of_stream_published_ = false;
  uint64_t status_version_ = 1u;
  std::vector<GetStatusCallback> pending_status_callbacks_;
  VideoConverter converter_;
};

}  // namespace media
}  // namespace moj

#endif  // MOJO_SERVICES_MEDIA_COMMON_CPP_VIDEO_RENDERER_H_
