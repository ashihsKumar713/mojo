// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_COMMON_CPP_PACKET_CONSUMER_BASE_H_
#define MOJO_SERVICES_MEDIA_COMMON_CPP_PACKET_CONSUMER_BASE_H_

#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/media/common/cpp/mapped_shared_buffer.h"
#include "mojo/services/media/common/interfaces/media_transport.mojom.h"

namespace mojo {
namespace media {

// Base class that implements MediaPacketConsumer.
class MediaPacketConsumerBase : public MediaPacketConsumer {
 public:
  MediaPacketConsumerBase();

  ~MediaPacketConsumerBase() override;

  class SuppliedPacket {
   public:
    SuppliedPacket(MediaPacketPtr packet,
                   void* payload,
                   const SendPacketCallback& callback);

    ~SuppliedPacket();

    const MediaPacketPtr& packet() { return packet_; }
    void* payload() { return payload_; }
    uint64_t payload_size() { return packet_->payload->length; }

   private:
    MediaPacketPtr packet_;
    void* payload_;
    SendPacketCallback callback_;
  };

  // Binds to this MediaPacketConsumer.
  void Bind(InterfaceRequest<MediaPacketConsumer> request);

  // Determines if the consumer is bound to a message pipe.
  bool is_bound();

  // Shuts down the consumer.
  void Reset();

  // Shuts down the consumer and calls OnFailure().
  void Fail();

 protected:
  // Called when a packet is supplied.
  virtual void OnPacketSupplied(
      std::unique_ptr<SuppliedPacket> supplied_packet) = 0;

  // Called when a fatal error occurs. The default implementation does nothing.
  virtual void OnFailure();

  // MediaPacketConsumer implementation.
  void SetBuffer(ScopedSharedBufferHandle buffer_handle,
                 const SetBufferCallback& callback) override;

  void SendPacket(MediaPacketPtr packet,
                  const SendPacketCallback& callback) override;

  void Prime(const PrimeCallback& callback) override;

  void Flush(const FlushCallback& callback) override;

 private:
  Binding<MediaPacketConsumer> binding_;
  MappedSharedBuffer buffer_;
};

}  // namespace media
}  // namespace mojo

#endif  // MOJO_SERVICES_MEDIA_COMMON_CPP_PACKET_CONSUMER_BASE_H_
