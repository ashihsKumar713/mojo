// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library view_provider_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/service_provider.mojom.dart' as service_provider_mojom;
import 'package:mojo_services/mojo/ui/view_token.mojom.dart' as view_token_mojom;



class _ViewProviderCreateViewParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object viewOwner = null;
  Object services = null;
  Object exposedServices = null;

  _ViewProviderCreateViewParams() : super(kVersions.last.size);

  static _ViewProviderCreateViewParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewProviderCreateViewParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewProviderCreateViewParams result = new _ViewProviderCreateViewParams();

    var mainDataHeader = decoder0.decodeStructDataHeader();
    if (mainDataHeader.version <= kVersions.last.version) {
      // Scan in reverse order to optimize for more recent versions.
      for (int i = kVersions.length - 1; i >= 0; --i) {
        if (mainDataHeader.version >= kVersions[i].version) {
          if (mainDataHeader.size == kVersions[i].size) {
            // Found a match.
            break;
          }
          throw new bindings.MojoCodecError(
              'Header size doesn\'t correspond to known version size.');
        }
      }
    } else if (mainDataHeader.size < kVersions.last.size) {
      throw new bindings.MojoCodecError(
        'Message newer than the last known version cannot be shorter than '
        'required by the last known version.');
    }
    if (mainDataHeader.version >= 0) {
      
      result.viewOwner = decoder0.decodeInterfaceRequest(8, false, view_token_mojom.ViewOwnerStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.services = decoder0.decodeInterfaceRequest(12, true, service_provider_mojom.ServiceProviderStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.exposedServices = decoder0.decodeServiceInterface(16, true, service_provider_mojom.ServiceProviderProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(viewOwner, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewOwner of struct _ViewProviderCreateViewParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(services, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "services of struct _ViewProviderCreateViewParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(exposedServices, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "exposedServices of struct _ViewProviderCreateViewParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewProviderCreateViewParams("
           "viewOwner: $viewOwner" ", "
           "services: $services" ", "
           "exposedServices: $exposedServices" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _viewProviderMethodCreateViewName = 0;

class _ViewProviderServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewProvider {
  static const String serviceName = "mojo::ui::ViewProvider";
  void createView(Object viewOwner, Object services, Object exposedServices);
}

class _ViewProviderProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _ViewProviderProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewProviderProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ViewProviderProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _ViewProviderServiceDescription();

  String get serviceName => ViewProvider.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_ViewProviderProxyControl($superString)";
  }
}

class ViewProviderProxy
    extends bindings.Proxy
    implements ViewProvider {
  ViewProviderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _ViewProviderProxyControl.fromEndpoint(endpoint));

  ViewProviderProxy.fromHandle(core.MojoHandle handle)
      : super(new _ViewProviderProxyControl.fromHandle(handle));

  ViewProviderProxy.unbound()
      : super(new _ViewProviderProxyControl.unbound());

  static ViewProviderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewProviderProxy"));
    return new ViewProviderProxy.fromEndpoint(endpoint);
  }

  factory ViewProviderProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewProviderProxy p = new ViewProviderProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void createView(Object viewOwner, Object services, Object exposedServices) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ViewProviderCreateViewParams();
    params.viewOwner = viewOwner;
    params.services = services;
    params.exposedServices = exposedServices;
    ctrl.sendMessage(params,
        _viewProviderMethodCreateViewName);
  }
}

class _ViewProviderStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<ViewProvider> {
  ViewProvider _impl;

  _ViewProviderStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ViewProvider impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _ViewProviderStubControl.fromHandle(
      core.MojoHandle handle, [ViewProvider impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _ViewProviderStubControl.unbound([this._impl]) : super.unbound();



  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          0,
                                                          message);
    }
    if (_impl == null) {
      throw new core.MojoApiError("$this has no implementation set");
    }
    switch (message.header.type) {
      case _viewProviderMethodCreateViewName:
        var params = _ViewProviderCreateViewParams.deserialize(
            message.payload);
        _impl.createView(params.viewOwner, params.services, params.exposedServices);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ViewProvider get impl => _impl;
  set impl(ViewProvider d) {
    if (d == null) {
      throw new core.MojoApiError("$this: Cannot set a null implementation");
    }
    if (isBound && (_impl == null)) {
      beginHandlingEvents();
    }
    _impl = d;
  }

  @override
  void bind(core.MojoMessagePipeEndpoint endpoint) {
    super.bind(endpoint);
    if (!isOpen && (_impl != null)) {
      beginHandlingEvents();
    }
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_ViewProviderStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewProviderServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class ViewProviderStub
    extends bindings.Stub<ViewProvider>
    implements ViewProvider {
  ViewProviderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ViewProvider impl])
      : super(new _ViewProviderStubControl.fromEndpoint(endpoint, impl));

  ViewProviderStub.fromHandle(
      core.MojoHandle handle, [ViewProvider impl])
      : super(new _ViewProviderStubControl.fromHandle(handle, impl));

  ViewProviderStub.unbound([ViewProvider impl])
      : super(new _ViewProviderStubControl.unbound(impl));

  static ViewProviderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewProviderStub"));
    return new ViewProviderStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _ViewProviderStubControl.serviceDescription;


  void createView(Object viewOwner, Object services, Object exposedServices) {
    return impl.createView(viewOwner, services, exposedServices);
  }
}



