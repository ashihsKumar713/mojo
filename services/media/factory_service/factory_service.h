// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_MEDIA_FACTORY_FACTORY_SERVICE_H_
#define MOJO_SERVICES_MEDIA_FACTORY_FACTORY_SERVICE_H_

#include "mojo/common/binding_set.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/services/media/control/interfaces/media_factory.mojom.h"
#include "services/util/cpp/factory_service_base.h"

namespace mojo {
namespace media {

class MediaFactoryService : public util::FactoryServiceBase,
                            public MediaFactory {
 public:
  MediaFactoryService();

  ~MediaFactoryService() override;

  // ApplicationDelegate implementation.
  bool ConfigureIncomingConnection(
      ServiceProviderImpl* service_provider_impl) override;

  // MediaFactory implementation.
  void CreatePlayer(InterfaceHandle<SeekingReader> reader,
                    InterfaceRequest<MediaPlayer> player) override;

  void CreateSource(InterfaceHandle<SeekingReader> reader,
                    Array<MediaTypeSetPtr> allowed_media_types,
                    InterfaceRequest<MediaSource> source) override;

  void CreateSink(const String& destination_url,
                  MediaTypePtr media_type,
                  InterfaceRequest<MediaSink> sink) override;

  void CreateDemux(InterfaceHandle<SeekingReader> reader,
                   InterfaceRequest<MediaDemux> demux) override;

  void CreateDecoder(MediaTypePtr input_media_type,
                     InterfaceRequest<MediaTypeConverter> decoder) override;

  void CreateNetworkReader(const String& url,
                           InterfaceRequest<SeekingReader> reader) override;

 private:
  BindingSet<MediaFactory> bindings_;
};

}  // namespace media
}  // namespace mojo

#endif  // MOJO_SERVICES_MEDIA_FACTORY_FACTORY_SERVICE_H_
