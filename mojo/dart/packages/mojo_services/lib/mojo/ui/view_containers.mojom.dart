// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library view_containers_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/gfx/composition/scene_token.mojom.dart' as scene_token_mojom;
import 'package:mojo_services/mojo/ui/view_properties.mojom.dart' as view_properties_mojom;
import 'package:mojo_services/mojo/ui/view_token.mojom.dart' as view_token_mojom;



class ViewInfo extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  scene_token_mojom.SceneToken sceneToken = null;

  ViewInfo() : super(kVersions.last.size);

  static ViewInfo deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewInfo decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewInfo result = new ViewInfo();

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
          "sceneToken of struct ViewInfo: $e";
      rethrow;
    }
  }

  String toString() {
    return "ViewInfo("
           "sceneToken: $sceneToken" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sceneToken"] = sceneToken;
    return map;
  }
}


class _ViewContainerSetListenerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object listener = null;

  _ViewContainerSetListenerParams() : super(kVersions.last.size);

  static _ViewContainerSetListenerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewContainerSetListenerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewContainerSetListenerParams result = new _ViewContainerSetListenerParams();

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
      
      result.listener = decoder0.decodeServiceInterface(8, true, ViewContainerListenerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(listener, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "listener of struct _ViewContainerSetListenerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewContainerSetListenerParams("
           "listener: $listener" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewContainerAddChildParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int childKey = 0;
  Object childViewOwner = null;

  _ViewContainerAddChildParams() : super(kVersions.last.size);

  static _ViewContainerAddChildParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewContainerAddChildParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewContainerAddChildParams result = new _ViewContainerAddChildParams();

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
      
      result.childKey = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.childViewOwner = decoder0.decodeServiceInterface(12, false, view_token_mojom.ViewOwnerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(childKey, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childKey of struct _ViewContainerAddChildParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(childViewOwner, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childViewOwner of struct _ViewContainerAddChildParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewContainerAddChildParams("
           "childKey: $childKey" ", "
           "childViewOwner: $childViewOwner" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewContainerRemoveChildParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int childKey = 0;
  Object transferredViewOwner = null;

  _ViewContainerRemoveChildParams() : super(kVersions.last.size);

  static _ViewContainerRemoveChildParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewContainerRemoveChildParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewContainerRemoveChildParams result = new _ViewContainerRemoveChildParams();

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
      
      result.childKey = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.transferredViewOwner = decoder0.decodeInterfaceRequest(12, true, view_token_mojom.ViewOwnerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(childKey, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childKey of struct _ViewContainerRemoveChildParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(transferredViewOwner, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "transferredViewOwner of struct _ViewContainerRemoveChildParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewContainerRemoveChildParams("
           "childKey: $childKey" ", "
           "transferredViewOwner: $transferredViewOwner" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewContainerSetChildPropertiesParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int childKey = 0;
  int childSceneVersion = 0;
  view_properties_mojom.ViewProperties childViewProperties = null;

  _ViewContainerSetChildPropertiesParams() : super(kVersions.last.size);

  static _ViewContainerSetChildPropertiesParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewContainerSetChildPropertiesParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewContainerSetChildPropertiesParams result = new _ViewContainerSetChildPropertiesParams();

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
      
      result.childKey = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.childSceneVersion = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.childViewProperties = view_properties_mojom.ViewProperties.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(childKey, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childKey of struct _ViewContainerSetChildPropertiesParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(childSceneVersion, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childSceneVersion of struct _ViewContainerSetChildPropertiesParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(childViewProperties, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childViewProperties of struct _ViewContainerSetChildPropertiesParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewContainerSetChildPropertiesParams("
           "childKey: $childKey" ", "
           "childSceneVersion: $childSceneVersion" ", "
           "childViewProperties: $childViewProperties" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["childKey"] = childKey;
    map["childSceneVersion"] = childSceneVersion;
    map["childViewProperties"] = childViewProperties;
    return map;
  }
}


class _ViewContainerListenerOnChildAttachedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int childKey = 0;
  ViewInfo childViewInfo = null;

  _ViewContainerListenerOnChildAttachedParams() : super(kVersions.last.size);

  static _ViewContainerListenerOnChildAttachedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewContainerListenerOnChildAttachedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewContainerListenerOnChildAttachedParams result = new _ViewContainerListenerOnChildAttachedParams();

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
      
      result.childKey = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.childViewInfo = ViewInfo.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(childKey, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childKey of struct _ViewContainerListenerOnChildAttachedParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(childViewInfo, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childViewInfo of struct _ViewContainerListenerOnChildAttachedParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewContainerListenerOnChildAttachedParams("
           "childKey: $childKey" ", "
           "childViewInfo: $childViewInfo" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["childKey"] = childKey;
    map["childViewInfo"] = childViewInfo;
    return map;
  }
}


class ViewContainerListenerOnChildAttachedResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewContainerListenerOnChildAttachedResponseParams() : super(kVersions.last.size);

  static ViewContainerListenerOnChildAttachedResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewContainerListenerOnChildAttachedResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewContainerListenerOnChildAttachedResponseParams result = new ViewContainerListenerOnChildAttachedResponseParams();

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
    return "ViewContainerListenerOnChildAttachedResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _ViewContainerListenerOnChildUnavailableParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int childKey = 0;

  _ViewContainerListenerOnChildUnavailableParams() : super(kVersions.last.size);

  static _ViewContainerListenerOnChildUnavailableParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewContainerListenerOnChildUnavailableParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewContainerListenerOnChildUnavailableParams result = new _ViewContainerListenerOnChildUnavailableParams();

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
      
      result.childKey = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(childKey, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "childKey of struct _ViewContainerListenerOnChildUnavailableParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewContainerListenerOnChildUnavailableParams("
           "childKey: $childKey" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["childKey"] = childKey;
    return map;
  }
}


class ViewContainerListenerOnChildUnavailableResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  ViewContainerListenerOnChildUnavailableResponseParams() : super(kVersions.last.size);

  static ViewContainerListenerOnChildUnavailableResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ViewContainerListenerOnChildUnavailableResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ViewContainerListenerOnChildUnavailableResponseParams result = new ViewContainerListenerOnChildUnavailableResponseParams();

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
    return "ViewContainerListenerOnChildUnavailableResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _viewContainerMethodSetListenerName = 0;
const int _viewContainerMethodAddChildName = 1;
const int _viewContainerMethodRemoveChildName = 2;
const int _viewContainerMethodSetChildPropertiesName = 3;

class _ViewContainerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewContainer {
  static const String serviceName = null;
  void setListener(Object listener);
  void addChild(int childKey, Object childViewOwner);
  void removeChild(int childKey, Object transferredViewOwner);
  void setChildProperties(int childKey, int childSceneVersion, view_properties_mojom.ViewProperties childViewProperties);
}


class _ViewContainerProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _ViewContainerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewContainerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ViewContainerProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _ViewContainerServiceDescription();

  String get serviceName => ViewContainer.serviceName;

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
    return "_ViewContainerProxyControl($superString)";
  }
}


class ViewContainerProxy extends bindings.Proxy
                              implements ViewContainer {
  ViewContainerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _ViewContainerProxyControl.fromEndpoint(endpoint));

  ViewContainerProxy.fromHandle(core.MojoHandle handle)
      : super(new _ViewContainerProxyControl.fromHandle(handle));

  ViewContainerProxy.unbound()
      : super(new _ViewContainerProxyControl.unbound());

  static ViewContainerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewContainerProxy"));
    return new ViewContainerProxy.fromEndpoint(endpoint);
  }

  factory ViewContainerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewContainerProxy p = new ViewContainerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void setListener(Object listener) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ViewContainerSetListenerParams();
    params.listener = listener;
    ctrl.sendMessage(params,
        _viewContainerMethodSetListenerName);
  }
  void addChild(int childKey, Object childViewOwner) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ViewContainerAddChildParams();
    params.childKey = childKey;
    params.childViewOwner = childViewOwner;
    ctrl.sendMessage(params,
        _viewContainerMethodAddChildName);
  }
  void removeChild(int childKey, Object transferredViewOwner) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ViewContainerRemoveChildParams();
    params.childKey = childKey;
    params.transferredViewOwner = transferredViewOwner;
    ctrl.sendMessage(params,
        _viewContainerMethodRemoveChildName);
  }
  void setChildProperties(int childKey, int childSceneVersion, view_properties_mojom.ViewProperties childViewProperties) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ViewContainerSetChildPropertiesParams();
    params.childKey = childKey;
    params.childSceneVersion = childSceneVersion;
    params.childViewProperties = childViewProperties;
    ctrl.sendMessage(params,
        _viewContainerMethodSetChildPropertiesName);
  }
}


class ViewContainerStub extends bindings.Stub {
  ViewContainer _impl;

  ViewContainerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ViewContainer impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  ViewContainerStub.fromHandle(
      core.MojoHandle handle, [ViewContainer impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  ViewContainerStub.unbound([this._impl]) : super.unbound();

  static ViewContainerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewContainerStub"));
    return new ViewContainerStub.fromEndpoint(endpoint);
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
      case _viewContainerMethodSetListenerName:
        var params = _ViewContainerSetListenerParams.deserialize(
            message.payload);
        _impl.setListener(params.listener);
        break;
      case _viewContainerMethodAddChildName:
        var params = _ViewContainerAddChildParams.deserialize(
            message.payload);
        _impl.addChild(params.childKey, params.childViewOwner);
        break;
      case _viewContainerMethodRemoveChildName:
        var params = _ViewContainerRemoveChildParams.deserialize(
            message.payload);
        _impl.removeChild(params.childKey, params.transferredViewOwner);
        break;
      case _viewContainerMethodSetChildPropertiesName:
        var params = _ViewContainerSetChildPropertiesParams.deserialize(
            message.payload);
        _impl.setChildProperties(params.childKey, params.childSceneVersion, params.childViewProperties);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ViewContainer get impl => _impl;
  set impl(ViewContainer d) {
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
    return "ViewContainerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewContainerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _viewContainerListenerMethodOnChildAttachedName = 0;
const int _viewContainerListenerMethodOnChildUnavailableName = 1;

class _ViewContainerListenerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewContainerListener {
  static const String serviceName = null;
  dynamic onChildAttached(int childKey,ViewInfo childViewInfo,[Function responseFactory = null]);
  dynamic onChildUnavailable(int childKey,[Function responseFactory = null]);
}


class _ViewContainerListenerProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _ViewContainerListenerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewContainerListenerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ViewContainerListenerProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _ViewContainerListenerServiceDescription();

  String get serviceName => ViewContainerListener.serviceName;

  @override
  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _viewContainerListenerMethodOnChildAttachedName:
        var r = ViewContainerListenerOnChildAttachedResponseParams.deserialize(
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
      case _viewContainerListenerMethodOnChildUnavailableName:
        var r = ViewContainerListenerOnChildUnavailableResponseParams.deserialize(
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
    return "_ViewContainerListenerProxyControl($superString)";
  }
}


class ViewContainerListenerProxy extends bindings.Proxy
                              implements ViewContainerListener {
  ViewContainerListenerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _ViewContainerListenerProxyControl.fromEndpoint(endpoint));

  ViewContainerListenerProxy.fromHandle(core.MojoHandle handle)
      : super(new _ViewContainerListenerProxyControl.fromHandle(handle));

  ViewContainerListenerProxy.unbound()
      : super(new _ViewContainerListenerProxyControl.unbound());

  static ViewContainerListenerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewContainerListenerProxy"));
    return new ViewContainerListenerProxy.fromEndpoint(endpoint);
  }

  factory ViewContainerListenerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewContainerListenerProxy p = new ViewContainerListenerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic onChildAttached(int childKey,ViewInfo childViewInfo,[Function responseFactory = null]) {
    var params = new _ViewContainerListenerOnChildAttachedParams();
    params.childKey = childKey;
    params.childViewInfo = childViewInfo;
    return ctrl.sendMessageWithRequestId(
        params,
        _viewContainerListenerMethodOnChildAttachedName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic onChildUnavailable(int childKey,[Function responseFactory = null]) {
    var params = new _ViewContainerListenerOnChildUnavailableParams();
    params.childKey = childKey;
    return ctrl.sendMessageWithRequestId(
        params,
        _viewContainerListenerMethodOnChildUnavailableName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}


class ViewContainerListenerStub extends bindings.Stub {
  ViewContainerListener _impl;

  ViewContainerListenerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ViewContainerListener impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  ViewContainerListenerStub.fromHandle(
      core.MojoHandle handle, [ViewContainerListener impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  ViewContainerListenerStub.unbound([this._impl]) : super.unbound();

  static ViewContainerListenerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewContainerListenerStub"));
    return new ViewContainerListenerStub.fromEndpoint(endpoint);
  }


  ViewContainerListenerOnChildAttachedResponseParams _viewContainerListenerOnChildAttachedResponseParamsFactory() {
    var result = new ViewContainerListenerOnChildAttachedResponseParams();
    return result;
  }
  ViewContainerListenerOnChildUnavailableResponseParams _viewContainerListenerOnChildUnavailableResponseParamsFactory() {
    var result = new ViewContainerListenerOnChildUnavailableResponseParams();
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
      case _viewContainerListenerMethodOnChildAttachedName:
        var params = _ViewContainerListenerOnChildAttachedParams.deserialize(
            message.payload);
        var response = _impl.onChildAttached(params.childKey,params.childViewInfo,_viewContainerListenerOnChildAttachedResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _viewContainerListenerMethodOnChildAttachedName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _viewContainerListenerMethodOnChildAttachedName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _viewContainerListenerMethodOnChildUnavailableName:
        var params = _ViewContainerListenerOnChildUnavailableParams.deserialize(
            message.payload);
        var response = _impl.onChildUnavailable(params.childKey,_viewContainerListenerOnChildUnavailableResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _viewContainerListenerMethodOnChildUnavailableName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _viewContainerListenerMethodOnChildUnavailableName,
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

  ViewContainerListener get impl => _impl;
  set impl(ViewContainerListener d) {
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
    return "ViewContainerListenerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewContainerListenerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



