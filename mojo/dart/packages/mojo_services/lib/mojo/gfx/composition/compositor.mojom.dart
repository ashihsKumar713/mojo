// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library compositor_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/gfx/composition/renderers.mojom.dart' as renderers_mojom;
import 'package:mojo_services/mojo/gfx/composition/scene_token.mojom.dart' as scene_token_mojom;
import 'package:mojo_services/mojo/gfx/composition/scenes.mojom.dart' as scenes_mojom;
import 'package:mojom/mojo/context_provider.mojom.dart' as context_provider_mojom;
const int kLabelMaxLength = 32;



class _CompositorCreateSceneParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object scene = null;
  String label = null;

  _CompositorCreateSceneParams() : super(kVersions.last.size);

  static _CompositorCreateSceneParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CompositorCreateSceneParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CompositorCreateSceneParams result = new _CompositorCreateSceneParams();

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
      
      result.scene = decoder0.decodeInterfaceRequest(8, false, scenes_mojom.SceneStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.label = decoder0.decodeString(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(scene, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "scene of struct _CompositorCreateSceneParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(label, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "label of struct _CompositorCreateSceneParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_CompositorCreateSceneParams("
           "scene: $scene" ", "
           "label: $label" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class CompositorCreateSceneResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  scene_token_mojom.SceneToken sceneToken = null;

  CompositorCreateSceneResponseParams() : super(kVersions.last.size);

  static CompositorCreateSceneResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CompositorCreateSceneResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CompositorCreateSceneResponseParams result = new CompositorCreateSceneResponseParams();

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
      result.sceneToken = scene_token_mojom.SceneToken.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(sceneToken, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sceneToken of struct CompositorCreateSceneResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "CompositorCreateSceneResponseParams("
           "sceneToken: $sceneToken" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sceneToken"] = sceneToken;
    return map;
  }
}


class _CompositorCreateRendererParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  Object contextProvider = null;
  Object renderer = null;
  String label = null;

  _CompositorCreateRendererParams() : super(kVersions.last.size);

  static _CompositorCreateRendererParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CompositorCreateRendererParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CompositorCreateRendererParams result = new _CompositorCreateRendererParams();

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
      
      result.contextProvider = decoder0.decodeServiceInterface(8, false, context_provider_mojom.ContextProviderProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.renderer = decoder0.decodeInterfaceRequest(16, false, renderers_mojom.RendererStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.label = decoder0.decodeString(24, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(contextProvider, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "contextProvider of struct _CompositorCreateRendererParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(renderer, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "renderer of struct _CompositorCreateRendererParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(label, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "label of struct _CompositorCreateRendererParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_CompositorCreateRendererParams("
           "contextProvider: $contextProvider" ", "
           "renderer: $renderer" ", "
           "label: $label" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _compositorMethodCreateSceneName = 0;
const int _compositorMethodCreateRendererName = 1;

class _CompositorServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Compositor {
  static const String serviceName = "mojo::gfx::composition::Compositor";
  dynamic createScene(Object scene,String label,[Function responseFactory = null]);
  void createRenderer(Object contextProvider, Object renderer, String label);
}


class _CompositorProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _CompositorProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CompositorProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _CompositorProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _CompositorServiceDescription();

  String get serviceName => Compositor.serviceName;

  @override
  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _compositorMethodCreateSceneName:
        var r = CompositorCreateSceneResponseParams.deserialize(
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
    return "_CompositorProxyControl($superString)";
  }
}


class CompositorProxy extends bindings.Proxy
                              implements Compositor {
  CompositorProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _CompositorProxyControl.fromEndpoint(endpoint));

  CompositorProxy.fromHandle(core.MojoHandle handle)
      : super(new _CompositorProxyControl.fromHandle(handle));

  CompositorProxy.unbound()
      : super(new _CompositorProxyControl.unbound());

  static CompositorProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CompositorProxy"));
    return new CompositorProxy.fromEndpoint(endpoint);
  }

  factory CompositorProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CompositorProxy p = new CompositorProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic createScene(Object scene,String label,[Function responseFactory = null]) {
    var params = new _CompositorCreateSceneParams();
    params.scene = scene;
    params.label = label;
    return ctrl.sendMessageWithRequestId(
        params,
        _compositorMethodCreateSceneName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void createRenderer(Object contextProvider, Object renderer, String label) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _CompositorCreateRendererParams();
    params.contextProvider = contextProvider;
    params.renderer = renderer;
    params.label = label;
    ctrl.sendMessage(params,
        _compositorMethodCreateRendererName);
  }
}


class CompositorStub extends bindings.Stub {
  Compositor _impl;

  CompositorStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Compositor impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  CompositorStub.fromHandle(
      core.MojoHandle handle, [Compositor impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  CompositorStub.unbound([this._impl]) : super.unbound();

  static CompositorStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CompositorStub"));
    return new CompositorStub.fromEndpoint(endpoint);
  }


  CompositorCreateSceneResponseParams _compositorCreateSceneResponseParamsFactory(scene_token_mojom.SceneToken sceneToken) {
    var result = new CompositorCreateSceneResponseParams();
    result.sceneToken = sceneToken;
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
      case _compositorMethodCreateSceneName:
        var params = _CompositorCreateSceneParams.deserialize(
            message.payload);
        var response = _impl.createScene(params.scene,params.label,_compositorCreateSceneResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _compositorMethodCreateSceneName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _compositorMethodCreateSceneName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _compositorMethodCreateRendererName:
        var params = _CompositorCreateRendererParams.deserialize(
            message.payload);
        _impl.createRenderer(params.contextProvider, params.renderer, params.label);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Compositor get impl => _impl;
  set impl(Compositor d) {
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

  String toString() {
    var superString = super.toString();
    return "CompositorStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _CompositorServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



