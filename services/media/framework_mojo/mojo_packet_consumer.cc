// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "base/logging.h"
#include "services/media/framework_mojo/mojo_packet_consumer.h"

namespace mojo {
namespace media {

void MojoMediaPacketConsumerBase::Flush(const FlushCallback& callback) {
  MediaPacketConsumerFlush(callback);
}

MojoPacketConsumer::MojoPacketConsumer() {}

MojoPacketConsumer::~MojoPacketConsumer() {}

void MojoPacketConsumer::Bind(
    InterfaceRequest<MediaPacketConsumer> packet_consumer_request) {
  MediaPacketConsumerBase::Bind(packet_consumer_request.Pass());
}

void MojoPacketConsumer::SetPrimeRequestedCallback(
    const PrimeRequestedCallback& callback) {
  prime_requested_callback_ = callback;
}

void MojoPacketConsumer::SetFlushRequestedCallback(
    const FlushRequestedCallback& callback) {
  flush_requested_callback_ = callback;
}

void MojoPacketConsumer::OnPacketSupplied(
    std::unique_ptr<SuppliedPacket> supplied_packet) {
  DCHECK(supplied_packet);
  DCHECK(supply_callback_);
  supply_callback_(PacketImpl::Create(std::move(supplied_packet)));
}

void MojoPacketConsumer::Prime(const PrimeCallback& callback) {
  if (prime_requested_callback_) {
    prime_requested_callback_(callback);
  } else {
    LOG(WARNING) << "prime requested but no callback registered";
    callback.Run();
  }
}

void MojoPacketConsumer::MediaPacketConsumerFlush(
    const FlushCallback& callback) {
  if (flush_requested_callback_) {
    flush_requested_callback_(callback);
  } else {
    LOG(WARNING) << "flush requested but no callback registered";
    callback.Run();
  }
}

bool MojoPacketConsumer::can_accept_allocator() const {
  return false;
}

void MojoPacketConsumer::set_allocator(PayloadAllocator* allocator) {
  LOG(ERROR) << "set_allocator called on MojoPacketConsumer";
}

void MojoPacketConsumer::SetSupplyCallback(
    const SupplyCallback& supply_callback) {
  supply_callback_ = supply_callback;
}

void MojoPacketConsumer::SetDownstreamDemand(Demand demand) {}

MojoPacketConsumer::PacketImpl::PacketImpl(
    std::unique_ptr<SuppliedPacket> supplied_packet)
    : Packet(supplied_packet->packet()->pts,
             supplied_packet->packet()->end_of_stream,
             supplied_packet->payload_size(),
             supplied_packet->payload()),
      supplied_packet_(std::move(supplied_packet)) {}

MojoPacketConsumer::PacketImpl::~PacketImpl() {}

void MojoPacketConsumer::PacketImpl::Release() {
  delete this;
}

}  // namespace media
}  // namespace mojo
