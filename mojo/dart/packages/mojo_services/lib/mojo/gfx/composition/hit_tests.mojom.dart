// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library hit_tests_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/gfx/composition/scene_token.mojom.dart' as scene_token_mojom;



class HitTestBehaviorVisibility extends bindings.MojoEnum {
  static const HitTestBehaviorVisibility opaque = const HitTestBehaviorVisibility._(0);
  static const HitTestBehaviorVisibility translucent = const HitTestBehaviorVisibility._(1);
  static const HitTestBehaviorVisibility invisible = const HitTestBehaviorVisibility._(2);

  const HitTestBehaviorVisibility._(int v) : super(v);

  static const Map<String, HitTestBehaviorVisibility> valuesMap = const {
    "opaque": opaque,
    "translucent": translucent,
    "invisible": invisible,
  };
  static const List<HitTestBehaviorVisibility> values = const [
    opaque,
    translucent,
    invisible,
  ];

  static HitTestBehaviorVisibility valueOf(String name) => valuesMap[name];

  factory HitTestBehaviorVisibility(int v) {
    switch (v) {
      case 0:
        return HitTestBehaviorVisibility.opaque;
      case 1:
        return HitTestBehaviorVisibility.translucent;
      case 2:
        return HitTestBehaviorVisibility.invisible;
      default:
        return null;
    }
  }

  static HitTestBehaviorVisibility decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    HitTestBehaviorVisibility result = new HitTestBehaviorVisibility(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum HitTestBehaviorVisibility.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case opaque:
        return 'HitTestBehaviorVisibility.opaque';
      case translucent:
        return 'HitTestBehaviorVisibility.translucent';
      case invisible:
        return 'HitTestBehaviorVisibility.invisible';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class HitTestBehavior extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  HitTestBehaviorVisibility visibility = new HitTestBehaviorVisibility(0);
  bool prune = false;
  geometry_mojom.RectF hitRect = null;

  HitTestBehavior() : super(kVersions.last.size);

  static HitTestBehavior deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HitTestBehavior decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HitTestBehavior result = new HitTestBehavior();

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
      
        result.visibility = HitTestBehaviorVisibility.decode(decoder0, 8);
        if (result.visibility == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable HitTestBehaviorVisibility.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.prune = decoder0.decodeBool(12, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.hitRect = geometry_mojom.RectF.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(visibility, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "visibility of struct HitTestBehavior: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(prune, 12, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "prune of struct HitTestBehavior: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(hitRect, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "hitRect of struct HitTestBehavior: $e";
      rethrow;
    }
  }

  String toString() {
    return "HitTestBehavior("
           "visibility: $visibility" ", "
           "prune: $prune" ", "
           "hitRect: $hitRect" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["visibility"] = visibility;
    map["prune"] = prune;
    map["hitRect"] = hitRect;
    return map;
  }
}


class HitTestResult extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  SceneHit root = null;

  HitTestResult() : super(kVersions.last.size);

  static HitTestResult deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HitTestResult decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HitTestResult result = new HitTestResult();

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
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.root = SceneHit.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(root, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "root of struct HitTestResult: $e";
      rethrow;
    }
  }

  String toString() {
    return "HitTestResult("
           "root: $root" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["root"] = root;
    return map;
  }
}


class SceneHit extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  scene_token_mojom.SceneToken sceneToken = null;
  int sceneVersion = 0;
  List<Hit> hits = null;

  SceneHit() : super(kVersions.last.size);

  static SceneHit deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SceneHit decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SceneHit result = new SceneHit();

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
      {
        var si1 = decoder1.decodeDataHeaderForUnionArray(bindings.kUnspecifiedArrayLength);
        result.hits = new List<Hit>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
            result.hits[i1] = Hit.decode(decoder1, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1);
            if (result.hits[i1] == null) {
              throw new bindings.MojoCodecError(
                'Trying to decode null union for non-nullable Hit.');
            }
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(sceneToken, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sceneToken of struct SceneHit: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(sceneVersion, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sceneVersion of struct SceneHit: $e";
      rethrow;
    }
    try {
      if (hits == null) {
        encoder0.encodeNullPointer(24, false);
      } else {
        var encoder1 = encoder0.encodeUnionArray(hits.length, 24, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < hits.length; ++i0) {
          encoder1.encodeUnion(hits[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "hits of struct SceneHit: $e";
      rethrow;
    }
  }

  String toString() {
    return "SceneHit("
           "sceneToken: $sceneToken" ", "
           "sceneVersion: $sceneVersion" ", "
           "hits: $hits" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sceneToken"] = sceneToken;
    map["sceneVersion"] = sceneVersion;
    map["hits"] = hits;
    return map;
  }
}


class NodeHit extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int nodeId = 0;
  geometry_mojom.Transform transform = null;

  NodeHit() : super(kVersions.last.size);

  static NodeHit deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NodeHit decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NodeHit result = new NodeHit();

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
      
      result.nodeId = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.transform = geometry_mojom.Transform.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(nodeId, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "nodeId of struct NodeHit: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(transform, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "transform of struct NodeHit: $e";
      rethrow;
    }
  }

  String toString() {
    return "NodeHit("
           "nodeId: $nodeId" ", "
           "transform: $transform" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["nodeId"] = nodeId;
    map["transform"] = transform;
    return map;
  }
}


class _HitTesterHitTestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  geometry_mojom.PointF point = null;

  _HitTesterHitTestParams() : super(kVersions.last.size);

  static _HitTesterHitTestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HitTesterHitTestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HitTesterHitTestParams result = new _HitTesterHitTestParams();

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
      result.point = geometry_mojom.PointF.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(point, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "point of struct _HitTesterHitTestParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HitTesterHitTestParams("
           "point: $point" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["point"] = point;
    return map;
  }
}


class HitTesterHitTestResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  HitTestResult result = null;

  HitTesterHitTestResponseParams() : super(kVersions.last.size);

  static HitTesterHitTestResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HitTesterHitTestResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HitTesterHitTestResponseParams result = new HitTesterHitTestResponseParams();

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
      result.result = HitTestResult.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct HitTesterHitTestResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HitTesterHitTestResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}



enum HitTag {
  scene,
  node,
  unknown
}

class Hit extends bindings.Union {
  static final _tagToInt = const {
    HitTag.scene: 0,
    HitTag.node: 1,
  };

  static final _intToTag = const {
    0: HitTag.scene,
    1: HitTag.node,
  };

  var _data;
  HitTag _tag = HitTag.unknown;

  HitTag get tag => _tag;
  SceneHit get scene {
    if (_tag != HitTag.scene) {
      throw new bindings.UnsetUnionTagError(_tag, HitTag.scene);
    }
    return _data;
  }

  set scene(SceneHit value) {
    _tag = HitTag.scene;
    _data = value;
  }
  NodeHit get node {
    if (_tag != HitTag.node) {
      throw new bindings.UnsetUnionTagError(_tag, HitTag.node);
    }
    return _data;
  }

  set node(NodeHit value) {
    _tag = HitTag.node;
    _data = value;
  }

  static Hit decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    Hit result = new Hit();

    
    HitTag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case HitTag.scene:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.scene = SceneHit.decode(decoder1);
        break;
      case HitTag.node:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.node = NodeHit.decode(decoder1);
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
      case HitTag.scene:
        encoder0.encodeStruct(scene, offset + 8, false);
        break;
      case HitTag.node:
        encoder0.encodeStruct(node, offset + 8, false);
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "Hit(";
    switch (_tag) {
      case HitTag.scene:
        result += "scene";
        break;
      case HitTag.node:
        result += "node";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}
const int _hitTesterMethodHitTestName = 0;

class _HitTesterServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class HitTester {
  static const String serviceName = null;
  dynamic hitTest(geometry_mojom.PointF point,[Function responseFactory = null]);
}

class _HitTesterProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _HitTesterProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HitTesterProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _HitTesterProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _HitTesterServiceDescription();

  String get serviceName => HitTester.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _hitTesterMethodHitTestName:
        var r = HitTesterHitTestResponseParams.deserialize(
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
    return "_HitTesterProxyControl($superString)";
  }
}

class HitTesterProxy
    extends bindings.Proxy
    implements HitTester {
  HitTesterProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _HitTesterProxyControl.fromEndpoint(endpoint));

  HitTesterProxy.fromHandle(core.MojoHandle handle)
      : super(new _HitTesterProxyControl.fromHandle(handle));

  HitTesterProxy.unbound()
      : super(new _HitTesterProxyControl.unbound());

  static HitTesterProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HitTesterProxy"));
    return new HitTesterProxy.fromEndpoint(endpoint);
  }

  factory HitTesterProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HitTesterProxy p = new HitTesterProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic hitTest(geometry_mojom.PointF point,[Function responseFactory = null]) {
    var params = new _HitTesterHitTestParams();
    params.point = point;
    return ctrl.sendMessageWithRequestId(
        params,
        _hitTesterMethodHitTestName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _HitTesterStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<HitTester> {
  HitTester _impl;

  _HitTesterStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HitTester impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _HitTesterStubControl.fromHandle(
      core.MojoHandle handle, [HitTester impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _HitTesterStubControl.unbound([this._impl]) : super.unbound();


  HitTesterHitTestResponseParams _hitTesterHitTestResponseParamsFactory(HitTestResult result) {
    var result = new HitTesterHitTestResponseParams();
    result.result = result;
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
      case _hitTesterMethodHitTestName:
        var params = _HitTesterHitTestParams.deserialize(
            message.payload);
        var response = _impl.hitTest(params.point,_hitTesterHitTestResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _hitTesterMethodHitTestName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _hitTesterMethodHitTestName,
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

  HitTester get impl => _impl;
  set impl(HitTester d) {
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
    return "_HitTesterStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _HitTesterServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class HitTesterStub
    extends bindings.Stub<HitTester>
    implements HitTester {
  HitTesterStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HitTester impl])
      : super(new _HitTesterStubControl.fromEndpoint(endpoint, impl));

  HitTesterStub.fromHandle(
      core.MojoHandle handle, [HitTester impl])
      : super(new _HitTesterStubControl.fromHandle(handle, impl));

  HitTesterStub.unbound([HitTester impl])
      : super(new _HitTesterStubControl.unbound(impl));

  static HitTesterStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HitTesterStub"));
    return new HitTesterStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _HitTesterStubControl.serviceDescription;


  dynamic hitTest(geometry_mojom.PointF point,[Function responseFactory = null]) {
    return impl.hitTest(point,responseFactory);
  }
}



