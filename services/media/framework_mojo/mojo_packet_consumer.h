// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_PACKET_CONSUMER_H_
#define SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_PACKET_CONSUMER_H_

#include "mojo/services/media/common/cpp/media_packet_consumer_base.h"
#include "mojo/services/media/common/interfaces/media_transport.mojom.h"
#include "services/media/framework/models/active_source.h"

namespace mojo {
namespace media {

// Implements MediaConsumer::Flush on behalf of MojoPacketConsumer to avoid name
// conflict with Part::Flush.
class MojoMediaPacketConsumerBase : public MediaPacketConsumerBase {
  // MediaConsumer implementation.
  void Flush(const FlushCallback& callback) override;

  // Implements MediaConsumer::Flush.
  virtual void MediaPacketConsumerFlush(const FlushCallback& callback) = 0;
};

// Implements MediaPacketConsumer to receive a stream from across mojo.
class MojoPacketConsumer : public MojoMediaPacketConsumerBase,
                           public ActiveSource {
 public:
  using PrimeRequestedCallback = std::function<void(const PrimeCallback&)>;
  using FlushRequestedCallback = std::function<void(const FlushCallback&)>;

  static std::shared_ptr<MojoPacketConsumer> Create() {
    return std::shared_ptr<MojoPacketConsumer>(new MojoPacketConsumer());
  }

  ~MojoPacketConsumer() override;

  // Binds.
  void Bind(InterfaceRequest<MediaPacketConsumer> packet_consumer_request);

  // Sets a callback signalling that a prime has been requested from the
  // MediaPacketConsumer client.
  void SetPrimeRequestedCallback(const PrimeRequestedCallback& callback);

  // Sets a callback signalling that a flush has been requested from the
  // MediaPacketConsumer client.
  void SetFlushRequestedCallback(const FlushRequestedCallback& callback);

  // MediaPacketConsumerBase overrides.
  void OnPacketSupplied(
      std::unique_ptr<SuppliedPacket> supplied_packet) override;

  void Prime(const PrimeCallback& callback) override;

  void MediaPacketConsumerFlush(const FlushCallback& callback) override;

  // ActiveSource implementation.
  bool can_accept_allocator() const override;

  void set_allocator(PayloadAllocator* allocator) override;

  void SetSupplyCallback(const SupplyCallback& supply_callback) override;

  void SetDownstreamDemand(Demand demand) override;

 private:
  MojoPacketConsumer();

  // Specialized packet implementation.
  class PacketImpl : public Packet {
   public:
    static PacketPtr Create(std::unique_ptr<SuppliedPacket> supplied_packet) {
      return PacketPtr(new PacketImpl(std::move(supplied_packet)));
    }

   protected:
    void Release() override;

   private:
    PacketImpl(std::unique_ptr<SuppliedPacket> supplied_packet);

    ~PacketImpl() override;

    std::unique_ptr<SuppliedPacket> supplied_packet_;
  };

  PrimeRequestedCallback prime_requested_callback_;
  FlushRequestedCallback flush_requested_callback_;
  SupplyCallback supply_callback_;
};

}  // namespace media
}  // namespace mojo

#endif  // SERVICES_MEDIA_FRAMEWORK_MOJO_MOJO_PACKET_CONSUMER_H_
