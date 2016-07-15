// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <memory>

#include "mojo/public/cpp/application/application_impl_base.h"
#include "mojo/services/media/common/cpp/media_packet_producer_base.h"
#include "mojo/services/media/common/interfaces/timelines.mojom.h"

namespace mojo {
namespace media {
namespace audio {
namespace examples {

// Base class for play_tone and play_wav example apps.
class PlayAudioApp : public ApplicationImplBase {
 public:
  PlayAudioApp();

  ~PlayAudioApp() override;

  // ApplicationImplBase override. It's OK to override this as well, but the
  // override should call this one.
  void OnQuit() override;

 protected:
  // Starts audio playback.
  void Start(AudioSampleFormat sample_format,
             uint32_t channels,
             uint32_t frames_per_second);

  // Returns the number of bytes per frame.
  uint32_t bytes_per_frame() { return bytes_per_frame_; }

  // Handles connection errors.
  void OnConnectionError(const std::string& connection_name);

  // Posts a shutdown operation to the run loop.
  void PostShutdown();

  // Shuts down the app.
  void Shutdown();

  // Fills a payload buffer. Returns true if there will be more packets, false
  // if this is the last.
  virtual bool FillPayloadBuffer(void* payload, uint32_t frames_per_packet) = 0;

 private:
  static constexpr size_t kMaxPacketsOutstanding = 3;
  static constexpr uint32_t kPacketsPerSecond = 10;

  class MediaPacketProducer : public MediaPacketProducerBase {
   public:
    using FailureCallback = std::function<void()>;

    MediaPacketProducer();

    ~MediaPacketProducer() override;

    void set_failure_callback(const FailureCallback& failure_callback) {
      failure_callback_ = failure_callback;
    }

   protected:
    void OnFailure() override;

   private:
    FailureCallback failure_callback_;
  };

  // Sends a packet to the packet consumer.
  void ProducePacket();

  // Determines if we should produce another packet.
  bool ShouldProducePacket();

  TimelineConsumerPtr timeline_consumer_;
  MediaPacketProducer packet_producer_;
  bool shutting_down_ = false;
  int64_t pts_ = 0;
  size_t packets_outstanding_ = 0;
  uint32_t bytes_per_frame_;
  uint32_t frames_per_packet_;
  bool end_of_stream_ = false;
};

}  // namespace examples
}  // namespace audio
}  // namespace media
}  // namespace mojo
