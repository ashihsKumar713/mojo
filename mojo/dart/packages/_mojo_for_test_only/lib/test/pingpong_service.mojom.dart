// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library pingpong_service_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _PingPongServiceSetClientParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  PingPongClientInterface client = null;

  _PingPongServiceSetClientParams() : super(kVersions.last.size);

  static _PingPongServiceSetClientParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServiceSetClientParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServiceSetClientParams result = new _PingPongServiceSetClientParams();

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
      
      result.client = decoder0.decodeServiceInterface(8, false, PingPongClientProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(client, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "client of struct _PingPongServiceSetClientParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServiceSetClientParams("
           "client: $client" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _PingPongServicePingParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int pingValue = 0;

  _PingPongServicePingParams() : super(kVersions.last.size);

  static _PingPongServicePingParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServicePingParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServicePingParams result = new _PingPongServicePingParams();

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
      
      result.pingValue = decoder0.decodeUint16(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint16(pingValue, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pingValue of struct _PingPongServicePingParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServicePingParams("
           "pingValue: $pingValue" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["pingValue"] = pingValue;
    return map;
  }
}


class _PingPongServicePingTargetUrlParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String url = null;
  int count = 0;

  _PingPongServicePingTargetUrlParams() : super(kVersions.last.size);

  static _PingPongServicePingTargetUrlParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServicePingTargetUrlParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServicePingTargetUrlParams result = new _PingPongServicePingTargetUrlParams();

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
      
      result.url = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.count = decoder0.decodeUint16(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(url, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "url of struct _PingPongServicePingTargetUrlParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(count, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "count of struct _PingPongServicePingTargetUrlParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServicePingTargetUrlParams("
           "url: $url" ", "
           "count: $count" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["url"] = url;
    map["count"] = count;
    return map;
  }
}


class PingPongServicePingTargetUrlResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool ok = false;

  PingPongServicePingTargetUrlResponseParams() : super(kVersions.last.size);

  static PingPongServicePingTargetUrlResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PingPongServicePingTargetUrlResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PingPongServicePingTargetUrlResponseParams result = new PingPongServicePingTargetUrlResponseParams();

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
      
      result.ok = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(ok, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ok of struct PingPongServicePingTargetUrlResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "PingPongServicePingTargetUrlResponseParams("
           "ok: $ok" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["ok"] = ok;
    return map;
  }
}


class _PingPongServicePingTargetServiceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  PingPongServiceInterface service = null;
  int count = 0;

  _PingPongServicePingTargetServiceParams() : super(kVersions.last.size);

  static _PingPongServicePingTargetServiceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServicePingTargetServiceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServicePingTargetServiceParams result = new _PingPongServicePingTargetServiceParams();

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
      
      result.service = decoder0.decodeServiceInterface(8, false, PingPongServiceProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.count = decoder0.decodeUint16(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(service, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "service of struct _PingPongServicePingTargetServiceParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(count, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "count of struct _PingPongServicePingTargetServiceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServicePingTargetServiceParams("
           "service: $service" ", "
           "count: $count" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class PingPongServicePingTargetServiceResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool ok = false;

  PingPongServicePingTargetServiceResponseParams() : super(kVersions.last.size);

  static PingPongServicePingTargetServiceResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static PingPongServicePingTargetServiceResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    PingPongServicePingTargetServiceResponseParams result = new PingPongServicePingTargetServiceResponseParams();

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
      
      result.ok = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(ok, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ok of struct PingPongServicePingTargetServiceResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "PingPongServicePingTargetServiceResponseParams("
           "ok: $ok" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["ok"] = ok;
    return map;
  }
}


class _PingPongServiceGetPingPongServiceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  PingPongServiceInterfaceRequest service = null;

  _PingPongServiceGetPingPongServiceParams() : super(kVersions.last.size);

  static _PingPongServiceGetPingPongServiceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServiceGetPingPongServiceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServiceGetPingPongServiceParams result = new _PingPongServiceGetPingPongServiceParams();

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
      
      result.service = decoder0.decodeInterfaceRequest(8, false, PingPongServiceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(service, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "service of struct _PingPongServiceGetPingPongServiceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServiceGetPingPongServiceParams("
           "service: $service" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _PingPongServiceGetPingPongServiceDelayedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  PingPongServiceInterfaceRequest service = null;

  _PingPongServiceGetPingPongServiceDelayedParams() : super(kVersions.last.size);

  static _PingPongServiceGetPingPongServiceDelayedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServiceGetPingPongServiceDelayedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServiceGetPingPongServiceDelayedParams result = new _PingPongServiceGetPingPongServiceDelayedParams();

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
      
      result.service = decoder0.decodeInterfaceRequest(8, false, PingPongServiceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(service, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "service of struct _PingPongServiceGetPingPongServiceDelayedParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongServiceGetPingPongServiceDelayedParams("
           "service: $service" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _PingPongServiceQuitParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _PingPongServiceQuitParams() : super(kVersions.last.size);

  static _PingPongServiceQuitParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongServiceQuitParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongServiceQuitParams result = new _PingPongServiceQuitParams();

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
    return "_PingPongServiceQuitParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _PingPongClientPongParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int pongValue = 0;

  _PingPongClientPongParams() : super(kVersions.last.size);

  static _PingPongClientPongParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _PingPongClientPongParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _PingPongClientPongParams result = new _PingPongClientPongParams();

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
      
      result.pongValue = decoder0.decodeUint16(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint16(pongValue, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pongValue of struct _PingPongClientPongParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_PingPongClientPongParams("
           "pongValue: $pongValue" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["pongValue"] = pongValue;
    return map;
  }
}

const int _pingPongServiceMethodSetClientName = 0;
const int _pingPongServiceMethodPingName = 1;
const int _pingPongServiceMethodPingTargetUrlName = 2;
const int _pingPongServiceMethodPingTargetServiceName = 3;
const int _pingPongServiceMethodGetPingPongServiceName = 4;
const int _pingPongServiceMethodGetPingPongServiceDelayedName = 5;
const int _pingPongServiceMethodQuitName = 6;

class _PingPongServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]){
    var interfaceTypeKey = getRuntimeTypeInfo().services["test::PingPongService"];
    var userDefinedType = getAllMojomTypeDefinitions()[interfaceTypeKey];
    return responseFactory(userDefinedType.interfaceType);
  }

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions()[typeKey]);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions());
}

abstract class PingPongService {
  static const String serviceName = "test::PingPongService";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _PingPongServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static PingPongServiceProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    PingPongServiceProxy p = new PingPongServiceProxy.unbound();
    String name = serviceName ?? PingPongService.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void setClient(PingPongClientInterface client);
  void ping(int pingValue);
  dynamic pingTargetUrl(String url,int count,[Function responseFactory = null]);
  dynamic pingTargetService(PingPongServiceInterface service,int count,[Function responseFactory = null]);
  void getPingPongService(PingPongServiceInterfaceRequest service);
  void getPingPongServiceDelayed(PingPongServiceInterfaceRequest service);
  void quit();
}

abstract class PingPongServiceInterface
    implements bindings.MojoInterface<PingPongService>,
               PingPongService {
  factory PingPongServiceInterface([PingPongService impl]) =>
      new PingPongServiceStub.unbound(impl);
  factory PingPongServiceInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [PingPongService impl]) =>
      new PingPongServiceStub.fromEndpoint(endpoint, impl);
}

abstract class PingPongServiceInterfaceRequest
    implements bindings.MojoInterface<PingPongService>,
               PingPongService {
  factory PingPongServiceInterfaceRequest() =>
      new PingPongServiceProxy.unbound();
}

class _PingPongServiceProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<PingPongService> {
  _PingPongServiceProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _PingPongServiceProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _PingPongServiceProxyControl.unbound() : super.unbound();

  String get serviceName => PingPongService.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _pingPongServiceMethodPingTargetUrlName:
        var r = PingPongServicePingTargetUrlResponseParams.deserialize(
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
      case _pingPongServiceMethodPingTargetServiceName:
        var r = PingPongServicePingTargetServiceResponseParams.deserialize(
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

  PingPongService get impl => null;
  set impl(PingPongService _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_PingPongServiceProxyControl($superString)";
  }
}

class PingPongServiceProxy
    extends bindings.Proxy<PingPongService>
    implements PingPongService,
               PingPongServiceInterface,
               PingPongServiceInterfaceRequest {
  PingPongServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _PingPongServiceProxyControl.fromEndpoint(endpoint));

  PingPongServiceProxy.fromHandle(core.MojoHandle handle)
      : super(new _PingPongServiceProxyControl.fromHandle(handle));

  PingPongServiceProxy.unbound()
      : super(new _PingPongServiceProxyControl.unbound());

  static PingPongServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PingPongServiceProxy"));
    return new PingPongServiceProxy.fromEndpoint(endpoint);
  }


  void setClient(PingPongClientInterface client) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _PingPongServiceSetClientParams();
    params.client = client;
    ctrl.sendMessage(params,
        _pingPongServiceMethodSetClientName);
  }
  void ping(int pingValue) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _PingPongServicePingParams();
    params.pingValue = pingValue;
    ctrl.sendMessage(params,
        _pingPongServiceMethodPingName);
  }
  dynamic pingTargetUrl(String url,int count,[Function responseFactory = null]) {
    var params = new _PingPongServicePingTargetUrlParams();
    params.url = url;
    params.count = count;
    return ctrl.sendMessageWithRequestId(
        params,
        _pingPongServiceMethodPingTargetUrlName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic pingTargetService(PingPongServiceInterface service,int count,[Function responseFactory = null]) {
    var params = new _PingPongServicePingTargetServiceParams();
    params.service = service;
    params.count = count;
    return ctrl.sendMessageWithRequestId(
        params,
        _pingPongServiceMethodPingTargetServiceName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void getPingPongService(PingPongServiceInterfaceRequest service) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _PingPongServiceGetPingPongServiceParams();
    params.service = service;
    ctrl.sendMessage(params,
        _pingPongServiceMethodGetPingPongServiceName);
  }
  void getPingPongServiceDelayed(PingPongServiceInterfaceRequest service) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _PingPongServiceGetPingPongServiceDelayedParams();
    params.service = service;
    ctrl.sendMessage(params,
        _pingPongServiceMethodGetPingPongServiceDelayedName);
  }
  void quit() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _PingPongServiceQuitParams();
    ctrl.sendMessage(params,
        _pingPongServiceMethodQuitName);
  }
}

class _PingPongServiceStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<PingPongService> {
  PingPongService _impl;

  _PingPongServiceStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [PingPongService impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _PingPongServiceStubControl.fromHandle(
      core.MojoHandle handle, [PingPongService impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _PingPongServiceStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => PingPongService.serviceName;


  PingPongServicePingTargetUrlResponseParams _pingPongServicePingTargetUrlResponseParamsFactory(bool ok) {
    var result = new PingPongServicePingTargetUrlResponseParams();
    result.ok = ok;
    return result;
  }
  PingPongServicePingTargetServiceResponseParams _pingPongServicePingTargetServiceResponseParamsFactory(bool ok) {
    var result = new PingPongServicePingTargetServiceResponseParams();
    result.ok = ok;
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
      case _pingPongServiceMethodSetClientName:
        var params = _PingPongServiceSetClientParams.deserialize(
            message.payload);
        _impl.setClient(params.client);
        break;
      case _pingPongServiceMethodPingName:
        var params = _PingPongServicePingParams.deserialize(
            message.payload);
        _impl.ping(params.pingValue);
        break;
      case _pingPongServiceMethodPingTargetUrlName:
        var params = _PingPongServicePingTargetUrlParams.deserialize(
            message.payload);
        var response = _impl.pingTargetUrl(params.url,params.count,_pingPongServicePingTargetUrlResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _pingPongServiceMethodPingTargetUrlName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _pingPongServiceMethodPingTargetUrlName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _pingPongServiceMethodPingTargetServiceName:
        var params = _PingPongServicePingTargetServiceParams.deserialize(
            message.payload);
        var response = _impl.pingTargetService(params.service,params.count,_pingPongServicePingTargetServiceResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _pingPongServiceMethodPingTargetServiceName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _pingPongServiceMethodPingTargetServiceName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _pingPongServiceMethodGetPingPongServiceName:
        var params = _PingPongServiceGetPingPongServiceParams.deserialize(
            message.payload);
        _impl.getPingPongService(params.service);
        break;
      case _pingPongServiceMethodGetPingPongServiceDelayedName:
        var params = _PingPongServiceGetPingPongServiceDelayedParams.deserialize(
            message.payload);
        _impl.getPingPongServiceDelayed(params.service);
        break;
      case _pingPongServiceMethodQuitName:
        _impl.quit();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  PingPongService get impl => _impl;
  set impl(PingPongService d) {
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
    return "_PingPongServiceStubControl($superString)";
  }

  int get version => 0;
}

class PingPongServiceStub
    extends bindings.Stub<PingPongService>
    implements PingPongService,
               PingPongServiceInterface,
               PingPongServiceInterfaceRequest {
  PingPongServiceStub.unbound([PingPongService impl])
      : super(new _PingPongServiceStubControl.unbound(impl));

  PingPongServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [PingPongService impl])
      : super(new _PingPongServiceStubControl.fromEndpoint(endpoint, impl));

  PingPongServiceStub.fromHandle(
      core.MojoHandle handle, [PingPongService impl])
      : super(new _PingPongServiceStubControl.fromHandle(handle, impl));

  static PingPongServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PingPongServiceStub"));
    return new PingPongServiceStub.fromEndpoint(endpoint);
  }


  void setClient(PingPongClientInterface client) {
    return impl.setClient(client);
  }
  void ping(int pingValue) {
    return impl.ping(pingValue);
  }
  dynamic pingTargetUrl(String url,int count,[Function responseFactory = null]) {
    return impl.pingTargetUrl(url,count,responseFactory);
  }
  dynamic pingTargetService(PingPongServiceInterface service,int count,[Function responseFactory = null]) {
    return impl.pingTargetService(service,count,responseFactory);
  }
  void getPingPongService(PingPongServiceInterfaceRequest service) {
    return impl.getPingPongService(service);
  }
  void getPingPongServiceDelayed(PingPongServiceInterfaceRequest service) {
    return impl.getPingPongServiceDelayed(service);
  }
  void quit() {
    return impl.quit();
  }
}

const int _pingPongClientMethodPongName = 0;

class _PingPongClientServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class PingPongClient {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _PingPongClientServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static PingPongClientProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    PingPongClientProxy p = new PingPongClientProxy.unbound();
    String name = serviceName ?? PingPongClient.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void pong(int pongValue);
}

abstract class PingPongClientInterface
    implements bindings.MojoInterface<PingPongClient>,
               PingPongClient {
  factory PingPongClientInterface([PingPongClient impl]) =>
      new PingPongClientStub.unbound(impl);
  factory PingPongClientInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [PingPongClient impl]) =>
      new PingPongClientStub.fromEndpoint(endpoint, impl);
}

abstract class PingPongClientInterfaceRequest
    implements bindings.MojoInterface<PingPongClient>,
               PingPongClient {
  factory PingPongClientInterfaceRequest() =>
      new PingPongClientProxy.unbound();
}

class _PingPongClientProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<PingPongClient> {
  _PingPongClientProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _PingPongClientProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _PingPongClientProxyControl.unbound() : super.unbound();

  String get serviceName => PingPongClient.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  PingPongClient get impl => null;
  set impl(PingPongClient _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_PingPongClientProxyControl($superString)";
  }
}

class PingPongClientProxy
    extends bindings.Proxy<PingPongClient>
    implements PingPongClient,
               PingPongClientInterface,
               PingPongClientInterfaceRequest {
  PingPongClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _PingPongClientProxyControl.fromEndpoint(endpoint));

  PingPongClientProxy.fromHandle(core.MojoHandle handle)
      : super(new _PingPongClientProxyControl.fromHandle(handle));

  PingPongClientProxy.unbound()
      : super(new _PingPongClientProxyControl.unbound());

  static PingPongClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PingPongClientProxy"));
    return new PingPongClientProxy.fromEndpoint(endpoint);
  }


  void pong(int pongValue) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _PingPongClientPongParams();
    params.pongValue = pongValue;
    ctrl.sendMessage(params,
        _pingPongClientMethodPongName);
  }
}

class _PingPongClientStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<PingPongClient> {
  PingPongClient _impl;

  _PingPongClientStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [PingPongClient impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _PingPongClientStubControl.fromHandle(
      core.MojoHandle handle, [PingPongClient impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _PingPongClientStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => PingPongClient.serviceName;



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
      case _pingPongClientMethodPongName:
        var params = _PingPongClientPongParams.deserialize(
            message.payload);
        _impl.pong(params.pongValue);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  PingPongClient get impl => _impl;
  set impl(PingPongClient d) {
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
    return "_PingPongClientStubControl($superString)";
  }

  int get version => 0;
}

class PingPongClientStub
    extends bindings.Stub<PingPongClient>
    implements PingPongClient,
               PingPongClientInterface,
               PingPongClientInterfaceRequest {
  PingPongClientStub.unbound([PingPongClient impl])
      : super(new _PingPongClientStubControl.unbound(impl));

  PingPongClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [PingPongClient impl])
      : super(new _PingPongClientStubControl.fromEndpoint(endpoint, impl));

  PingPongClientStub.fromHandle(
      core.MojoHandle handle, [PingPongClient impl])
      : super(new _PingPongClientStubControl.fromHandle(handle, impl));

  static PingPongClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For PingPongClientStub"));
    return new PingPongClientStub.fromEndpoint(endpoint);
  }


  void pong(int pongValue) {
    return impl.pong(pongValue);
  }
}


mojom_types.RuntimeTypeInfo getRuntimeTypeInfo() => _runtimeTypeInfo ??
    _initRuntimeTypeInfo();

Map<String, mojom_types.UserDefinedType> getAllMojomTypeDefinitions() {
  return getRuntimeTypeInfo().typeMap;
}

var _runtimeTypeInfo;
mojom_types.RuntimeTypeInfo  _initRuntimeTypeInfo() {
  // serializedRuntimeTypeInfo contains the bytes of the Mojo serialization of
  // a mojom_types.RuntimeTypeInfo struct describing the Mojom types in this
  // file. The string contains the base64 encoding of the gzip-compressed bytes.
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+xZTU/bTBB2HD7ywhs+3hdKSigKlFb0AEZqD4gTUkFFalWlLVXLKVhhC26T2LUdpN565CfwE/oTeuxP4dgjR27tLpltl/VOYkeJbVpWGsyuP3bn2Zl5ZicFrdUm4HoCV3l8XehnqOSgf4fKNBWfeP7GRtlqHJbtxuEr4h5bVaJ4/h68s7tX3q483d7bYC+uBt+T53eEdenC+Bpcl6jMod99XLNIw48y/7IwT1ZaD+t/Hmj1l2G8pEktc7W7Kd1ek8Z/QCtr6naLyhgVWaMiHfsf8FeoG8BxgcoIlQqVN1SMI7tODLd5YNetBnGNuv3eNjy32vrnwHR9w3Qc9nXPYH8rtOcZVsMn7juzSjzDoXM6dM6K18Julb1YD8zL+/9K0Mj2IeN5huCB4akJeIrfkxtbB9tCBpcKp0XY/37jVJLw4fpeZMLrydoaoucU6Mr0XHHJxyZdm0pf3vqtr7zfm4r4ogn3O7WwdoDh8x/4w+VSj81ak6jj3yL4X9z4FKSQMoH4iQP2coLEHY7vKVy/SPbzFcFHXk9JwQ/DwjiLRaNUIJI+N+skFE/MUBkX4hu/Mwc2jITpwD7lYopvnfSR1yXy1LCwnzrwCYtFg1SGhH0bFvbtWxbiAzywn29dd6ZgfAb2v6i2j+998p9JKv9c7rcvsE5Q/5GE4inX+60eLZ6uI/reBp1/6SsG1ZTHVWZf5z2Oqxi/joEtV8EoVPZQjNEeNGn+Uoe8Kmw+2W28PkPSxTC4Z8LkNZY6r8n/aXmNdZPXtM1rrPZ5TT7leQ2P3+tw3tIj4KO3wWcadGf2s2u6h8R//fKZAp/JhHmrkO0Nb/F85Yq+guMk5Tfyeb6Uwf0nEyN/jUJe1nRrSr+ZhJw1Dr9pl893iiu5LnBpxy95yCOqdrPhI7jcTTie6EIf86uoPIT51TzkELJfeXTNHkk/H2kx+RPP/+0PGupPD1PMQzzunAIPZSPgkhVwx84Tv+1HONwqcJpOiI+4/k5EPtpE9F4A3QN6p+Q8JfOSk0nHuWoc6gKwWqV9LKXgXIXVc8LW39POcwznRynmuXPxoR74K6t/ziL+yrnuOpy/0sJ3zH62rgHf8TYQAZeBNnw3C2fTJ8RXVHM15e9GSfLdfo/9J6j3VcK7qR+G4znWvx+jXeh94rlu/fNCwmswAu6DiufkvCxop1ukZn4iB0heVkzITzkORxH9dAfR/wFggOp/U+/vyl+Zfaz8xf4q1/uHIuA+FKLe/6JpKevf8wnX+8+03tb7mZ5pqPfnkN/HC8i55GcAAAD//zW0L99oJQAA";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
