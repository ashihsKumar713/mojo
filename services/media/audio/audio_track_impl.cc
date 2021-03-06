// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <algorithm>
#include <limits>

#include "base/logging.h"
#include "mojo/services/media/common/cpp/linear_transform.h"
#include "mojo/services/media/common/cpp/timeline.h"
#include "services/media/audio/audio_output_manager.h"
#include "services/media/audio/audio_server_impl.h"
#include "services/media/audio/audio_track_impl.h"
#include "services/media/audio/audio_track_to_output_link.h"

namespace mojo {
namespace media {
namespace audio {

constexpr size_t AudioTrackImpl::PTS_FRACTIONAL_BITS;

// TODO(johngro): If there is ever a better way to do this type of static-table
// initialization using mojom generated structs, we should switch to it.
static const struct {
  AudioSampleFormat sample_format;
  uint32_t min_channels;
  uint32_t max_channels;
  uint32_t min_frames_per_second;
  uint32_t max_frames_per_second;
} kSupportedAudioTypeSets[] = {
  {
    .sample_format = AudioSampleFormat::UNSIGNED_8,
    .min_channels = 1,
    .max_channels = 2,
    .min_frames_per_second = 1000,
    .max_frames_per_second = 48000,
  },
  {
    .sample_format = AudioSampleFormat::SIGNED_16,
    .min_channels = 1,
    .max_channels = 2,
    .min_frames_per_second = 1000,
    .max_frames_per_second = 48000,
  },
};

AudioTrackImpl::AudioTrackImpl(InterfaceRequest<AudioTrack> track_request,
                               InterfaceRequest<MediaRenderer> renderer_request,
                               AudioServerImpl* owner)
  : owner_(owner),
    track_binding_(this, track_request.Pass()),
    renderer_binding_(this, renderer_request.Pass()),
    pipe_(this, owner) {
  CHECK(nullptr != owner_);

  track_binding_.set_connection_error_handler([this]() -> void {
    if (!renderer_binding_.is_bound()) {
      Shutdown();
    }
  });

  renderer_binding_.set_connection_error_handler([this]() -> void {
    if (!track_binding_.is_bound()) {
      Shutdown();
    }
  });

  timeline_control_point_.SetPrimeRequestedCallback(
      [this](const TimelineControlPoint::PrimeCallback& callback) {
        pipe_.PrimeRequested(callback);
      });
}

AudioTrackImpl::~AudioTrackImpl() {
  // assert that we have been cleanly shutdown already.
  MOJO_DCHECK(!track_binding_.is_bound());
  MOJO_DCHECK(!renderer_binding_.is_bound());
}

AudioTrackImplPtr AudioTrackImpl::Create(
    InterfaceRequest<AudioTrack> track_request,
    InterfaceRequest<MediaRenderer> renderer_request,
    AudioServerImpl* owner) {
  AudioTrackImplPtr ret(
      new AudioTrackImpl(track_request.Pass(), renderer_request.Pass(), owner));
  ret->weak_this_ = ret;
  return ret;
}

void AudioTrackImpl::Shutdown() {
  if (track_binding_.is_bound()) {
    track_binding_.set_connection_error_handler(mojo::Closure());
    track_binding_.Close();
  }

  // If we are unbound, then we have already been shut down and are just waiting
  // for the service to destroy us.  Run some DCHECK sanity checks and get out.
  if (!renderer_binding_.is_bound()) {
    DCHECK(!pipe_.is_bound());
    DCHECK(!timeline_control_point_.is_bound());
    DCHECK(!outputs_.size());
    return;
  }

  // Close the connection to our client
  renderer_binding_.set_connection_error_handler(mojo::Closure());
  renderer_binding_.Close();

  // reset all of our internal state and close any other client connections in
  // the process.
  pipe_.Reset();
  timeline_control_point_.Reset();
  outputs_.clear();

  DCHECK(owner_);
  AudioTrackImplPtr thiz = weak_this_.lock();
  owner_->RemoveTrack(thiz);
}

void AudioTrackImpl::GetSupportedMediaTypes(
    const GetSupportedMediaTypesCallback& cbk) {
  // Build a minimal descriptor
  //
  // TODO(johngro): one day, we need to make this description much more rich and
  // fully describe our capabilities, based on things like what outputs are
  // available, the class of hardware we are on, and what options we were
  // compiled with.
  //
  // For now, it would be nice to just be able to have a static const tree of
  // capabilities in this translational unit which we could use to construct our
  // message, but the nature of the structures generated by the C++ bindings
  // make this difficult.  For now, we just create a trivial descriptor entierly
  // by hand.
  Array<MediaTypeSetPtr> supported_media_types =
    Array<MediaTypeSetPtr>::New(arraysize(kSupportedAudioTypeSets));

  for (size_t i = 0; i < supported_media_types.size(); ++i) {
    const MediaTypeSetPtr& mts =
      (supported_media_types[i] = MediaTypeSet::New());

    mts->medium    = MediaTypeMedium::AUDIO;
    mts->encodings = Array<String>::New(1);
    mts->details   = MediaTypeSetDetails::New();

    mts->encodings[0] = MediaType::kAudioEncodingLpcm;

    const auto& s = kSupportedAudioTypeSets[i];
    AudioMediaTypeSetDetailsPtr audio_detail = AudioMediaTypeSetDetails::New();

    audio_detail->sample_format = s.sample_format;
    audio_detail->min_channels = s.min_channels;
    audio_detail->max_channels = s.max_channels;
    audio_detail->min_frames_per_second = s.min_frames_per_second;
    audio_detail->max_frames_per_second = s.max_frames_per_second;
    mts->details->set_audio(audio_detail.Pass());
  }

  cbk.Run(supported_media_types.Pass());
}

void AudioTrackImpl::SetMediaType(MediaTypePtr media_type) {
  // Are we already configured?
  if (pipe_.is_bound()) {
    LOG(ERROR) << "Attempting to reconfigure a configured audio track.";
    Shutdown();
    return;
  }

  // Check the requested configuration.
  if ((media_type->medium != MediaTypeMedium::AUDIO) ||
      (media_type->encoding != MediaType::kAudioEncodingLpcm) ||
      (!media_type->details->is_audio())) {
    LOG(ERROR) << "Unsupported configuration requested in "
                  "AudioTrack::Configure.  Media type must be LPCM audio.";
    Shutdown();
    return;
  }

  // Search our supported configuration sets to find one compatible with this
  // request.
  auto& cfg = media_type->details->get_audio();
  size_t i;
  for (i = 0; i < arraysize(kSupportedAudioTypeSets); ++i) {
    const auto& cfg_set = kSupportedAudioTypeSets[i];

    if ((cfg->sample_format == cfg_set.sample_format) &&
        (cfg->channels >= cfg_set.min_channels) &&
        (cfg->channels <= cfg_set.max_channels) &&
        (cfg->frames_per_second >= cfg_set.min_frames_per_second) &&
        (cfg->frames_per_second <= cfg_set.max_frames_per_second)) {
      break;
    }
  }

  if (i >= arraysize(kSupportedAudioTypeSets)) {
    LOG(ERROR) << "Unsupported LPCM configuration requested in "
                  "AudioTrack::Configure.  "
               << "(format = " << cfg->sample_format
               << ", channels = "
               << static_cast<uint32_t>(cfg->channels)
               << ", frames_per_second = " << cfg->frames_per_second
               << ")";
    Shutdown();
    return;
  }

  frames_per_ns_ =
      TimelineRate(cfg->frames_per_second, Timeline::ns_from_seconds(1));

  // Figure out the rate we need to scale by in order to produce our fixed
  // point timestamps.
  LinearTransform::Ratio frac_scale(1 << PTS_FRACTIONAL_BITS, 1);
  LinearTransform::Ratio frame_scale(LinearTransform::Ratio(1, 1));
  bool no_loss = LinearTransform::Ratio::Compose(frac_scale,
                                                 frame_scale,
                                                 &frame_to_media_ratio_);
  if (!no_loss) {
    LOG(ERROR) << "Invalid (audio frames:media time ticks) ratio (1/1)";
    Shutdown();
    return;
  }

  // Figure out how many bytes we need to hold the requested number of nSec of
  // audio.
  switch (cfg->sample_format) {
    case AudioSampleFormat::UNSIGNED_8:
      bytes_per_frame_ = 1;
      break;

    case AudioSampleFormat::SIGNED_16:
      bytes_per_frame_ = 2;
      break;

    case AudioSampleFormat::SIGNED_24_IN_32:
      bytes_per_frame_ = 4;
      break;

    default:
      DCHECK(false);
      bytes_per_frame_ = 2;
      break;
  }
  bytes_per_frame_ *= cfg->channels;

  // Stash our configuration.
  format_ = cfg.Pass();

  // Have the audio output manager initialize our set of outputs.  Note; there
  // is currently no need for a lock here.  Methods called from our user-facing
  // interfaces are seriailzed by nature of the mojo framework, and none of the
  // output manager's threads should ever need to manipulate the set.  Cleanup
  // of outputs which have gone away is currently handled in a lazy fashion when
  // the track fails to promote its weak reference during an operation involving
  // its outputs.
  //
  // TODO(johngro): someday, we will need to deal with recalculating properties
  // which depend on a track's current set of outputs (for example, the minimum
  // latency).  This will probably be done using a dirty flag in the track
  // implementations, and scheduling a job to recalculate the properties for the
  // dirty tracks and notify the users as appropriate.

  // If we cannot promote our own weak pointer, something is seriously wrong.
  AudioTrackImplPtr strong_this(weak_this_.lock());
  DCHECK(strong_this);
  DCHECK(owner_);
  owner_->GetOutputManager().SelectOutputsForTrack(strong_this);
}

void AudioTrackImpl::GetPacketConsumer(
    InterfaceRequest<MediaPacketConsumer> consumer_request) {
  // Bind our pipe to the interface request.
  pipe_.Bind(consumer_request.Pass());
}

void AudioTrackImpl::GetTimelineControlPoint(
    InterfaceRequest<MediaTimelineControlPoint> req) {
  timeline_control_point_.Bind(req.Pass());
}

void AudioTrackImpl::SetGain(float db_gain) {
  if (db_gain >= AudioTrack::kMaxGain) {
    LOG(ERROR) << "Gain value too large (" << db_gain << ") for audio track.";
    Shutdown();
    return;
  }

  db_gain_ = db_gain;

  for (const auto& output : outputs_) {
    DCHECK(output);
    output->UpdateGain();
  }
}

void AudioTrackImpl::AddOutput(AudioTrackToOutputLinkPtr link) {
  // TODO(johngro): assert that we are on the main message loop thread.
  DCHECK(link);
  auto res = outputs_.emplace(link);
  DCHECK(res.second);
  link->UpdateGain();
}

void AudioTrackImpl::RemoveOutput(AudioTrackToOutputLinkPtr link) {
  // TODO(johngro): assert that we are on the main message loop thread.
  DCHECK(link);

  auto iter = outputs_.find(link);
  if (iter != outputs_.end()) {
    outputs_.erase(iter);
  } else {
    // TODO(johngro): that's odd.  I can't think of a reason why we we should
    // not be able to find this link in our set of outputs... should we log
    // something about this?
    DCHECK(false);
  }
}

void AudioTrackImpl::SnapshotRateTrans(LinearTransform* out,
                                       uint32_t* generation) {
  TimelineFunction timeline_function;
  timeline_control_point_.SnapshotCurrentFunction(
      Timeline::local_now(), &timeline_function, generation);

  // The control point works in ns units. We want the rate in frames per
  // nanosecond, so we convert here.
  TimelineRate rate_in_frames_per_ns =
      timeline_function.rate() * frames_per_ns_;

  *out = LinearTransform(timeline_function.reference_time(),
                         rate_in_frames_per_ns.subject_delta(),
                         rate_in_frames_per_ns.reference_delta(),
                         timeline_function.subject_time() * frames_per_ns_);
}

void AudioTrackImpl::OnPacketReceived(AudioPipe::AudioPacketRefPtr packet) {
  DCHECK(packet);
  for (const auto& output : outputs_) {
    DCHECK(output);
    output->PushToPendingQueue(packet);
  }

  if (packet->supplied_packet()->packet()->end_of_stream) {
    timeline_control_point_.SetEndOfStreamPts(
        (packet->supplied_packet()->packet()->pts + packet->frame_count()) /
            frames_per_ns_);
  }
}

bool AudioTrackImpl::OnFlushRequested(
    const MediaPacketConsumer::FlushCallback& cbk) {
  for (const auto& output : outputs_) {
    DCHECK(output);
    output->FlushPendingQueue();
  }
  cbk.Run();
  return true;
}

}  // namespace audio
}  // namespace media
}  // namespace mojo
