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

MediaPacketConsumerBase::MediaPacketConsumerBase() : binding_(this) {
  Reset();
  MOJO_DCHECK(counter_);
}

MediaPacketConsumerBase::~MediaPacketConsumerBase() {
  CHECK_THREAD(thread_checker_);

  // Prevent the counter from calling us back.
  counter_->Detach();

  if (binding_.is_bound()) {
    binding_.Close();
  }
}

void MediaPacketConsumerBase::Bind(
    InterfaceRequest<MediaPacketConsumer> request) {
  CHECK_THREAD(thread_checker_);
  binding_.Bind(request.Pass());
}

bool MediaPacketConsumerBase::is_bound() {
  CHECK_THREAD(thread_checker_);
  return binding_.is_bound();
}

void MediaPacketConsumerBase::SetDemand(uint32_t min_packets_outstanding,
                                        int64_t min_pts) {
  CHECK_THREAD(thread_checker_);
  if (min_packets_outstanding == demand_.min_packets_outstanding &&
      min_pts == demand_.min_pts) {
    // Demand hasn't changed. Nothing to do.
    return;
  }

  demand_.min_packets_outstanding = min_packets_outstanding;
  demand_.min_pts = min_pts;

  demand_update_required_ = true;

  MaybeCompletePullDemandUpdate();
}

void MediaPacketConsumerBase::Reset() {
  CHECK_THREAD(thread_checker_);
  if (binding_.is_bound()) {
    binding_.Close();
  }

  buffer_.Reset();

  demand_.min_packets_outstanding = 0;
  demand_.min_pts = MediaPacket::kNoTimestamp;

  get_demand_update_callback_.reset();

  if (counter_) {
    counter_->Detach();
  }
  counter_ = std::make_shared<SuppliedPacketCounter>(this);
}

void MediaPacketConsumerBase::Fail() {
  CHECK_THREAD(thread_checker_);
  Reset();
  OnFailure();
}

void MediaPacketConsumerBase::OnPacketReturning() {}

void MediaPacketConsumerBase::OnPrimeRequested(const PrimeCallback& callback) {
  callback.Run();
}

void MediaPacketConsumerBase::OnFlushRequested(const FlushCallback& callback) {
  callback.Run();
}

void MediaPacketConsumerBase::OnFailure() {
  CHECK_THREAD(thread_checker_);
}

void MediaPacketConsumerBase::PullDemandUpdate(
    const PullDemandUpdateCallback& callback) {
  CHECK_THREAD(thread_checker_);
  if (!get_demand_update_callback_.is_null()) {
    // There's already a pending request. This isn't harmful, but it indicates
    // that the client doesn't know what it's doing.
    MOJO_DLOG(WARNING) << "PullDemandUpdate was called when another "
                          "PullDemandUpdate call was pending";
    get_demand_update_callback_.Run(demand_.Clone());
  }

  get_demand_update_callback_ = callback;

  MaybeCompletePullDemandUpdate();
}

void MediaPacketConsumerBase::AddPayloadBuffer(
    uint32_t payload_buffer_id,
    ScopedSharedBufferHandle payload_buffer) {
  CHECK_THREAD(thread_checker_);
  MOJO_DCHECK(payload_buffer.is_valid());
  // TODO(dalesat): Fully support the semantics.
  RCHECK(payload_buffer_id == 0, "payload_buffer_id must be 0 for now");
  RCHECK(!buffer_.initialized(), "buffer already set");
  MojoResult result = buffer_.InitFromHandle(payload_buffer.Pass());
  RCHECK(result == MOJO_RESULT_OK, "failed to map buffer");
}

void MediaPacketConsumerBase::RemovePayloadBuffer(uint32_t payload_buffer_id) {
  CHECK_THREAD(thread_checker_);
  // TODO(dalesat): Implement RemovePayloadBuffer.
  RCHECK(false, "RemovePayloadBuffer not implemented");
}

void MediaPacketConsumerBase::SupplyPacket(
    MediaPacketPtr media_packet,
    const SupplyPacketCallback& callback) {
  CHECK_THREAD(thread_checker_);
  MOJO_DCHECK(media_packet);
  RCHECK(media_packet->payload_buffer_id == 0,
         "payload_buffer_id must be 0 for now");
  RCHECK(buffer_.initialized(), "need to AddPayloadBuffer before SupplyPacket");

  void* payload;
  if (media_packet->payload_size == 0) {
    payload = nullptr;
  } else {
    RCHECK(buffer_.Validate(media_packet->payload_offset,
                            media_packet->payload_size),
           "invalid buffer region");
    payload = buffer_.PtrFromOffset(media_packet->payload_offset);
  }

  OnPacketSupplied(std::unique_ptr<SuppliedPacket>(
      new SuppliedPacket(media_packet.Pass(), payload, callback, counter_)));
}

void MediaPacketConsumerBase::Prime(const PrimeCallback& callback) {
  CHECK_THREAD(thread_checker_);

  demand_.min_packets_outstanding = 0;
  demand_.min_pts = MediaPacket::kNoTimestamp;

  OnPrimeRequested([this, callback]() { callback.Run(); });
}

void MediaPacketConsumerBase::Flush(const FlushCallback& callback) {
  CHECK_THREAD(thread_checker_);
  OnFlushRequested([this, callback]() { callback.Run(); });
}

void MediaPacketConsumerBase::MaybeCompletePullDemandUpdate() {
  CHECK_THREAD(thread_checker_);
  // If we're in the middle of returning a packet, we want to use the
  // SupplyPacket callback for demand updates rather than the PullDemandUpdate
  // callback.
  if (!demand_update_required_ || returning_packet_ ||
      get_demand_update_callback_.is_null()) {
    return;
  }

  demand_update_required_ = false;
  get_demand_update_callback_.Run(demand_.Clone());
  get_demand_update_callback_.reset();
}

MediaPacketDemandPtr MediaPacketConsumerBase::GetDemandForPacketDeparture() {
  CHECK_THREAD(thread_checker_);

  // Note that we're returning a packet so that MaybeCompletePullDemandUpdate
  // won't try to send a packet update via a PullDemandUpdate callback.
  returning_packet_ = true;
  // This is the subclass's chance to SetDemand.
  OnPacketReturning();
  returning_packet_ = false;

  if (!demand_update_required_) {
    return nullptr;
  }

  demand_update_required_ = false;
  return demand_.Clone();
}

MediaPacketConsumerBase::SuppliedPacket::SuppliedPacket(
    MediaPacketPtr packet,
    void* payload,
    const SupplyPacketCallback& callback,
    std::shared_ptr<SuppliedPacketCounter> counter)
    : packet_(packet.Pass()),
      payload_(payload),
      callback_(callback),
      counter_(counter) {
  MOJO_DCHECK(packet_);
  MOJO_DCHECK(!callback.is_null());
  MOJO_DCHECK(counter_);
  counter_->OnPacketArrival();
}

MediaPacketConsumerBase::SuppliedPacket::~SuppliedPacket() {
  CHECK_THREAD(thread_checker_);
  callback_.Run(counter_->OnPacketDeparture());
}

MediaPacketConsumerBase::SuppliedPacketCounter::SuppliedPacketCounter(
    MediaPacketConsumerBase* owner)
    : owner_(owner) {
  CHECK_THREAD(thread_checker_);
}

MediaPacketConsumerBase::SuppliedPacketCounter::~SuppliedPacketCounter() {
  CHECK_THREAD(thread_checker_);
}

}  // namespace media
}  // namespace mojo
