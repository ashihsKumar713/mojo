// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library renderers_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/gfx/composition/hit_tests.mojom.dart' as hit_tests_mojom;
import 'package:mojo_services/mojo/gfx/composition/scene_token.mojom.dart' as scene_token_mojom;



class _RendererSetRootSceneParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  scene_token_mojom.SceneToken sceneToken = null;
  int sceneVersion = 0;
  geometry_mojom.Rect viewport = null;

  _RendererSetRootSceneParams() : super(kVersions.last.size);

  static _RendererSetRootSceneParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _RendererSetRootSceneParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _RendererSetRootSceneParams result = new _RendererSetRootSceneParams();

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
    if (mainDataHeader.version >= 0) {
      
      result.sceneVersion = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.viewport = geometry_mojom.Rect.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(sceneToken, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sceneToken of struct _RendererSetRootSceneParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(sceneVersion, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sceneVersion of struct _RendererSetRootSceneParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(viewport, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewport of struct _RendererSetRootSceneParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_RendererSetRootSceneParams("
           "sceneToken: $sceneToken" ", "
           "sceneVersion: $sceneVersion" ", "
           "viewport: $viewport" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sceneToken"] = sceneToken;
    map["sceneVersion"] = sceneVersion;
    map["viewport"] = viewport;
    return map;
  }
}


class _RendererClearRootSceneParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _RendererClearRootSceneParams() : super(kVersions.last.size);

  static _RendererClearRootSceneParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _RendererClearRootSceneParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _RendererClearRootSceneParams result = new _RendererClearRootSceneParams();

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
    return "_RendererClearRootSceneParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _RendererGetHitTesterParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object hitTester = null;

  _RendererGetHitTesterParams() : super(kVersions.last.size);

  static _RendererGetHitTesterParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _RendererGetHitTesterParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _RendererGetHitTesterParams result = new _RendererGetHitTesterParams();

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
      
      result.hitTester = decoder0.decodeInterfaceRequest(8, false, hit_tests_mojom.HitTesterStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(hitTester, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "hitTester of struct _RendererGetHitTesterParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_RendererGetHitTesterParams("
           "hitTester: $hitTester" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _rendererMethodSetRootSceneName = 0;
const int _rendererMethodClearRootSceneName = 1;
const int _rendererMethodGetHitTesterName = 2;

class _RendererServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Renderer {
  static const String serviceName = null;
  void setRootScene(scene_token_mojom.SceneToken sceneToken, int sceneVersion, geometry_mojom.Rect viewport);
  void clearRootScene();
  void getHitTester(Object hitTester);
}


class _RendererProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _RendererProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _RendererProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _RendererProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _RendererServiceDescription();

  String get serviceName => Renderer.serviceName;

  @override
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
    return "_RendererProxyControl($superString)";
  }
}


class RendererProxy extends bindings.Proxy
                              implements Renderer {
  RendererProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _RendererProxyControl.fromEndpoint(endpoint));

  RendererProxy.fromHandle(core.MojoHandle handle)
      : super(new _RendererProxyControl.fromHandle(handle));

  RendererProxy.unbound()
      : super(new _RendererProxyControl.unbound());

  static RendererProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For RendererProxy"));
    return new RendererProxy.fromEndpoint(endpoint);
  }

  factory RendererProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    RendererProxy p = new RendererProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void setRootScene(scene_token_mojom.SceneToken sceneToken, int sceneVersion, geometry_mojom.Rect viewport) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _RendererSetRootSceneParams();
    params.sceneToken = sceneToken;
    params.sceneVersion = sceneVersion;
    params.viewport = viewport;
    ctrl.sendMessage(params,
        _rendererMethodSetRootSceneName);
  }
  void clearRootScene() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _RendererClearRootSceneParams();
    ctrl.sendMessage(params,
        _rendererMethodClearRootSceneName);
  }
  void getHitTester(Object hitTester) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _RendererGetHitTesterParams();
    params.hitTester = hitTester;
    ctrl.sendMessage(params,
        _rendererMethodGetHitTesterName);
  }
}


class RendererStub extends bindings.Stub {
  Renderer _impl;

  RendererStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Renderer impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  RendererStub.fromHandle(
      core.MojoHandle handle, [Renderer impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  RendererStub.unbound([this._impl]) : super.unbound();

  static RendererStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For RendererStub"));
    return new RendererStub.fromEndpoint(endpoint);
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
      case _rendererMethodSetRootSceneName:
        var params = _RendererSetRootSceneParams.deserialize(
            message.payload);
        _impl.setRootScene(params.sceneToken, params.sceneVersion, params.viewport);
        break;
      case _rendererMethodClearRootSceneName:
        _impl.clearRootScene();
        break;
      case _rendererMethodGetHitTesterName:
        var params = _RendererGetHitTesterParams.deserialize(
            message.payload);
        _impl.getHitTester(params.hitTester);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Renderer get impl => _impl;
  set impl(Renderer d) {
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
    return "RendererStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _RendererServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



