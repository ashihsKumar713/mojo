// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_TEST_SERVICE_TEST_SERVICE_APPLICATION_H_
#define SERVICES_TEST_SERVICE_TEST_SERVICE_APPLICATION_H_

#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/system/macros.h"

namespace mojo {
class ApplicationConnection;

namespace test {
class TestService;
class TestTimeService;

class TestServiceApplication : public ApplicationDelegate {
 public:
  TestServiceApplication();
  ~TestServiceApplication() override;

  void Initialize(ApplicationImpl* app) override;

  // ApplicationDelegate implementation.
  bool ConfigureIncomingConnection(
      ServiceProviderImpl* service_provider_impl) override;

  void AddRef();
  void ReleaseRef();

 private:
  int ref_count_;
  ApplicationImpl* app_impl_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(TestServiceApplication);
};

}  // namespace test
}  // namespace mojo

#endif  // SERVICES_TEST_SERVICE_TEST_SERVICE_APPLICATION_H_
