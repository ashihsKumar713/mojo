// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <limits>
#include <vector>

#include "services/media/audio/audio_pipe.h"
#include "services/media/audio/audio_server_impl.h"
#include "services/media/audio/audio_track_impl.h"

namespace mojo {
namespace media {
namespace audio {

AudioPipe::AudioPacketRef::AudioPacketRef(
    MediaPacketStatePtr state,
    AudioServerImpl* server,
    std::vector<Region>&& regions,  // NOLINT(build/c++11)
    int64_t start_pts,
    int64_t end_pts)
  : state_(std::move(state)),
    server_(server),
    regions_(std::move(regions)),
    start_pts_(start_pts),
    end_pts_(end_pts)  {
  DCHECK(state_);
  DCHECK(server_);
}

AudioPipe::AudioPacketRef::~AudioPacketRef() {
  DCHECK(server_);
  server_->SchedulePacketCleanup(std::move(state_));
}

AudioPipe::AudioPipe(AudioTrackImpl* owner,
                     AudioServerImpl* server)
  : owner_(owner),
    server_(server) {
  DCHECK(owner_);
  DCHECK(server_);
}

AudioPipe::~AudioPipe() {}

void AudioPipe::OnPacketReceived(MediaPacketStatePtr state) {
  const MediaPacketPtr& packet = state->GetPacket();
  DCHECK(packet);
  DCHECK(packet->payload);
  DCHECK(owner_);

  // Start by making sure that we are regions we are receiving are made from an
  // integral number of audio frames.  Count the total number of frames in the
  // process.
  //
  // TODO(johngro): Someday, automatically enforce this using
  // alignment/allocation restrictions at the MediaPipe level of things.
  uint32_t frame_count = 0;
  uint32_t frame_size = owner_->BytesPerFrame();
  const MediaPacketRegionPtr* region = &packet->payload;
  size_t ndx = 0;
  std::vector<AudioPacketRef::Region> regions;

  regions.reserve(packet->extra_payload.size() + 1);

  DCHECK(frame_size);
  while (true) {
    if ((frame_size > 1) && ((*region)->length % frame_size)) {
      state->SetResult(MediaResult::INVALID_ARGUMENT);
      return;
    }

    frame_count += ((*region)->length / frame_size);
    if (frame_count > (std::numeric_limits<uint32_t>::max() >>
                       AudioTrackImpl::PTS_FRACTIONAL_BITS)) {
      state->SetResult(MediaResult::INVALID_ARGUMENT);
      return;
    }

    regions.emplace_back(
        static_cast<const uint8_t*>(buffer()) + (*region)->offset,
        frame_count << AudioTrackImpl::PTS_FRACTIONAL_BITS);

    if (ndx >= packet->extra_payload.size()) {
      break;
    }

    region = &(packet->extra_payload[ndx]);
    ndx++;
  }

  // Figure out the starting PTS.
  int64_t start_pts;
  if (packet->pts != MediaPacket::kNoTimestamp) {
    // The user provided an explicit PTS for this audio.  Transform it into
    // units of fractional frames.
    LinearTransform tmp(0, owner_->FractionalFrameToMediaTimeRatio(), 0);
    if (!tmp.DoForwardTransform(packet->pts, &start_pts)) {
      state->SetResult(MediaResult::INTERNAL_ERROR);
      return;
    }
  } else {
    // No PTS was provided.  Use the end time of the last audio packet, if
    // known.  Otherwise, just assume a media time of 0.
    start_pts = next_pts_known_ ? next_pts_ : 0;
  }

  // The end pts is the value we will use for the next packet's start PTS, if
  // the user does not provide an explicit PTS.
  int64_t pts_delta = (static_cast<int64_t>(frame_count)
                    << AudioTrackImpl::PTS_FRACTIONAL_BITS);
  next_pts_ = start_pts + pts_delta;
  next_pts_known_ = true;

  owner_->OnPacketReceived(AudioPacketRefPtr(
        new AudioPacketRef(std::move(state),
                           server_,
                           std::move(regions),
                           start_pts,
                           next_pts_)));
}

void AudioPipe::OnFlushRequested(const FlushCallback& cbk) {
  DCHECK(owner_);
  owner_->OnFlushRequested(cbk);
  next_pts_known_ = false;
}

}  // namespace audio
}  // namespace media
}  // namespace mojo
