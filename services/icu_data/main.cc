// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/application/application_runner_chromium.h"
#include "mojo/public/c/system/main.h"
#include "services/icu_data/icu_data_impl.h"

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(new icu_data::ICUDataImpl);
  return runner.Run(application_request);
}
