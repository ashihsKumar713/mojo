// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_FACTORY_MEDIA_PLAYER_IMPL_H_
#define MOJO_SERVICES_MEDIA_FACTORY_MEDIA_PLAYER_IMPL_H_

#include <limits>
#include <vector>

#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/media/common/cpp/timeline.h"
#include "mojo/services/media/common/cpp/timeline_function.h"
#include "mojo/services/media/common/interfaces/media_transport.mojom.h"
#include "mojo/services/media/control/interfaces/media_factory.mojom.h"
#include "mojo/services/media/core/interfaces/seeking_reader.mojom.h"
#include "mojo/services/media/core/interfaces/timeline_controller.mojom.h"
#include "services/media/common/mojo_publisher.h"
#include "services/media/factory_service/factory_service.h"
#include "services/media/framework/util/callback_joiner.h"

namespace mojo {
namespace media {

// Mojo agent that renders streams from an origin specified by URL.
class MediaPlayerImpl : public MediaFactoryService::Product<MediaPlayer>,
                        public MediaPlayer {
 public:
  static std::shared_ptr<MediaPlayerImpl> Create(
      InterfaceHandle<SeekingReader> reader,
      InterfaceHandle<MediaRenderer> audio_renderer,
      InterfaceHandle<MediaRenderer> video_renderer,
      InterfaceRequest<MediaPlayer> request,
      MediaFactoryService* owner);

  ~MediaPlayerImpl() override;

  // MediaPlayer implementation.
  void GetStatus(uint64_t version_last_seen,
                 const GetStatusCallback& callback) override;

  void Play() override;

  void Pause() override;

  void Seek(int64_t position) override;

 private:
  static constexpr int64_t kMinimumLeadTime = Timeline::ns_from_ms(30);

  // Internal state.
  enum class State {
    kWaiting,  // Waiting for some work to complete.
    kFlushed,  // Paused with no data in the pipeline.
    kPrimed,   // Paused with data in the pipeline.
    kPlaying,  // Time is progressing.
  };

  struct Stream {
    Stream();
    ~Stream();
    // TODO(dalesat): Have the sink enlist the decoder.
    MediaTypeConverterPtr decoder_;
    MediaSinkPtr sink_;
    // The following fields are just temporaries used to solve lambda capture
    // problems.
    MediaProducerPtr encoded_producer_;
    MediaProducerPtr decoded_producer_;
    InterfaceHandle<MediaRenderer> renderer_;
  };

  MediaPlayerImpl(InterfaceHandle<SeekingReader> reader,
                  InterfaceHandle<MediaRenderer> audio_renderer,
                  InterfaceHandle<MediaRenderer> video_renderer,
                  InterfaceRequest<MediaPlayer> request,
                  MediaFactoryService* owner);

  // Takes action based on current state.
  void Update();

  // Prepares a stream.
  void PrepareStream(Stream* stream,
                     size_t index,
                     const MediaTypePtr& input_media_type,
                     const std::function<void()>& callback);

  // Creates a sink for a stream.
  void CreateSink(Stream* stream,
                  const MediaTypePtr& input_media_type,
                  const std::function<void()>& callback);

  // Handles a metadata update from the demux. When called with the default
  // argument values, initiates demux metadata updates.
  void HandleDemuxMetadataUpdates(
      uint64_t version = MediaDemux::kInitialMetadata,
      MediaMetadataPtr metadata = nullptr);

  // Handles a status update from the control site. When called with the default
  // argument values, initiates control site. status updates.
  void HandleTimelineControlSiteStatusUpdates(
      uint64_t version = MediaTimelineControlSite::kInitialStatus,
      MediaTimelineControlSiteStatusPtr status = nullptr);

  MediaFactoryPtr factory_;
  MediaDemuxPtr demux_;
  MediaTimelineControllerPtr timeline_controller_;
  MediaTimelineControlSitePtr timeline_control_site_;
  TimelineConsumerPtr timeline_consumer_;
  std::vector<std::unique_ptr<Stream>> streams_;

  // The state we're currently in.
  State state_ = State::kWaiting;

  // The state we trying to transition to, either because the client has called
  // |Play| or |Pause| or because we've hit end-of-stream.
  State target_state_ = State::kFlushed;

  // Whether we're currently at end-of-stream.
  bool end_of_stream_ = false;

  // The position we want to seek to (because the client called Seek) or
  // kUnspecifiedTime, which indicates there's no desire to seek.
  int64_t target_position_ = kUnspecifiedTime;

  // The subject time to be used for SetTimelineTransform. The value is
  // kUnspecifiedTime if there's no need to seek or the position we want to
  // seek to if there is.
  int64_t transform_subject_time_ = kUnspecifiedTime;

  // A function that translates local time into presentation time in ns.
  TimelineFunction timeline_function_;

  CallbackJoiner set_transform_joiner_;
  MediaMetadataPtr metadata_;
  MojoPublisher<GetStatusCallback> status_publisher_;

  // The following fields are just temporaries used to solve lambda capture
  // problems.
  InterfaceHandle<MediaRenderer> audio_renderer_;
  InterfaceHandle<MediaRenderer> video_renderer_;
};

}  // namespace media
}  // namespace mojo

#endif  // MOJO_SERVICES_MEDIA_FACTORY_MEDIA_PLAYER_IMPL_H_
