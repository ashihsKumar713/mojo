// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library web_socket_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _WebSocketConnectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  String url = null;
  List<String> protocols = null;
  String origin = null;
  core.MojoDataPipeConsumer sendStream = null;
  WebSocketClientInterface client = null;

  _WebSocketConnectParams() : super(kVersions.last.size);

  static _WebSocketConnectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketConnectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketConnectParams result = new _WebSocketConnectParams();

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
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.protocols = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.protocols[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.origin = decoder0.decodeString(24, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.sendStream = decoder0.decodeConsumerHandle(32, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.client = decoder0.decodeServiceInterface(36, false, WebSocketClientProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(url, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "url of struct _WebSocketConnectParams: $e";
      rethrow;
    }
    try {
      if (protocols == null) {
        encoder0.encodeNullPointer(16, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(protocols.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < protocols.length; ++i0) {
          encoder1.encodeString(protocols[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "protocols of struct _WebSocketConnectParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(origin, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "origin of struct _WebSocketConnectParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandle(sendStream, 32, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sendStream of struct _WebSocketConnectParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(client, 36, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "client of struct _WebSocketConnectParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_WebSocketConnectParams("
           "url: $url" ", "
           "protocols: $protocols" ", "
           "origin: $origin" ", "
           "sendStream: $sendStream" ", "
           "client: $client" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _WebSocketSendParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  bool fin = false;
  WebSocketMessageType type = null;
  int numBytes = 0;

  _WebSocketSendParams() : super(kVersions.last.size);

  static _WebSocketSendParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketSendParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketSendParams result = new _WebSocketSendParams();

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
      
      result.fin = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
        result.type = WebSocketMessageType.decode(decoder0, 12);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable WebSocketMessageType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.numBytes = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(fin, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fin of struct _WebSocketSendParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(type, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "type of struct _WebSocketSendParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(numBytes, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "numBytes of struct _WebSocketSendParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_WebSocketSendParams("
           "fin: $fin" ", "
           "type: $type" ", "
           "numBytes: $numBytes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fin"] = fin;
    map["type"] = type;
    map["numBytes"] = numBytes;
    return map;
  }
}


class _WebSocketFlowControlParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int quota = 0;

  _WebSocketFlowControlParams() : super(kVersions.last.size);

  static _WebSocketFlowControlParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketFlowControlParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketFlowControlParams result = new _WebSocketFlowControlParams();

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
      
      result.quota = decoder0.decodeInt64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(quota, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "quota of struct _WebSocketFlowControlParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_WebSocketFlowControlParams("
           "quota: $quota" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["quota"] = quota;
    return map;
  }
}


class _WebSocketCloseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int code = 0;
  String reason = null;

  _WebSocketCloseParams() : super(kVersions.last.size);

  static _WebSocketCloseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketCloseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketCloseParams result = new _WebSocketCloseParams();

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
      
      result.code = decoder0.decodeUint16(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.reason = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint16(code, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "code of struct _WebSocketCloseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(reason, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "reason of struct _WebSocketCloseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_WebSocketCloseParams("
           "code: $code" ", "
           "reason: $reason" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["code"] = code;
    map["reason"] = reason;
    return map;
  }
}


class _WebSocketClientDidConnectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  String selectedSubprotocol = null;
  String extensions = null;
  core.MojoDataPipeConsumer receiveStream = null;

  _WebSocketClientDidConnectParams() : super(kVersions.last.size);

  static _WebSocketClientDidConnectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketClientDidConnectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketClientDidConnectParams result = new _WebSocketClientDidConnectParams();

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
      
      result.selectedSubprotocol = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.extensions = decoder0.decodeString(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.receiveStream = decoder0.decodeConsumerHandle(24, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(selectedSubprotocol, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "selectedSubprotocol of struct _WebSocketClientDidConnectParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(extensions, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "extensions of struct _WebSocketClientDidConnectParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandle(receiveStream, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "receiveStream of struct _WebSocketClientDidConnectParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_WebSocketClientDidConnectParams("
           "selectedSubprotocol: $selectedSubprotocol" ", "
           "extensions: $extensions" ", "
           "receiveStream: $receiveStream" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _WebSocketClientDidReceiveDataParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  bool fin = false;
  WebSocketMessageType type = null;
  int numBytes = 0;

  _WebSocketClientDidReceiveDataParams() : super(kVersions.last.size);

  static _WebSocketClientDidReceiveDataParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketClientDidReceiveDataParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketClientDidReceiveDataParams result = new _WebSocketClientDidReceiveDataParams();

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
      
      result.fin = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
        result.type = WebSocketMessageType.decode(decoder0, 12);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable WebSocketMessageType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.numBytes = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(fin, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fin of struct _WebSocketClientDidReceiveDataParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(type, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "type of struct _WebSocketClientDidReceiveDataParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(numBytes, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "numBytes of struct _WebSocketClientDidReceiveDataParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_WebSocketClientDidReceiveDataParams("
           "fin: $fin" ", "
           "type: $type" ", "
           "numBytes: $numBytes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fin"] = fin;
    map["type"] = type;
    map["numBytes"] = numBytes;
    return map;
  }
}


class _WebSocketClientDidReceiveFlowControlParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int quota = 0;

  _WebSocketClientDidReceiveFlowControlParams() : super(kVersions.last.size);

  static _WebSocketClientDidReceiveFlowControlParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketClientDidReceiveFlowControlParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketClientDidReceiveFlowControlParams result = new _WebSocketClientDidReceiveFlowControlParams();

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
      
      result.quota = decoder0.decodeInt64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(quota, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "quota of struct _WebSocketClientDidReceiveFlowControlParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_WebSocketClientDidReceiveFlowControlParams("
           "quota: $quota" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["quota"] = quota;
    return map;
  }
}


class _WebSocketClientDidFailParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String message = null;

  _WebSocketClientDidFailParams() : super(kVersions.last.size);

  static _WebSocketClientDidFailParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketClientDidFailParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketClientDidFailParams result = new _WebSocketClientDidFailParams();

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
      
      result.message = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(message, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "message of struct _WebSocketClientDidFailParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_WebSocketClientDidFailParams("
           "message: $message" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["message"] = message;
    return map;
  }
}


class _WebSocketClientDidCloseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  bool wasClean = false;
  int code = 0;
  String reason = null;

  _WebSocketClientDidCloseParams() : super(kVersions.last.size);

  static _WebSocketClientDidCloseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _WebSocketClientDidCloseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _WebSocketClientDidCloseParams result = new _WebSocketClientDidCloseParams();

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
      
      result.wasClean = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.code = decoder0.decodeUint16(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.reason = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(wasClean, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "wasClean of struct _WebSocketClientDidCloseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(code, 10);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "code of struct _WebSocketClientDidCloseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(reason, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "reason of struct _WebSocketClientDidCloseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_WebSocketClientDidCloseParams("
           "wasClean: $wasClean" ", "
           "code: $code" ", "
           "reason: $reason" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["wasClean"] = wasClean;
    map["code"] = code;
    map["reason"] = reason;
    return map;
  }
}

const int _webSocketMethodConnectName = 0;
const int _webSocketMethodSendName = 1;
const int _webSocketMethodFlowControlName = 2;
const int _webSocketMethodCloseName = 3;
  
class WebSocketMessageType extends bindings.MojoEnum {
  static const WebSocketMessageType continuation = const WebSocketMessageType._(0);
  static const WebSocketMessageType text = const WebSocketMessageType._(1);
  static const WebSocketMessageType binary = const WebSocketMessageType._(2);

  const WebSocketMessageType._(int v) : super(v);

  static const Map<String, WebSocketMessageType> valuesMap = const {
    "continuation": continuation,
    "text": text,
    "binary": binary,
  };
  static const List<WebSocketMessageType> values = const [
    continuation,
    text,
    binary,
  ];

  static WebSocketMessageType valueOf(String name) => valuesMap[name];

  factory WebSocketMessageType(int v) {
    switch (v) {
      case 0:
        return WebSocketMessageType.continuation;
      case 1:
        return WebSocketMessageType.text;
      case 2:
        return WebSocketMessageType.binary;
      default:
        return null;
    }
  }

  static WebSocketMessageType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    WebSocketMessageType result = new WebSocketMessageType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum WebSocketMessageType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case continuation:
        return 'WebSocketMessageType.continuation';
      case text:
        return 'WebSocketMessageType.text';
      case binary:
        return 'WebSocketMessageType.binary';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class _WebSocketServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class WebSocket {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _WebSocketServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static WebSocketProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    WebSocketProxy p = new WebSocketProxy.unbound();
    String name = serviceName ?? WebSocket.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void connect(String url, List<String> protocols, String origin, core.MojoDataPipeConsumer sendStream, WebSocketClientInterface client);
  void send(bool fin, WebSocketMessageType type, int numBytes);
  void flowControl(int quota);
  void close_(int code, String reason);
  static const int kAbnormalCloseCode = 1006;
}

abstract class WebSocketInterface
    implements bindings.MojoInterface<WebSocket>,
               WebSocket {
  factory WebSocketInterface([WebSocket impl]) =>
      new WebSocketStub.unbound(impl);
  factory WebSocketInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [WebSocket impl]) =>
      new WebSocketStub.fromEndpoint(endpoint, impl);
}

abstract class WebSocketInterfaceRequest
    implements bindings.MojoInterface<WebSocket>,
               WebSocket {
  factory WebSocketInterfaceRequest() =>
      new WebSocketProxy.unbound();
}

class _WebSocketProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<WebSocket> {
  _WebSocketProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _WebSocketProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _WebSocketProxyControl.unbound() : super.unbound();

  String get serviceName => WebSocket.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  WebSocket get impl => null;
  set impl(WebSocket _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_WebSocketProxyControl($superString)";
  }
}

class WebSocketProxy
    extends bindings.Proxy<WebSocket>
    implements WebSocket,
               WebSocketInterface,
               WebSocketInterfaceRequest {
  WebSocketProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _WebSocketProxyControl.fromEndpoint(endpoint));

  WebSocketProxy.fromHandle(core.MojoHandle handle)
      : super(new _WebSocketProxyControl.fromHandle(handle));

  WebSocketProxy.unbound()
      : super(new _WebSocketProxyControl.unbound());

  static WebSocketProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WebSocketProxy"));
    return new WebSocketProxy.fromEndpoint(endpoint);
  }


  void connect(String url, List<String> protocols, String origin, core.MojoDataPipeConsumer sendStream, WebSocketClientInterface client) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _WebSocketConnectParams();
    params.url = url;
    params.protocols = protocols;
    params.origin = origin;
    params.sendStream = sendStream;
    params.client = client;
    ctrl.sendMessage(params,
        _webSocketMethodConnectName);
  }
  void send(bool fin, WebSocketMessageType type, int numBytes) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _WebSocketSendParams();
    params.fin = fin;
    params.type = type;
    params.numBytes = numBytes;
    ctrl.sendMessage(params,
        _webSocketMethodSendName);
  }
  void flowControl(int quota) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _WebSocketFlowControlParams();
    params.quota = quota;
    ctrl.sendMessage(params,
        _webSocketMethodFlowControlName);
  }
  void close_(int code, String reason) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _WebSocketCloseParams();
    params.code = code;
    params.reason = reason;
    ctrl.sendMessage(params,
        _webSocketMethodCloseName);
  }
}

class _WebSocketStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<WebSocket> {
  WebSocket _impl;

  _WebSocketStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [WebSocket impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _WebSocketStubControl.fromHandle(
      core.MojoHandle handle, [WebSocket impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _WebSocketStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => WebSocket.serviceName;



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
      case _webSocketMethodConnectName:
        var params = _WebSocketConnectParams.deserialize(
            message.payload);
        _impl.connect(params.url, params.protocols, params.origin, params.sendStream, params.client);
        break;
      case _webSocketMethodSendName:
        var params = _WebSocketSendParams.deserialize(
            message.payload);
        _impl.send(params.fin, params.type, params.numBytes);
        break;
      case _webSocketMethodFlowControlName:
        var params = _WebSocketFlowControlParams.deserialize(
            message.payload);
        _impl.flowControl(params.quota);
        break;
      case _webSocketMethodCloseName:
        var params = _WebSocketCloseParams.deserialize(
            message.payload);
        _impl.close_(params.code, params.reason);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  WebSocket get impl => _impl;
  set impl(WebSocket d) {
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
    return "_WebSocketStubControl($superString)";
  }

  int get version => 0;
}

class WebSocketStub
    extends bindings.Stub<WebSocket>
    implements WebSocket,
               WebSocketInterface,
               WebSocketInterfaceRequest {
  WebSocketStub.unbound([WebSocket impl])
      : super(new _WebSocketStubControl.unbound(impl));

  WebSocketStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [WebSocket impl])
      : super(new _WebSocketStubControl.fromEndpoint(endpoint, impl));

  WebSocketStub.fromHandle(
      core.MojoHandle handle, [WebSocket impl])
      : super(new _WebSocketStubControl.fromHandle(handle, impl));

  static WebSocketStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WebSocketStub"));
    return new WebSocketStub.fromEndpoint(endpoint);
  }


  void connect(String url, List<String> protocols, String origin, core.MojoDataPipeConsumer sendStream, WebSocketClientInterface client) {
    return impl.connect(url, protocols, origin, sendStream, client);
  }
  void send(bool fin, WebSocketMessageType type, int numBytes) {
    return impl.send(fin, type, numBytes);
  }
  void flowControl(int quota) {
    return impl.flowControl(quota);
  }
  void close_(int code, String reason) {
    return impl.close_(code, reason);
  }
}

const int _webSocketClientMethodDidConnectName = 0;
const int _webSocketClientMethodDidReceiveDataName = 1;
const int _webSocketClientMethodDidReceiveFlowControlName = 2;
const int _webSocketClientMethodDidFailName = 3;
const int _webSocketClientMethodDidCloseName = 4;

class _WebSocketClientServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class WebSocketClient {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _WebSocketClientServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static WebSocketClientProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    WebSocketClientProxy p = new WebSocketClientProxy.unbound();
    String name = serviceName ?? WebSocketClient.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void didConnect(String selectedSubprotocol, String extensions, core.MojoDataPipeConsumer receiveStream);
  void didReceiveData(bool fin, WebSocketMessageType type, int numBytes);
  void didReceiveFlowControl(int quota);
  void didFail(String message);
  void didClose(bool wasClean, int code, String reason);
}

abstract class WebSocketClientInterface
    implements bindings.MojoInterface<WebSocketClient>,
               WebSocketClient {
  factory WebSocketClientInterface([WebSocketClient impl]) =>
      new WebSocketClientStub.unbound(impl);
  factory WebSocketClientInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [WebSocketClient impl]) =>
      new WebSocketClientStub.fromEndpoint(endpoint, impl);
}

abstract class WebSocketClientInterfaceRequest
    implements bindings.MojoInterface<WebSocketClient>,
               WebSocketClient {
  factory WebSocketClientInterfaceRequest() =>
      new WebSocketClientProxy.unbound();
}

class _WebSocketClientProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<WebSocketClient> {
  _WebSocketClientProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _WebSocketClientProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _WebSocketClientProxyControl.unbound() : super.unbound();

  String get serviceName => WebSocketClient.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  WebSocketClient get impl => null;
  set impl(WebSocketClient _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_WebSocketClientProxyControl($superString)";
  }
}

class WebSocketClientProxy
    extends bindings.Proxy<WebSocketClient>
    implements WebSocketClient,
               WebSocketClientInterface,
               WebSocketClientInterfaceRequest {
  WebSocketClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _WebSocketClientProxyControl.fromEndpoint(endpoint));

  WebSocketClientProxy.fromHandle(core.MojoHandle handle)
      : super(new _WebSocketClientProxyControl.fromHandle(handle));

  WebSocketClientProxy.unbound()
      : super(new _WebSocketClientProxyControl.unbound());

  static WebSocketClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WebSocketClientProxy"));
    return new WebSocketClientProxy.fromEndpoint(endpoint);
  }


  void didConnect(String selectedSubprotocol, String extensions, core.MojoDataPipeConsumer receiveStream) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _WebSocketClientDidConnectParams();
    params.selectedSubprotocol = selectedSubprotocol;
    params.extensions = extensions;
    params.receiveStream = receiveStream;
    ctrl.sendMessage(params,
        _webSocketClientMethodDidConnectName);
  }
  void didReceiveData(bool fin, WebSocketMessageType type, int numBytes) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _WebSocketClientDidReceiveDataParams();
    params.fin = fin;
    params.type = type;
    params.numBytes = numBytes;
    ctrl.sendMessage(params,
        _webSocketClientMethodDidReceiveDataName);
  }
  void didReceiveFlowControl(int quota) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _WebSocketClientDidReceiveFlowControlParams();
    params.quota = quota;
    ctrl.sendMessage(params,
        _webSocketClientMethodDidReceiveFlowControlName);
  }
  void didFail(String message) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _WebSocketClientDidFailParams();
    params.message = message;
    ctrl.sendMessage(params,
        _webSocketClientMethodDidFailName);
  }
  void didClose(bool wasClean, int code, String reason) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _WebSocketClientDidCloseParams();
    params.wasClean = wasClean;
    params.code = code;
    params.reason = reason;
    ctrl.sendMessage(params,
        _webSocketClientMethodDidCloseName);
  }
}

class _WebSocketClientStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<WebSocketClient> {
  WebSocketClient _impl;

  _WebSocketClientStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [WebSocketClient impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _WebSocketClientStubControl.fromHandle(
      core.MojoHandle handle, [WebSocketClient impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _WebSocketClientStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => WebSocketClient.serviceName;



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
      case _webSocketClientMethodDidConnectName:
        var params = _WebSocketClientDidConnectParams.deserialize(
            message.payload);
        _impl.didConnect(params.selectedSubprotocol, params.extensions, params.receiveStream);
        break;
      case _webSocketClientMethodDidReceiveDataName:
        var params = _WebSocketClientDidReceiveDataParams.deserialize(
            message.payload);
        _impl.didReceiveData(params.fin, params.type, params.numBytes);
        break;
      case _webSocketClientMethodDidReceiveFlowControlName:
        var params = _WebSocketClientDidReceiveFlowControlParams.deserialize(
            message.payload);
        _impl.didReceiveFlowControl(params.quota);
        break;
      case _webSocketClientMethodDidFailName:
        var params = _WebSocketClientDidFailParams.deserialize(
            message.payload);
        _impl.didFail(params.message);
        break;
      case _webSocketClientMethodDidCloseName:
        var params = _WebSocketClientDidCloseParams.deserialize(
            message.payload);
        _impl.didClose(params.wasClean, params.code, params.reason);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  WebSocketClient get impl => _impl;
  set impl(WebSocketClient d) {
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
    return "_WebSocketClientStubControl($superString)";
  }

  int get version => 0;
}

class WebSocketClientStub
    extends bindings.Stub<WebSocketClient>
    implements WebSocketClient,
               WebSocketClientInterface,
               WebSocketClientInterfaceRequest {
  WebSocketClientStub.unbound([WebSocketClient impl])
      : super(new _WebSocketClientStubControl.unbound(impl));

  WebSocketClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [WebSocketClient impl])
      : super(new _WebSocketClientStubControl.fromEndpoint(endpoint, impl));

  WebSocketClientStub.fromHandle(
      core.MojoHandle handle, [WebSocketClient impl])
      : super(new _WebSocketClientStubControl.fromHandle(handle, impl));

  static WebSocketClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For WebSocketClientStub"));
    return new WebSocketClientStub.fromEndpoint(endpoint);
  }


  void didConnect(String selectedSubprotocol, String extensions, core.MojoDataPipeConsumer receiveStream) {
    return impl.didConnect(selectedSubprotocol, extensions, receiveStream);
  }
  void didReceiveData(bool fin, WebSocketMessageType type, int numBytes) {
    return impl.didReceiveData(fin, type, numBytes);
  }
  void didReceiveFlowControl(int quota) {
    return impl.didReceiveFlowControl(quota);
  }
  void didFail(String message) {
    return impl.didFail(message);
  }
  void didClose(bool wasClean, int code, String reason) {
    return impl.didClose(wasClean, code, reason);
  }
}



