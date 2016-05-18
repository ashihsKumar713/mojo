// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_UI_BASE_VIEW_H_
#define MOJO_UI_BASE_VIEW_H_

#include <string>

#include "mojo/public/cpp/bindings/binding.h"
#include "mojo/public/cpp/bindings/interface_handle.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/public/cpp/system/macros.h"
#include "mojo/public/interfaces/application/application_connector.mojom.h"
#include "mojo/public/interfaces/application/service_provider.mojom.h"
#include "mojo/services/gfx/composition/interfaces/scenes.mojom.h"
#include "mojo/services/ui/views/interfaces/view_manager.mojom.h"
#include "mojo/services/ui/views/interfaces/views.mojom.h"

namespace mojo {
namespace ui {

// Abstract base implementation of a view for simple applications.
// Subclasses must handle layout and provide content for the scene by
// implementing the methods of the |ViewListener| mojom interface.
//
// It is not necessary to use this class to implement all Views.
// This class is merely intended to make the simple apps easier to write.
class BaseView : public ViewListener, public ViewContainerListener {
 public:
  BaseView(InterfaceHandle<ApplicationConnector> app_connector,
           InterfaceRequest<ViewOwner> view_owner_request,
           const std::string& label);

  ~BaseView() override;

  // Gets the application implementation object provided at creation time.
  ApplicationConnector* app_connector() { return app_connector_.get(); }

  // Gets the view manager.
  ViewManager* view_manager() { return view_manager_.get(); }

  // Gets the underlying view interface.
  View* view() { return view_.get(); }

  // Gets the service provider for the view.
  ServiceProvider* GetViewServiceProvider();

  // Gets the underlying view container interface.
  ViewContainer* GetViewContainer();

  // Gets the scene for the view.
  // Returns nullptr if the |TakeScene| was called.
  gfx::composition::Scene* scene() { return scene_.get(); }

  // Takes the scene from the view.
  // This is useful if the scene will be rendered by a separate component.
  gfx::composition::ScenePtr TakeScene() { return scene_.Pass(); }

  // Gets the currently requested scene version.
  uint32_t scene_version() { return scene_version_; }

  // Gets the current view properties.
  // Returns nullptr if none.
  ViewProperties* properties() { return properties_.get(); }

  // Called when properties changed.
  // Use |scene_version()| and |properties()| to get the current values.
  virtual void OnPropertiesChanged(uint32_t old_scene_version,
                                   ViewPropertiesPtr old_properties);

  // Called when a child is attached.
  virtual void OnChildAttached(uint32_t child_key, ViewInfoPtr child_view_info);

  // Called when a child becomes unavailable.
  virtual void OnChildUnavailable(uint32_t child_key);

 private:
  // |ViewListener|:
  void OnPropertiesChanged(
      uint32_t scene_version,
      ViewPropertiesPtr properties,
      const OnPropertiesChangedCallback& callback) override;

  // |ViewContainerListener|:
  void OnChildAttached(uint32_t child_key,
                       ViewInfoPtr child_view_info,
                       const OnChildAttachedCallback& callback) override;
  void OnChildUnavailable(uint32_t child_key,
                          const OnChildUnavailableCallback& callback) override;

  ApplicationConnectorPtr app_connector_;

  StrongBinding<ViewListener> view_listener_binding_;
  Binding<ViewContainerListener> view_container_listener_binding_;
  ViewManagerPtr view_manager_;
  ViewPtr view_;
  ServiceProviderPtr view_service_provider_;
  ViewContainerPtr view_container_;
  gfx::composition::ScenePtr scene_;
  uint32_t scene_version_ = gfx::composition::kSceneVersionNone;
  ViewPropertiesPtr properties_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(BaseView);
};

}  // namespace ui
}  // namespace mojo

#endif  // MOJO_UI_BASE_VIEW_H_
