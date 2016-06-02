// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library view_trees_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/service_provider.mojom.dart' as service_provider_mojom;
import 'package:mojo_services/mojo/gfx/composition/renderers.mojom.dart' as renderers_mojom;
import 'package:mojo_services/mojo/ui/view_containers.mojom.dart' as view_containers_mojom;
import 'package:mojo_services/mojo/ui/view_tree_token.mojom.dart' as view_tree_token_mojom;



class _ViewTreeGetTokenParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ViewTreeGetTokenParams() : super(kVersions.last.size);

  static _ViewTreeGetTokenParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeGetTokenParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeGetTokenParams result = new _ViewTreeGetTokenParams();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "_ViewTreeGetTokenParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewTreeGetTokenResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  view_tree_token_mojom.ViewTreeToken token = null;

  ViewTreeGetTokenResponseParams() : super(kVersions.last.size);

  static ViewTreeGetTokenResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeGetTokenResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeGetTokenResponseParams result = new ViewTreeGetTokenResponseParams();

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
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.token = view_tree_token_mojom.ViewTreeToken.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(token, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "token of struct ViewTreeGetTokenResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ViewTreeGetTokenResponseParams("
           "token: $token" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["token"] = token;
    return map;
  }
}


class _ViewTreeGetServiceProviderParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  service_provider_mojom.ServiceProviderInterfaceRequest serviceProvider = null;

  _ViewTreeGetServiceProviderParams() : super(kVersions.last.size);

  static _ViewTreeGetServiceProviderParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeGetServiceProviderParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeGetServiceProviderParams result = new _ViewTreeGetServiceProviderParams();

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
      
      result.serviceProvider = decoder0.decodeInterfaceRequest(8, false, service_provider_mojom.ServiceProviderStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(serviceProvider, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "serviceProvider of struct _ViewTreeGetServiceProviderParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewTreeGetServiceProviderParams("
           "serviceProvider: $serviceProvider" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewTreeSetRendererParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  renderers_mojom.RendererInterface renderer = null;

  _ViewTreeSetRendererParams() : super(kVersions.last.size);

  static _ViewTreeSetRendererParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeSetRendererParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeSetRendererParams result = new _ViewTreeSetRendererParams();

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
      
      result.renderer = decoder0.decodeServiceInterface(8, true, renderers_mojom.RendererProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(renderer, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "renderer of struct _ViewTreeSetRendererParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewTreeSetRendererParams("
           "renderer: $renderer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewTreeGetContainerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  view_containers_mojom.ViewContainerInterfaceRequest container = null;

  _ViewTreeGetContainerParams() : super(kVersions.last.size);

  static _ViewTreeGetContainerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeGetContainerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeGetContainerParams result = new _ViewTreeGetContainerParams();

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
      
      result.container = decoder0.decodeInterfaceRequest(8, false, view_containers_mojom.ViewContainerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(container, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "container of struct _ViewTreeGetContainerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewTreeGetContainerParams("
           "container: $container" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewTreeListenerOnRendererDiedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ViewTreeListenerOnRendererDiedParams() : super(kVersions.last.size);

  static _ViewTreeListenerOnRendererDiedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewTreeListenerOnRendererDiedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewTreeListenerOnRendererDiedParams result = new _ViewTreeListenerOnRendererDiedParams();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "_ViewTreeListenerOnRendererDiedParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ViewTreeListenerOnRendererDiedResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewTreeListenerOnRendererDiedResponseParams() : super(kVersions.last.size);

  static ViewTreeListenerOnRendererDiedResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewTreeListenerOnRendererDiedResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewTreeListenerOnRendererDiedResponseParams result = new ViewTreeListenerOnRendererDiedResponseParams();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    encoder.getStructEncoderAtOffset(kVersions.last);
  }

  String toString() {
    return "ViewTreeListenerOnRendererDiedResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _viewTreeMethodGetTokenName = 0;
const int _viewTreeMethodGetServiceProviderName = 1;
const int _viewTreeMethodSetRendererName = 2;
const int _viewTreeMethodGetContainerName = 3;

class _ViewTreeServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewTree {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewTreeServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static ViewTreeProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewTreeProxy p = new ViewTreeProxy.unbound();
    String name = serviceName ?? ViewTree.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic getToken([Function responseFactory = null]);
  void getServiceProvider(service_provider_mojom.ServiceProviderInterfaceRequest serviceProvider);
  void setRenderer(renderers_mojom.RendererInterface renderer);
  void getContainer(view_containers_mojom.ViewContainerInterfaceRequest container);
}

abstract class ViewTreeInterface
    implements bindings.MojoInterface<ViewTree>,
               ViewTree {
  factory ViewTreeInterface([ViewTree impl]) =>
      new ViewTreeStub.unbound(impl);

  factory ViewTreeInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [ViewTree impl]) =>
      new ViewTreeStub.fromEndpoint(endpoint, impl);

  factory ViewTreeInterface.fromMock(
      ViewTree mock) =>
      new ViewTreeProxy.fromMock(mock);
}

abstract class ViewTreeInterfaceRequest
    implements bindings.MojoInterface<ViewTree>,
               ViewTree {
  factory ViewTreeInterfaceRequest() =>
      new ViewTreeProxy.unbound();
}

class _ViewTreeProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<ViewTree> {
  ViewTree impl;

  _ViewTreeProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewTreeProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ViewTreeProxyControl.unbound() : super.unbound();

  String get serviceName => ViewTree.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _viewTreeMethodGetTokenName:
        var r = ViewTreeGetTokenResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_ViewTreeProxyControl($superString)";
  }
}

class ViewTreeProxy
    extends bindings.Proxy<ViewTree>
    implements ViewTree,
               ViewTreeInterface,
               ViewTreeInterfaceRequest {
  ViewTreeProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _ViewTreeProxyControl.fromEndpoint(endpoint));

  ViewTreeProxy.fromHandle(core.MojoHandle handle)
      : super(new _ViewTreeProxyControl.fromHandle(handle));

  ViewTreeProxy.unbound()
      : super(new _ViewTreeProxyControl.unbound());

  factory ViewTreeProxy.fromMock(ViewTree mock) {
    ViewTreeProxy newMockedProxy =
        new ViewTreeProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static ViewTreeProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeProxy"));
    return new ViewTreeProxy.fromEndpoint(endpoint);
  }


  dynamic getToken([Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.getToken(_ViewTreeStubControl._viewTreeGetTokenResponseParamsFactory));
    }
    var params = new _ViewTreeGetTokenParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _viewTreeMethodGetTokenName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void getServiceProvider(service_provider_mojom.ServiceProviderInterfaceRequest serviceProvider) {
    if (impl != null) {
      impl.getServiceProvider(serviceProvider);
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ViewTreeGetServiceProviderParams();
    params.serviceProvider = serviceProvider;
    ctrl.sendMessage(params,
        _viewTreeMethodGetServiceProviderName);
  }
  void setRenderer(renderers_mojom.RendererInterface renderer) {
    if (impl != null) {
      impl.setRenderer(renderer);
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ViewTreeSetRendererParams();
    params.renderer = renderer;
    ctrl.sendMessage(params,
        _viewTreeMethodSetRendererName);
  }
  void getContainer(view_containers_mojom.ViewContainerInterfaceRequest container) {
    if (impl != null) {
      impl.getContainer(container);
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ViewTreeGetContainerParams();
    params.container = container;
    ctrl.sendMessage(params,
        _viewTreeMethodGetContainerName);
  }
}

class _ViewTreeStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<ViewTree> {
  ViewTree _impl;

  _ViewTreeStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ViewTree impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _ViewTreeStubControl.fromHandle(
      core.MojoHandle handle, [ViewTree impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _ViewTreeStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => ViewTree.serviceName;


  static ViewTreeGetTokenResponseParams _viewTreeGetTokenResponseParamsFactory(view_tree_token_mojom.ViewTreeToken token) {
    var result = new ViewTreeGetTokenResponseParams();
    result.token = token;
    return result;
  }

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
      case _viewTreeMethodGetTokenName:
        var response = _impl.getToken(_viewTreeGetTokenResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _viewTreeMethodGetTokenName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _viewTreeMethodGetTokenName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _viewTreeMethodGetServiceProviderName:
        var params = _ViewTreeGetServiceProviderParams.deserialize(
            message.payload);
        _impl.getServiceProvider(params.serviceProvider);
        break;
      case _viewTreeMethodSetRendererName:
        var params = _ViewTreeSetRendererParams.deserialize(
            message.payload);
        _impl.setRenderer(params.renderer);
        break;
      case _viewTreeMethodGetContainerName:
        var params = _ViewTreeGetContainerParams.deserialize(
            message.payload);
        _impl.getContainer(params.container);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ViewTree get impl => _impl;
  set impl(ViewTree d) {
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
    return "_ViewTreeStubControl($superString)";
  }

  int get version => 0;
}

class ViewTreeStub
    extends bindings.Stub<ViewTree>
    implements ViewTree,
               ViewTreeInterface,
               ViewTreeInterfaceRequest {
  ViewTreeStub.unbound([ViewTree impl])
      : super(new _ViewTreeStubControl.unbound(impl));

  ViewTreeStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ViewTree impl])
      : super(new _ViewTreeStubControl.fromEndpoint(endpoint, impl));

  ViewTreeStub.fromHandle(
      core.MojoHandle handle, [ViewTree impl])
      : super(new _ViewTreeStubControl.fromHandle(handle, impl));

  static ViewTreeStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeStub"));
    return new ViewTreeStub.fromEndpoint(endpoint);
  }


  dynamic getToken([Function responseFactory = null]) {
    return impl.getToken(responseFactory);
  }
  void getServiceProvider(service_provider_mojom.ServiceProviderInterfaceRequest serviceProvider) {
    return impl.getServiceProvider(serviceProvider);
  }
  void setRenderer(renderers_mojom.RendererInterface renderer) {
    return impl.setRenderer(renderer);
  }
  void getContainer(view_containers_mojom.ViewContainerInterfaceRequest container) {
    return impl.getContainer(container);
  }
}

const int _viewTreeListenerMethodOnRendererDiedName = 0;

class _ViewTreeListenerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewTreeListener {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewTreeListenerServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static ViewTreeListenerProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewTreeListenerProxy p = new ViewTreeListenerProxy.unbound();
    String name = serviceName ?? ViewTreeListener.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic onRendererDied([Function responseFactory = null]);
}

abstract class ViewTreeListenerInterface
    implements bindings.MojoInterface<ViewTreeListener>,
               ViewTreeListener {
  factory ViewTreeListenerInterface([ViewTreeListener impl]) =>
      new ViewTreeListenerStub.unbound(impl);

  factory ViewTreeListenerInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [ViewTreeListener impl]) =>
      new ViewTreeListenerStub.fromEndpoint(endpoint, impl);

  factory ViewTreeListenerInterface.fromMock(
      ViewTreeListener mock) =>
      new ViewTreeListenerProxy.fromMock(mock);
}

abstract class ViewTreeListenerInterfaceRequest
    implements bindings.MojoInterface<ViewTreeListener>,
               ViewTreeListener {
  factory ViewTreeListenerInterfaceRequest() =>
      new ViewTreeListenerProxy.unbound();
}

class _ViewTreeListenerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<ViewTreeListener> {
  ViewTreeListener impl;

  _ViewTreeListenerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewTreeListenerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ViewTreeListenerProxyControl.unbound() : super.unbound();

  String get serviceName => ViewTreeListener.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _viewTreeListenerMethodOnRendererDiedName:
        var r = ViewTreeListenerOnRendererDiedResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Completer c = completerMap[message.header.requestId];
        if (c == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        completerMap.remove(message.header.requestId);
        if (c.isCompleted) {
          proxyError("Response completer already completed");
          return;
        }
        c.complete(r);
        break;
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_ViewTreeListenerProxyControl($superString)";
  }
}

class ViewTreeListenerProxy
    extends bindings.Proxy<ViewTreeListener>
    implements ViewTreeListener,
               ViewTreeListenerInterface,
               ViewTreeListenerInterfaceRequest {
  ViewTreeListenerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _ViewTreeListenerProxyControl.fromEndpoint(endpoint));

  ViewTreeListenerProxy.fromHandle(core.MojoHandle handle)
      : super(new _ViewTreeListenerProxyControl.fromHandle(handle));

  ViewTreeListenerProxy.unbound()
      : super(new _ViewTreeListenerProxyControl.unbound());

  factory ViewTreeListenerProxy.fromMock(ViewTreeListener mock) {
    ViewTreeListenerProxy newMockedProxy =
        new ViewTreeListenerProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static ViewTreeListenerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeListenerProxy"));
    return new ViewTreeListenerProxy.fromEndpoint(endpoint);
  }


  dynamic onRendererDied([Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.onRendererDied(_ViewTreeListenerStubControl._viewTreeListenerOnRendererDiedResponseParamsFactory));
    }
    var params = new _ViewTreeListenerOnRendererDiedParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _viewTreeListenerMethodOnRendererDiedName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _ViewTreeListenerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<ViewTreeListener> {
  ViewTreeListener _impl;

  _ViewTreeListenerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ViewTreeListener impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _ViewTreeListenerStubControl.fromHandle(
      core.MojoHandle handle, [ViewTreeListener impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _ViewTreeListenerStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => ViewTreeListener.serviceName;


  static ViewTreeListenerOnRendererDiedResponseParams _viewTreeListenerOnRendererDiedResponseParamsFactory() {
    var result = new ViewTreeListenerOnRendererDiedResponseParams();
    return result;
  }

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
      case _viewTreeListenerMethodOnRendererDiedName:
        var response = _impl.onRendererDied(_viewTreeListenerOnRendererDiedResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _viewTreeListenerMethodOnRendererDiedName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _viewTreeListenerMethodOnRendererDiedName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ViewTreeListener get impl => _impl;
  set impl(ViewTreeListener d) {
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
    return "_ViewTreeListenerStubControl($superString)";
  }

  int get version => 0;
}

class ViewTreeListenerStub
    extends bindings.Stub<ViewTreeListener>
    implements ViewTreeListener,
               ViewTreeListenerInterface,
               ViewTreeListenerInterfaceRequest {
  ViewTreeListenerStub.unbound([ViewTreeListener impl])
      : super(new _ViewTreeListenerStubControl.unbound(impl));

  ViewTreeListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ViewTreeListener impl])
      : super(new _ViewTreeListenerStubControl.fromEndpoint(endpoint, impl));

  ViewTreeListenerStub.fromHandle(
      core.MojoHandle handle, [ViewTreeListener impl])
      : super(new _ViewTreeListenerStubControl.fromHandle(handle, impl));

  static ViewTreeListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewTreeListenerStub"));
    return new ViewTreeListenerStub.fromEndpoint(endpoint);
  }


  dynamic onRendererDied([Function responseFactory = null]) {
    return impl.onRendererDied(responseFactory);
  }
}



