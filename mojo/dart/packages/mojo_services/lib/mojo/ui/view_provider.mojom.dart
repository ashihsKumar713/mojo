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
    const bindings.StructDataHeader(16, 0)
  ];
  view_token_mojom.ViewOwnerInterfaceRequest viewOwner = null;
  service_provider_mojom.ServiceProviderInterfaceRequest services = null;

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
  }

  String toString() {
    return "_ViewProviderCreateViewParams("
           "viewOwner: $viewOwner" ", "
           "services: $services" ")";
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

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewProviderServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static ViewProviderProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewProviderProxy p = new ViewProviderProxy.unbound();
    String name = serviceName ?? ViewProvider.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void createView(view_token_mojom.ViewOwnerInterfaceRequest viewOwner, service_provider_mojom.ServiceProviderInterfaceRequest services);
}

abstract class ViewProviderInterface
    implements bindings.MojoInterface<ViewProvider>,
               ViewProvider {
  factory ViewProviderInterface([ViewProvider impl]) =>
      new ViewProviderStub.unbound(impl);
  factory ViewProviderInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [ViewProvider impl]) =>
      new ViewProviderStub.fromEndpoint(endpoint, impl);
}

abstract class ViewProviderInterfaceRequest
    implements bindings.MojoInterface<ViewProvider>,
               ViewProvider {
  factory ViewProviderInterfaceRequest() =>
      new ViewProviderProxy.unbound();
}

class _ViewProviderProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<ViewProvider> {
  _ViewProviderProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewProviderProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ViewProviderProxyControl.unbound() : super.unbound();

  String get serviceName => ViewProvider.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  ViewProvider get impl => null;
  set impl(ViewProvider _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_ViewProviderProxyControl($superString)";
  }
}

class ViewProviderProxy
    extends bindings.Proxy<ViewProvider>
    implements ViewProvider,
               ViewProviderInterface,
               ViewProviderInterfaceRequest {
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


  void createView(view_token_mojom.ViewOwnerInterfaceRequest viewOwner, service_provider_mojom.ServiceProviderInterfaceRequest services) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ViewProviderCreateViewParams();
    params.viewOwner = viewOwner;
    params.services = services;
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

  String get serviceName => ViewProvider.serviceName;



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
        _impl.createView(params.viewOwner, params.services);
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
}

class ViewProviderStub
    extends bindings.Stub<ViewProvider>
    implements ViewProvider,
               ViewProviderInterface,
               ViewProviderInterfaceRequest {
  ViewProviderStub.unbound([ViewProvider impl])
      : super(new _ViewProviderStubControl.unbound(impl));

  ViewProviderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ViewProvider impl])
      : super(new _ViewProviderStubControl.fromEndpoint(endpoint, impl));

  ViewProviderStub.fromHandle(
      core.MojoHandle handle, [ViewProvider impl])
      : super(new _ViewProviderStubControl.fromHandle(handle, impl));

  static ViewProviderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewProviderStub"));
    return new ViewProviderStub.fromEndpoint(endpoint);
  }


  void createView(view_token_mojom.ViewOwnerInterfaceRequest viewOwner, service_provider_mojom.ServiceProviderInterfaceRequest services) {
    return impl.createView(viewOwner, services);
  }
}



