// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library scenes_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/gfx/composition/nodes.mojom.dart' as nodes_mojom;
import 'package:mojo_services/mojo/gfx/composition/resources.mojom.dart' as resources_mojom;
import 'package:mojo_services/mojo/gfx/composition/scheduling.mojom.dart' as scheduling_mojom;
const int kSceneRootNodeId = 0;
const int kSceneVersionNone = 0;



class SceneUpdate extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  bool clearResources = false;
  bool clearNodes = false;
  Map<int, resources_mojom.Resource> resources = null;
  Map<int, nodes_mojom.Node> nodes = null;

  SceneUpdate() : super(kVersions.last.size);

  static SceneUpdate deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SceneUpdate decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SceneUpdate result = new SceneUpdate();

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
      
      result.clearResources = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.clearNodes = decoder0.decodeBool(8, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.resources = null;
      } else {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<resources_mojom.Resource> values0;
        {
          
          keys0 = decoder1.decodeUint32Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForUnionArray(keys0.length);
            values0 = new List<resources_mojom.Resource>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
                values0[i2] = resources_mojom.Resource.decode(decoder2, bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i2);
            }
          }
        }
        result.resources = new Map<int, resources_mojom.Resource>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, true);
      if (decoder1 == null) {
        result.nodes = null;
      } else {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<nodes_mojom.Node> values0;
        {
          
          keys0 = decoder1.decodeUint32Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<nodes_mojom.Node>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, true);
              values0[i2] = nodes_mojom.Node.decode(decoder3);
            }
          }
        }
        result.nodes = new Map<int, nodes_mojom.Node>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(clearResources, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "clearResources of struct SceneUpdate: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(clearNodes, 8, 1);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "clearNodes of struct SceneUpdate: $e";
      rethrow;
    }
    try {
      if (resources == null) {
        encoder0.encodeNullPointer(16, true);
      } else {
        var encoder1 = encoder0.encoderForMap(16);
        var keys0 = resources.keys.toList();
        var values0 = resources.values.toList();
        encoder1.encodeUint32Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        
        {
          var encoder2 = encoder1.encodeUnionArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeUnion(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kUnionSize * i1, true);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "resources of struct SceneUpdate: $e";
      rethrow;
    }
    try {
      if (nodes == null) {
        encoder0.encodeNullPointer(24, true);
      } else {
        var encoder1 = encoder0.encoderForMap(24);
        var keys0 = nodes.keys.toList();
        var values0 = nodes.values.toList();
        encoder1.encodeUint32Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "nodes of struct SceneUpdate: $e";
      rethrow;
    }
  }

  String toString() {
    return "SceneUpdate("
           "clearResources: $clearResources" ", "
           "clearNodes: $clearNodes" ", "
           "resources: $resources" ", "
           "nodes: $nodes" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class SceneMetadata extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int version = 0;
  int presentationTime = 0;

  SceneMetadata() : super(kVersions.last.size);

  static SceneMetadata deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SceneMetadata decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SceneMetadata result = new SceneMetadata();

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
      
      result.version = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.presentationTime = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(version, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "version of struct SceneMetadata: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(presentationTime, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "presentationTime of struct SceneMetadata: $e";
      rethrow;
    }
  }

  String toString() {
    return "SceneMetadata("
           "version: $version" ", "
           "presentationTime: $presentationTime" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["version"] = version;
    map["presentationTime"] = presentationTime;
    return map;
  }
}


class _SceneSetListenerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object listener = null;

  _SceneSetListenerParams() : super(kVersions.last.size);

  static _SceneSetListenerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SceneSetListenerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SceneSetListenerParams result = new _SceneSetListenerParams();

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
      
      result.listener = decoder0.decodeServiceInterface(8, true, SceneListenerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(listener, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "listener of struct _SceneSetListenerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SceneSetListenerParams("
           "listener: $listener" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _SceneUpdateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  SceneUpdate update = null;

  _SceneUpdateParams() : super(kVersions.last.size);

  static _SceneUpdateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SceneUpdateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SceneUpdateParams result = new _SceneUpdateParams();

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
      result.update = SceneUpdate.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(update, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "update of struct _SceneUpdateParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SceneUpdateParams("
           "update: $update" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ScenePublishParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  SceneMetadata metadata = null;

  _ScenePublishParams() : super(kVersions.last.size);

  static _ScenePublishParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ScenePublishParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ScenePublishParams result = new _ScenePublishParams();

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
      result.metadata = SceneMetadata.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(metadata, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "metadata of struct _ScenePublishParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ScenePublishParams("
           "metadata: $metadata" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["metadata"] = metadata;
    return map;
  }
}


class _SceneGetSchedulerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object scheduler = null;

  _SceneGetSchedulerParams() : super(kVersions.last.size);

  static _SceneGetSchedulerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SceneGetSchedulerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SceneGetSchedulerParams result = new _SceneGetSchedulerParams();

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
      
      result.scheduler = decoder0.decodeInterfaceRequest(8, false, scheduling_mojom.FrameSchedulerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(scheduler, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "scheduler of struct _SceneGetSchedulerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SceneGetSchedulerParams("
           "scheduler: $scheduler" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _SceneListenerOnResourceUnavailableParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int resourceId = 0;

  _SceneListenerOnResourceUnavailableParams() : super(kVersions.last.size);

  static _SceneListenerOnResourceUnavailableParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SceneListenerOnResourceUnavailableParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SceneListenerOnResourceUnavailableParams result = new _SceneListenerOnResourceUnavailableParams();

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
      
      result.resourceId = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(resourceId, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "resourceId of struct _SceneListenerOnResourceUnavailableParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SceneListenerOnResourceUnavailableParams("
           "resourceId: $resourceId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["resourceId"] = resourceId;
    return map;
  }
}


class SceneListenerOnResourceUnavailableResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  SceneListenerOnResourceUnavailableResponseParams() : super(kVersions.last.size);

  static SceneListenerOnResourceUnavailableResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SceneListenerOnResourceUnavailableResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SceneListenerOnResourceUnavailableResponseParams result = new SceneListenerOnResourceUnavailableResponseParams();

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
    return "SceneListenerOnResourceUnavailableResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _sceneMethodSetListenerName = 0;
const int _sceneMethodUpdateName = 1;
const int _sceneMethodPublishName = 2;
const int _sceneMethodGetSchedulerName = 3;

class _SceneServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Scene {
  static const String serviceName = null;
  void setListener(Object listener);
  void update(SceneUpdate update);
  void publish(SceneMetadata metadata);
  void getScheduler(Object scheduler);
}

class _SceneProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _SceneProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SceneProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _SceneProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _SceneServiceDescription();

  String get serviceName => Scene.serviceName;

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
    return "_SceneProxyControl($superString)";
  }
}

class SceneProxy
    extends bindings.Proxy
    implements Scene {
  SceneProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _SceneProxyControl.fromEndpoint(endpoint));

  SceneProxy.fromHandle(core.MojoHandle handle)
      : super(new _SceneProxyControl.fromHandle(handle));

  SceneProxy.unbound()
      : super(new _SceneProxyControl.unbound());

  static SceneProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SceneProxy"));
    return new SceneProxy.fromEndpoint(endpoint);
  }

  factory SceneProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SceneProxy p = new SceneProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void setListener(Object listener) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _SceneSetListenerParams();
    params.listener = listener;
    ctrl.sendMessage(params,
        _sceneMethodSetListenerName);
  }
  void update(SceneUpdate update) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _SceneUpdateParams();
    params.update = update;
    ctrl.sendMessage(params,
        _sceneMethodUpdateName);
  }
  void publish(SceneMetadata metadata) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ScenePublishParams();
    params.metadata = metadata;
    ctrl.sendMessage(params,
        _sceneMethodPublishName);
  }
  void getScheduler(Object scheduler) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _SceneGetSchedulerParams();
    params.scheduler = scheduler;
    ctrl.sendMessage(params,
        _sceneMethodGetSchedulerName);
  }
}

class _SceneStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<Scene> {
  Scene _impl;

  _SceneStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Scene impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _SceneStubControl.fromHandle(
      core.MojoHandle handle, [Scene impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _SceneStubControl.unbound([this._impl]) : super.unbound();



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
      case _sceneMethodSetListenerName:
        var params = _SceneSetListenerParams.deserialize(
            message.payload);
        _impl.setListener(params.listener);
        break;
      case _sceneMethodUpdateName:
        var params = _SceneUpdateParams.deserialize(
            message.payload);
        _impl.update(params.update);
        break;
      case _sceneMethodPublishName:
        var params = _ScenePublishParams.deserialize(
            message.payload);
        _impl.publish(params.metadata);
        break;
      case _sceneMethodGetSchedulerName:
        var params = _SceneGetSchedulerParams.deserialize(
            message.payload);
        _impl.getScheduler(params.scheduler);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Scene get impl => _impl;
  set impl(Scene d) {
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
    return "_SceneStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SceneServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class SceneStub
    extends bindings.Stub<Scene>
    implements Scene {
  SceneStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Scene impl])
      : super(new _SceneStubControl.fromEndpoint(endpoint, impl));

  SceneStub.fromHandle(
      core.MojoHandle handle, [Scene impl])
      : super(new _SceneStubControl.fromHandle(handle, impl));

  SceneStub.unbound([Scene impl])
      : super(new _SceneStubControl.unbound(impl));

  static SceneStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SceneStub"));
    return new SceneStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _SceneStubControl.serviceDescription;


  void setListener(Object listener) {
    return impl.setListener(listener);
  }
  void update(SceneUpdate update) {
    return impl.update(update);
  }
  void publish(SceneMetadata metadata) {
    return impl.publish(metadata);
  }
  void getScheduler(Object scheduler) {
    return impl.getScheduler(scheduler);
  }
}

const int _sceneListenerMethodOnResourceUnavailableName = 0;

class _SceneListenerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class SceneListener {
  static const String serviceName = null;
  dynamic onResourceUnavailable(int resourceId,[Function responseFactory = null]);
}

class _SceneListenerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _SceneListenerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SceneListenerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _SceneListenerProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _SceneListenerServiceDescription();

  String get serviceName => SceneListener.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _sceneListenerMethodOnResourceUnavailableName:
        var r = SceneListenerOnResourceUnavailableResponseParams.deserialize(
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
    return "_SceneListenerProxyControl($superString)";
  }
}

class SceneListenerProxy
    extends bindings.Proxy
    implements SceneListener {
  SceneListenerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _SceneListenerProxyControl.fromEndpoint(endpoint));

  SceneListenerProxy.fromHandle(core.MojoHandle handle)
      : super(new _SceneListenerProxyControl.fromHandle(handle));

  SceneListenerProxy.unbound()
      : super(new _SceneListenerProxyControl.unbound());

  static SceneListenerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SceneListenerProxy"));
    return new SceneListenerProxy.fromEndpoint(endpoint);
  }

  factory SceneListenerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SceneListenerProxy p = new SceneListenerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic onResourceUnavailable(int resourceId,[Function responseFactory = null]) {
    var params = new _SceneListenerOnResourceUnavailableParams();
    params.resourceId = resourceId;
    return ctrl.sendMessageWithRequestId(
        params,
        _sceneListenerMethodOnResourceUnavailableName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _SceneListenerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<SceneListener> {
  SceneListener _impl;

  _SceneListenerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [SceneListener impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _SceneListenerStubControl.fromHandle(
      core.MojoHandle handle, [SceneListener impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _SceneListenerStubControl.unbound([this._impl]) : super.unbound();


  SceneListenerOnResourceUnavailableResponseParams _sceneListenerOnResourceUnavailableResponseParamsFactory() {
    var result = new SceneListenerOnResourceUnavailableResponseParams();
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
      case _sceneListenerMethodOnResourceUnavailableName:
        var params = _SceneListenerOnResourceUnavailableParams.deserialize(
            message.payload);
        var response = _impl.onResourceUnavailable(params.resourceId,_sceneListenerOnResourceUnavailableResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _sceneListenerMethodOnResourceUnavailableName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _sceneListenerMethodOnResourceUnavailableName,
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

  SceneListener get impl => _impl;
  set impl(SceneListener d) {
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
    return "_SceneListenerStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SceneListenerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class SceneListenerStub
    extends bindings.Stub<SceneListener>
    implements SceneListener {
  SceneListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [SceneListener impl])
      : super(new _SceneListenerStubControl.fromEndpoint(endpoint, impl));

  SceneListenerStub.fromHandle(
      core.MojoHandle handle, [SceneListener impl])
      : super(new _SceneListenerStubControl.fromHandle(handle, impl));

  SceneListenerStub.unbound([SceneListener impl])
      : super(new _SceneListenerStubControl.unbound(impl));

  static SceneListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SceneListenerStub"));
    return new SceneListenerStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _SceneListenerStubControl.serviceDescription;


  dynamic onResourceUnavailable(int resourceId,[Function responseFactory = null]) {
    return impl.onResourceUnavailable(resourceId,responseFactory);
  }
}



