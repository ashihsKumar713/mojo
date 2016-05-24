// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
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
        });
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
      LOG(WARNING) << "failed to build conversion pipeline";
      // TODO(dalesat): Add problem reporting.
      return;
    }

    graph_.ConnectOutputToPart(out, producer_ref);

    controller_->Configure(std::move(producer_stream_type),
                           [this](MediaConsumerPtr consumer) {
                             DCHECK(consumer);
                             producer_->Connect(consumer.Pass(), [this]() {
                               graph_.Prepare();
                               ready_.Occur();
                             });
                           });
  });
}

MediaSinkImpl::~MediaSinkImpl() {}

void MediaSinkImpl::GetConsumer(InterfaceRequest<MediaConsumer> consumer) {
  consumer_->AddBinding(consumer.Pass());
}

void MediaSinkImpl::GetTimelineControlSite(
    InterfaceRequest<MediaTimelineControlSite> req) {
  if (!controller_) {
    LOG(ERROR) << "GetTimelineControlSite not implemented for 'nowhere' case";
    abort();
  }
  controller_->GetTimelineControlSite(req.Pass());
}

}  // namespace media
}  // namespace mojo
