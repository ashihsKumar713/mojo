// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/ui/base_view.h"

#include "base/logging.h"
#include "mojo/public/cpp/application/connect.h"

namespace mojo {
namespace ui {

BaseView::BaseView(InterfaceHandle<ApplicationConnector> app_connector,
                   InterfaceRequest<ViewOwner> view_owner_request,
                   const std::string& label)
    : app_connector_(ApplicationConnectorPtr::Create(app_connector.Pass())),
      view_listener_binding_(this),
      view_container_listener_binding_(this) {
  DCHECK(app_connector_);
  ConnectToService(app_connector_.get(), "mojo:view_manager_service",
                   GetProxy(&view_manager_));

  ViewListenerPtr view_listener;
  view_listener_binding_.Bind(GetProxy(&view_listener));
  view_manager_->CreateView(GetProxy(&view_), view_owner_request.Pass(),
                            view_listener.Pass(), label);
  view_->CreateScene(GetProxy(&scene_));
}

BaseView::~BaseView() {}

ServiceProvider* BaseView::GetViewServiceProvider() {
  if (!view_service_provider_)
    view_->GetServiceProvider(GetProxy(&view_service_provider_));
  return view_service_provider_.get();
}

ViewContainer* BaseView::GetViewContainer() {
  if (!view_container_) {
    view_->GetContainer(GetProxy(&view_container_));
    ViewContainerListenerPtr view_container_listener;
    view_container_listener_binding_.Bind(GetProxy(&view_container_listener));
    view_container_->SetListener(view_container_listener.Pass());
  }
  return view_container_.get();
}

void BaseView::OnPropertiesChanged(uint32_t old_scene_version,
                                   ViewPropertiesPtr old_properties) {}

void BaseView::OnChildAttached(uint32_t child_key,
                               ViewInfoPtr child_view_info) {}

void BaseView::OnChildUnavailable(uint32_t child_key) {}

void BaseView::OnPropertiesChanged(
    uint32_t scene_version,
    ViewPropertiesPtr properties,
    const OnPropertiesChangedCallback& callback) {
  DCHECK(properties);
  DCHECK(properties->display_metrics);
  DCHECK(properties->view_layout);
  DCHECK(properties->view_layout->size);

  uint32_t old_scene_version = scene_version_;
  ViewPropertiesPtr old_properties = properties_.Pass();
  scene_version_ = scene_version;
  properties_ = properties.Pass();

  OnPropertiesChanged(old_scene_version, old_properties.Pass());
  callback.Run();
}

void BaseView::OnChildAttached(uint32_t child_key,
                               ViewInfoPtr child_view_info,
                               const OnChildUnavailableCallback& callback) {
  DCHECK(child_view_info);

  OnChildAttached(child_key, child_view_info.Pass());
  callback.Run();
}

void BaseView::OnChildUnavailable(uint32_t child_key,
                                  const OnChildUnavailableCallback& callback) {
  OnChildUnavailable(child_key);
  callback.Run();
}

}  // namespace ui
}  // namespace mojo
