// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_PACKET_PRODUCER_H_
#define SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_PACKET_PRODUCER_H_

#include "base/single_thread_task_runner.h"
#include "base/synchronization/lock.h"
#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/media/common/cpp/media_packet_producer_base.h"
#include "mojo/services/media/common/interfaces/media_transport.mojom.h"
#include "services/media/framework/models/active_sink.h"
#include "services/media/framework/payload_allocator.h"

namespace mojo {
namespace media {

// Implements MediaPacketProducer to forward a stream across mojo.
class MojoPacketProducer : private MediaPacketProducerBase,
                           public MediaPacketProducer,
                           public ActiveSink,
                           public PayloadAllocator {
 public:
  using PrimeConnectionCallback = mojo::Callback<void()>;
  using FlushConnectionCallback = mojo::Callback<void()>;

  static std::shared_ptr<MojoPacketProducer> Create() {
    return std::shared_ptr<MojoPacketProducer>(new MojoPacketProducer());
  }

  ~MojoPacketProducer() override;

  // Binds.
  void Bind(InterfaceRequest<MediaPacketProducer> request);

  // Initiates demand to provide downstream parties with enough content to
  // start without starving.
  void PrimeConnection(const PrimeConnectionCallback& callback);

  // Unprimes and tells the connected consumer to flush.
  void FlushConnection(const FlushConnectionCallback& callback);

  // ActiveSink implementation.
  PayloadAllocator* allocator() override;

  void SetDemandCallback(const DemandCallback& demand_callback) override;

  Demand SupplyPacket(PacketPtr packet) override;

  // MediaPacketProducer implementation.
  void Connect(InterfaceHandle<MediaPacketConsumer> consumer,
               const ConnectCallback& callback) override;

  void Disconnect() override;

  // PayloadAllocator implementation:
  void* AllocatePayloadBuffer(size_t size) override;

  // Releases a buffer previously allocated via AllocatePayloadBuffer.
  void ReleasePayloadBuffer(void* buffer) override;

 private:
  MojoPacketProducer();

  // Sends a packet to the consumer.
  // TODO(dalesat): Don't use a raw pointer, if possible.
  void SendPacket(Packet* packet_raw_ptr);

  // Shuts down the producer.
  void Reset();

  Binding<MediaPacketProducer> binding_;

  mutable base::Lock lock_;
  // THE FIELDS BELOW SHOULD ONLY BE ACCESSED WITH lock_ TAKEN.
  DemandCallback demand_callback_;
  scoped_refptr<base::SingleThreadTaskRunner> task_runner_;
  // TODO(dalesat): Base this logic on presentation time or duration.
  uint32_t max_pushes_outstanding_ = 0;
  uint32_t current_pushes_outstanding_ = 0;
  // THE FIELDS ABOVE SHOULD ONLY BE ACCESSED WITH lock_ TAKEN.
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_PACKET_PRODUCER_H_
