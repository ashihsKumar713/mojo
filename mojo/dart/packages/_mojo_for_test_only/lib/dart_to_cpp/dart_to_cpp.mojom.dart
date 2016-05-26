// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library dart_to_cpp_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class EchoArgs extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(104, 0)
  ];
  int si64 = 0;
  int si32 = 0;
  int si16 = 0;
  int si8 = 0;
  int ui8 = 0;
  int ui64 = 0;
  int ui32 = 0;
  int ui16 = 0;
  double floatVal = 0.0;
  double floatInf = 0.0;
  double floatNan = 0.0;
  core.MojoMessagePipeEndpoint messageHandle = null;
  double doubleVal = 0.0;
  double doubleInf = 0.0;
  double doubleNan = 0.0;
  String name = null;
  List<String> stringArray = null;
  core.MojoDataPipeConsumer dataHandle = null;

  EchoArgs() : super(kVersions.last.size);

  static EchoArgs deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoArgs decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoArgs result = new EchoArgs();

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
      
      result.si64 = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.si32 = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.si16 = decoder0.decodeInt16(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.si8 = decoder0.decodeInt8(22);
    }
    if (mainDataHeader.version >= 0) {
      
      result.ui8 = decoder0.decodeUint8(23);
    }
    if (mainDataHeader.version >= 0) {
      
      result.ui64 = decoder0.decodeUint64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.ui32 = decoder0.decodeUint32(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.ui16 = decoder0.decodeUint16(36);
    }
    if (mainDataHeader.version >= 0) {
      
      result.floatVal = decoder0.decodeFloat(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.floatInf = decoder0.decodeFloat(44);
    }
    if (mainDataHeader.version >= 0) {
      
      result.floatNan = decoder0.decodeFloat(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.messageHandle = decoder0.decodeMessagePipeHandle(52, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.doubleVal = decoder0.decodeDouble(56);
    }
    if (mainDataHeader.version >= 0) {
      
      result.doubleInf = decoder0.decodeDouble(64);
    }
    if (mainDataHeader.version >= 0) {
      
      result.doubleNan = decoder0.decodeDouble(72);
    }
    if (mainDataHeader.version >= 0) {
      
      result.name = decoder0.decodeString(80, true);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(88, true);
      if (decoder1 == null) {
        result.stringArray = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.stringArray = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.stringArray[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.dataHandle = decoder0.decodeConsumerHandle(96, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(si64, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "si64 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(si32, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "si32 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(si16, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "si16 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(si8, 22);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "si8 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8(ui8, 23);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ui8 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(ui64, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ui64 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(ui32, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ui32 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(ui16, 36);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ui16 of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(floatVal, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "floatVal of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(floatInf, 44);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "floatInf of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(floatNan, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "floatNan of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(messageHandle, 52, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "messageHandle of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(doubleVal, 56);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "doubleVal of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(doubleInf, 64);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "doubleInf of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(doubleNan, 72);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "doubleNan of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(name, 80, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "name of struct EchoArgs: $e";
      rethrow;
    }
    try {
      if (stringArray == null) {
        encoder0.encodeNullPointer(88, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(stringArray.length, 88, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < stringArray.length; ++i0) {
          encoder1.encodeString(stringArray[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "stringArray of struct EchoArgs: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandle(dataHandle, 96, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "dataHandle of struct EchoArgs: $e";
      rethrow;
    }
  }

  String toString() {
    return "EchoArgs("
           "si64: $si64" ", "
           "si32: $si32" ", "
           "si16: $si16" ", "
           "si8: $si8" ", "
           "ui8: $ui8" ", "
           "ui64: $ui64" ", "
           "ui32: $ui32" ", "
           "ui16: $ui16" ", "
           "floatVal: $floatVal" ", "
           "floatInf: $floatInf" ", "
           "floatNan: $floatNan" ", "
           "messageHandle: $messageHandle" ", "
           "doubleVal: $doubleVal" ", "
           "doubleInf: $doubleInf" ", "
           "doubleNan: $doubleNan" ", "
           "name: $name" ", "
           "stringArray: $stringArray" ", "
           "dataHandle: $dataHandle" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class EchoArgsList extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  EchoArgsList next = null;
  EchoArgs item = null;

  EchoArgsList() : super(kVersions.last.size);

  static EchoArgsList deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoArgsList decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoArgsList result = new EchoArgsList();

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
      result.next = EchoArgsList.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.item = EchoArgs.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(next, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "next of struct EchoArgsList: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(item, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "item of struct EchoArgsList: $e";
      rethrow;
    }
  }

  String toString() {
    return "EchoArgsList("
           "next: $next" ", "
           "item: $item" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _CppSideStartTestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _CppSideStartTestParams() : super(kVersions.last.size);

  static _CppSideStartTestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CppSideStartTestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CppSideStartTestParams result = new _CppSideStartTestParams();

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
    return "_CppSideStartTestParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _CppSideTestFinishedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _CppSideTestFinishedParams() : super(kVersions.last.size);

  static _CppSideTestFinishedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CppSideTestFinishedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CppSideTestFinishedParams result = new _CppSideTestFinishedParams();

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
    return "_CppSideTestFinishedParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _CppSidePingResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _CppSidePingResponseParams() : super(kVersions.last.size);

  static _CppSidePingResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CppSidePingResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CppSidePingResponseParams result = new _CppSidePingResponseParams();

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
    return "_CppSidePingResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _CppSideEchoResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  EchoArgsList list = null;

  _CppSideEchoResponseParams() : super(kVersions.last.size);

  static _CppSideEchoResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CppSideEchoResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CppSideEchoResponseParams result = new _CppSideEchoResponseParams();

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
      result.list = EchoArgsList.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(list, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "list of struct _CppSideEchoResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_CppSideEchoResponseParams("
           "list: $list" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _DartSideSetClientParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  CppSideInterface cppSide = null;

  _DartSideSetClientParams() : super(kVersions.last.size);

  static _DartSideSetClientParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DartSideSetClientParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DartSideSetClientParams result = new _DartSideSetClientParams();

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
      
      result.cppSide = decoder0.decodeServiceInterface(8, false, CppSideProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(cppSide, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "cppSide of struct _DartSideSetClientParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DartSideSetClientParams("
           "cppSide: $cppSide" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _DartSidePingParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _DartSidePingParams() : super(kVersions.last.size);

  static _DartSidePingParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DartSidePingParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DartSidePingParams result = new _DartSidePingParams();

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
    return "_DartSidePingParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _DartSideEchoParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int numIterations = 0;
  EchoArgs arg = null;

  _DartSideEchoParams() : super(kVersions.last.size);

  static _DartSideEchoParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DartSideEchoParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DartSideEchoParams result = new _DartSideEchoParams();

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
      
      result.numIterations = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.arg = EchoArgs.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(numIterations, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "numIterations of struct _DartSideEchoParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(arg, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "arg of struct _DartSideEchoParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_DartSideEchoParams("
           "numIterations: $numIterations" ", "
           "arg: $arg" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _cppSideMethodStartTestName = 88888888;
const int _cppSideMethodTestFinishedName = 99999999;
const int _cppSideMethodPingResponseName = 100000000;
const int _cppSideMethodEchoResponseName = 100000001;

class _CppSideServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class CppSide {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _CppSideServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static CppSideProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CppSideProxy p = new CppSideProxy.unbound();
    String name = serviceName ?? CppSide.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void startTest();
  void testFinished();
  void pingResponse();
  void echoResponse(EchoArgsList list);
}

abstract class CppSideInterface
    implements bindings.MojoInterface<CppSide>,
               CppSide {
  factory CppSideInterface([CppSide impl]) =>
      new CppSideStub.unbound(impl);
  factory CppSideInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [CppSide impl]) =>
      new CppSideStub.fromEndpoint(endpoint, impl);
}

abstract class CppSideInterfaceRequest
    implements bindings.MojoInterface<CppSide>,
               CppSide {
  factory CppSideInterfaceRequest() =>
      new CppSideProxy.unbound();
}

class _CppSideProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<CppSide> {
  _CppSideProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CppSideProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _CppSideProxyControl.unbound() : super.unbound();

  String get serviceName => CppSide.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  CppSide get impl => null;
  set impl(CppSide _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_CppSideProxyControl($superString)";
  }
}

class CppSideProxy
    extends bindings.Proxy<CppSide>
    implements CppSide,
               CppSideInterface,
               CppSideInterfaceRequest {
  CppSideProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _CppSideProxyControl.fromEndpoint(endpoint));

  CppSideProxy.fromHandle(core.MojoHandle handle)
      : super(new _CppSideProxyControl.fromHandle(handle));

  CppSideProxy.unbound()
      : super(new _CppSideProxyControl.unbound());

  static CppSideProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CppSideProxy"));
    return new CppSideProxy.fromEndpoint(endpoint);
  }


  void startTest() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _CppSideStartTestParams();
    ctrl.sendMessage(params,
        _cppSideMethodStartTestName);
  }
  void testFinished() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _CppSideTestFinishedParams();
    ctrl.sendMessage(params,
        _cppSideMethodTestFinishedName);
  }
  void pingResponse() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _CppSidePingResponseParams();
    ctrl.sendMessage(params,
        _cppSideMethodPingResponseName);
  }
  void echoResponse(EchoArgsList list) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _CppSideEchoResponseParams();
    params.list = list;
    ctrl.sendMessage(params,
        _cppSideMethodEchoResponseName);
  }
}

class _CppSideStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<CppSide> {
  CppSide _impl;

  _CppSideStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [CppSide impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _CppSideStubControl.fromHandle(
      core.MojoHandle handle, [CppSide impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _CppSideStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => CppSide.serviceName;



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
      case _cppSideMethodStartTestName:
        _impl.startTest();
        break;
      case _cppSideMethodTestFinishedName:
        _impl.testFinished();
        break;
      case _cppSideMethodPingResponseName:
        _impl.pingResponse();
        break;
      case _cppSideMethodEchoResponseName:
        var params = _CppSideEchoResponseParams.deserialize(
            message.payload);
        _impl.echoResponse(params.list);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  CppSide get impl => _impl;
  set impl(CppSide d) {
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
    return "_CppSideStubControl($superString)";
  }

  int get version => 0;
}

class CppSideStub
    extends bindings.Stub<CppSide>
    implements CppSide,
               CppSideInterface,
               CppSideInterfaceRequest {
  CppSideStub.unbound([CppSide impl])
      : super(new _CppSideStubControl.unbound(impl));

  CppSideStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [CppSide impl])
      : super(new _CppSideStubControl.fromEndpoint(endpoint, impl));

  CppSideStub.fromHandle(
      core.MojoHandle handle, [CppSide impl])
      : super(new _CppSideStubControl.fromHandle(handle, impl));

  static CppSideStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CppSideStub"));
    return new CppSideStub.fromEndpoint(endpoint);
  }


  void startTest() {
    return impl.startTest();
  }
  void testFinished() {
    return impl.testFinished();
  }
  void pingResponse() {
    return impl.pingResponse();
  }
  void echoResponse(EchoArgsList list) {
    return impl.echoResponse(list);
  }
}

const int _dartSideMethodSetClientName = 0;
const int _dartSideMethodPingName = 1;
const int _dartSideMethodEchoName = 2;

class _DartSideServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class DartSide {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _DartSideServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static DartSideProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    DartSideProxy p = new DartSideProxy.unbound();
    String name = serviceName ?? DartSide.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void setClient(CppSideInterface cppSide);
  void ping();
  void echo(int numIterations, EchoArgs arg);
}

abstract class DartSideInterface
    implements bindings.MojoInterface<DartSide>,
               DartSide {
  factory DartSideInterface([DartSide impl]) =>
      new DartSideStub.unbound(impl);
  factory DartSideInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [DartSide impl]) =>
      new DartSideStub.fromEndpoint(endpoint, impl);
}

abstract class DartSideInterfaceRequest
    implements bindings.MojoInterface<DartSide>,
               DartSide {
  factory DartSideInterfaceRequest() =>
      new DartSideProxy.unbound();
}

class _DartSideProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<DartSide> {
  _DartSideProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _DartSideProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _DartSideProxyControl.unbound() : super.unbound();

  String get serviceName => DartSide.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  DartSide get impl => null;
  set impl(DartSide _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_DartSideProxyControl($superString)";
  }
}

class DartSideProxy
    extends bindings.Proxy<DartSide>
    implements DartSide,
               DartSideInterface,
               DartSideInterfaceRequest {
  DartSideProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _DartSideProxyControl.fromEndpoint(endpoint));

  DartSideProxy.fromHandle(core.MojoHandle handle)
      : super(new _DartSideProxyControl.fromHandle(handle));

  DartSideProxy.unbound()
      : super(new _DartSideProxyControl.unbound());

  static DartSideProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DartSideProxy"));
    return new DartSideProxy.fromEndpoint(endpoint);
  }


  void setClient(CppSideInterface cppSide) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _DartSideSetClientParams();
    params.cppSide = cppSide;
    ctrl.sendMessage(params,
        _dartSideMethodSetClientName);
  }
  void ping() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _DartSidePingParams();
    ctrl.sendMessage(params,
        _dartSideMethodPingName);
  }
  void echo(int numIterations, EchoArgs arg) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _DartSideEchoParams();
    params.numIterations = numIterations;
    params.arg = arg;
    ctrl.sendMessage(params,
        _dartSideMethodEchoName);
  }
}

class _DartSideStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<DartSide> {
  DartSide _impl;

  _DartSideStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [DartSide impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _DartSideStubControl.fromHandle(
      core.MojoHandle handle, [DartSide impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _DartSideStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => DartSide.serviceName;



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
      case _dartSideMethodSetClientName:
        var params = _DartSideSetClientParams.deserialize(
            message.payload);
        _impl.setClient(params.cppSide);
        break;
      case _dartSideMethodPingName:
        _impl.ping();
        break;
      case _dartSideMethodEchoName:
        var params = _DartSideEchoParams.deserialize(
            message.payload);
        _impl.echo(params.numIterations, params.arg);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  DartSide get impl => _impl;
  set impl(DartSide d) {
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
    return "_DartSideStubControl($superString)";
  }

  int get version => 0;
}

class DartSideStub
    extends bindings.Stub<DartSide>
    implements DartSide,
               DartSideInterface,
               DartSideInterfaceRequest {
  DartSideStub.unbound([DartSide impl])
      : super(new _DartSideStubControl.unbound(impl));

  DartSideStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [DartSide impl])
      : super(new _DartSideStubControl.fromEndpoint(endpoint, impl));

  DartSideStub.fromHandle(
      core.MojoHandle handle, [DartSide impl])
      : super(new _DartSideStubControl.fromHandle(handle, impl));

  static DartSideStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DartSideStub"));
    return new DartSideStub.fromEndpoint(endpoint);
  }


  void setClient(CppSideInterface cppSide) {
    return impl.setClient(cppSide);
  }
  void ping() {
    return impl.ping();
  }
  void echo(int numIterations, EchoArgs arg) {
    return impl.echo(numIterations, arg);
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/9yaz2/bNhTHJdlObMdOnMTNvK3rPKDFsmKN0x8ojJ08dBkyrBiMtSjak6vGrK3Blj1JHrJbjjvu2D9lf8L+hByz2467FNitJdtHh6VJmRIs0YmAB1oxY/H74ePT45NqxvujAu0+tPzfaZvnWr7fKbS72LLY6nDegvY5tCfQXsd2FdvjZ+2Dzo8Hz77p2l7QCUado/F478F4/MjpItLvBrbPZP2+w5+hY2i/g6P+6Fuv5+Pvv8L2xbx+Dx0/gHEegh6iM4Otyeh+d752fm4SnTsfnv9185yLwXChx3/ceYs7p/NCr/sGjkNDfGxgW8VGEX6KP29jk+CdmUfCsYjtCbafsDX6oyFqeJPuaOi4yGsMR7+MGr539P4D+dXGxHWCAPmB30DDF6jbRV6HnOLO7EVJ/+Hs9eqMPxHOzScPc2/OXueMf17nTGy8P+1awCULXFbEfM84LuR3w/jy/fYlfDexFbA9CrC2x2jqJ7yuL7FZCXKsc9c949p5OqkfNSU6PwatU523PPTrRK6XHknpzRsfris+DhlcfJrnD+98TIUT7meG+EMVW4nEEzzy7x3X8fuoK+Jz84L7w1XQyupkXeKi+wOJN6qcLAV/aDtu72fkj0euj0R8bl0Sf2B1XiZ/MCP4Q0bBH0hqEeYPe5r8oW0t1h9YnTr9gfeDFpdHke/JBP9rqB0qfFi/4o8S5DEDR8xjDxgmPf+GJP9i/ZRNgaPmy2Hrz2Sum1Y+XIGx0K0C9VPJNmJmXm5ryoersL+g3Czm+wwzzhPodJxTvM9F9Oe5eTAKHgwc5Mrywjua4lrLWnAeTHVqzoOXLa7R/eYR7ClF81/VENdqkv2wat0hbhw75fOICJxNhfsHybdEfnc35XV2yrWq60wlb77IeSQ//1YEPpbC/JNbrojLPU3zf5hZ7PwTfTrnvwYcp/VPUx5nDYi1i4yzMj5XsJWxuZPhD3joduDgDFviB+UE+US93+RjcAiLg2uQ/9hez5Ctgxsa7zc036SpsWpdOizeWMw5vw5pvrxbXWy+TIcmypeZYc/wL8D9Nin+r/BvbmH7E673B6zPEwi0xxCPxlAf7sMCfQ514qersO8F0O0CtEVooZ7fLkFbhnYd/n8DrguCX22Gx4eVlPeXvnP/nmheijCvacaFsPi46Lhwrv/uHZH+NU36syHjjarfUtJ/+75If0mT/oxkvOsx9GcU7gu+0xTeF8oJxyWZ/mJInI2qP6sw/xPJ+l+H2Jy2/oJkvLUY+nNK+sXrf0OT/nxIvTSq/hUl/eL1X9GkfzWkbhBV/6rC+p9I1v+mpvhnScZbj6E/r1CPezkY2UHnN3sgqU9tLRmH6zE4FJQ5OO5LCYftJeOwG4NDUZmDa7sSDlVNHEzJuPdjcFgL4bAF9+DuaPJigM4XBs/hiqb4KOPQjMGhpM5hujB4DjtLxqEVg0NZncN0YfAcPtLAwQypoxzG4LCukC+49lD43KuW8HOviqQ+zvKwBM8D6dGOwWND4Tm9H3iO2+vYnmf/LuJCnwclXV8yYcx8XUi2b2C5ZUO4fR2DWyWE2w7sLYbI9+0e6vRttztAs9w+AZZp+JMZg8vTGFw2Q7hsQ07atQN7CkXgT+T9zGspcbHm1BlJbOxL6oz/Q/v3nHp/i6szthXq/ewrBHW4puw1A57ftYT39fzzgLG5XO+TuOhY+Jzkc/icRpxK8n0S3c8bKGcnQEMR5zr0SZtzWs8b3gYAAP//ZmL1wygwAAA=";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
