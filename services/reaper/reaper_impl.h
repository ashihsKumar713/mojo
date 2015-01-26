// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef SERVICES_REAPER_REAPER_IMPL_H_
#define SERVICES_REAPER_REAPER_IMPL_H_

#include <map>

#include "base/macros.h"
#include "mojo/common/weak_binding_set.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/interface_factory.h"
#include "mojo/public/cpp/bindings/array.h"
#include "mojo/public/cpp/bindings/callback.h"
#include "services/reaper/diagnostics.mojom.h"
#include "services/reaper/reaper.mojom.h"
#include "url/gurl.h"

namespace mojo {
class ApplicationConnection;
}  // namespace mojo

namespace reaper {

class ReaperImpl : public Diagnostics,
                   public mojo::ApplicationDelegate,
                   public mojo::InterfaceFactory<Reaper>,
                   public mojo::InterfaceFactory<Diagnostics> {
 public:
  ReaperImpl();
  ~ReaperImpl();

  void CreateReference(GURL caller_app,
                       uint32 source_node_id,
                       uint32 target_node_id);
  void DropNode(GURL caller_app, uint32 node);

 private:
  struct NodeLocator;
  struct NodeInfo;

  // mojo::ApplicationDelegate
  bool ConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override;

  // mojo::InterfaceFactory<Reaper>
  void Create(mojo::ApplicationConnection* connection,
              mojo::InterfaceRequest<Reaper> request) override;

  // mojo::InterfaceFactory<Diagnostics>
  void Create(mojo::ApplicationConnection* connection,
              mojo::InterfaceRequest<Diagnostics> request) override;

  // Diagnostics
  void DumpNodes(
      const mojo::Callback<void(mojo::Array<NodePtr>)>& callback) override;
  void Reset(const mojo::Callback<void()>&) override;

  std::map<NodeLocator, NodeInfo> nodes_;
  mojo::WeakBindingSet<Diagnostics> diagnostics_bindings_;

  DISALLOW_COPY_AND_ASSIGN(ReaperImpl);
};

#endif  // SERVICES_REAPER_REAPER_IMPL_H_

}  // namespace reaper
