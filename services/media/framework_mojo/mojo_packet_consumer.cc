// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/bind.h"
#include "base/logging.h"
#include "base/message_loop/message_loop.h"
#include "services/media/framework_mojo/mojo_packet_consumer.h"

namespace mojo {
namespace media {

void MojoPacketConsumerMediaPacketConsumer::Flush(
    const FlushCallback& callback) {
  MediaPacketConsumerFlush(callback);
}

MojoPacketConsumer::MojoPacketConsumer() {}

MojoPacketConsumer::~MojoPacketConsumer() {}

void MojoPacketConsumer::AddBinding(
    InterfaceRequest<MediaPacketConsumer> consumer) {
  bindings_.AddBinding(this, consumer.Pass());
  DCHECK(base::MessageLoop::current());
  task_runner_ = base::MessageLoop::current()->task_runner();
  DCHECK(task_runner_);
}

void MojoPacketConsumer::SetPrimeRequestedCallback(
    const PrimeRequestedCallback& callback) {
  prime_requested_callback_ = callback;
}

void MojoPacketConsumer::SetFlushRequestedCallback(
    const FlushRequestedCallback& callback) {
  flush_requested_callback_ = callback;
}

void MojoPacketConsumer::SetBuffer(ScopedSharedBufferHandle buffer,
                                   const SetBufferCallback& callback) {
  buffer_.InitFromHandle(buffer.Pass());
  callback.Run();
}

void MojoPacketConsumer::SendPacket(MediaPacketPtr media_packet,
                                    const SendPacketCallback& callback) {
  DCHECK(media_packet);
  DCHECK(supply_callback_);
  supply_callback_(
      PacketImpl::Create(media_packet.Pass(), callback, task_runner_, buffer_));
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
    MediaPacketPtr media_packet,
    const SendPacketCallback& callback,
    scoped_refptr<base::SingleThreadTaskRunner> task_runner,
    const MappedSharedBuffer& buffer)
    : Packet(media_packet->pts,
             media_packet->end_of_stream,
             media_packet->payload->length,
             media_packet->payload->length == 0
                 ? nullptr
                 : buffer.PtrFromOffset(media_packet->payload->offset)),
      media_packet_(media_packet.Pass()),
      callback_(callback),
      task_runner_(task_runner) {}

MojoPacketConsumer::PacketImpl::~PacketImpl() {}

// static
void MojoPacketConsumer::PacketImpl::RunCallback(
    const SendPacketCallback& callback) {
  callback.Run(MediaPacketConsumer::SendResult::CONSUMED);
}

void MojoPacketConsumer::PacketImpl::Release() {
  task_runner_->PostTask(FROM_HERE, base::Bind(&RunCallback, callback_));
  delete this;
}

}  // namespace media
}  // namespace mojo
