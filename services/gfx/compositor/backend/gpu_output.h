// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_GFX_COMPOSITOR_BACKEND_GPU_OUTPUT_H_
#define SERVICES_GFX_COMPOSITOR_BACKEND_GPU_OUTPUT_H_

#include <memory>
#include <mutex>
#include <queue>

#include "base/callback.h"
#include "base/macros.h"
#include "base/memory/ref_counted.h"
#include "base/synchronization/waitable_event.h"
#include "base/task_runner.h"
#include "base/threading/thread.h"
#include "mojo/services/gpu/interfaces/context_provider.mojom.h"
#include "services/gfx/compositor/backend/gpu_rasterizer.h"
#include "services/gfx/compositor/backend/output.h"
#include "services/gfx/compositor/backend/vsync_scheduler.h"

namespace compositor {

// Renderer backed by a ContextProvider.
class GpuOutput : public Output, private GpuRasterizer::Callbacks {
 public:
  GpuOutput(mojo::InterfaceHandle<mojo::ContextProvider> context_provider,
            const SchedulerCallbacks& scheduler_callbacks,
            const base::Closure& error_callback);
  ~GpuOutput() override;

  Scheduler* GetScheduler() override;
  void SubmitFrame(const scoped_refptr<RenderFrame>& frame) override;

 private:
  struct FrameData : public base::RefCountedThreadSafe<FrameData> {
    FrameData(const scoped_refptr<RenderFrame>& frame, int64_t submit_time);

    void Recycle();

    const scoped_refptr<RenderFrame> frame;
    const int64_t submit_time;
    bool drawn = false;     // set when DrawFrame is called
    int64_t draw_time = 0;  // 0 if not drawn
    int64_t wait_time = 0;  // 0 if not drawn

   private:
    friend class base::RefCountedThreadSafe<FrameData>;

    ~FrameData();

    DISALLOW_COPY_AND_ASSIGN(FrameData);
  };

  // |GpuRasterizer::Callbacks|:
  void OnRasterizerReady(int64_t vsync_timebase,
                         int64_t vsync_interval) override;
  void OnRasterizerSuspended() override;
  void OnRasterizerFinishedDraw(bool presented) override;
  void OnRasterizerError() override;

  void ScheduleDrawLocked();
  void OnDraw();

  void InitializeRasterizer(
      mojo::InterfaceHandle<mojo::ContextProvider> context_provider);
  void DestroyRasterizer();
  void PostErrorCallback();

  scoped_refptr<base::SingleThreadTaskRunner> compositor_task_runner_;
  scoped_refptr<VsyncScheduler> vsync_scheduler_;
  base::Closure error_callback_;

  // Maximum number of frames to hold in the drawing pipeline.
  // Any more than this and we start dropping them.
  uint32_t pipeline_depth_;

  // The rasterizer itself runs on its own thread.
  std::unique_ptr<base::Thread> rasterizer_thread_;
  scoped_refptr<base::SingleThreadTaskRunner> rasterizer_task_runner_;
  base::WaitableEvent rasterizer_initialized_;
  std::unique_ptr<GpuRasterizer> rasterizer_;

  // Holds state shared between the compositor and rasterizer threads.
  struct {
    std::mutex mutex;  // guards all shared state

    // The most recently submitted frame.
    // Only null until the first frame has been submitted.
    scoped_refptr<FrameData> current_frame_data;

    // Frames drawn and awaiting completion by the rasterizer.
    std::queue<scoped_refptr<FrameData>> drawn_frames_awaiting_finish;

    // Set to true when the rasterizer is ready to draw.
    bool rasterizer_ready = false;

    // Set to true when a request to draw has been scheduled.
    bool draw_scheduled = false;
  } shared_state_;

  DISALLOW_COPY_AND_ASSIGN(GpuOutput);
};

}  // namespace compositor

#endif  // SERVICES_GFX_COMPOSITOR_BACKEND_GPU_OUTPUT_H_
