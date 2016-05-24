// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/util/cpp/factory_service_base.h"

namespace mojo {
namespace util {

FactoryServiceBase::ProductBase::ProductBase(FactoryServiceBase* owner)
    : owner_(owner) {
  DCHECK(owner_);
}

FactoryServiceBase::ProductBase::~ProductBase() {}

FactoryServiceBase::FactoryServiceBase() {}

FactoryServiceBase::~FactoryServiceBase() {}

void FactoryServiceBase::Initialize(ApplicationImpl* app) {
  app_ = app;
}

}  // namespace util
}  // namespace mojo
