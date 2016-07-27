// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_COMMON_CPP_MEDIA_PACKET_CONSUMER_BASE_H_
#define MOJO_SERVICES_MEDIA_COMMON_CPP_MEDIA_PACKET_CONSUMER_BASE_H_

#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/services/media/common/cpp/mapped_shared_buffer.h"
#include "mojo/services/media/common/cpp/thread_checker.h"
#include "mojo/services/media/common/interfaces/media_transport.mojom.h"

namespace mojo {
namespace media {

// Base class that implements MediaPacketConsumer.
class MediaPacketConsumerBase : public MediaPacketConsumer {
 private:
  class SuppliedPacketCounter;

 public:
  MediaPacketConsumerBase();

  ~MediaPacketConsumerBase() override;

  // Wraps a supplied MediaPacket and calls the associated callback when
  // destroyed. Also works with SuppliedPacketCounter to keep track of the
  // number of outstanding packets and to deliver demand updates.
  class SuppliedPacket {
   public:
    ~SuppliedPacket();

    const MediaPacketPtr& packet() { return packet_; }
    void* payload() { return payload_; }
    uint64_t payload_size() { return packet_->payload_size; }

   private:
    SuppliedPacket(MediaPacketPtr packet,
                   void* payload,
                   const SupplyPacketCallback& callback,
                   std::shared_ptr<SuppliedPacketCounter> counter);

    MediaPacketPtr packet_;
    void* payload_;
    SupplyPacketCallback callback_;
    std::shared_ptr<SuppliedPacketCounter> counter_;

    DECLARE_THREAD_CHECKER(thread_checker_);

    // So the constructor can be private.
    friend class MediaPacketConsumerBase;
  };

  // Binds to this MediaPacketConsumer.
  void Bind(InterfaceRequest<MediaPacketConsumer> request);

  // Determines if the consumer is bound to a message pipe.
  bool is_bound();

  const MediaPacketDemand& current_demand() { return demand_; }

  // Sets the demand, which is communicated back to the producer at the first
  // opportunity (in response to PullDemandUpdate or SupplyPacket).
  void SetDemand(uint32_t min_packets_outstanding,
                 int64_t min_pts = MediaPacket::kNoTimestamp);

  // Shuts down the consumer.
  void Reset();

  // Shuts down the consumer and calls OnFailure().
  void Fail();

 protected:
  // Called when a packet is supplied.
  virtual void OnPacketSupplied(
      std::unique_ptr<SuppliedPacket> supplied_packet) = 0;

  // Called upon the return of a supplied packet after the value returned by
  // supplied_packets_outstanding() has been updated and before the callback is
  // called. This is often a good time to call SetDemand. The default
  // implementation does nothing.
  virtual void OnPacketReturning();

  // Called when the consumer is asked to prime. The default implementation
  // just runs the callback.
  virtual void OnPrimeRequested(const PrimeCallback& callback);

  // Called when the consumer is asked to flush. The default implementation
  // just runs the callback.
  virtual void OnFlushRequested(const FlushCallback& callback);

  // Called when a fatal error occurs. The default implementation does nothing.
  virtual void OnFailure();

  size_t supplied_packets_outstanding() {
    return counter_->packets_outstanding();
  }

 private:
  // MediaPacketConsumer implementation.
  void PullDemandUpdate(const PullDemandUpdateCallback& callback) final;

  void AddPayloadBuffer(uint32_t payload_buffer_id,
                        ScopedSharedBufferHandle payload_buffer) final;

  void RemovePayloadBuffer(uint32_t payload_buffer_id) final;

  void SupplyPacket(MediaPacketPtr packet,
                    const SupplyPacketCallback& callback) final;

  void Prime(const PrimeCallback& callback) final;

  void Flush(const FlushCallback& callback) final;

  // Counts oustanding supplied packets and uses their callbacks to deliver
  // demand updates. This class is referenced using shared_ptrs so that no
  // SuppliedPackets outlive it.
  // TODO(dalesat): Get rid of this separate class by insisting that the
  // MediaPacketConsumerBase outlive its SuppliedPackets.
  class SuppliedPacketCounter {
   public:
    SuppliedPacketCounter(MediaPacketConsumerBase* owner);

    ~SuppliedPacketCounter();

    // Prevents any subsequent calls to the owner.
    void Detach() {
      CHECK_THREAD(thread_checker_);
      owner_ = nullptr;
    }

    // Records the arrival of a packet.
    void OnPacketArrival() {
      CHECK_THREAD(thread_checker_);
      ++packets_outstanding_;
    }

    // Records the departure of a packet and returns the current demand update,
    // if any.
    MediaPacketDemandPtr OnPacketDeparture() {
      CHECK_THREAD(thread_checker_);
      --packets_outstanding_;
      return (owner_ == nullptr) ? nullptr
                                 : owner_->GetDemandForPacketDeparture();
    }

    // Returns number of packets currently outstanding.
    size_t packets_outstanding() {
      CHECK_THREAD(thread_checker_);
      return packets_outstanding_;
    }

   private:
    MediaPacketConsumerBase* owner_;
    size_t packets_outstanding_ = 0;

    DECLARE_THREAD_CHECKER(thread_checker_);
  };

  // Completes a pending PullDemandUpdate if there is one and if there's an
  // update to send.
  void MaybeCompletePullDemandUpdate();

  // Returns the demand update, if any, to be included in a SupplyPacket
  // callback.
  MediaPacketDemandPtr GetDemandForPacketDeparture();

  Binding<MediaPacketConsumer> binding_;
  MappedSharedBuffer buffer_;
  MediaPacketDemand demand_;
  bool demand_update_required_ = false;
  bool returning_packet_ = false;
  PullDemandUpdateCallback get_demand_update_callback_;
  std::shared_ptr<SuppliedPacketCounter> counter_;

  DECLARE_THREAD_CHECKER(thread_checker_);
};

}  // namespace media
}  // namespace mojo

#endif  // MOJO_SERVICES_MEDIA_COMMON_CPP_MEDIA_PACKET_CONSUMER_BASE_H_
