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
    SuppliedPacketPtr supplied_packet,
    AudioServerImpl* server,
    uint32_t frac_frame_len,
    int64_t start_pts,
    int64_t end_pts,
    uint32_t frame_count)
  : supplied_packet_(std::move(supplied_packet)),
    server_(server),
    frac_frame_len_(frac_frame_len),
    start_pts_(start_pts),
    end_pts_(end_pts),
    frame_count_(frame_count) {
  DCHECK(supplied_packet_);
  DCHECK(server_);
}

AudioPipe::AudioPacketRef::~AudioPacketRef() {
  DCHECK(server_);
  server_->SchedulePacketCleanup(std::move(supplied_packet_));
}

AudioPipe::AudioPipe(AudioTrackImpl* owner,
                     AudioServerImpl* server)
  : owner_(owner),
    server_(server) {
  DCHECK(owner_);
  DCHECK(server_);
}

AudioPipe::~AudioPipe() {}

void AudioPipe::OnPacketSupplied(SuppliedPacketPtr supplied_packet) {
  DCHECK(supplied_packet);
  const MediaPacketPtr& packet = supplied_packet->packet();
  DCHECK(packet);
  DCHECK(packet->payload);
  DCHECK(owner_);

  // Start by making sure that the region we are receiving is made from an
  // integral number of audio frames.  Count the total number of frames in the
  // process.
  //
  // TODO(johngro): Someday, automatically enforce this using
  // alignment/allocation restrictions at the MediaPipe level of things.
  uint32_t frame_size = owner_->BytesPerFrame();

  if ((frame_size > 1) && (packet->payload->length % frame_size)) {
    LOG(ERROR) << "Region length (" << packet->payload->length
               << ") is not divisible by by audio frame size ("
               << frame_size << ")";
    Reset();
    return;
  }

  static constexpr uint32_t kMaxFrames = std::numeric_limits<uint32_t>::max()
                                      >> AudioTrackImpl::PTS_FRACTIONAL_BITS;
  uint32_t frame_count = (packet->payload->length / frame_size);
  if (frame_count > kMaxFrames) {
    LOG(ERROR) << "Audio frame count ("
               << frame_count << ") exceeds maximum allowed ("
               << kMaxFrames  << ")";
    Reset();
    return;
  }

  // Figure out the starting PTS.
  int64_t start_pts;
  if (packet->pts != MediaPacket::kNoTimestamp) {
    // The user provided an explicit PTS for this audio.  Transform it into
    // units of fractional frames.
    LinearTransform tmp(0, owner_->FractionalFrameToMediaTimeRatio(), 0);
    if (!tmp.DoForwardTransform(packet->pts, &start_pts)) {
      LOG(ERROR) << "Overflow while transforming explicitly provided PTS ("
                 << packet->pts
                 << ") during SendPacket on MediaPipe transporting audio data.";
      Reset();
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
        new AudioPacketRef(std::move(supplied_packet),
                           server_,
                           frame_count << AudioTrackImpl::PTS_FRACTIONAL_BITS,
                           start_pts,
                           next_pts_,
                           frame_count)));

   if (!prime_callback_.is_null()) {
     // Prime was requested. Call the callback to indicate priming is complete.
     // TODO(dalesat): Don't do this until low water mark is reached.
     prime_callback_.Run();
     prime_callback_.reset();
   }
}

void AudioPipe::Prime(const PrimeCallback& cbk) {
  if (!prime_callback_.is_null()) {
    // Prime was already requested. Complete the old one and warn.
    LOG(WARNING) << "multiple prime requests received";
    prime_callback_.Run();
  }
  prime_callback_ = cbk;
}

void AudioPipe::Flush(const FlushCallback& cbk) {
  DCHECK(owner_);
  next_pts_known_ = false;
  owner_->OnFlushRequested(cbk);
}

}  // namespace audio
}  // namespace media
}  // namespace mojo
