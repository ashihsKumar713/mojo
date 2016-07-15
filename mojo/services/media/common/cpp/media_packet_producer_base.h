// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_COMMON_CPP_PACKET_PRODUCER_BASE_H_
#define MOJO_SERVICES_MEDIA_COMMON_CPP_PACKET_PRODUCER_BASE_H_

#include "mojo/services/media/common/cpp/shared_media_buffer_allocator.h"
#include "mojo/services/media/common/interfaces/media_transport.mojom.h"

namespace mojo {
namespace media {

// Base class for clients of MediaPacketConsumer.
class MediaPacketProducerBase {
 public:
  using ProducePacketCallback = std::function<void()>;

  MediaPacketProducerBase();

  virtual ~MediaPacketProducerBase();

  // Connects to the indicated consumer.
  void Connect(MediaPacketConsumerPtr consumer,
               const MediaPacketProducer::ConnectCallback& callback);

  // Disconnects from the consumer.
  void Disconnect() { consumer_.reset(); }

  // Determines if we are connected to a consumer.
  bool is_connected() { return consumer_.is_bound(); }

  // Resets to initial state.
  void Reset();

  // Flushes the consumer.
  void PrimeConsumer(const MediaPacketConsumer::PrimeCallback& callback);

  // Primes the consumer.
  void FlushConsumer(const MediaPacketConsumer::FlushCallback& callback);

  // Allocates a payload buffer of the specified size.
  void* AllocatePayloadBuffer(size_t size);

  // Releases a payload buffer obtained via AllocatePayloadBuffer.
  void ReleasePayloadBuffer(void* buffer);

  // Produces a packet and supplies it to the consumer.
  void ProducePacket(void* payload,
                     size_t size,
                     int64_t pts,
                     bool end_of_stream,
                     const ProducePacketCallback& callback);

 protected:
  // Called when a fatal error occurs. The default implementation does nothing.
  virtual void OnFailure();

 private:
  // Ensures that the allocator is initialized. Returns false if the allocator
  // could not be initialized.
  bool EnsureAllocatorInitialized();

  SharedMediaBufferAllocator allocator_;
  MediaPacketConsumerPtr consumer_;
};

}  // namespace media
}  // namespace mojo

#endif  // MOJO_SERVICES_MEDIA_COMMON_CPP_PACKET_PRODUCER_BASE_H_
