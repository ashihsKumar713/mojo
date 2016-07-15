// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "base/bind_helpers.h"
#include "base/logging.h"
#include "base/message_loop/message_loop.h"
#include "services/media/framework_mojo/mojo_packet_producer.h"

namespace mojo {
namespace media {

MojoPacketProducer::MojoPacketProducer() : binding_(this) {
  task_runner_ = base::MessageLoop::current()->task_runner();
  DCHECK(task_runner_);
}

MojoPacketProducer::~MojoPacketProducer() {
  base::AutoLock lock(lock_);
}

void MojoPacketProducer::Bind(InterfaceRequest<MediaPacketProducer> request) {
  binding_.Bind(request.Pass());
}

void MojoPacketProducer::PrimeConnection(
    const PrimeConnectionCallback& callback) {
  Demand demand;

  if (is_connected()) {
    base::AutoLock lock(lock_);
    max_pushes_outstanding_ = 4;  // TODO(dalesat): Made up!
    demand = current_pushes_outstanding_ < max_pushes_outstanding_
                 ? Demand::kPositive
                 : Demand::kNegative;
  } else {
    demand = Demand::kNeutral;
  }

  DCHECK(demand_callback_);
  demand_callback_(demand);

  if (is_connected()) {
    PrimeConsumer(callback);
  } else {
    callback.Run();
  }
}

void MojoPacketProducer::FlushConnection(
    const FlushConnectionCallback& callback) {
  {
    base::AutoLock lock(lock_);
    max_pushes_outstanding_ = 0;
  }

  DCHECK(demand_callback_);
  demand_callback_(Demand::kNegative);

  if (is_connected()) {
    FlushConsumer(callback);
  } else {
    callback.Run();
  }
}

PayloadAllocator* MojoPacketProducer::allocator() {
  return this;
}

void MojoPacketProducer::SetDemandCallback(
    const DemandCallback& demand_callback) {
  demand_callback_ = demand_callback;
}

Demand MojoPacketProducer::SupplyPacket(PacketPtr packet) {
  DCHECK(packet);

  // If we're not connected, throw the packet away.
  if (!is_connected()) {
    return packet->end_of_stream() ? Demand::kNegative : Demand::kNeutral;
  }

  Demand demand;

  {
    base::AutoLock lock(lock_);
    DCHECK(current_pushes_outstanding_ < max_pushes_outstanding_);

    ++current_pushes_outstanding_;

    if (packet->end_of_stream()) {
      demand = Demand::kNegative;
      max_pushes_outstanding_ = 0;
    } else {
      demand = current_pushes_outstanding_ < max_pushes_outstanding_
                   ? Demand::kPositive
                   : Demand::kNegative;
    }
  }

  task_runner_->PostTask(FROM_HERE,
                         base::Bind(&MojoPacketProducer::SendPacket,
                                    base::Unretained(this), packet.release()));

  return demand;
}

void MojoPacketProducer::Connect(InterfaceHandle<MediaPacketConsumer> consumer,
                                 const ConnectCallback& callback) {
  DCHECK(consumer);
  MediaPacketProducerBase::Connect(
      MediaPacketConsumerPtr::Create(std::move(consumer)).Pass(), callback);
}

void MojoPacketProducer::Disconnect() {
  if (demand_callback_) {
    demand_callback_(Demand::kNegative);
  }

  MediaPacketProducerBase::Disconnect();
}

void* MojoPacketProducer::AllocatePayloadBuffer(size_t size) {
  return MediaPacketProducerBase::AllocatePayloadBuffer(size);
}

void MojoPacketProducer::ReleasePayloadBuffer(void* buffer) {
  MediaPacketProducerBase::ReleasePayloadBuffer(buffer);
}

void MojoPacketProducer::SendPacket(Packet* packet_raw_ptr) {
  DCHECK(packet_raw_ptr);

  ProducePacket(
      packet_raw_ptr->payload(), packet_raw_ptr->size(), packet_raw_ptr->pts(),
      packet_raw_ptr->end_of_stream(), [this, packet_raw_ptr]() {
        PacketPtr packet = PacketPtr(packet_raw_ptr);
        Demand demand;

        {
          base::AutoLock lock(lock_);
          demand = --current_pushes_outstanding_ < max_pushes_outstanding_
                       ? Demand::kPositive
                       : Demand::kNegative;
        }

        DCHECK(demand_callback_);
        demand_callback_(demand);
      });
}

void MojoPacketProducer::Reset() {
  if (binding_.is_bound()) {
    binding_.Close();
  }

  MediaPacketProducerBase::Reset();
}

}  // namespace media
}  // namespace mojo
