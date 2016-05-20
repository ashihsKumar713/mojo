// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/choreographer.h"

#include "base/bind.h"
#include "base/logging.h"
#include "mojo/public/cpp/system/time.h"

namespace mojo {
namespace ui {

Choreographer::Choreographer(mojo::gfx::composition::Scene* scene,
                             ChoreographerDelegate* delegate)
    : delegate_(delegate) {
  DCHECK(delegate_);
  scene->GetScheduler(mojo::GetProxy(&frame_scheduler_));
}

Choreographer::Choreographer(
    mojo::gfx::composition::FrameSchedulerPtr frame_scheduler,
    ChoreographerDelegate* delegate)
    : frame_scheduler_(frame_scheduler.Pass()), delegate_(delegate) {
  DCHECK(frame_scheduler_);
  DCHECK(delegate_);
}

Choreographer::~Choreographer() {}

void Choreographer::ScheduleDraw() {
  if (!draw_scheduled_) {
    draw_scheduled_ = true;
    ScheduleFrame();
  }
}

void Choreographer::ScheduleFrame() {
  if (!frame_scheduled_) {
    frame_scheduled_ = true;
    frame_scheduler_->ScheduleFrame(
        base::Bind(&Choreographer::DoFrame, base::Unretained(this)));
  }
}

void Choreographer::DoFrame(mojo::gfx::composition::FrameInfoPtr frame_info) {
  DCHECK(frame_info);
  DCHECK(frame_scheduled_);
  frame_scheduled_ = false;

  if (draw_scheduled_) {
    draw_scheduled_ = false;

    // To reduce latency and jank, anticipate the next frame to be drawn by
    // scheduling it early.
    //
    // TODO(jeffbrown): Reenable this once issue #604 is fixed.  Unfortunately
    // this exacerbates starvation issues in the Mojo message pump.
    // ScheduleFrame();

    base::TimeDelta time_delta = base::TimeDelta::FromMicroseconds(
        frame_tracker_.Update(*frame_info, mojo::GetTimeTicksNow()));
    delegate_->OnDraw(frame_tracker_.frame_info(), time_delta);
  }
}

}  // namespace ui
}  // namespace mojo
