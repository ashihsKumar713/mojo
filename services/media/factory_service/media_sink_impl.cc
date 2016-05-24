// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "mojo/services/media/common/cpp/timeline.h"
#include "mojo/services/media/common/cpp/timeline_function.h"
#include "services/media/factory_service/media_sink_impl.h"
#include "services/media/framework/util/conversion_pipeline_builder.h"
#include "services/media/framework_mojo/mojo_type_conversions.h"

namespace mojo {
namespace media {

// static
std::shared_ptr<MediaSinkImpl> MediaSinkImpl::Create(
    const String& destination_url,
    MediaTypePtr media_type,
    InterfaceRequest<MediaSink> request,
    MediaFactoryService* owner) {
  return std::shared_ptr<MediaSinkImpl>(new MediaSinkImpl(
      destination_url, media_type.Pass(), request.Pass(), owner));
}

MediaSinkImpl::MediaSinkImpl(const String& destination_url,
                             MediaTypePtr media_type,
                             InterfaceRequest<MediaSink> request,
                             MediaFactoryService* owner)
    : MediaFactoryService::Product<MediaSink>(this, request.Pass(), owner),
      consumer_(MojoConsumer::Create()),
      producer_(MojoProducer::Create()) {
  DCHECK(destination_url);
  DCHECK(media_type);

  status_publisher_.SetCallbackRunner([this](const GetStatusCallback& callback,
                                             uint64_t version) {
    MediaSinkStatusPtr status = MediaSinkStatus::New();
    status->state = (producer_state_ == MediaState::PAUSED && rate_ != 0.0)
                        ? MediaState::PLAYING
                        : producer_state_;
    status->timeline_transform = TimelineTransform::From(timeline_function_);
    callback.Run(version, status.Pass());
  });

  PartRef consumer_ref = graph_.Add(consumer_);
  PartRef producer_ref = graph_.Add(producer_);

  consumer_->SetPrimeRequestedCallback(
      [this](const MediaConsumer::PrimeCallback& callback) {
        ready_.When([this, callback]() {
          DCHECK(producer_);
          producer_->PrimeConnection(callback);
        });
      });
  consumer_->SetFlushRequestedCallback(
      [this, consumer_ref](const MediaConsumer::FlushCallback& callback) {
        ready_.When([this, consumer_ref, callback]() {
          DCHECK(producer_);
          graph_.FlushOutput(consumer_ref.output());
          producer_->FlushConnection(callback);
          flushed_ = true;
        });
      });

  producer_->SetStatusCallback([this](MediaState state) {
    producer_state_ = state;
    status_publisher_.SendUpdates();
    if (state == MediaState::ENDED) {
      Pause();
    }
  });

  // TODO(dalesat): Temporary, remove.
  if (destination_url == "nowhere") {
    // Throwing away the content.
    graph_.ConnectParts(consumer_ref, producer_ref);
    graph_.Prepare();
    ready_.Occur();
    return;
  }

  RCHECK(destination_url == "mojo:audio_server");

  // TODO(dalesat): Once we have c++14, get rid of this shared pointer hack.
  std::shared_ptr<StreamType> captured_stream_type(
      media_type.To<std::unique_ptr<StreamType>>().release());

  // An AudioTrackController knows how to talk to an audio track, interrogating
  // it for supported stream types and configuring it for the chosen stream
  // type.
  controller_.reset(new AudioTrackController(destination_url, app()));

  controller_->GetSupportedMediaTypes([this, consumer_ref, producer_ref,
                                       captured_stream_type](
      std::unique_ptr<std::vector<std::unique_ptr<StreamTypeSet>>>
          supported_stream_types) {
    std::unique_ptr<StreamType> producer_stream_type;

    // Add transforms to the pipeline to convert from stream_type to a
    // type supported by the track.
    OutputRef out = consumer_ref.output();
    bool result =
        BuildConversionPipeline(*captured_stream_type, *supported_stream_types,
                                &graph_, &out, &producer_stream_type);
    if (!result) {
      // Failed to build conversion pipeline.
      producer_state_ = MediaState::FAULT;
      status_publisher_.SendUpdates();
      return;
    }

    graph_.ConnectOutputToPart(out, producer_ref);

    if (producer_stream_type->medium() == StreamType::Medium::kAudio) {
      frames_per_ns_ =
          TimelineRate(producer_stream_type->audio()->frames_per_second(),
                       Timeline::ns_from_seconds(1));

    } else {
      // Unsupported producer stream type.
      LOG(ERROR) << "unsupported producer stream type";
      abort();
    }

    controller_->Configure(
        std::move(producer_stream_type),
        [this](MediaConsumerPtr consumer,
               MediaTimelineControlSitePtr timeline_control_site) {
          DCHECK(consumer);
          DCHECK(timeline_control_site);
          timeline_control_site->GetTimelineConsumer(
              GetProxy(&timeline_consumer_));
          producer_->Connect(consumer.Pass(), [this]() {
            graph_.Prepare();
            ready_.Occur();
            MaybeSetRate();
          });
        });
  });
}

MediaSinkImpl::~MediaSinkImpl() {}

void MediaSinkImpl::GetConsumer(InterfaceRequest<MediaConsumer> consumer) {
  consumer_->AddBinding(consumer.Pass());
}

void MediaSinkImpl::GetStatus(uint64_t version_last_seen,
                              const GetStatusCallback& callback) {
  status_publisher_.Get(version_last_seen, callback);
}

void MediaSinkImpl::Play() {
  target_rate_ = 1.0;
  MaybeSetRate();
}

void MediaSinkImpl::Pause() {
  target_rate_ = 0.0;
  MaybeSetRate();
}

void MediaSinkImpl::MaybeSetRate() {
  if (producer_state_ < MediaState::PAUSED || rate_ == target_rate_) {
    return;
  }

  if (!timeline_consumer_) {
    rate_ = target_rate_;
    status_publisher_.SendUpdates();
    return;
  }

  // TODO(dalesat): start_local_time and start_presentation_time should be
  // supplied via the mojo interface. For now, start_local_time is hard-coded
  // to be 30ms in the future, and start_presentation_time is grabbed from the
  // first primed packet or is calculated from start_local_time based on the
  // previous timeline function.

  // The local time when we want the rate to change.
  int64_t start_local_time = Timeline::local_now() + Timeline::ns_from_ms(30);

  // The media time corresponding to start_local_time.
  int64_t start_presentation_time;
  if (flushed_ && producer_->GetFirstPtsSinceFlush() != Packet::kUnknownPts) {
    // We're getting started initially or after a flush/prime, so the media
    // time corresponding to start_local_time should be the PTS of
    // the first packet converted to ns (rather than frame) units.
    start_presentation_time =
        producer_->GetFirstPtsSinceFlush() / frames_per_ns_;
  } else {
    // We're resuming, so the media time corresponding to start_local_time can
    // be calculated using the existing transform.
    start_presentation_time = timeline_function_(start_local_time);
  }

  flushed_ = false;

  // Update the transform.
  timeline_function_ = TimelineFunction(
      start_local_time, start_presentation_time, TimelineRate(target_rate_));

  // Set the rate.
  timeline_consumer_->SetTimelineTransform(
      timeline_function_.subject_time(), timeline_function_.reference_delta(),
      timeline_function_.subject_delta(), timeline_function_.reference_time(),
      kUnspecifiedTime, [](bool completed) {});

  rate_ = target_rate_;
  status_publisher_.SendUpdates();
}

}  // namespace media
}  // namespace mojo
