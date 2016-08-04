// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <memory>

#include "examples/audio_play_test/play_audio.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/public/cpp/utility/run_loop.h"
#include "mojo/services/media/audio/interfaces/audio_server.mojom.h"
#include "mojo/services/media/audio/interfaces/audio_track.mojom.h"
#include "mojo/services/media/core/interfaces/media_renderer.mojom.h"

namespace mojo {
namespace media {
namespace audio {
namespace examples {

PlayAudioApp::PlayAudioApp() {}

PlayAudioApp::~PlayAudioApp() {
  OnQuit();
}

void PlayAudioApp::OnQuit() {
  timeline_consumer_.reset();
  packet_producer_.Reset();
}

void PlayAudioApp::Start(AudioSampleFormat sample_format,
                         uint32_t channels,
                         uint32_t frames_per_second) {
  frames_per_packet_ = frames_per_second / kPacketsPerSecond;
  switch (sample_format) {
    case AudioSampleFormat::UNSIGNED_8:
      bytes_per_frame_ = sizeof(uint8_t) * channels;
      break;
    case AudioSampleFormat::SIGNED_16:
      bytes_per_frame_ = sizeof(int16_t) * channels;
      break;
    case AudioSampleFormat::SIGNED_24_IN_32:
      bytes_per_frame_ = sizeof(int32_t) * channels;
      break;
    case AudioSampleFormat::FLOAT:
      bytes_per_frame_ = sizeof(float) * channels;
      break;
    default:
      MOJO_LOG(ERROR) << "Unsupported sample format " << sample_format;
      PostShutdown();
      return;
  }

  AudioServerPtr audio_server;
  ConnectToService(shell(), "mojo:audio_server", GetProxy(&audio_server));

  // Create the audio sink we will use to play this WAV file and start to
  // configure it.
  AudioTrackPtr audio_track;
  MediaRendererPtr media_renderer;
  audio_server->CreateTrack(GetProxy(&audio_track), GetProxy(&media_renderer));

  AudioMediaTypeDetailsPtr pcm_cfg = AudioMediaTypeDetails::New();
  pcm_cfg->sample_format = sample_format;
  pcm_cfg->channels = channels;
  pcm_cfg->frames_per_second = frames_per_second;

  MediaTypePtr media_type = MediaType::New();
  media_type->medium = MediaTypeMedium::AUDIO;
  media_type->details = MediaTypeDetails::New();
  media_type->details->set_audio(pcm_cfg.Pass());
  media_type->encoding = MediaType::kAudioEncodingLpcm;

  media_renderer->SetMediaType(media_type.Pass());

  MediaPacketConsumerPtr packet_consumer;
  media_renderer->GetPacketConsumer(GetProxy(&packet_consumer));

  packet_producer_.set_failure_callback(
      [this]() { OnConnectionError("packet_producer"); });

  packet_producer_.Connect(packet_consumer.Pass(), []() {});

  // Grab the timeline consumer interface for our audio renderer.
  MediaTimelineControlPointPtr timeline_control_point;
  media_renderer->GetTimelineControlPoint(GetProxy(&timeline_control_point));
  timeline_control_point->GetTimelineConsumer(GetProxy(&timeline_consumer_));
  timeline_consumer_.set_connection_error_handler(
      [this]() { OnConnectionError("timeline_consumer"); });

  while (ShouldProducePacket()) {
    ProducePacket();
  }

  TimelineTransformPtr timeline_transform = TimelineTransform::New();
  timeline_transform->reference_time = kUnspecifiedTime;
  timeline_transform->subject_time = kUnspecifiedTime;
  timeline_transform->reference_delta = 1;
  timeline_transform->subject_delta = 1;
  timeline_consumer_->SetTimelineTransform(timeline_transform.Pass(),
                                           [](bool completed) {});
}

void PlayAudioApp::ProducePacket() {
  void* payload = packet_producer_.AllocatePayloadBuffer(bytes_per_frame_ *
                                                         frames_per_packet_);
  if (payload == nullptr) {
    MOJO_LOG(ERROR) << "Failed to allocate payload buffer";
    PostShutdown();
    return;
  }

  end_of_stream_ = !FillPayloadBuffer(payload, frames_per_packet_);

  packet_producer_.ProducePacket(
      payload, bytes_per_frame_ * frames_per_packet_, pts_, end_of_stream_,
      [this, payload]() {
        packet_producer_.ReleasePayloadBuffer(payload);
        --packets_outstanding_;
        if (ShouldProducePacket()) {
          ProducePacket();
        } else if (end_of_stream_) {
          MOJO_LOG(INFO) << "Playback complete";
          PostShutdown();
        }
      });

  ++packets_outstanding_;
  pts_ += frames_per_packet_;
}

bool PlayAudioApp::ShouldProducePacket() {
  return !shutting_down_ && !end_of_stream_ &&
         packets_outstanding_ < kMaxPacketsOutstanding;
}

void PlayAudioApp::OnConnectionError(const std::string& connection_name) {
  if (!shutting_down_) {
    MOJO_LOG(ERROR) << connection_name << " connection closed unexpectedly!";
    PostShutdown();
  }
}

void PlayAudioApp::PostShutdown() {
  shutting_down_ = true;
  RunLoop::current()->PostDelayedTask([this]() -> void { Shutdown(); }, 0);
}

// TODO(johngro): remove this when we can.  Right now, the proper way to cleanly
// shut down a running mojo application is a bit unclear to me.  Calling
// RunLoop::current()->Quit() seems like the best option, but the run loop does
// not seem to call our application's quit method.  Instead, it starts to close
// all of our connections (triggering all of our connection error handlers we
// have registered on interfaces) before finally destroying our application
// object.
//
// The net result is that we end up spurious "connection closed unexpectedly"
// error messages when we are actually shutting down cleanly.  For now, we
// suppress this by having a shutting_down_ flag and suppressing the error
// message which show up after shutdown has been triggered.  When the proper
// pattern for shutting down an app has been established, come back here and
// remove all this junk.
void PlayAudioApp::Shutdown() {
  OnQuit();
  RunLoop::current()->Quit();
}

PlayAudioApp::MediaPacketProducer::MediaPacketProducer() {}

PlayAudioApp::MediaPacketProducer::~MediaPacketProducer() {}

void PlayAudioApp::MediaPacketProducer::OnDemandUpdated(
    uint32_t min_packets_outstanding,
    int64_t min_pts) {}

void PlayAudioApp::MediaPacketProducer::OnFailure() {
  if (failure_callback_) {
    failure_callback_();
  }
}

}  // namespace examples
}  // namespace audio
}  // namespace media
}  // namespace mojo
