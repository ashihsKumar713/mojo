// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library sample_interfaces_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
const int kLong = 4405;

class Enum extends bindings.MojoEnum {
  static const Enum value = const Enum._(0);

  const Enum._(int v) : super(v);

  static const Map<String, Enum> valuesMap = const {
    "value": value,
  };
  static const List<Enum> values = const [
    value,
  ];

  static Enum valueOf(String name) => valuesMap[name];

  factory Enum(int v) {
    switch (v) {
      case 0:
        return Enum.value;
      default:
        return null;
    }
  }

  static Enum decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Enum result = new Enum(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Enum.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case value:
        return 'Enum.value';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class _ProviderEchoStringParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String a = null;

  _ProviderEchoStringParams() : super(kVersions.last.size);

  static _ProviderEchoStringParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoStringParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoStringParams result = new _ProviderEchoStringParams();

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
      
      result.a = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct _ProviderEchoStringParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoStringParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class ProviderEchoStringResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String a = null;

  ProviderEchoStringResponseParams() : super(kVersions.last.size);

  static ProviderEchoStringResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoStringResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoStringResponseParams result = new ProviderEchoStringResponseParams();

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
      
      result.a = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct ProviderEchoStringResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoStringResponseParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class _ProviderEchoStringsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String a = null;
  String b = null;

  _ProviderEchoStringsParams() : super(kVersions.last.size);

  static _ProviderEchoStringsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoStringsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoStringsParams result = new _ProviderEchoStringsParams();

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
      
      result.a = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.b = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct _ProviderEchoStringsParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(b, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "b of struct _ProviderEchoStringsParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoStringsParams("
           "a: $a" ", "
           "b: $b" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    map["b"] = b;
    return map;
  }
}


class ProviderEchoStringsResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String a = null;
  String b = null;

  ProviderEchoStringsResponseParams() : super(kVersions.last.size);

  static ProviderEchoStringsResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoStringsResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoStringsResponseParams result = new ProviderEchoStringsResponseParams();

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
      
      result.a = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.b = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct ProviderEchoStringsResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(b, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "b of struct ProviderEchoStringsResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoStringsResponseParams("
           "a: $a" ", "
           "b: $b" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    map["b"] = b;
    return map;
  }
}


class _ProviderEchoMessagePipeHandleParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoMessagePipeEndpoint a = null;

  _ProviderEchoMessagePipeHandleParams() : super(kVersions.last.size);

  static _ProviderEchoMessagePipeHandleParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoMessagePipeHandleParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoMessagePipeHandleParams result = new _ProviderEchoMessagePipeHandleParams();

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
      
      result.a = decoder0.decodeMessagePipeHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeMessagePipeHandle(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct _ProviderEchoMessagePipeHandleParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoMessagePipeHandleParams("
           "a: $a" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ProviderEchoMessagePipeHandleResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoMessagePipeEndpoint a = null;

  ProviderEchoMessagePipeHandleResponseParams() : super(kVersions.last.size);

  static ProviderEchoMessagePipeHandleResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoMessagePipeHandleResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoMessagePipeHandleResponseParams result = new ProviderEchoMessagePipeHandleResponseParams();

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
      
      result.a = decoder0.decodeMessagePipeHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeMessagePipeHandle(a, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct ProviderEchoMessagePipeHandleResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoMessagePipeHandleResponseParams("
           "a: $a" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ProviderEchoEnumParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Enum a = null;

  _ProviderEchoEnumParams() : super(kVersions.last.size);

  static _ProviderEchoEnumParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoEnumParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoEnumParams result = new _ProviderEchoEnumParams();

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
      
        result.a = Enum.decode(decoder0, 8);
        if (result.a == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(a, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct _ProviderEchoEnumParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoEnumParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class ProviderEchoEnumResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Enum a = null;

  ProviderEchoEnumResponseParams() : super(kVersions.last.size);

  static ProviderEchoEnumResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoEnumResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoEnumResponseParams result = new ProviderEchoEnumResponseParams();

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
      
        result.a = Enum.decode(decoder0, 8);
        if (result.a == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(a, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct ProviderEchoEnumResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoEnumResponseParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class _ProviderEchoIntParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int a = 0;

  _ProviderEchoIntParams() : super(kVersions.last.size);

  static _ProviderEchoIntParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProviderEchoIntParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProviderEchoIntParams result = new _ProviderEchoIntParams();

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
      
      result.a = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(a, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct _ProviderEchoIntParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProviderEchoIntParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class ProviderEchoIntResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int a = 0;

  ProviderEchoIntResponseParams() : super(kVersions.last.size);

  static ProviderEchoIntResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProviderEchoIntResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProviderEchoIntResponseParams result = new ProviderEchoIntResponseParams();

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
      
      result.a = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(a, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "a of struct ProviderEchoIntResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProviderEchoIntResponseParams("
           "a: $a" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["a"] = a;
    return map;
  }
}


class _IntegerAccessorGetIntegerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _IntegerAccessorGetIntegerParams() : super(kVersions.last.size);

  static _IntegerAccessorGetIntegerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _IntegerAccessorGetIntegerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _IntegerAccessorGetIntegerParams result = new _IntegerAccessorGetIntegerParams();

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
    return "_IntegerAccessorGetIntegerParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class IntegerAccessorGetIntegerResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 2)
  ];
  int data = 0;
  Enum type = null;

  IntegerAccessorGetIntegerResponseParams() : super(kVersions.last.size);

  static IntegerAccessorGetIntegerResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static IntegerAccessorGetIntegerResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    IntegerAccessorGetIntegerResponseParams result = new IntegerAccessorGetIntegerResponseParams();

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
      
      result.data = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 2) {
      
        result.type = Enum.decode(decoder0, 16);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(data, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "data of struct IntegerAccessorGetIntegerResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(type, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "type of struct IntegerAccessorGetIntegerResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "IntegerAccessorGetIntegerResponseParams("
           "data: $data" ", "
           "type: $type" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["data"] = data;
    map["type"] = type;
    return map;
  }
}


class _IntegerAccessorSetIntegerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 3)
  ];
  int data = 0;
  Enum type = null;

  _IntegerAccessorSetIntegerParams() : super(kVersions.last.size);

  static _IntegerAccessorSetIntegerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _IntegerAccessorSetIntegerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _IntegerAccessorSetIntegerParams result = new _IntegerAccessorSetIntegerParams();

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
      
      result.data = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 3) {
      
        result.type = Enum.decode(decoder0, 16);
        if (result.type == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(data, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "data of struct _IntegerAccessorSetIntegerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(type, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "type of struct _IntegerAccessorSetIntegerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_IntegerAccessorSetIntegerParams("
           "data: $data" ", "
           "type: $type" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["data"] = data;
    map["type"] = type;
    return map;
  }
}


class _SampleInterfaceSampleMethod1Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int in1 = 0;
  String in2 = null;

  _SampleInterfaceSampleMethod1Params() : super(kVersions.last.size);

  static _SampleInterfaceSampleMethod1Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SampleInterfaceSampleMethod1Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SampleInterfaceSampleMethod1Params result = new _SampleInterfaceSampleMethod1Params();

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
      
      result.in1 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.in2 = decoder0.decodeString(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(in1, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "in1 of struct _SampleInterfaceSampleMethod1Params: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(in2, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "in2 of struct _SampleInterfaceSampleMethod1Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SampleInterfaceSampleMethod1Params("
           "in1: $in1" ", "
           "in2: $in2" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["in1"] = in1;
    map["in2"] = in2;
    return map;
  }
}


class SampleInterfaceSampleMethod1ResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String out1 = null;
  Enum out2 = null;

  SampleInterfaceSampleMethod1ResponseParams() : super(kVersions.last.size);

  static SampleInterfaceSampleMethod1ResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SampleInterfaceSampleMethod1ResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SampleInterfaceSampleMethod1ResponseParams result = new SampleInterfaceSampleMethod1ResponseParams();

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
      
      result.out1 = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
        result.out2 = Enum.decode(decoder0, 16);
        if (result.out2 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Enum.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(out1, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "out1 of struct SampleInterfaceSampleMethod1ResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(out2, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "out2 of struct SampleInterfaceSampleMethod1ResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "SampleInterfaceSampleMethod1ResponseParams("
           "out1: $out1" ", "
           "out2: $out2" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["out1"] = out1;
    map["out2"] = out2;
    return map;
  }
}


class _SampleInterfaceSampleMethod0Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SampleInterfaceSampleMethod0Params() : super(kVersions.last.size);

  static _SampleInterfaceSampleMethod0Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SampleInterfaceSampleMethod0Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SampleInterfaceSampleMethod0Params result = new _SampleInterfaceSampleMethod0Params();

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
    return "_SampleInterfaceSampleMethod0Params("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _SampleInterfaceSampleMethod2Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SampleInterfaceSampleMethod2Params() : super(kVersions.last.size);

  static _SampleInterfaceSampleMethod2Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SampleInterfaceSampleMethod2Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SampleInterfaceSampleMethod2Params result = new _SampleInterfaceSampleMethod2Params();

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
    return "_SampleInterfaceSampleMethod2Params("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _providerMethodEchoStringName = 0;
const int _providerMethodEchoStringsName = 1;
const int _providerMethodEchoMessagePipeHandleName = 2;
const int _providerMethodEchoEnumName = 3;
const int _providerMethodEchoIntName = 4;

class _ProviderServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Provider {
  static const String serviceName = null;
  dynamic echoString(String a,[Function responseFactory = null]);
  dynamic echoStrings(String a,String b,[Function responseFactory = null]);
  dynamic echoMessagePipeHandle(core.MojoMessagePipeEndpoint a,[Function responseFactory = null]);
  dynamic echoEnum(Enum a,[Function responseFactory = null]);
  dynamic echoInt(int a,[Function responseFactory = null]);
}

class _ProviderProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _ProviderProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ProviderProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ProviderProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _ProviderServiceDescription();

  String get serviceName => Provider.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _providerMethodEchoStringName:
        var r = ProviderEchoStringResponseParams.deserialize(
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
      case _providerMethodEchoStringsName:
        var r = ProviderEchoStringsResponseParams.deserialize(
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
      case _providerMethodEchoMessagePipeHandleName:
        var r = ProviderEchoMessagePipeHandleResponseParams.deserialize(
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
      case _providerMethodEchoEnumName:
        var r = ProviderEchoEnumResponseParams.deserialize(
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
      case _providerMethodEchoIntName:
        var r = ProviderEchoIntResponseParams.deserialize(
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
    return "_ProviderProxyControl($superString)";
  }
}

class ProviderProxy
    extends bindings.Proxy
    implements Provider {
  ProviderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _ProviderProxyControl.fromEndpoint(endpoint));

  ProviderProxy.fromHandle(core.MojoHandle handle)
      : super(new _ProviderProxyControl.fromHandle(handle));

  ProviderProxy.unbound()
      : super(new _ProviderProxyControl.unbound());

  static ProviderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProviderProxy"));
    return new ProviderProxy.fromEndpoint(endpoint);
  }

  factory ProviderProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ProviderProxy p = new ProviderProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic echoString(String a,[Function responseFactory = null]) {
    var params = new _ProviderEchoStringParams();
    params.a = a;
    return ctrl.sendMessageWithRequestId(
        params,
        _providerMethodEchoStringName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic echoStrings(String a,String b,[Function responseFactory = null]) {
    var params = new _ProviderEchoStringsParams();
    params.a = a;
    params.b = b;
    return ctrl.sendMessageWithRequestId(
        params,
        _providerMethodEchoStringsName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic echoMessagePipeHandle(core.MojoMessagePipeEndpoint a,[Function responseFactory = null]) {
    var params = new _ProviderEchoMessagePipeHandleParams();
    params.a = a;
    return ctrl.sendMessageWithRequestId(
        params,
        _providerMethodEchoMessagePipeHandleName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic echoEnum(Enum a,[Function responseFactory = null]) {
    var params = new _ProviderEchoEnumParams();
    params.a = a;
    return ctrl.sendMessageWithRequestId(
        params,
        _providerMethodEchoEnumName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic echoInt(int a,[Function responseFactory = null]) {
    var params = new _ProviderEchoIntParams();
    params.a = a;
    return ctrl.sendMessageWithRequestId(
        params,
        _providerMethodEchoIntName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _ProviderStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<Provider> {
  Provider _impl;

  _ProviderStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Provider impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _ProviderStubControl.fromHandle(
      core.MojoHandle handle, [Provider impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _ProviderStubControl.unbound([this._impl]) : super.unbound();


  ProviderEchoStringResponseParams _providerEchoStringResponseParamsFactory(String a) {
    var result = new ProviderEchoStringResponseParams();
    result.a = a;
    return result;
  }
  ProviderEchoStringsResponseParams _providerEchoStringsResponseParamsFactory(String a, String b) {
    var result = new ProviderEchoStringsResponseParams();
    result.a = a;
    result.b = b;
    return result;
  }
  ProviderEchoMessagePipeHandleResponseParams _providerEchoMessagePipeHandleResponseParamsFactory(core.MojoMessagePipeEndpoint a) {
    var result = new ProviderEchoMessagePipeHandleResponseParams();
    result.a = a;
    return result;
  }
  ProviderEchoEnumResponseParams _providerEchoEnumResponseParamsFactory(Enum a) {
    var result = new ProviderEchoEnumResponseParams();
    result.a = a;
    return result;
  }
  ProviderEchoIntResponseParams _providerEchoIntResponseParamsFactory(int a) {
    var result = new ProviderEchoIntResponseParams();
    result.a = a;
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
      case _providerMethodEchoStringName:
        var params = _ProviderEchoStringParams.deserialize(
            message.payload);
        var response = _impl.echoString(params.a,_providerEchoStringResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _providerMethodEchoStringName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _providerMethodEchoStringName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _providerMethodEchoStringsName:
        var params = _ProviderEchoStringsParams.deserialize(
            message.payload);
        var response = _impl.echoStrings(params.a,params.b,_providerEchoStringsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _providerMethodEchoStringsName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _providerMethodEchoStringsName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _providerMethodEchoMessagePipeHandleName:
        var params = _ProviderEchoMessagePipeHandleParams.deserialize(
            message.payload);
        var response = _impl.echoMessagePipeHandle(params.a,_providerEchoMessagePipeHandleResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _providerMethodEchoMessagePipeHandleName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _providerMethodEchoMessagePipeHandleName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _providerMethodEchoEnumName:
        var params = _ProviderEchoEnumParams.deserialize(
            message.payload);
        var response = _impl.echoEnum(params.a,_providerEchoEnumResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _providerMethodEchoEnumName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _providerMethodEchoEnumName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _providerMethodEchoIntName:
        var params = _ProviderEchoIntParams.deserialize(
            message.payload);
        var response = _impl.echoInt(params.a,_providerEchoIntResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _providerMethodEchoIntName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _providerMethodEchoIntName,
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

  Provider get impl => _impl;
  set impl(Provider d) {
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
    return "_ProviderStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ProviderServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class ProviderStub
    extends bindings.Stub<Provider>
    implements Provider {
  ProviderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Provider impl])
      : super(new _ProviderStubControl.fromEndpoint(endpoint, impl));

  ProviderStub.fromHandle(
      core.MojoHandle handle, [Provider impl])
      : super(new _ProviderStubControl.fromHandle(handle, impl));

  ProviderStub.unbound([Provider impl])
      : super(new _ProviderStubControl.unbound(impl));

  static ProviderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProviderStub"));
    return new ProviderStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _ProviderStubControl.serviceDescription;


  dynamic echoString(String a,[Function responseFactory = null]) {
    return impl.echoString(a,responseFactory);
  }
  dynamic echoStrings(String a,String b,[Function responseFactory = null]) {
    return impl.echoStrings(a,b,responseFactory);
  }
  dynamic echoMessagePipeHandle(core.MojoMessagePipeEndpoint a,[Function responseFactory = null]) {
    return impl.echoMessagePipeHandle(a,responseFactory);
  }
  dynamic echoEnum(Enum a,[Function responseFactory = null]) {
    return impl.echoEnum(a,responseFactory);
  }
  dynamic echoInt(int a,[Function responseFactory = null]) {
    return impl.echoInt(a,responseFactory);
  }
}

const int _integerAccessorMethodGetIntegerName = 0;
const int _integerAccessorMethodSetIntegerName = 1;

class _IntegerAccessorServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class IntegerAccessor {
  static const String serviceName = null;
  dynamic getInteger([Function responseFactory = null]);
  void setInteger(int data, Enum type);
}

class _IntegerAccessorProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _IntegerAccessorProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _IntegerAccessorProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _IntegerAccessorProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _IntegerAccessorServiceDescription();

  String get serviceName => IntegerAccessor.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _integerAccessorMethodGetIntegerName:
        var r = IntegerAccessorGetIntegerResponseParams.deserialize(
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
    return "_IntegerAccessorProxyControl($superString)";
  }
}

class IntegerAccessorProxy
    extends bindings.Proxy
    implements IntegerAccessor {
  IntegerAccessorProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _IntegerAccessorProxyControl.fromEndpoint(endpoint));

  IntegerAccessorProxy.fromHandle(core.MojoHandle handle)
      : super(new _IntegerAccessorProxyControl.fromHandle(handle));

  IntegerAccessorProxy.unbound()
      : super(new _IntegerAccessorProxyControl.unbound());

  static IntegerAccessorProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For IntegerAccessorProxy"));
    return new IntegerAccessorProxy.fromEndpoint(endpoint);
  }

  factory IntegerAccessorProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    IntegerAccessorProxy p = new IntegerAccessorProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic getInteger([Function responseFactory = null]) {
    var params = new _IntegerAccessorGetIntegerParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _integerAccessorMethodGetIntegerName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void setInteger(int data, Enum type) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _IntegerAccessorSetIntegerParams();
    params.data = data;
    params.type = type;
    ctrl.sendMessage(params,
        _integerAccessorMethodSetIntegerName);
  }
}

class _IntegerAccessorStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<IntegerAccessor> {
  IntegerAccessor _impl;

  _IntegerAccessorStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [IntegerAccessor impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _IntegerAccessorStubControl.fromHandle(
      core.MojoHandle handle, [IntegerAccessor impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _IntegerAccessorStubControl.unbound([this._impl]) : super.unbound();


  IntegerAccessorGetIntegerResponseParams _integerAccessorGetIntegerResponseParamsFactory(int data, Enum type) {
    var result = new IntegerAccessorGetIntegerResponseParams();
    result.data = data;
    result.type = type;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          3,
                                                          message);
    }
    if (_impl == null) {
      throw new core.MojoApiError("$this has no implementation set");
    }
    switch (message.header.type) {
      case _integerAccessorMethodGetIntegerName:
        var response = _impl.getInteger(_integerAccessorGetIntegerResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _integerAccessorMethodGetIntegerName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _integerAccessorMethodGetIntegerName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _integerAccessorMethodSetIntegerName:
        var params = _IntegerAccessorSetIntegerParams.deserialize(
            message.payload);
        _impl.setInteger(params.data, params.type);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  IntegerAccessor get impl => _impl;
  set impl(IntegerAccessor d) {
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
    return "_IntegerAccessorStubControl($superString)";
  }

  int get version => 3;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _IntegerAccessorServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class IntegerAccessorStub
    extends bindings.Stub<IntegerAccessor>
    implements IntegerAccessor {
  IntegerAccessorStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [IntegerAccessor impl])
      : super(new _IntegerAccessorStubControl.fromEndpoint(endpoint, impl));

  IntegerAccessorStub.fromHandle(
      core.MojoHandle handle, [IntegerAccessor impl])
      : super(new _IntegerAccessorStubControl.fromHandle(handle, impl));

  IntegerAccessorStub.unbound([IntegerAccessor impl])
      : super(new _IntegerAccessorStubControl.unbound(impl));

  static IntegerAccessorStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For IntegerAccessorStub"));
    return new IntegerAccessorStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _IntegerAccessorStubControl.serviceDescription;


  dynamic getInteger([Function responseFactory = null]) {
    return impl.getInteger(responseFactory);
  }
  void setInteger(int data, Enum type) {
    return impl.setInteger(data, type);
  }
}

const int _sampleInterfaceMethodSampleMethod1Name = 1;
const int _sampleInterfaceMethodSampleMethod0Name = 0;
const int _sampleInterfaceMethodSampleMethod2Name = 2;

class _SampleInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class SampleInterface {
  static const String serviceName = null;
  dynamic sampleMethod1(int in1,String in2,[Function responseFactory = null]);
  void sampleMethod0();
  void sampleMethod2();
}

class _SampleInterfaceProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _SampleInterfaceProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SampleInterfaceProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _SampleInterfaceProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _SampleInterfaceServiceDescription();

  String get serviceName => SampleInterface.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _sampleInterfaceMethodSampleMethod1Name:
        var r = SampleInterfaceSampleMethod1ResponseParams.deserialize(
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
    return "_SampleInterfaceProxyControl($superString)";
  }
}

class SampleInterfaceProxy
    extends bindings.Proxy
    implements SampleInterface {
  SampleInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _SampleInterfaceProxyControl.fromEndpoint(endpoint));

  SampleInterfaceProxy.fromHandle(core.MojoHandle handle)
      : super(new _SampleInterfaceProxyControl.fromHandle(handle));

  SampleInterfaceProxy.unbound()
      : super(new _SampleInterfaceProxyControl.unbound());

  static SampleInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SampleInterfaceProxy"));
    return new SampleInterfaceProxy.fromEndpoint(endpoint);
  }

  factory SampleInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SampleInterfaceProxy p = new SampleInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic sampleMethod1(int in1,String in2,[Function responseFactory = null]) {
    var params = new _SampleInterfaceSampleMethod1Params();
    params.in1 = in1;
    params.in2 = in2;
    return ctrl.sendMessageWithRequestId(
        params,
        _sampleInterfaceMethodSampleMethod1Name,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void sampleMethod0() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _SampleInterfaceSampleMethod0Params();
    ctrl.sendMessage(params,
        _sampleInterfaceMethodSampleMethod0Name);
  }
  void sampleMethod2() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _SampleInterfaceSampleMethod2Params();
    ctrl.sendMessage(params,
        _sampleInterfaceMethodSampleMethod2Name);
  }
}

class _SampleInterfaceStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<SampleInterface> {
  SampleInterface _impl;

  _SampleInterfaceStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [SampleInterface impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _SampleInterfaceStubControl.fromHandle(
      core.MojoHandle handle, [SampleInterface impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _SampleInterfaceStubControl.unbound([this._impl]) : super.unbound();


  SampleInterfaceSampleMethod1ResponseParams _sampleInterfaceSampleMethod1ResponseParamsFactory(String out1, Enum out2) {
    var result = new SampleInterfaceSampleMethod1ResponseParams();
    result.out1 = out1;
    result.out2 = out2;
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
      case _sampleInterfaceMethodSampleMethod1Name:
        var params = _SampleInterfaceSampleMethod1Params.deserialize(
            message.payload);
        var response = _impl.sampleMethod1(params.in1,params.in2,_sampleInterfaceSampleMethod1ResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _sampleInterfaceMethodSampleMethod1Name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _sampleInterfaceMethodSampleMethod1Name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _sampleInterfaceMethodSampleMethod0Name:
        _impl.sampleMethod0();
        break;
      case _sampleInterfaceMethodSampleMethod2Name:
        _impl.sampleMethod2();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  SampleInterface get impl => _impl;
  set impl(SampleInterface d) {
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
    return "_SampleInterfaceStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SampleInterfaceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class SampleInterfaceStub
    extends bindings.Stub<SampleInterface>
    implements SampleInterface {
  SampleInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [SampleInterface impl])
      : super(new _SampleInterfaceStubControl.fromEndpoint(endpoint, impl));

  SampleInterfaceStub.fromHandle(
      core.MojoHandle handle, [SampleInterface impl])
      : super(new _SampleInterfaceStubControl.fromHandle(handle, impl));

  SampleInterfaceStub.unbound([SampleInterface impl])
      : super(new _SampleInterfaceStubControl.unbound(impl));

  static SampleInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SampleInterfaceStub"));
    return new SampleInterfaceStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _SampleInterfaceStubControl.serviceDescription;


  dynamic sampleMethod1(int in1,String in2,[Function responseFactory = null]) {
    return impl.sampleMethod1(in1,in2,responseFactory);
  }
  void sampleMethod0() {
    return impl.sampleMethod0();
  }
  void sampleMethod2() {
    return impl.sampleMethod2();
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+xb3W7jRBS243Qpuyx0tymk+5tdtJCb1kmRoOIqvYhIBZUiFVbdq103GRKjxA62gwpPwCPwCFzyCDwCj8Jl78BuzmnGkxn/JE4zbjvS0dR/Gc/n73xn5sy0rEzKBtQ1qNnzWK8zNXvf31BXfSv6VoHjfahPoB5B/cS3km/fv2k3337bfPO1awxHA7LbtMbD4Prnvj3nXD+0PNIjzkGnQ1zXdi7aKXPuazv2L2aXOKLfOb6ogl9zfjQ6RGnBe28w7x0ca769K4SP//wofKzU+bicQ91QwqXGtPMfFPY+LB/A+yE+m77d842Bbab94Lk130zfDN/0sevoA7tjDPSebfcGRO/bQ6L/5hj60P7J1l2nM/ljND4dmB3dRIRc/dS0uqbVc3WPuJ6rT1p+O71hN3huSLWvUnypQl1RoktSnFqC5+9Df18ffPdD06+3fXsQxmkXr/HwCp4vrAAvET4b6qTWYvBpMPi0Bfh84ltAXdaPnvnnPp7ixF6ewSk4vrsCnHjvgcfgohe8K8Mx3nd2h48z+me1kIyHCoUz7zyWh4DPN8QDLPnvv70ivlUY/M4T6pXC8Gxf0P9HgMG0/zsO+XnsvxkfByxXjcO6QK/KzHutx+D2j5YNbo9B20O4uSPbcolUuLH+VVHD/d9n3vOOkqwk9btqTJzsGp4h8rftFeDFwyWIUy2V3w/kW0Hw/BkHF5UaX7GF5XeFo58a1R7q15FpvSaOa9pWGF/v1xER4fvFCvVMEcQHdvwUN/6c4TdHF1ROOwWwsiCuN5jvrYIl/b5nC35fNeb74vnjmLj1WLK4lZX+Ytw6ljxu5VV/Mb7lRX+1K9ZfbUH9DfDducH6q8Xob+jhOeadjYjvG3xbzDvgPItJR3DzKzLMo6pUXmaNgqgAmBYpXNao+8/h5uqH8HulSd1+FD3fOtGWM99qdvr2sef4OPD7+UCyuIXzzqzi1rT/csYtVgd5uqxy/HNZ8ep9aMpQxHwprQinqPgh0sFl8wzjd4hnEs5P88izlznimUjXfy+Gw2sS3NQIXcc895RvLhe/h5Lp+om2LH9zQ8Iu63ykpubD7wLebEngd2lxWp8DJzUBTqcROD2XXJ/ocf+y/RLnL2G/nAbCW79c3C93bv0ykV9+lSO/nJmPA459jZ/vjsKtQH0XtjwFXQ/884i4rtEjbXNEWobVHRAOjpuSjB8Qj1rK8booL/EKsODiQI0k8jRuL0qkU5sS6JS6wPwwa7595tuzCL5hhLzl2/x8O8wR31i9/xfniVqyfS00bloEbph/DXgX5JBZ3EqS6Dv2/11KfxPNj8vQR+w3Snqe/GtNIv8qwd95Xz9ZNF/YzyhfiPvvKH5S2cJ8xQHZePrkBvFUFEf2IYAUU+BejMA9WLN7D/h6aHkzuG9JFkc2MoojuF4J/b6cGeTJPxVq7XLV/rm1ojgyr+5nzSd6XDLh00T2b/k0P5+eSsynuP3rcTg1GF7F7V9n/3+D2b/OXp7BsyLJvosKFc81Zt8FXteo59pw4a+70etwafmJ7Yr8OeDf/Uvcj4jXt7s1Tn9eKtdzPzvmE0P9lzB/lnY/u4g/ZynXcdUIXon4U+fg9kIy/rS05fGnLiF/0u4rvar4eA900LTqXB19Aedk2Fd6letDU1z2hLi8WmG+UM1o3faPjPwQxwmsH8qWl5Z13Rbn9/bYq4v49qUEfEubv8naLymc9kQ4HVzz/E3Uui87Tk267ov/X5NmnLHHwf/TGzRO3bsG49T/AwAA//9GparmsEAAAA==";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
