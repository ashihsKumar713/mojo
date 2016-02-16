// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_UI_BASE_VIEW_H_
#define MOJO_UI_BASE_VIEW_H_

#include <string>

#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "mojo/public/cpp/system/macros.h"
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
class BaseView : public mojo::ui::ViewListener {
 public:
  // TODO(jeffbrown): Consider switching this over to an ApplicationConnector
  // but having ApplicationImpl is handy for simple examples.
  BaseView(mojo::ApplicationImpl* app_impl,
           mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
           const std::string& label);

  ~BaseView() override;

  // Gets the application implementation object provided at creation time.
  mojo::ApplicationImpl* app_impl() { return app_impl_; }

  // Gets the view manager.
  mojo::ui::ViewManager* view_manager() { return view_manager_.get(); }

  // Gets the underlying view interface.
  mojo::ui::View* view() { return view_.get(); }

  // Gets the service provider for the view.
  mojo::ServiceProvider* view_service_provider() {
    return view_service_provider_.get();
  }

  // Gets the scene for the view.
  // Returns nullptr if the |TakeScene| was called.
  mojo::gfx::composition::Scene* scene() { return scene_.get(); }

  // Takes the scene from the view.
  // This is useful if the scene will be rendered by a separate component.
  mojo::gfx::composition::ScenePtr TakeScene() { return scene_.Pass(); }

  // |ViewListener|:
  void OnChildUnavailable(uint32_t child_key,
                          const OnChildUnavailableCallback& callback) override;

 private:
  mojo::ApplicationImpl* app_impl_;

  mojo::StrongBinding<mojo::ui::ViewListener> view_listener_binding_;
  mojo::ui::ViewManagerPtr view_manager_;
  mojo::ui::ViewPtr view_;
  mojo::ServiceProviderPtr view_service_provider_;
  mojo::gfx::composition::ScenePtr scene_;

  MOJO_DISALLOW_COPY_AND_ASSIGN(BaseView);
};

}  // namespace ui
}  // namespace mojo

#endif  // MOJO_UI_BASE_VIEW_H_
