// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/public/cpp/environment/logging.h"
#include "mojo/services/media/common/cpp/media_packet_consumer_base.h"

namespace mojo {
namespace media {

// For checking preconditions when handling mojo requests.
// Checks the condition, and, if it's false, calls Fail and returns.
#define RCHECK(condition, message) \
  if (!(condition)) {              \
    MOJO_DLOG(ERROR) << message;   \
    Fail();                        \
    return;                        \
  }

MediaPacketConsumerBase::MediaPacketConsumerBase() : binding_(this) {}

MediaPacketConsumerBase::~MediaPacketConsumerBase() {}

void MediaPacketConsumerBase::Bind(
    InterfaceRequest<MediaPacketConsumer> request) {
  binding_.Bind(request.Pass());
}

bool MediaPacketConsumerBase::is_bound() {
  return binding_.is_bound();
}

void MediaPacketConsumerBase::Reset() {
  if (binding_.is_bound()) {
    binding_.Close();
  }

  buffer_.Reset();
}

void MediaPacketConsumerBase::Fail() {
  Reset();
  OnFailure();
}

void MediaPacketConsumerBase::OnFailure() {}

void MediaPacketConsumerBase::SetBuffer(ScopedSharedBufferHandle buffer_handle,
                                        const SetBufferCallback& callback) {
  MOJO_DCHECK(buffer_handle.is_valid());
  RCHECK(!buffer_.initialized(), "buffer already set");
  MojoResult result = buffer_.InitFromHandle(buffer_handle.Pass());
  RCHECK(result == MOJO_RESULT_OK, "failed to map buffer");
  callback.Run();
}

void MediaPacketConsumerBase::SendPacket(MediaPacketPtr media_packet,
                                         const SendPacketCallback& callback) {
  MOJO_DCHECK(media_packet);
  RCHECK(buffer_.initialized(), "need to SetBuffer before SendPacket");
  if (!media_packet->payload || media_packet->payload->length == 0) {
    OnPacketSupplied(std::unique_ptr<SuppliedPacket>(
        new SuppliedPacket(media_packet.Pass(), nullptr, callback)));
  } else {
    RCHECK(buffer_.Validate(media_packet->payload->offset,
                            media_packet->payload->length),
           "invalid buffer region");
    void* payload = buffer_.PtrFromOffset(media_packet->payload->offset);
    OnPacketSupplied(std::unique_ptr<SuppliedPacket>(
        new SuppliedPacket(media_packet.Pass(), payload, callback)));
  }
}

void MediaPacketConsumerBase::Prime(const PrimeCallback& callback) {
  callback.Run();
}

void MediaPacketConsumerBase::Flush(const FlushCallback& callback) {
  callback.Run();
}

MediaPacketConsumerBase::SuppliedPacket::SuppliedPacket(
    MediaPacketPtr packet,
    void* payload,
    const SendPacketCallback& callback)
    : packet_(packet.Pass()), payload_(payload), callback_(callback) {
  MOJO_DCHECK(packet_);
  MOJO_DCHECK(!callback.is_null());
}

MediaPacketConsumerBase::SuppliedPacket::~SuppliedPacket() {
  callback_.Run(MediaPacketConsumer::SendResult::CONSUMED);
}

}  // namespace media
}  // namespace mojo
