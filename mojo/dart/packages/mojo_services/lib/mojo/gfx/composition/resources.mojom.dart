// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library resources_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/gfx/composition/scene_token.mojom.dart' as scene_token_mojom;



class SceneResource extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  scene_token_mojom.SceneToken sceneToken = null;

  SceneResource() : super(kVersions.last.size);

  static SceneResource deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SceneResource decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SceneResource result = new SceneResource();

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
          "sceneToken of struct SceneResource: $e";
      rethrow;
    }
  }

  String toString() {
    return "SceneResource("
           "sceneToken: $sceneToken" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sceneToken"] = sceneToken;
    return map;
  }
}


class MailboxTextureResourceOrigin extends bindings.MojoEnum {
  static const MailboxTextureResourceOrigin topLeft = const MailboxTextureResourceOrigin._(0);
  static const MailboxTextureResourceOrigin bottomLeft = const MailboxTextureResourceOrigin._(1);

  const MailboxTextureResourceOrigin._(int v) : super(v);

  static const Map<String, MailboxTextureResourceOrigin> valuesMap = const {
    "topLeft": topLeft,
    "bottomLeft": bottomLeft,
  };
  static const List<MailboxTextureResourceOrigin> values = const [
    topLeft,
    bottomLeft,
  ];

  static MailboxTextureResourceOrigin valueOf(String name) => valuesMap[name];

  factory MailboxTextureResourceOrigin(int v) {
    switch (v) {
      case 0:
        return MailboxTextureResourceOrigin.topLeft;
      case 1:
        return MailboxTextureResourceOrigin.bottomLeft;
      default:
        return null;
    }
  }

  static MailboxTextureResourceOrigin decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    MailboxTextureResourceOrigin result = new MailboxTextureResourceOrigin(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum MailboxTextureResourceOrigin.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case topLeft:
        return 'MailboxTextureResourceOrigin.topLeft';
      case bottomLeft:
        return 'MailboxTextureResourceOrigin.bottomLeft';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class MailboxTextureResource extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  List<int> mailboxName = null;
  int syncPoint = 0;
  MailboxTextureResourceOrigin origin = new MailboxTextureResourceOrigin(0);
  geometry_mojom.Size size = null;
  Object callback = null;

  MailboxTextureResource() : super(kVersions.last.size);

  static MailboxTextureResource deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MailboxTextureResource decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MailboxTextureResource result = new MailboxTextureResource();

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
      
      result.mailboxName = decoder0.decodeUint8Array(8, bindings.kNothingNullable, 64);
    }
    if (mainDataHeader.version >= 0) {
      
      result.syncPoint = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
        result.origin = MailboxTextureResourceOrigin.decode(decoder0, 20);
        if (result.origin == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable MailboxTextureResourceOrigin.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.size = geometry_mojom.Size.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.callback = decoder0.decodeServiceInterface(32, false, MailboxTextureCallbackProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8Array(mailboxName, 8, bindings.kNothingNullable, 64);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mailboxName of struct MailboxTextureResource: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(syncPoint, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "syncPoint of struct MailboxTextureResource: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(origin, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "origin of struct MailboxTextureResource: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(size, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "size of struct MailboxTextureResource: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(callback, 32, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "callback of struct MailboxTextureResource: $e";
      rethrow;
    }
  }

  String toString() {
    return "MailboxTextureResource("
           "mailboxName: $mailboxName" ", "
           "syncPoint: $syncPoint" ", "
           "origin: $origin" ", "
           "size: $size" ", "
           "callback: $callback" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MailboxTextureCallbackOnMailboxTextureReleasedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MailboxTextureCallbackOnMailboxTextureReleasedParams() : super(kVersions.last.size);

  static _MailboxTextureCallbackOnMailboxTextureReleasedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MailboxTextureCallbackOnMailboxTextureReleasedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MailboxTextureCallbackOnMailboxTextureReleasedParams result = new _MailboxTextureCallbackOnMailboxTextureReleasedParams();

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
    return "_MailboxTextureCallbackOnMailboxTextureReleasedParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}



enum ResourceTag {
  scene,
  mailboxTexture,
  unknown
}

class Resource extends bindings.Union {
  static final _tagToInt = const {
    ResourceTag.scene: 0,
    ResourceTag.mailboxTexture: 1,
  };

  static final _intToTag = const {
    0: ResourceTag.scene,
    1: ResourceTag.mailboxTexture,
  };

  var _data;
  ResourceTag _tag = ResourceTag.unknown;

  ResourceTag get tag => _tag;
  SceneResource get scene {
    if (_tag != ResourceTag.scene) {
      throw new bindings.UnsetUnionTagError(_tag, ResourceTag.scene);
    }
    return _data;
  }

  set scene(SceneResource value) {
    _tag = ResourceTag.scene;
    _data = value;
  }
  MailboxTextureResource get mailboxTexture {
    if (_tag != ResourceTag.mailboxTexture) {
      throw new bindings.UnsetUnionTagError(_tag, ResourceTag.mailboxTexture);
    }
    return _data;
  }

  set mailboxTexture(MailboxTextureResource value) {
    _tag = ResourceTag.mailboxTexture;
    _data = value;
  }

  static Resource decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    Resource result = new Resource();

    
    ResourceTag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case ResourceTag.scene:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.scene = SceneResource.decode(decoder1);
        break;
      case ResourceTag.mailboxTexture:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.mailboxTexture = MailboxTextureResource.decode(decoder1);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $tag");
    }

    return result;
  }

  void encode(bindings.Encoder encoder0, int offset) {
    
    encoder0.encodeUint32(16, offset);
    encoder0.encodeUint32(_tagToInt[_tag], offset + 4);
    switch (_tag) {
      case ResourceTag.scene:
        encoder0.encodeStruct(scene, offset + 8, false);
        break;
      case ResourceTag.mailboxTexture:
        encoder0.encodeStruct(mailboxTexture, offset + 8, false);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "Resource(";
    switch (_tag) {
      case ResourceTag.scene:
        result += "scene";
        break;
      case ResourceTag.mailboxTexture:
        result += "mailboxTexture";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}
const int _mailboxTextureCallbackMethodOnMailboxTextureReleasedName = 0;

class _MailboxTextureCallbackServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class MailboxTextureCallback {
  static const String serviceName = null;
  void onMailboxTextureReleased();
}

class _MailboxTextureCallbackProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _MailboxTextureCallbackProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MailboxTextureCallbackProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _MailboxTextureCallbackProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _MailboxTextureCallbackServiceDescription();

  String get serviceName => MailboxTextureCallback.serviceName;

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
    return "_MailboxTextureCallbackProxyControl($superString)";
  }
}

class MailboxTextureCallbackProxy
    extends bindings.Proxy
    implements MailboxTextureCallback {
  MailboxTextureCallbackProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _MailboxTextureCallbackProxyControl.fromEndpoint(endpoint));

  MailboxTextureCallbackProxy.fromHandle(core.MojoHandle handle)
      : super(new _MailboxTextureCallbackProxyControl.fromHandle(handle));

  MailboxTextureCallbackProxy.unbound()
      : super(new _MailboxTextureCallbackProxyControl.unbound());

  static MailboxTextureCallbackProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MailboxTextureCallbackProxy"));
    return new MailboxTextureCallbackProxy.fromEndpoint(endpoint);
  }

  factory MailboxTextureCallbackProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MailboxTextureCallbackProxy p = new MailboxTextureCallbackProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void onMailboxTextureReleased() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MailboxTextureCallbackOnMailboxTextureReleasedParams();
    ctrl.sendMessage(params,
        _mailboxTextureCallbackMethodOnMailboxTextureReleasedName);
  }
}

class _MailboxTextureCallbackStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<MailboxTextureCallback> {
  MailboxTextureCallback _impl;

  _MailboxTextureCallbackStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MailboxTextureCallback impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _MailboxTextureCallbackStubControl.fromHandle(
      core.MojoHandle handle, [MailboxTextureCallback impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _MailboxTextureCallbackStubControl.unbound([this._impl]) : super.unbound();



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
      case _mailboxTextureCallbackMethodOnMailboxTextureReleasedName:
        _impl.onMailboxTextureReleased();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  MailboxTextureCallback get impl => _impl;
  set impl(MailboxTextureCallback d) {
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
    return "_MailboxTextureCallbackStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _MailboxTextureCallbackServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class MailboxTextureCallbackStub
    extends bindings.Stub<MailboxTextureCallback>
    implements MailboxTextureCallback {
  MailboxTextureCallbackStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MailboxTextureCallback impl])
      : super(new _MailboxTextureCallbackStubControl.fromEndpoint(endpoint, impl));

  MailboxTextureCallbackStub.fromHandle(
      core.MojoHandle handle, [MailboxTextureCallback impl])
      : super(new _MailboxTextureCallbackStubControl.fromHandle(handle, impl));

  MailboxTextureCallbackStub.unbound([MailboxTextureCallback impl])
      : super(new _MailboxTextureCallbackStubControl.unbound(impl));

  static MailboxTextureCallbackStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MailboxTextureCallbackStub"));
    return new MailboxTextureCallbackStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _MailboxTextureCallbackStubControl.serviceDescription;


  void onMailboxTextureReleased() {
    return impl.onMailboxTextureReleased();
  }
}



