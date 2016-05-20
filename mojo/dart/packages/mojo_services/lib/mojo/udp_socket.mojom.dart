// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library udp_socket_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/network_error.mojom.dart' as network_error_mojom;
import 'package:mojo_services/mojo/net_address.mojom.dart' as net_address_mojom;



class _UdpSocketAllowAddressReuseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _UdpSocketAllowAddressReuseParams() : super(kVersions.last.size);

  static _UdpSocketAllowAddressReuseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UdpSocketAllowAddressReuseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UdpSocketAllowAddressReuseParams result = new _UdpSocketAllowAddressReuseParams();

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
    return "_UdpSocketAllowAddressReuseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class UdpSocketAllowAddressReuseResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  UdpSocketAllowAddressReuseResponseParams() : super(kVersions.last.size);

  static UdpSocketAllowAddressReuseResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketAllowAddressReuseResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketAllowAddressReuseResponseParams result = new UdpSocketAllowAddressReuseResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct UdpSocketAllowAddressReuseResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UdpSocketAllowAddressReuseResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _UdpSocketBindParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  net_address_mojom.NetAddress addr = null;

  _UdpSocketBindParams() : super(kVersions.last.size);

  static _UdpSocketBindParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UdpSocketBindParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UdpSocketBindParams result = new _UdpSocketBindParams();

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
      result.addr = net_address_mojom.NetAddress.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(addr, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "addr of struct _UdpSocketBindParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UdpSocketBindParams("
           "addr: $addr" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["addr"] = addr;
    return map;
  }
}


class UdpSocketBindResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  network_error_mojom.NetworkError result = null;
  net_address_mojom.NetAddress boundAddr = null;
  UdpSocketReceiverInterfaceRequest receiver = null;

  UdpSocketBindResponseParams() : super(kVersions.last.size);

  static UdpSocketBindResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketBindResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketBindResponseParams result = new UdpSocketBindResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.boundAddr = net_address_mojom.NetAddress.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.receiver = decoder0.decodeInterfaceRequest(24, true, UdpSocketReceiverStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct UdpSocketBindResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(boundAddr, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "boundAddr of struct UdpSocketBindResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(receiver, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "receiver of struct UdpSocketBindResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UdpSocketBindResponseParams("
           "result: $result" ", "
           "boundAddr: $boundAddr" ", "
           "receiver: $receiver" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _UdpSocketConnectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  net_address_mojom.NetAddress remoteAddr = null;

  _UdpSocketConnectParams() : super(kVersions.last.size);

  static _UdpSocketConnectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UdpSocketConnectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UdpSocketConnectParams result = new _UdpSocketConnectParams();

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
      result.remoteAddr = net_address_mojom.NetAddress.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(remoteAddr, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "remoteAddr of struct _UdpSocketConnectParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UdpSocketConnectParams("
           "remoteAddr: $remoteAddr" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["remoteAddr"] = remoteAddr;
    return map;
  }
}


class UdpSocketConnectResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  network_error_mojom.NetworkError result = null;
  net_address_mojom.NetAddress localAddr = null;
  UdpSocketReceiverInterfaceRequest receiver = null;

  UdpSocketConnectResponseParams() : super(kVersions.last.size);

  static UdpSocketConnectResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketConnectResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketConnectResponseParams result = new UdpSocketConnectResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.localAddr = net_address_mojom.NetAddress.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.receiver = decoder0.decodeInterfaceRequest(24, true, UdpSocketReceiverStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct UdpSocketConnectResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(localAddr, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "localAddr of struct UdpSocketConnectResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(receiver, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "receiver of struct UdpSocketConnectResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UdpSocketConnectResponseParams("
           "result: $result" ", "
           "localAddr: $localAddr" ", "
           "receiver: $receiver" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _UdpSocketSetSendBufferSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int size = 0;

  _UdpSocketSetSendBufferSizeParams() : super(kVersions.last.size);

  static _UdpSocketSetSendBufferSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UdpSocketSetSendBufferSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UdpSocketSetSendBufferSizeParams result = new _UdpSocketSetSendBufferSizeParams();

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
      
      result.size = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(size, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "size of struct _UdpSocketSetSendBufferSizeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UdpSocketSetSendBufferSizeParams("
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["size"] = size;
    return map;
  }
}


class UdpSocketSetSendBufferSizeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  UdpSocketSetSendBufferSizeResponseParams() : super(kVersions.last.size);

  static UdpSocketSetSendBufferSizeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketSetSendBufferSizeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketSetSendBufferSizeResponseParams result = new UdpSocketSetSendBufferSizeResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct UdpSocketSetSendBufferSizeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UdpSocketSetSendBufferSizeResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _UdpSocketSetReceiveBufferSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int size = 0;

  _UdpSocketSetReceiveBufferSizeParams() : super(kVersions.last.size);

  static _UdpSocketSetReceiveBufferSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UdpSocketSetReceiveBufferSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UdpSocketSetReceiveBufferSizeParams result = new _UdpSocketSetReceiveBufferSizeParams();

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
      
      result.size = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(size, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "size of struct _UdpSocketSetReceiveBufferSizeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UdpSocketSetReceiveBufferSizeParams("
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["size"] = size;
    return map;
  }
}


class UdpSocketSetReceiveBufferSizeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  UdpSocketSetReceiveBufferSizeResponseParams() : super(kVersions.last.size);

  static UdpSocketSetReceiveBufferSizeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketSetReceiveBufferSizeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketSetReceiveBufferSizeResponseParams result = new UdpSocketSetReceiveBufferSizeResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct UdpSocketSetReceiveBufferSizeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UdpSocketSetReceiveBufferSizeResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _UdpSocketNegotiateMaxPendingSendRequestsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int requestedSize = 0;

  _UdpSocketNegotiateMaxPendingSendRequestsParams() : super(kVersions.last.size);

  static _UdpSocketNegotiateMaxPendingSendRequestsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UdpSocketNegotiateMaxPendingSendRequestsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UdpSocketNegotiateMaxPendingSendRequestsParams result = new _UdpSocketNegotiateMaxPendingSendRequestsParams();

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
      
      result.requestedSize = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(requestedSize, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "requestedSize of struct _UdpSocketNegotiateMaxPendingSendRequestsParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UdpSocketNegotiateMaxPendingSendRequestsParams("
           "requestedSize: $requestedSize" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["requestedSize"] = requestedSize;
    return map;
  }
}


class UdpSocketNegotiateMaxPendingSendRequestsResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int actualSize = 0;

  UdpSocketNegotiateMaxPendingSendRequestsResponseParams() : super(kVersions.last.size);

  static UdpSocketNegotiateMaxPendingSendRequestsResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketNegotiateMaxPendingSendRequestsResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketNegotiateMaxPendingSendRequestsResponseParams result = new UdpSocketNegotiateMaxPendingSendRequestsResponseParams();

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
      
      result.actualSize = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(actualSize, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "actualSize of struct UdpSocketNegotiateMaxPendingSendRequestsResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UdpSocketNegotiateMaxPendingSendRequestsResponseParams("
           "actualSize: $actualSize" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["actualSize"] = actualSize;
    return map;
  }
}


class _UdpSocketReceiveMoreParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int datagramNumber = 0;

  _UdpSocketReceiveMoreParams() : super(kVersions.last.size);

  static _UdpSocketReceiveMoreParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UdpSocketReceiveMoreParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UdpSocketReceiveMoreParams result = new _UdpSocketReceiveMoreParams();

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
      
      result.datagramNumber = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(datagramNumber, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "datagramNumber of struct _UdpSocketReceiveMoreParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UdpSocketReceiveMoreParams("
           "datagramNumber: $datagramNumber" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["datagramNumber"] = datagramNumber;
    return map;
  }
}


class _UdpSocketSendToParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  net_address_mojom.NetAddress destAddr = null;
  List<int> data = null;

  _UdpSocketSendToParams() : super(kVersions.last.size);

  static _UdpSocketSendToParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UdpSocketSendToParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UdpSocketSendToParams result = new _UdpSocketSendToParams();

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
      result.destAddr = net_address_mojom.NetAddress.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.data = decoder0.decodeUint8Array(16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(destAddr, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "destAddr of struct _UdpSocketSendToParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(data, 16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "data of struct _UdpSocketSendToParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UdpSocketSendToParams("
           "destAddr: $destAddr" ", "
           "data: $data" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["destAddr"] = destAddr;
    map["data"] = data;
    return map;
  }
}


class UdpSocketSendToResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  UdpSocketSendToResponseParams() : super(kVersions.last.size);

  static UdpSocketSendToResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UdpSocketSendToResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UdpSocketSendToResponseParams result = new UdpSocketSendToResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct UdpSocketSendToResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UdpSocketSendToResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _UdpSocketReceiverOnReceivedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  network_error_mojom.NetworkError result = null;
  net_address_mojom.NetAddress srcAddr = null;
  List<int> data = null;

  _UdpSocketReceiverOnReceivedParams() : super(kVersions.last.size);

  static _UdpSocketReceiverOnReceivedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UdpSocketReceiverOnReceivedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UdpSocketReceiverOnReceivedParams result = new _UdpSocketReceiverOnReceivedParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.srcAddr = net_address_mojom.NetAddress.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.data = decoder0.decodeUint8Array(24, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct _UdpSocketReceiverOnReceivedParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(srcAddr, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "srcAddr of struct _UdpSocketReceiverOnReceivedParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(data, 24, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "data of struct _UdpSocketReceiverOnReceivedParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UdpSocketReceiverOnReceivedParams("
           "result: $result" ", "
           "srcAddr: $srcAddr" ", "
           "data: $data" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    map["srcAddr"] = srcAddr;
    map["data"] = data;
    return map;
  }
}

const int _udpSocketMethodAllowAddressReuseName = 0;
const int _udpSocketMethodBindName = 1;
const int _udpSocketMethodConnectName = 2;
const int _udpSocketMethodSetSendBufferSizeName = 3;
const int _udpSocketMethodSetReceiveBufferSizeName = 4;
const int _udpSocketMethodNegotiateMaxPendingSendRequestsName = 5;
const int _udpSocketMethodReceiveMoreName = 6;
const int _udpSocketMethodSendToName = 7;

class _UdpSocketServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class UdpSocket {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _UdpSocketServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static UdpSocketProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    UdpSocketProxy p = new UdpSocketProxy.unbound();
    String name = serviceName ?? UdpSocket.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic allowAddressReuse([Function responseFactory = null]);
  dynamic bind(net_address_mojom.NetAddress addr,[Function responseFactory = null]);
  dynamic connect(net_address_mojom.NetAddress remoteAddr,[Function responseFactory = null]);
  dynamic setSendBufferSize(int size,[Function responseFactory = null]);
  dynamic setReceiveBufferSize(int size,[Function responseFactory = null]);
  dynamic negotiateMaxPendingSendRequests(int requestedSize,[Function responseFactory = null]);
  void receiveMore(int datagramNumber);
  dynamic sendTo(net_address_mojom.NetAddress destAddr,List<int> data,[Function responseFactory = null]);
}

abstract class UdpSocketInterface
    implements bindings.MojoInterface<UdpSocket>,
               UdpSocket {
  factory UdpSocketInterface([UdpSocket impl]) =>
      new UdpSocketStub.unbound(impl);
  factory UdpSocketInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [UdpSocket impl]) =>
      new UdpSocketStub.fromEndpoint(endpoint, impl);
}

abstract class UdpSocketInterfaceRequest
    implements bindings.MojoInterface<UdpSocket>,
               UdpSocket {
  factory UdpSocketInterfaceRequest() =>
      new UdpSocketProxy.unbound();
}

class _UdpSocketProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<UdpSocket> {
  _UdpSocketProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _UdpSocketProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _UdpSocketProxyControl.unbound() : super.unbound();

  String get serviceName => UdpSocket.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _udpSocketMethodAllowAddressReuseName:
        var r = UdpSocketAllowAddressReuseResponseParams.deserialize(
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
      case _udpSocketMethodBindName:
        var r = UdpSocketBindResponseParams.deserialize(
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
      case _udpSocketMethodConnectName:
        var r = UdpSocketConnectResponseParams.deserialize(
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
      case _udpSocketMethodSetSendBufferSizeName:
        var r = UdpSocketSetSendBufferSizeResponseParams.deserialize(
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
      case _udpSocketMethodSetReceiveBufferSizeName:
        var r = UdpSocketSetReceiveBufferSizeResponseParams.deserialize(
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
      case _udpSocketMethodNegotiateMaxPendingSendRequestsName:
        var r = UdpSocketNegotiateMaxPendingSendRequestsResponseParams.deserialize(
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
      case _udpSocketMethodSendToName:
        var r = UdpSocketSendToResponseParams.deserialize(
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

  UdpSocket get impl => null;
  set impl(UdpSocket _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_UdpSocketProxyControl($superString)";
  }
}

class UdpSocketProxy
    extends bindings.Proxy<UdpSocket>
    implements UdpSocket,
               UdpSocketInterface,
               UdpSocketInterfaceRequest {
  UdpSocketProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _UdpSocketProxyControl.fromEndpoint(endpoint));

  UdpSocketProxy.fromHandle(core.MojoHandle handle)
      : super(new _UdpSocketProxyControl.fromHandle(handle));

  UdpSocketProxy.unbound()
      : super(new _UdpSocketProxyControl.unbound());

  static UdpSocketProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UdpSocketProxy"));
    return new UdpSocketProxy.fromEndpoint(endpoint);
  }


  dynamic allowAddressReuse([Function responseFactory = null]) {
    var params = new _UdpSocketAllowAddressReuseParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _udpSocketMethodAllowAddressReuseName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic bind(net_address_mojom.NetAddress addr,[Function responseFactory = null]) {
    var params = new _UdpSocketBindParams();
    params.addr = addr;
    return ctrl.sendMessageWithRequestId(
        params,
        _udpSocketMethodBindName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic connect(net_address_mojom.NetAddress remoteAddr,[Function responseFactory = null]) {
    var params = new _UdpSocketConnectParams();
    params.remoteAddr = remoteAddr;
    return ctrl.sendMessageWithRequestId(
        params,
        _udpSocketMethodConnectName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic setSendBufferSize(int size,[Function responseFactory = null]) {
    var params = new _UdpSocketSetSendBufferSizeParams();
    params.size = size;
    return ctrl.sendMessageWithRequestId(
        params,
        _udpSocketMethodSetSendBufferSizeName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic setReceiveBufferSize(int size,[Function responseFactory = null]) {
    var params = new _UdpSocketSetReceiveBufferSizeParams();
    params.size = size;
    return ctrl.sendMessageWithRequestId(
        params,
        _udpSocketMethodSetReceiveBufferSizeName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic negotiateMaxPendingSendRequests(int requestedSize,[Function responseFactory = null]) {
    var params = new _UdpSocketNegotiateMaxPendingSendRequestsParams();
    params.requestedSize = requestedSize;
    return ctrl.sendMessageWithRequestId(
        params,
        _udpSocketMethodNegotiateMaxPendingSendRequestsName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void receiveMore(int datagramNumber) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _UdpSocketReceiveMoreParams();
    params.datagramNumber = datagramNumber;
    ctrl.sendMessage(params,
        _udpSocketMethodReceiveMoreName);
  }
  dynamic sendTo(net_address_mojom.NetAddress destAddr,List<int> data,[Function responseFactory = null]) {
    var params = new _UdpSocketSendToParams();
    params.destAddr = destAddr;
    params.data = data;
    return ctrl.sendMessageWithRequestId(
        params,
        _udpSocketMethodSendToName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _UdpSocketStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<UdpSocket> {
  UdpSocket _impl;

  _UdpSocketStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [UdpSocket impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _UdpSocketStubControl.fromHandle(
      core.MojoHandle handle, [UdpSocket impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _UdpSocketStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => UdpSocket.serviceName;


  UdpSocketAllowAddressReuseResponseParams _udpSocketAllowAddressReuseResponseParamsFactory(network_error_mojom.NetworkError result) {
    var result = new UdpSocketAllowAddressReuseResponseParams();
    result.result = result;
    return result;
  }
  UdpSocketBindResponseParams _udpSocketBindResponseParamsFactory(network_error_mojom.NetworkError result, net_address_mojom.NetAddress boundAddr, UdpSocketReceiverInterfaceRequest receiver) {
    var result = new UdpSocketBindResponseParams();
    result.result = result;
    result.boundAddr = boundAddr;
    result.receiver = receiver;
    return result;
  }
  UdpSocketConnectResponseParams _udpSocketConnectResponseParamsFactory(network_error_mojom.NetworkError result, net_address_mojom.NetAddress localAddr, UdpSocketReceiverInterfaceRequest receiver) {
    var result = new UdpSocketConnectResponseParams();
    result.result = result;
    result.localAddr = localAddr;
    result.receiver = receiver;
    return result;
  }
  UdpSocketSetSendBufferSizeResponseParams _udpSocketSetSendBufferSizeResponseParamsFactory(network_error_mojom.NetworkError result) {
    var result = new UdpSocketSetSendBufferSizeResponseParams();
    result.result = result;
    return result;
  }
  UdpSocketSetReceiveBufferSizeResponseParams _udpSocketSetReceiveBufferSizeResponseParamsFactory(network_error_mojom.NetworkError result) {
    var result = new UdpSocketSetReceiveBufferSizeResponseParams();
    result.result = result;
    return result;
  }
  UdpSocketNegotiateMaxPendingSendRequestsResponseParams _udpSocketNegotiateMaxPendingSendRequestsResponseParamsFactory(int actualSize) {
    var result = new UdpSocketNegotiateMaxPendingSendRequestsResponseParams();
    result.actualSize = actualSize;
    return result;
  }
  UdpSocketSendToResponseParams _udpSocketSendToResponseParamsFactory(network_error_mojom.NetworkError result) {
    var result = new UdpSocketSendToResponseParams();
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
      case _udpSocketMethodAllowAddressReuseName:
        var response = _impl.allowAddressReuse(_udpSocketAllowAddressReuseResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _udpSocketMethodAllowAddressReuseName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _udpSocketMethodAllowAddressReuseName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _udpSocketMethodBindName:
        var params = _UdpSocketBindParams.deserialize(
            message.payload);
        var response = _impl.bind(params.addr,_udpSocketBindResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _udpSocketMethodBindName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _udpSocketMethodBindName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _udpSocketMethodConnectName:
        var params = _UdpSocketConnectParams.deserialize(
            message.payload);
        var response = _impl.connect(params.remoteAddr,_udpSocketConnectResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _udpSocketMethodConnectName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _udpSocketMethodConnectName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _udpSocketMethodSetSendBufferSizeName:
        var params = _UdpSocketSetSendBufferSizeParams.deserialize(
            message.payload);
        var response = _impl.setSendBufferSize(params.size,_udpSocketSetSendBufferSizeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _udpSocketMethodSetSendBufferSizeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _udpSocketMethodSetSendBufferSizeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _udpSocketMethodSetReceiveBufferSizeName:
        var params = _UdpSocketSetReceiveBufferSizeParams.deserialize(
            message.payload);
        var response = _impl.setReceiveBufferSize(params.size,_udpSocketSetReceiveBufferSizeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _udpSocketMethodSetReceiveBufferSizeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _udpSocketMethodSetReceiveBufferSizeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _udpSocketMethodNegotiateMaxPendingSendRequestsName:
        var params = _UdpSocketNegotiateMaxPendingSendRequestsParams.deserialize(
            message.payload);
        var response = _impl.negotiateMaxPendingSendRequests(params.requestedSize,_udpSocketNegotiateMaxPendingSendRequestsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _udpSocketMethodNegotiateMaxPendingSendRequestsName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _udpSocketMethodNegotiateMaxPendingSendRequestsName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _udpSocketMethodReceiveMoreName:
        var params = _UdpSocketReceiveMoreParams.deserialize(
            message.payload);
        _impl.receiveMore(params.datagramNumber);
        break;
      case _udpSocketMethodSendToName:
        var params = _UdpSocketSendToParams.deserialize(
            message.payload);
        var response = _impl.sendTo(params.destAddr,params.data,_udpSocketSendToResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _udpSocketMethodSendToName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _udpSocketMethodSendToName,
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

  UdpSocket get impl => _impl;
  set impl(UdpSocket d) {
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
    return "_UdpSocketStubControl($superString)";
  }

  int get version => 0;
}

class UdpSocketStub
    extends bindings.Stub<UdpSocket>
    implements UdpSocket,
               UdpSocketInterface,
               UdpSocketInterfaceRequest {
  UdpSocketStub.unbound([UdpSocket impl])
      : super(new _UdpSocketStubControl.unbound(impl));

  UdpSocketStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [UdpSocket impl])
      : super(new _UdpSocketStubControl.fromEndpoint(endpoint, impl));

  UdpSocketStub.fromHandle(
      core.MojoHandle handle, [UdpSocket impl])
      : super(new _UdpSocketStubControl.fromHandle(handle, impl));

  static UdpSocketStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UdpSocketStub"));
    return new UdpSocketStub.fromEndpoint(endpoint);
  }


  dynamic allowAddressReuse([Function responseFactory = null]) {
    return impl.allowAddressReuse(responseFactory);
  }
  dynamic bind(net_address_mojom.NetAddress addr,[Function responseFactory = null]) {
    return impl.bind(addr,responseFactory);
  }
  dynamic connect(net_address_mojom.NetAddress remoteAddr,[Function responseFactory = null]) {
    return impl.connect(remoteAddr,responseFactory);
  }
  dynamic setSendBufferSize(int size,[Function responseFactory = null]) {
    return impl.setSendBufferSize(size,responseFactory);
  }
  dynamic setReceiveBufferSize(int size,[Function responseFactory = null]) {
    return impl.setReceiveBufferSize(size,responseFactory);
  }
  dynamic negotiateMaxPendingSendRequests(int requestedSize,[Function responseFactory = null]) {
    return impl.negotiateMaxPendingSendRequests(requestedSize,responseFactory);
  }
  void receiveMore(int datagramNumber) {
    return impl.receiveMore(datagramNumber);
  }
  dynamic sendTo(net_address_mojom.NetAddress destAddr,List<int> data,[Function responseFactory = null]) {
    return impl.sendTo(destAddr,data,responseFactory);
  }
}

const int _udpSocketReceiverMethodOnReceivedName = 0;

class _UdpSocketReceiverServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class UdpSocketReceiver {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _UdpSocketReceiverServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static UdpSocketReceiverProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    UdpSocketReceiverProxy p = new UdpSocketReceiverProxy.unbound();
    String name = serviceName ?? UdpSocketReceiver.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void onReceived(network_error_mojom.NetworkError result, net_address_mojom.NetAddress srcAddr, List<int> data);
}

abstract class UdpSocketReceiverInterface
    implements bindings.MojoInterface<UdpSocketReceiver>,
               UdpSocketReceiver {
  factory UdpSocketReceiverInterface([UdpSocketReceiver impl]) =>
      new UdpSocketReceiverStub.unbound(impl);
  factory UdpSocketReceiverInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [UdpSocketReceiver impl]) =>
      new UdpSocketReceiverStub.fromEndpoint(endpoint, impl);
}

abstract class UdpSocketReceiverInterfaceRequest
    implements bindings.MojoInterface<UdpSocketReceiver>,
               UdpSocketReceiver {
  factory UdpSocketReceiverInterfaceRequest() =>
      new UdpSocketReceiverProxy.unbound();
}

class _UdpSocketReceiverProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<UdpSocketReceiver> {
  _UdpSocketReceiverProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _UdpSocketReceiverProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _UdpSocketReceiverProxyControl.unbound() : super.unbound();

  String get serviceName => UdpSocketReceiver.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  UdpSocketReceiver get impl => null;
  set impl(UdpSocketReceiver _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_UdpSocketReceiverProxyControl($superString)";
  }
}

class UdpSocketReceiverProxy
    extends bindings.Proxy<UdpSocketReceiver>
    implements UdpSocketReceiver,
               UdpSocketReceiverInterface,
               UdpSocketReceiverInterfaceRequest {
  UdpSocketReceiverProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _UdpSocketReceiverProxyControl.fromEndpoint(endpoint));

  UdpSocketReceiverProxy.fromHandle(core.MojoHandle handle)
      : super(new _UdpSocketReceiverProxyControl.fromHandle(handle));

  UdpSocketReceiverProxy.unbound()
      : super(new _UdpSocketReceiverProxyControl.unbound());

  static UdpSocketReceiverProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UdpSocketReceiverProxy"));
    return new UdpSocketReceiverProxy.fromEndpoint(endpoint);
  }


  void onReceived(network_error_mojom.NetworkError result, net_address_mojom.NetAddress srcAddr, List<int> data) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _UdpSocketReceiverOnReceivedParams();
    params.result = result;
    params.srcAddr = srcAddr;
    params.data = data;
    ctrl.sendMessage(params,
        _udpSocketReceiverMethodOnReceivedName);
  }
}

class _UdpSocketReceiverStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<UdpSocketReceiver> {
  UdpSocketReceiver _impl;

  _UdpSocketReceiverStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [UdpSocketReceiver impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _UdpSocketReceiverStubControl.fromHandle(
      core.MojoHandle handle, [UdpSocketReceiver impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _UdpSocketReceiverStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => UdpSocketReceiver.serviceName;



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
      case _udpSocketReceiverMethodOnReceivedName:
        var params = _UdpSocketReceiverOnReceivedParams.deserialize(
            message.payload);
        _impl.onReceived(params.result, params.srcAddr, params.data);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  UdpSocketReceiver get impl => _impl;
  set impl(UdpSocketReceiver d) {
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
    return "_UdpSocketReceiverStubControl($superString)";
  }

  int get version => 0;
}

class UdpSocketReceiverStub
    extends bindings.Stub<UdpSocketReceiver>
    implements UdpSocketReceiver,
               UdpSocketReceiverInterface,
               UdpSocketReceiverInterfaceRequest {
  UdpSocketReceiverStub.unbound([UdpSocketReceiver impl])
      : super(new _UdpSocketReceiverStubControl.unbound(impl));

  UdpSocketReceiverStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [UdpSocketReceiver impl])
      : super(new _UdpSocketReceiverStubControl.fromEndpoint(endpoint, impl));

  UdpSocketReceiverStub.fromHandle(
      core.MojoHandle handle, [UdpSocketReceiver impl])
      : super(new _UdpSocketReceiverStubControl.fromHandle(handle, impl));

  static UdpSocketReceiverStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UdpSocketReceiverStub"));
    return new UdpSocketReceiverStub.fromEndpoint(endpoint);
  }


  void onReceived(network_error_mojom.NetworkError result, net_address_mojom.NetAddress srcAddr, List<int> data) {
    return impl.onReceived(result, srcAddr, data);
  }
}



