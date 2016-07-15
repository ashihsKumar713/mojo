// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/public/cpp/environment/logging.h"
#include "mojo/services/media/common/cpp/media_packet_producer_base.h"

namespace mojo {
namespace media {

MediaPacketProducerBase::MediaPacketProducerBase() {}

MediaPacketProducerBase::~MediaPacketProducerBase() {}

void MediaPacketProducerBase::Connect(
    MediaPacketConsumerPtr consumer,
    const MediaPacketProducer::ConnectCallback& callback) {
  MOJO_DCHECK(consumer);

  consumer_ = consumer.Pass();

  consumer_.set_connection_error_handler([this]() { OnFailure(); });

  if (!EnsureAllocatorInitialized()) {
    callback.Run();
    return;
  }

  consumer_->SetBuffer(allocator_.GetDuplicateHandle(),
                       [callback]() { callback.Run(); });
}

void MediaPacketProducerBase::Reset() {
  Disconnect();
  allocator_.Reset();
}

void MediaPacketProducerBase::PrimeConsumer(
    const MediaPacketConsumer::PrimeCallback& callback) {
  MOJO_DCHECK(consumer_.is_bound());
  consumer_->Prime(callback);
}

void MediaPacketProducerBase::FlushConsumer(
    const MediaPacketConsumer::FlushCallback& callback) {
  MOJO_DCHECK(consumer_.is_bound());
  consumer_->Flush(callback);
}

void* MediaPacketProducerBase::AllocatePayloadBuffer(size_t size) {
  if (!EnsureAllocatorInitialized()) {
    return nullptr;
  }

  return allocator_.AllocateRegion(size);
}

void MediaPacketProducerBase::ReleasePayloadBuffer(void* buffer) {
  allocator_.ReleaseRegion(buffer);
}

void MediaPacketProducerBase::ProducePacket(
    void* payload,
    size_t size,
    int64_t pts,
    bool end_of_stream,
    const ProducePacketCallback& callback) {
  MOJO_DCHECK(size == 0 || payload != nullptr);

  if (!consumer_.is_bound()) {
    callback();
    return;
  }

  MediaPacketRegionPtr region = MediaPacketRegion::New();
  region->offset = size == 0 ? 0 : allocator_.OffsetFromPtr(payload);
  region->length = size;

  MediaPacketPtr media_packet = MediaPacket::New();
  media_packet->pts = pts;
  media_packet->end_of_stream = end_of_stream;
  media_packet->payload = region.Pass();

  consumer_->SendPacket(
      media_packet.Pass(),
      [this, callback](MediaPacketConsumer::SendResult send_result) {
        callback();
      });
}

void MediaPacketProducerBase::OnFailure() {}

bool MediaPacketProducerBase::EnsureAllocatorInitialized() {
  if (allocator_.initialized()) {
    return true;
  }

  // TODO(dalesat): Made up allocation.
  if (allocator_.InitNew(4096 * 1024) == MOJO_RESULT_OK) {
    return true;
  }

  Reset();
  OnFailure();
  return false;
}

}  // namespace media
}  // namespace mojo
