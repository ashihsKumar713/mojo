// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/public/cpp/environment/logging.h"
#include "mojo/services/media/common/cpp/media_packet_producer_base.h"

namespace mojo {
namespace media {

MediaPacketProducerBase::MediaPacketProducerBase() {
  // No demand initially.
  demand_.min_packets_outstanding = 0;
  demand_.min_pts = MediaPacket::kNoTimestamp;
}

MediaPacketProducerBase::~MediaPacketProducerBase() {
  CHECK_THREAD(thread_checker_);
}

void MediaPacketProducerBase::Connect(
    MediaPacketConsumerPtr consumer,
    const MediaPacketProducer::ConnectCallback& callback) {
  CHECK_THREAD(thread_checker_);
  MOJO_DCHECK(consumer);

  consumer_ = consumer.Pass();
  consumer_.set_connection_error_handler([this]() { OnFailure(); });

  if (!EnsureAllocatorInitialized()) {
    callback.Run();
    return;
  }

  // TODO(dalesat): Implement dynamic buffer allocation.
  consumer_->AddPayloadBuffer(0, allocator_.GetDuplicateHandle());
  HandleDemandUpdate();
  callback.Run();
}

void MediaPacketProducerBase::Reset() {
  CHECK_THREAD(thread_checker_);
  Disconnect();
  allocator_.Reset();
}

void MediaPacketProducerBase::PrimeConsumer(
    const MediaPacketConsumer::PrimeCallback& callback) {
  CHECK_THREAD(thread_checker_);
  MOJO_DCHECK(consumer_.is_bound());
  consumer_->Prime([this, callback]() {
    callback.Run();
  });
}

void MediaPacketProducerBase::FlushConsumer(
    const MediaPacketConsumer::FlushCallback& callback) {
  CHECK_THREAD(thread_checker_);
  MOJO_DCHECK(consumer_.is_bound());

  {
    std::lock_guard<std::mutex> lock(lock_);
    end_of_stream_ = false;
  }

  MediaPacketDemand demand;
  demand.min_packets_outstanding = 0;
  demand.min_pts = MediaPacket::kNoTimestamp;
  UpdateDemand(demand);

  flush_in_progress_ = true;
  consumer_->Flush([this, callback]() {
    flush_in_progress_ = false;
    callback.Run();
  });
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
  CHECK_THREAD(thread_checker_);
  MOJO_DCHECK(size == 0 || payload != nullptr);

  if (!consumer_.is_bound()) {
    callback();
    return;
  }

  MediaPacketPtr media_packet = MediaPacket::New();
  media_packet->pts = pts;
  media_packet->end_of_stream = end_of_stream;
  media_packet->payload_buffer_id = 0;
  media_packet->payload_offset = allocator_.OffsetFromPtr(payload);
  media_packet->payload_size = size;

  {
    std::lock_guard<std::mutex> lock(lock_);
    ++packets_outstanding_;
    pts_last_produced_ = pts;
    end_of_stream_ = end_of_stream;
  }

  consumer_->SupplyPacket(media_packet.Pass(),
                          [this, callback](MediaPacketDemandPtr demand) {
                            CHECK_THREAD(thread_checker_);

                            {
                              std::lock_guard<std::mutex> lock(lock_);
                              --packets_outstanding_;
                            }

                            if (demand) {
                              UpdateDemand(*demand);
                            }

                            callback();
                          });
}

bool MediaPacketProducerBase::ShouldProducePacket(
    uint32_t additional_packets_outstanding) {
  std::lock_guard<std::mutex> lock(lock_);

  // Shouldn't send any more after end of stream.
  if (end_of_stream_) {
    return false;
  }

  // See if more packets are demanded.
  if (demand_.min_packets_outstanding >
      packets_outstanding_ + additional_packets_outstanding) {
    return true;
  }

  // See if a higher PTS is demanded.
  return demand_.min_pts != MediaPacket::kNoTimestamp &&
         demand_.min_pts > pts_last_produced_;
}

void MediaPacketProducerBase::OnFailure() {
  CHECK_THREAD(thread_checker_);
}

void MediaPacketProducerBase::OnDemandUpdated(uint32_t min_packets_outstanding,
                                              int64_t min_pts) {
  CHECK_THREAD(thread_checker_);
}

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

void MediaPacketProducerBase::HandleDemandUpdate(MediaPacketDemandPtr demand) {
  CHECK_THREAD(thread_checker_);
  if (demand) {
    UpdateDemand(*demand);
  }

  if (consumer_.is_bound()) {
    consumer_->PullDemandUpdate([this](MediaPacketDemandPtr demand) {
      CHECK_THREAD(thread_checker_);
      HandleDemandUpdate(demand.Pass());
    });
  }
}

void MediaPacketProducerBase::UpdateDemand(const MediaPacketDemand& demand) {
  CHECK_THREAD(thread_checker_);

  if (flush_in_progress_) {
    // While flushing, we ignore demand changes, because the consumer may have
    // sent them before it knew we were flushing.
    return;
  }

  bool updated = false;

  {
    std::lock_guard<std::mutex> lock(lock_);
    if (demand_.min_packets_outstanding != demand.min_packets_outstanding ||
        demand_.min_pts != demand.min_pts) {
      demand_.min_packets_outstanding = demand.min_packets_outstanding;
      demand_.min_pts = demand.min_pts;
      updated = true;
    }
  }

  if (updated) {
    OnDemandUpdated(demand.min_packets_outstanding, demand.min_pts);
  }
}

}  // namespace media
}  // namespace mojo
