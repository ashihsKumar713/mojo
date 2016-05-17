// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library test_structs_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:_mojo_for_test_only/mojo/test/rect.mojom.dart' as rect_mojom;



class StructOfStructs extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  NamedRegion nr = null;
  List<NamedRegion> aNr = null;
  List<RectPair> aRp = null;
  Map<int, NoDefaultFieldValues> mNdfv = null;
  Map<int, HandleStruct> mHs = null;

  StructOfStructs() : super(kVersions.last.size);

  static StructOfStructs deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructOfStructs decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructOfStructs result = new StructOfStructs();

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
      result.nr = NamedRegion.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.aNr = new List<NamedRegion>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.aNr[i1] = NamedRegion.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.aRp = new List<RectPair>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.aRp[i1] = RectPair.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<NoDefaultFieldValues> values0;
        {
          
          keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<NoDefaultFieldValues>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              values0[i2] = NoDefaultFieldValues.decode(decoder3);
            }
          }
        }
        result.mNdfv = new Map<int, NoDefaultFieldValues>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<HandleStruct> values0;
        {
          
          keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<HandleStruct>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              values0[i2] = HandleStruct.decode(decoder3);
            }
          }
        }
        result.mHs = new Map<int, HandleStruct>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(nr, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "nr of struct StructOfStructs: $e";
      rethrow;
    }
    try {
      if (aNr == null) {
        encoder0.encodeNullPointer(16, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(aNr.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < aNr.length; ++i0) {
          encoder1.encodeStruct(aNr[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "aNr of struct StructOfStructs: $e";
      rethrow;
    }
    try {
      if (aRp == null) {
        encoder0.encodeNullPointer(24, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(aRp.length, 24, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < aRp.length; ++i0) {
          encoder1.encodeStruct(aRp[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "aRp of struct StructOfStructs: $e";
      rethrow;
    }
    try {
      if (mNdfv == null) {
        encoder0.encodeNullPointer(32, false);
      } else {
        var encoder1 = encoder0.encoderForMap(32);
        var keys0 = mNdfv.keys.toList();
        var values0 = mNdfv.values.toList();
        encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mNdfv of struct StructOfStructs: $e";
      rethrow;
    }
    try {
      if (mHs == null) {
        encoder0.encodeNullPointer(40, false);
      } else {
        var encoder1 = encoder0.encoderForMap(40);
        var keys0 = mHs.keys.toList();
        var values0 = mHs.values.toList();
        encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mHs of struct StructOfStructs: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructOfStructs("
           "nr: $nr" ", "
           "aNr: $aNr" ", "
           "aRp: $aRp" ", "
           "mNdfv: $mNdfv" ", "
           "mHs: $mHs" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class NamedRegion extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String name = null;
  List<rect_mojom.Rect> rects = null;

  NamedRegion() : super(kVersions.last.size);

  static NamedRegion deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NamedRegion decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NamedRegion result = new NamedRegion();

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
      
      result.name = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.rects = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.rects = new List<rect_mojom.Rect>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.rects[i1] = rect_mojom.Rect.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(name, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "name of struct NamedRegion: $e";
      rethrow;
    }
    try {
      if (rects == null) {
        encoder0.encodeNullPointer(16, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(rects.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < rects.length; ++i0) {
          encoder1.encodeStruct(rects[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rects of struct NamedRegion: $e";
      rethrow;
    }
  }

  String toString() {
    return "NamedRegion("
           "name: $name" ", "
           "rects: $rects" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["name"] = name;
    map["rects"] = rects;
    return map;
  }
}


class RectPair extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  rect_mojom.Rect first = null;
  rect_mojom.Rect second = null;

  RectPair() : super(kVersions.last.size);

  static RectPair deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static RectPair decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    RectPair result = new RectPair();

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
      result.first = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.second = rect_mojom.Rect.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(first, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "first of struct RectPair: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(second, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "second of struct RectPair: $e";
      rethrow;
    }
  }

  String toString() {
    return "RectPair("
           "first: $first" ", "
           "second: $second" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["first"] = first;
    map["second"] = second;
    return map;
  }
}


class EmptyStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  EmptyStruct() : super(kVersions.last.size);

  static EmptyStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EmptyStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EmptyStruct result = new EmptyStruct();

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
    return "EmptyStruct("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class HandleStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  core.MojoMessagePipeEndpoint h = null;
  List<core.MojoMessagePipeEndpoint> arrayH = null;

  HandleStruct() : super(kVersions.last.size);

  static HandleStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HandleStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HandleStruct result = new HandleStruct();

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
      
      result.h = decoder0.decodeMessagePipeHandle(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.arrayH = decoder0.decodeMessagePipeHandleArray(16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeMessagePipeHandle(h, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "h of struct HandleStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandleArray(arrayH, 16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "arrayH of struct HandleStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "HandleStruct("
           "h: $h" ", "
           "arrayH: $arrayH" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class NullableHandleStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoMessagePipeEndpoint h = null;
  int data = 1234;

  NullableHandleStruct() : super(kVersions.last.size);

  static NullableHandleStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NullableHandleStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NullableHandleStruct result = new NullableHandleStruct();

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
      
      result.h = decoder0.decodeMessagePipeHandle(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.data = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeMessagePipeHandle(h, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "h of struct NullableHandleStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(data, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "data of struct NullableHandleStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "NullableHandleStruct("
           "h: $h" ", "
           "data: $data" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class NoDefaultFieldValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(160, 0)
  ];
  bool f0 = false;
  int f1 = 0;
  int f2 = 0;
  int f3 = 0;
  int f4 = 0;
  int f5 = 0;
  int f6 = 0;
  int f7 = 0;
  int f8 = 0;
  double f9 = 0.0;
  core.MojoMessagePipeEndpoint f13 = null;
  double f10 = 0.0;
  String f11 = null;
  String f12 = null;
  core.MojoDataPipeConsumer f14 = null;
  core.MojoDataPipeProducer f15 = null;
  core.MojoMessagePipeEndpoint f16 = null;
  core.MojoDataPipeConsumer f17 = null;
  core.MojoDataPipeProducer f18 = null;
  core.MojoHandle f19 = null;
  core.MojoHandle f20 = null;
  core.MojoSharedBuffer f21 = null;
  core.MojoSharedBuffer f22 = null;
  List<String> f23 = null;
  List<String> f24 = null;
  List<String> f25 = null;
  List<String> f26 = null;
  EmptyStruct f27 = null;
  EmptyStruct f28 = null;

  NoDefaultFieldValues() : super(kVersions.last.size);

  static NoDefaultFieldValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NoDefaultFieldValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NoDefaultFieldValues result = new NoDefaultFieldValues();

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
      
      result.f0 = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeInt8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeUint8(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeInt16(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeUint16(14);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeInt64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeUint64(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeFloat(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f13 = decoder0.decodeMessagePipeHandle(44, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f10 = decoder0.decodeDouble(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f11 = decoder0.decodeString(56, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f12 = decoder0.decodeString(64, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f14 = decoder0.decodeConsumerHandle(72, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f15 = decoder0.decodeProducerHandle(76, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f16 = decoder0.decodeMessagePipeHandle(80, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f17 = decoder0.decodeConsumerHandle(84, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f18 = decoder0.decodeProducerHandle(88, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f19 = decoder0.decodeHandle(92, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f20 = decoder0.decodeHandle(96, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f21 = decoder0.decodeSharedBufferHandle(100, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f22 = decoder0.decodeSharedBufferHandle(104, true);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(112, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f23 = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f23[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(120, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f24 = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f24[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(128, true);
      if (decoder1 == null) {
        result.f25 = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f25 = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f25[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(136, true);
      if (decoder1 == null) {
        result.f26 = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f26 = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f26[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(144, false);
      result.f27 = EmptyStruct.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(152, true);
      result.f28 = EmptyStruct.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(f0, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(f1, 9);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8(f2, 10);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(f3, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(f4, 14);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f5, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(f6, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(f7, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f7 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(f8, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f8 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(f9, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f9 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(f13, 44, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f13 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f10, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f10 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(f11, 56, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f11 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(f12, 64, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f12 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandle(f14, 72, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f14 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeProducerHandle(f15, 76, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f15 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(f16, 80, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f16 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandle(f17, 84, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f17 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeProducerHandle(f18, 88, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f18 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeHandle(f19, 92, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f19 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeHandle(f20, 96, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f20 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeSharedBufferHandle(f21, 100, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f21 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeSharedBufferHandle(f22, 104, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f22 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      if (f23 == null) {
        encoder0.encodeNullPointer(112, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(f23.length, 112, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < f23.length; ++i0) {
          encoder1.encodeString(f23[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f23 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      if (f24 == null) {
        encoder0.encodeNullPointer(120, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(f24.length, 120, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < f24.length; ++i0) {
          encoder1.encodeString(f24[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, true);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f24 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      if (f25 == null) {
        encoder0.encodeNullPointer(128, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(f25.length, 128, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < f25.length; ++i0) {
          encoder1.encodeString(f25[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f25 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      if (f26 == null) {
        encoder0.encodeNullPointer(136, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(f26.length, 136, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < f26.length; ++i0) {
          encoder1.encodeString(f26[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, true);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f26 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(f27, 144, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f27 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(f28, 152, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f28 of struct NoDefaultFieldValues: $e";
      rethrow;
    }
  }

  String toString() {
    return "NoDefaultFieldValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f13: $f13" ", "
           "f10: $f10" ", "
           "f11: $f11" ", "
           "f12: $f12" ", "
           "f14: $f14" ", "
           "f15: $f15" ", "
           "f16: $f16" ", "
           "f17: $f17" ", "
           "f18: $f18" ", "
           "f19: $f19" ", "
           "f20: $f20" ", "
           "f21: $f21" ", "
           "f22: $f22" ", "
           "f23: $f23" ", "
           "f24: $f24" ", "
           "f25: $f25" ", "
           "f26: $f26" ", "
           "f27: $f27" ", "
           "f28: $f28" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class DefaultFieldValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(96, 0)
  ];
  static const String kFoo = "foo";
  bool f0 = true;
  int f1 = 100;
  int f2 = 100;
  int f3 = 100;
  int f4 = 100;
  int f5 = 100;
  int f6 = 100;
  int f7 = 100;
  int f8 = 100;
  double f9 = 100;
  double f10 = 100.0;
  double f11 = 100;
  double f12 = 100.0;
  String f13 = "foo";
  String f14 = "foo";
  rect_mojom.Rect f15 = new rect_mojom.Rect();
  rect_mojom.Rect f16 = new rect_mojom.Rect();

  DefaultFieldValues() : super(kVersions.last.size);

  static DefaultFieldValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DefaultFieldValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DefaultFieldValues result = new DefaultFieldValues();

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
      
      result.f0 = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeInt8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeUint8(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeInt16(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeUint16(14);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeInt64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeUint64(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeFloat(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f10 = decoder0.decodeFloat(44);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f11 = decoder0.decodeDouble(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f12 = decoder0.decodeDouble(56);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f13 = decoder0.decodeString(64, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f14 = decoder0.decodeString(72, true);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(80, false);
      result.f15 = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(88, true);
      result.f16 = rect_mojom.Rect.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(f0, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(f1, 9);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8(f2, 10);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(f3, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(f4, 14);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f5, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(f6, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(f7, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f7 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(f8, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f8 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(f9, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f9 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(f10, 44);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f10 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f11, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f11 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f12, 56);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f12 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(f13, 64, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f13 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(f14, 72, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f14 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(f15, 80, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f15 of struct DefaultFieldValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(f16, 88, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f16 of struct DefaultFieldValues: $e";
      rethrow;
    }
  }

  String toString() {
    return "DefaultFieldValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ", "
           "f12: $f12" ", "
           "f13: $f13" ", "
           "f14: $f14" ", "
           "f15: $f15" ", "
           "f16: $f16" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    map["f10"] = f10;
    map["f11"] = f11;
    map["f12"] = f12;
    map["f13"] = f13;
    map["f14"] = f14;
    map["f15"] = f15;
    map["f16"] = f16;
    return map;
  }
}


class ScopedConstantsEType extends bindings.MojoEnum {
  static const ScopedConstantsEType e0 = const ScopedConstantsEType._(0);
  static const ScopedConstantsEType e1 = const ScopedConstantsEType._(1);
  static const ScopedConstantsEType e2 = const ScopedConstantsEType._(10);
  static const ScopedConstantsEType e3 = const ScopedConstantsEType._(10);
  static const ScopedConstantsEType e4 = const ScopedConstantsEType._(11);

  const ScopedConstantsEType._(int v) : super(v);

  static const Map<String, ScopedConstantsEType> valuesMap = const {
    "e0": e0,
    "e1": e1,
    "e2": e2,
    "e3": e3,
    "e4": e4,
  };
  static const List<ScopedConstantsEType> values = const [
    e0,
    e1,
    e2,
    e3,
    e4,
  ];

  static ScopedConstantsEType valueOf(String name) => valuesMap[name];

  factory ScopedConstantsEType(int v) {
    switch (v) {
      case 0:
        return ScopedConstantsEType.e0;
      case 1:
        return ScopedConstantsEType.e1;
      case 10:
        return ScopedConstantsEType.e2;
      case 10:
        return ScopedConstantsEType.e3;
      case 11:
        return ScopedConstantsEType.e4;
      default:
        return null;
    }
  }

  static ScopedConstantsEType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    ScopedConstantsEType result = new ScopedConstantsEType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum ScopedConstantsEType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case e0:
        return 'ScopedConstantsEType.e0';
      case e1:
        return 'ScopedConstantsEType.e1';
      case e2:
        return 'ScopedConstantsEType.e2';
      case e3:
        return 'ScopedConstantsEType.e3';
      case e4:
        return 'ScopedConstantsEType.e4';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class ScopedConstants extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  static const int ten = 10;
  static const int alsoTen = 10;
  ScopedConstantsEType f0 = new ScopedConstantsEType(0);
  ScopedConstantsEType f1 = new ScopedConstantsEType(1);
  ScopedConstantsEType f2 = new ScopedConstantsEType(10);
  ScopedConstantsEType f3 = new ScopedConstantsEType(10);
  ScopedConstantsEType f4 = new ScopedConstantsEType(11);
  int f5 = 10;
  int f6 = 10;

  ScopedConstants() : super(kVersions.last.size);

  static ScopedConstants deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ScopedConstants decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ScopedConstants result = new ScopedConstants();

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
      
        result.f0 = ScopedConstantsEType.decode(decoder0, 8);
        if (result.f0 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.f1 = ScopedConstantsEType.decode(decoder0, 12);
        if (result.f1 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.f2 = ScopedConstantsEType.decode(decoder0, 16);
        if (result.f2 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.f3 = ScopedConstantsEType.decode(decoder0, 20);
        if (result.f3 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.f4 = ScopedConstantsEType.decode(decoder0, 24);
        if (result.f4 == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ScopedConstantsEType.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeInt32(28);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeInt32(32);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(f0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct ScopedConstants: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(f1, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct ScopedConstants: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(f2, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct ScopedConstants: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(f3, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct ScopedConstants: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(f4, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct ScopedConstants: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f5, 28);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct ScopedConstants: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f6, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct ScopedConstants: $e";
      rethrow;
    }
  }

  String toString() {
    return "ScopedConstants("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    return map;
  }
}


class MapKeyTypes extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(104, 0)
  ];
  Map<bool, bool> f0 = null;
  Map<int, int> f1 = null;
  Map<int, int> f2 = null;
  Map<int, int> f3 = null;
  Map<int, int> f4 = null;
  Map<int, int> f5 = null;
  Map<int, int> f6 = null;
  Map<int, int> f7 = null;
  Map<int, int> f8 = null;
  Map<double, double> f9 = null;
  Map<double, double> f10 = null;
  Map<String, String> f11 = null;

  MapKeyTypes() : super(kVersions.last.size);

  static MapKeyTypes deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MapKeyTypes decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MapKeyTypes result = new MapKeyTypes();

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
      {
        decoder1.decodeDataHeaderForMap();
        List<bool> keys0;
        List<bool> values0;
        {
          
          keys0 = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f0 = new Map<bool, bool>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeInt8Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeInt8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f1 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f2 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeInt16Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeInt16Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f3 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeUint16Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeUint16Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f4 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(48, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeInt32Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeInt32Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f5 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(56, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeUint32Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeUint32Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f6 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(64, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f7 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(72, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<int> keys0;
        List<int> values0;
        {
          
          keys0 = decoder1.decodeUint64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeUint64Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f8 = new Map<int, int>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(80, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<double> keys0;
        List<double> values0;
        {
          
          keys0 = decoder1.decodeFloatArray(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeFloatArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f9 = new Map<double, double>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(88, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<double> keys0;
        List<double> values0;
        {
          
          keys0 = decoder1.decodeDoubleArray(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
        {
          
          values0 = decoder1.decodeDoubleArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f10 = new Map<double, double>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(96, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<String> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              values0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        result.f11 = new Map<String, String>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (f0 == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encoderForMap(8);
        var keys0 = f0.keys.toList();
        var values0 = f0.values.toList();
        encoder1.encodeBoolArray(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeBoolArray(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f1 == null) {
        encoder0.encodeNullPointer(16, false);
      } else {
        var encoder1 = encoder0.encoderForMap(16);
        var keys0 = f1.keys.toList();
        var values0 = f1.values.toList();
        encoder1.encodeInt8Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeInt8Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f2 == null) {
        encoder0.encodeNullPointer(24, false);
      } else {
        var encoder1 = encoder0.encoderForMap(24);
        var keys0 = f2.keys.toList();
        var values0 = f2.values.toList();
        encoder1.encodeUint8Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeUint8Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f3 == null) {
        encoder0.encodeNullPointer(32, false);
      } else {
        var encoder1 = encoder0.encoderForMap(32);
        var keys0 = f3.keys.toList();
        var values0 = f3.values.toList();
        encoder1.encodeInt16Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeInt16Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f4 == null) {
        encoder0.encodeNullPointer(40, false);
      } else {
        var encoder1 = encoder0.encoderForMap(40);
        var keys0 = f4.keys.toList();
        var values0 = f4.values.toList();
        encoder1.encodeUint16Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeUint16Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f5 == null) {
        encoder0.encodeNullPointer(48, false);
      } else {
        var encoder1 = encoder0.encoderForMap(48);
        var keys0 = f5.keys.toList();
        var values0 = f5.values.toList();
        encoder1.encodeInt32Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeInt32Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f6 == null) {
        encoder0.encodeNullPointer(56, false);
      } else {
        var encoder1 = encoder0.encoderForMap(56);
        var keys0 = f6.keys.toList();
        var values0 = f6.values.toList();
        encoder1.encodeUint32Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeUint32Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f7 == null) {
        encoder0.encodeNullPointer(64, false);
      } else {
        var encoder1 = encoder0.encoderForMap(64);
        var keys0 = f7.keys.toList();
        var values0 = f7.values.toList();
        encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeInt64Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f7 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f8 == null) {
        encoder0.encodeNullPointer(72, false);
      } else {
        var encoder1 = encoder0.encoderForMap(72);
        var keys0 = f8.keys.toList();
        var values0 = f8.values.toList();
        encoder1.encodeUint64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeUint64Array(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f8 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f9 == null) {
        encoder0.encodeNullPointer(80, false);
      } else {
        var encoder1 = encoder0.encoderForMap(80);
        var keys0 = f9.keys.toList();
        var values0 = f9.values.toList();
        encoder1.encodeFloatArray(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeFloatArray(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f9 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f10 == null) {
        encoder0.encodeNullPointer(88, false);
      } else {
        var encoder1 = encoder0.encoderForMap(88);
        var keys0 = f10.keys.toList();
        var values0 = f10.values.toList();
        encoder1.encodeDoubleArray(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        encoder1.encodeDoubleArray(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f10 of struct MapKeyTypes: $e";
      rethrow;
    }
    try {
      if (f11 == null) {
        encoder0.encodeNullPointer(96, false);
      } else {
        var encoder1 = encoder0.encoderForMap(96);
        var keys0 = f11.keys.toList();
        var values0 = f11.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeString(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f11 of struct MapKeyTypes: $e";
      rethrow;
    }
  }

  String toString() {
    return "MapKeyTypes("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    map["f10"] = f10;
    map["f11"] = f11;
    return map;
  }
}


class MapValueTypes extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(104, 0)
  ];
  Map<String, List<String>> f0 = null;
  Map<String, List<String>> f1 = null;
  Map<String, List<String>> f2 = null;
  Map<String, List<String>> f3 = null;
  Map<String, List<List<String>>> f4 = null;
  Map<String, List<List<String>>> f5 = null;
  Map<String, rect_mojom.Rect> f6 = null;
  Map<String, Map<String, String>> f7 = null;
  Map<String, List<Map<String, String>>> f8 = null;
  Map<String, core.MojoHandle> f9 = null;
  Map<String, List<core.MojoHandle>> f10 = null;
  Map<String, Map<String, core.MojoHandle>> f11 = null;

  MapValueTypes() : super(kVersions.last.size);

  static MapValueTypes deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MapValueTypes decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MapValueTypes result = new MapValueTypes();

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
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<String>> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<List<String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<String>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  values0[i2][i3] = decoder3.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
            }
          }
        }
        result.f0 = new Map<String, List<String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<String>> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<List<String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, true);
              if (decoder3 == null) {
                values0[i2] = null;
              } else {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<String>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  values0[i2][i3] = decoder3.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
            }
          }
        }
        result.f1 = new Map<String, List<String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<String>> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<List<String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<String>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  values0[i2][i3] = decoder3.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, true);
                }
              }
            }
          }
        }
        result.f2 = new Map<String, List<String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<String>> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<List<String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(2);
                values0[i2] = new List<String>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  values0[i2][i3] = decoder3.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
            }
          }
        }
        result.f3 = new Map<String, List<String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<List<String>>> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<List<List<String>>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<List<String>>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, true);
                  if (decoder4 == null) {
                    values0[i2][i3] = null;
                  } else {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(2);
                    values0[i2][i3] = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      values0[i2][i3][i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
              }
            }
          }
        }
        result.f4 = new Map<String, List<List<String>>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(48, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<List<String>>> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<List<List<String>>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(1);
                values0[i2] = new List<List<String>>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                  {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(2);
                    values0[i2][i3] = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      values0[i2][i3][i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
              }
            }
          }
        }
        result.f5 = new Map<String, List<List<String>>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(56, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<rect_mojom.Rect> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<rect_mojom.Rect>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, true);
              values0[i2] = rect_mojom.Rect.decode(decoder3);
            }
          }
        }
        result.f6 = new Map<String, rect_mojom.Rect>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(64, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<Map<String, String>> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<Map<String, String>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                decoder3.decodeDataHeaderForMap();
                List<String> keys2;
                List<String> values2;
                {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
                  {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                    keys2 = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      keys2[i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
                {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
                  {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(keys2.length);
                    values2 = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      values2[i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
                values0[i2] = new Map<String, String>.fromIterables(
                    keys2, values2);
              }
            }
          }
        }
        result.f7 = new Map<String, Map<String, String>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(72, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<Map<String, String>>> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<List<Map<String, String>>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                var si3 = decoder3.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                values0[i2] = new List<Map<String, String>>(si3.numElements);
                for (int i3 = 0; i3 < si3.numElements; ++i3) {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                  {
                    decoder4.decodeDataHeaderForMap();
                    List<String> keys3;
                    List<String> values3;
                    {
                      
                      var decoder5 = decoder4.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
                      {
                        var si5 = decoder5.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                        keys3 = new List<String>(si5.numElements);
                        for (int i5 = 0; i5 < si5.numElements; ++i5) {
                          
                          keys3[i5] = decoder5.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i5, false);
                        }
                      }
                    }
                    {
                      
                      var decoder5 = decoder4.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
                      {
                        var si5 = decoder5.decodeDataHeaderForPointerArray(keys3.length);
                        values3 = new List<String>(si5.numElements);
                        for (int i5 = 0; i5 < si5.numElements; ++i5) {
                          
                          values3[i5] = decoder5.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i5, false);
                        }
                      }
                    }
                    values0[i2][i3] = new Map<String, String>.fromIterables(
                        keys3, values3);
                  }
                }
              }
            }
          }
        }
        result.f8 = new Map<String, List<Map<String, String>>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(80, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<core.MojoHandle> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          values0 = decoder1.decodeHandleArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys0.length);
        }
        result.f9 = new Map<String, core.MojoHandle>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(88, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<List<core.MojoHandle>> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<List<core.MojoHandle>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              values0[i2] = decoder2.decodeHandleArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
            }
          }
        }
        result.f10 = new Map<String, List<core.MojoHandle>>.fromIterables(
            keys0, values0);
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(96, false);
      {
        decoder1.decodeDataHeaderForMap();
        List<String> keys0;
        List<Map<String, core.MojoHandle>> values0;
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
            keys0 = new List<String>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              keys0[i2] = decoder2.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
            }
          }
        }
        {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
          {
            var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
            values0 = new List<Map<String, core.MojoHandle>>(si2.numElements);
            for (int i2 = 0; i2 < si2.numElements; ++i2) {
              
              var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              {
                decoder3.decodeDataHeaderForMap();
                List<String> keys2;
                List<core.MojoHandle> values2;
                {
                  
                  var decoder4 = decoder3.decodePointer(bindings.ArrayDataHeader.kHeaderSize, false);
                  {
                    var si4 = decoder4.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
                    keys2 = new List<String>(si4.numElements);
                    for (int i4 = 0; i4 < si4.numElements; ++i4) {
                      
                      keys2[i4] = decoder4.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
                {
                  
                  values2 = decoder3.decodeHandleArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, keys2.length);
                }
                values0[i2] = new Map<String, core.MojoHandle>.fromIterables(
                    keys2, values2);
              }
            }
          }
        }
        result.f11 = new Map<String, Map<String, core.MojoHandle>>.fromIterables(
            keys0, values0);
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (f0 == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encoderForMap(8);
        var keys0 = f0.keys.toList();
        var values0 = f0.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
              for (int i2 = 0; i2 < values0[i1].length; ++i2) {
                encoder3.encodeString(values0[i1][i2], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f1 == null) {
        encoder0.encodeNullPointer(16, false);
      } else {
        var encoder1 = encoder0.encoderForMap(16);
        var keys0 = f1.keys.toList();
        var values0 = f1.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
            } else {
              var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
              for (int i2 = 0; i2 < values0[i1].length; ++i2) {
                encoder3.encodeString(values0[i1][i2], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f2 == null) {
        encoder0.encodeNullPointer(24, false);
      } else {
        var encoder1 = encoder0.encoderForMap(24);
        var keys0 = f2.keys.toList();
        var values0 = f2.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
              for (int i2 = 0; i2 < values0[i1].length; ++i2) {
                encoder3.encodeString(values0[i1][i2], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, true);
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f3 == null) {
        encoder0.encodeNullPointer(32, false);
      } else {
        var encoder1 = encoder0.encoderForMap(32);
        var keys0 = f3.keys.toList();
        var values0 = f3.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, 2);
              for (int i2 = 0; i2 < values0[i1].length; ++i2) {
                encoder3.encodeString(values0[i1][i2], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f4 == null) {
        encoder0.encodeNullPointer(40, false);
      } else {
        var encoder1 = encoder0.encoderForMap(40);
        var keys0 = f4.keys.toList();
        var values0 = f4.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
              for (int i2 = 0; i2 < values0[i1].length; ++i2) {
                if (values0[i1][i2] == null) {
                  encoder3.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, true);
                } else {
                  var encoder4 = encoder3.encodePointerArray(values0[i1][i2].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, 2);
                  for (int i3 = 0; i3 < values0[i1][i2].length; ++i3) {
                    encoder4.encodeString(values0[i1][i2][i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                  }
                }
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f5 == null) {
        encoder0.encodeNullPointer(48, false);
      } else {
        var encoder1 = encoder0.encoderForMap(48);
        var keys0 = f5.keys.toList();
        var values0 = f5.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, 1);
              for (int i2 = 0; i2 < values0[i1].length; ++i2) {
                if (values0[i1][i2] == null) {
                  encoder3.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
                } else {
                  var encoder4 = encoder3.encodePointerArray(values0[i1][i2].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, 2);
                  for (int i3 = 0; i3 < values0[i1][i2].length; ++i3) {
                    encoder4.encodeString(values0[i1][i2][i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                  }
                }
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f6 == null) {
        encoder0.encodeNullPointer(56, false);
      } else {
        var encoder1 = encoder0.encoderForMap(56);
        var keys0 = f6.keys.toList();
        var values0 = f6.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, true);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f7 == null) {
        encoder0.encodeNullPointer(64, false);
      } else {
        var encoder1 = encoder0.encoderForMap(64);
        var keys0 = f7.keys.toList();
        var values0 = f7.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encoderForMap(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1);
              var keys2 = values0[i1].keys.toList();
              var values2 = values0[i1].values.toList();
              
              {
                var encoder4 = encoder3.encodePointerArray(keys2.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
                for (int i3 = 0; i3 < keys2.length; ++i3) {
                  encoder4.encodeString(keys2[i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
              
              {
                var encoder4 = encoder3.encodePointerArray(values2.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
                for (int i3 = 0; i3 < values2.length; ++i3) {
                  encoder4.encodeString(values2[i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f7 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f8 == null) {
        encoder0.encodeNullPointer(72, false);
      } else {
        var encoder1 = encoder0.encoderForMap(72);
        var keys0 = f8.keys.toList();
        var values0 = f8.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encodePointerArray(values0[i1].length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kUnspecifiedArrayLength);
              for (int i2 = 0; i2 < values0[i1].length; ++i2) {
                if (values0[i1][i2] == null) {
                  encoder3.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
                } else {
                  var encoder4 = encoder3.encoderForMap(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2);
                  var keys3 = values0[i1][i2].keys.toList();
                  var values3 = values0[i1][i2].values.toList();
                  
                  {
                    var encoder5 = encoder4.encodePointerArray(keys3.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
                    for (int i4 = 0; i4 < keys3.length; ++i4) {
                      encoder5.encodeString(keys3[i4], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                  
                  {
                    var encoder5 = encoder4.encodePointerArray(values3.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
                    for (int i4 = 0; i4 < values3.length; ++i4) {
                      encoder5.encodeString(values3[i4], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i4, false);
                    }
                  }
                }
              }
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f8 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f9 == null) {
        encoder0.encodeNullPointer(80, false);
      } else {
        var encoder1 = encoder0.encoderForMap(80);
        var keys0 = f9.keys.toList();
        var values0 = f9.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        encoder1.encodeHandleArray(values0, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f9 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f10 == null) {
        encoder0.encodeNullPointer(88, false);
      } else {
        var encoder1 = encoder0.encoderForMap(88);
        var keys0 = f10.keys.toList();
        var values0 = f10.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            encoder2.encodeHandleArray(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f10 of struct MapValueTypes: $e";
      rethrow;
    }
    try {
      if (f11 == null) {
        encoder0.encodeNullPointer(96, false);
      } else {
        var encoder1 = encoder0.encoderForMap(96);
        var keys0 = f11.keys.toList();
        var values0 = f11.values.toList();
        
        {
          var encoder2 = encoder1.encodePointerArray(keys0.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < keys0.length; ++i1) {
            encoder2.encodeString(keys0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          }
        }
        
        {
          var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
          for (int i1 = 0; i1 < values0.length; ++i1) {
            if (values0[i1] == null) {
              encoder2.encodeNullPointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            } else {
              var encoder3 = encoder2.encoderForMap(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1);
              var keys2 = values0[i1].keys.toList();
              var values2 = values0[i1].values.toList();
              
              {
                var encoder4 = encoder3.encodePointerArray(keys2.length, bindings.ArrayDataHeader.kHeaderSize, bindings.kUnspecifiedArrayLength);
                for (int i3 = 0; i3 < keys2.length; ++i3) {
                  encoder4.encodeString(keys2[i3], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i3, false);
                }
              }
              encoder3.encodeHandleArray(values2, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
            }
          }
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f11 of struct MapValueTypes: $e";
      rethrow;
    }
  }

  String toString() {
    return "MapValueTypes("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ArrayValueTypes extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  List<int> f0 = null;
  List<int> f1 = null;
  List<int> f2 = null;
  List<int> f3 = null;
  List<double> f4 = null;
  List<double> f5 = null;

  ArrayValueTypes() : super(kVersions.last.size);

  static ArrayValueTypes deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ArrayValueTypes decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ArrayValueTypes result = new ArrayValueTypes();

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
      
      result.f0 = decoder0.decodeInt8Array(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeInt16Array(16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeInt32Array(24, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeInt64Array(32, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeFloatArray(40, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeDoubleArray(48, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt8Array(f0, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct ArrayValueTypes: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16Array(f1, 16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct ArrayValueTypes: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32Array(f2, 24, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct ArrayValueTypes: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64Array(f3, 32, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct ArrayValueTypes: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloatArray(f4, 40, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct ArrayValueTypes: $e";
      rethrow;
    }
    try {
      encoder0.encodeDoubleArray(f5, 48, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct ArrayValueTypes: $e";
      rethrow;
    }
  }

  String toString() {
    return "ArrayValueTypes("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    return map;
  }
}


class FloatNumberValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(72, 0)
  ];
  static const double v0 = double.INFINITY;
  static const double v1 = double.NEGATIVE_INFINITY;
  static const double v2 = double.NAN;
  static const double v3 = double.INFINITY;
  static const double v4 = double.NEGATIVE_INFINITY;
  static const double v5 = double.NAN;
  static const double v6 = 0.0;
  static const double v7 = 1234567890.123;
  static const double v8 = 1.2e+20;
  static const double v9 = -1.2e+20;
  double f0 = double.INFINITY;
  double f1 = double.NEGATIVE_INFINITY;
  double f2 = double.NAN;
  double f3 = double.INFINITY;
  double f4 = double.NEGATIVE_INFINITY;
  double f5 = double.NAN;
  double f6 = 0.0;
  double f7 = 1234567890.123;
  double f8 = 1.2e+20;
  double f9 = -1.2e+20;

  FloatNumberValues() : super(kVersions.last.size);

  static FloatNumberValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FloatNumberValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FloatNumberValues result = new FloatNumberValues();

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
      
      result.f0 = decoder0.decodeDouble(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeDouble(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeDouble(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeFloat(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeFloat(36);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeFloat(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeFloat(44);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeDouble(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeDouble(56);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeDouble(64);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeDouble(f0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f1, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f2, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(f3, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(f4, 36);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(f5, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeFloat(f6, 44);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f7, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f7 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f8, 56);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f8 of struct FloatNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeDouble(f9, 64);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f9 of struct FloatNumberValues: $e";
      rethrow;
    }
  }

  String toString() {
    return "FloatNumberValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    return map;
  }
}


class IntegerNumberValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(88, 0)
  ];
  static const int v0 = -128;
  static const int v1 = -1;
  static const int v2 = 0;
  static const int v3 = 42;
  static const int v4 = 127;
  static const int v5 = -32768;
  static const int v6 = -1;
  static const int v7 = 0;
  static const int v8 = 12345;
  static const int v9 = 32767;
  static const int v10 = -2147483648;
  static const int v11 = -1;
  static const int v12 = 0;
  static const int v13 = 1234567890;
  static const int v14 = 2147483647;
  static const int v15 = -9007199254740991;
  static const int v16 = -1;
  static const int v17 = 0;
  static const int v18 = 1234567890123456;
  static const int v19 = 9007199254740991;
  int f0 = -128;
  int f1 = -1;
  int f2 = 0;
  int f3 = 42;
  int f4 = 127;
  int f5 = -32768;
  int f6 = -1;
  int f7 = 0;
  int f8 = 12345;
  int f9 = 32767;
  int f10 = -2147483648;
  int f11 = -1;
  int f12 = 0;
  int f13 = 1234567890;
  int f14 = 2147483647;
  int f15 = -9007199254740991;
  int f16 = -1;
  int f17 = 0;
  int f18 = 1234567890123456;
  int f19 = 9007199254740991;

  IntegerNumberValues() : super(kVersions.last.size);

  static IntegerNumberValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static IntegerNumberValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    IntegerNumberValues result = new IntegerNumberValues();

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
      
      result.f0 = decoder0.decodeInt8(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeInt8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeInt8(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeInt8(11);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeInt8(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeInt16(14);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeInt16(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeInt16(18);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeInt16(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeInt16(22);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f10 = decoder0.decodeInt32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f11 = decoder0.decodeInt32(28);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f12 = decoder0.decodeInt32(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f13 = decoder0.decodeInt32(36);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f14 = decoder0.decodeInt32(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f15 = decoder0.decodeInt64(48);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f16 = decoder0.decodeInt64(56);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f17 = decoder0.decodeInt64(64);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f18 = decoder0.decodeInt64(72);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f19 = decoder0.decodeInt64(80);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt8(f0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(f1, 9);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(f2, 10);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(f3, 11);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8(f4, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(f5, 14);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(f6, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(f7, 18);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f7 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(f8, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f8 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(f9, 22);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f9 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f10, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f10 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f11, 28);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f11 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f12, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f12 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f13, 36);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f13 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(f14, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f14 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(f15, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f15 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(f16, 56);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f16 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(f17, 64);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f17 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(f18, 72);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f18 of struct IntegerNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(f19, 80);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f19 of struct IntegerNumberValues: $e";
      rethrow;
    }
  }

  String toString() {
    return "IntegerNumberValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ", "
           "f12: $f12" ", "
           "f13: $f13" ", "
           "f14: $f14" ", "
           "f15: $f15" ", "
           "f16: $f16" ", "
           "f17: $f17" ", "
           "f18: $f18" ", "
           "f19: $f19" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    map["f10"] = f10;
    map["f11"] = f11;
    map["f12"] = f12;
    map["f13"] = f13;
    map["f14"] = f14;
    map["f15"] = f15;
    map["f16"] = f16;
    map["f17"] = f17;
    map["f18"] = f18;
    map["f19"] = f19;
    return map;
  }
}


class UnsignedNumberValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(56, 0)
  ];
  static const int v0 = 0;
  static const int v1 = 42;
  static const int v2 = 255;
  static const int v3 = 0;
  static const int v4 = 12345;
  static const int v5 = 65535;
  static const int v6 = 0;
  static const int v7 = 1234567890;
  static const int v8 = 4294967295;
  static const int v9 = 0;
  static const int v10 = 1234567890123456;
  static const int v11 = 9007199254740991;
  int f0 = 0;
  int f1 = 42;
  int f2 = 255;
  int f3 = 0;
  int f4 = 12345;
  int f5 = 65535;
  int f6 = 0;
  int f7 = 1234567890;
  int f8 = 4294967295;
  int f9 = 0;
  int f10 = 1234567890123456;
  int f11 = 9007199254740991;

  UnsignedNumberValues() : super(kVersions.last.size);

  static UnsignedNumberValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UnsignedNumberValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UnsignedNumberValues result = new UnsignedNumberValues();

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
      
      result.f0 = decoder0.decodeUint8(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeUint8(9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeUint8(10);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeUint16(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f4 = decoder0.decodeUint16(14);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f5 = decoder0.decodeUint16(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f6 = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f7 = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f8 = decoder0.decodeUint32(28);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f9 = decoder0.decodeUint64(32);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f10 = decoder0.decodeUint64(40);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f11 = decoder0.decodeUint64(48);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8(f0, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8(f1, 9);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8(f2, 10);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(f3, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(f4, 14);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint16(f5, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(f6, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(f7, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f7 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(f8, 28);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f8 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(f9, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f9 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(f10, 40);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f10 of struct UnsignedNumberValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(f11, 48);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f11 of struct UnsignedNumberValues: $e";
      rethrow;
    }
  }

  String toString() {
    return "UnsignedNumberValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ", "
           "f7: $f7" ", "
           "f8: $f8" ", "
           "f9: $f9" ", "
           "f10: $f10" ", "
           "f11: $f11" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    map["f7"] = f7;
    map["f8"] = f8;
    map["f9"] = f9;
    map["f10"] = f10;
    map["f11"] = f11;
    return map;
  }
}


class BitArrayValues extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(64, 0)
  ];
  List<bool> f0 = null;
  List<bool> f1 = null;
  List<bool> f2 = null;
  List<bool> f3 = null;
  List<List<bool>> f4 = null;
  List<List<bool>> f5 = null;
  List<List<bool>> f6 = null;

  BitArrayValues() : super(kVersions.last.size);

  static BitArrayValues deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static BitArrayValues decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    BitArrayValues result = new BitArrayValues();

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
      
      result.f0 = decoder0.decodeBoolArray(8, bindings.kNothingNullable, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f1 = decoder0.decodeBoolArray(16, bindings.kNothingNullable, 7);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f2 = decoder0.decodeBoolArray(24, bindings.kNothingNullable, 9);
    }
    if (mainDataHeader.version >= 0) {
      
      result.f3 = decoder0.decodeBoolArray(32, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(40, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f4 = new List<List<bool>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f4[i1] = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(48, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f5 = new List<List<bool>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f5[i1] = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(56, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.f6 = new List<List<bool>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.f6[i1] = decoder1.decodeBoolArray(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kArrayNullable, 2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBoolArray(f0, 8, bindings.kNothingNullable, 1);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f0 of struct BitArrayValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeBoolArray(f1, 16, bindings.kNothingNullable, 7);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f1 of struct BitArrayValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeBoolArray(f2, 24, bindings.kNothingNullable, 9);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f2 of struct BitArrayValues: $e";
      rethrow;
    }
    try {
      encoder0.encodeBoolArray(f3, 32, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f3 of struct BitArrayValues: $e";
      rethrow;
    }
    try {
      if (f4 == null) {
        encoder0.encodeNullPointer(40, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(f4.length, 40, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < f4.length; ++i0) {
          encoder1.encodeBoolArray(f4[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f4 of struct BitArrayValues: $e";
      rethrow;
    }
    try {
      if (f5 == null) {
        encoder0.encodeNullPointer(48, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(f5.length, 48, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < f5.length; ++i0) {
          encoder1.encodeBoolArray(f5[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f5 of struct BitArrayValues: $e";
      rethrow;
    }
    try {
      if (f6 == null) {
        encoder0.encodeNullPointer(56, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(f6.length, 56, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < f6.length; ++i0) {
          encoder1.encodeBoolArray(f6[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kArrayNullable, 2);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "f6 of struct BitArrayValues: $e";
      rethrow;
    }
  }

  String toString() {
    return "BitArrayValues("
           "f0: $f0" ", "
           "f1: $f1" ", "
           "f2: $f2" ", "
           "f3: $f3" ", "
           "f4: $f4" ", "
           "f5: $f5" ", "
           "f6: $f6" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["f0"] = f0;
    map["f1"] = f1;
    map["f2"] = f2;
    map["f3"] = f3;
    map["f4"] = f4;
    map["f5"] = f5;
    map["f6"] = f6;
    return map;
  }
}


class MultiVersionStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1),
    const bindings.StructDataHeader(32, 3),
    const bindings.StructDataHeader(40, 5),
    const bindings.StructDataHeader(48, 7),
    const bindings.StructDataHeader(48, 9)
  ];
  int fInt32 = 0;
  core.MojoMessagePipeEndpoint fMessagePipe = null;
  rect_mojom.Rect fRect = null;
  String fString = null;
  List<int> fArray = null;
  bool fBool = false;
  int fInt16 = 0;

  MultiVersionStruct() : super(kVersions.last.size);

  static MultiVersionStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStruct result = new MultiVersionStruct();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 7) {
      
      result.fMessagePipe = decoder0.decodeMessagePipeHandle(12, true);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 3) {
      
      result.fString = decoder0.decodeString(24, true);
    }
    if (mainDataHeader.version >= 5) {
      
      result.fArray = decoder0.decodeInt8Array(32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 7) {
      
      result.fBool = decoder0.decodeBool(40, 0);
    }
    if (mainDataHeader.version >= 9) {
      
      result.fInt16 = decoder0.decodeInt16(42);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(fInt32, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt32 of struct MultiVersionStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(fMessagePipe, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fMessagePipe of struct MultiVersionStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(fRect, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fRect of struct MultiVersionStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(fString, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fString of struct MultiVersionStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8Array(fArray, 32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fArray of struct MultiVersionStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(fBool, 40, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fBool of struct MultiVersionStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt16(fInt16, 42);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt16 of struct MultiVersionStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "MultiVersionStruct("
           "fInt32: $fInt32" ", "
           "fMessagePipe: $fMessagePipe" ", "
           "fRect: $fRect" ", "
           "fString: $fString" ", "
           "fArray: $fArray" ", "
           "fBool: $fBool" ", "
           "fInt16: $fInt16" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class MultiVersionStructV0 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int fInt32 = 0;

  MultiVersionStructV0() : super(kVersions.last.size);

  static MultiVersionStructV0 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV0 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV0 result = new MultiVersionStructV0();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(fInt32, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt32 of struct MultiVersionStructV0: $e";
      rethrow;
    }
  }

  String toString() {
    return "MultiVersionStructV0("
           "fInt32: $fInt32" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fInt32"] = fInt32;
    return map;
  }
}


class MultiVersionStructV1 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1)
  ];
  int fInt32 = 0;
  rect_mojom.Rect fRect = null;

  MultiVersionStructV1() : super(kVersions.last.size);

  static MultiVersionStructV1 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV1 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV1 result = new MultiVersionStructV1();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(fInt32, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt32 of struct MultiVersionStructV1: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(fRect, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fRect of struct MultiVersionStructV1: $e";
      rethrow;
    }
  }

  String toString() {
    return "MultiVersionStructV1("
           "fInt32: $fInt32" ", "
           "fRect: $fRect" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fInt32"] = fInt32;
    map["fRect"] = fRect;
    return map;
  }
}


class MultiVersionStructV3 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1),
    const bindings.StructDataHeader(32, 3)
  ];
  int fInt32 = 0;
  rect_mojom.Rect fRect = null;
  String fString = null;

  MultiVersionStructV3() : super(kVersions.last.size);

  static MultiVersionStructV3 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV3 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV3 result = new MultiVersionStructV3();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 3) {
      
      result.fString = decoder0.decodeString(24, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(fInt32, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt32 of struct MultiVersionStructV3: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(fRect, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fRect of struct MultiVersionStructV3: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(fString, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fString of struct MultiVersionStructV3: $e";
      rethrow;
    }
  }

  String toString() {
    return "MultiVersionStructV3("
           "fInt32: $fInt32" ", "
           "fRect: $fRect" ", "
           "fString: $fString" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fInt32"] = fInt32;
    map["fRect"] = fRect;
    map["fString"] = fString;
    return map;
  }
}


class MultiVersionStructV5 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1),
    const bindings.StructDataHeader(32, 3),
    const bindings.StructDataHeader(40, 5)
  ];
  int fInt32 = 0;
  rect_mojom.Rect fRect = null;
  String fString = null;
  List<int> fArray = null;

  MultiVersionStructV5() : super(kVersions.last.size);

  static MultiVersionStructV5 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV5 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV5 result = new MultiVersionStructV5();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 3) {
      
      result.fString = decoder0.decodeString(24, true);
    }
    if (mainDataHeader.version >= 5) {
      
      result.fArray = decoder0.decodeInt8Array(32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(fInt32, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt32 of struct MultiVersionStructV5: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(fRect, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fRect of struct MultiVersionStructV5: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(fString, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fString of struct MultiVersionStructV5: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8Array(fArray, 32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fArray of struct MultiVersionStructV5: $e";
      rethrow;
    }
  }

  String toString() {
    return "MultiVersionStructV5("
           "fInt32: $fInt32" ", "
           "fRect: $fRect" ", "
           "fString: $fString" ", "
           "fArray: $fArray" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["fInt32"] = fInt32;
    map["fRect"] = fRect;
    map["fString"] = fString;
    map["fArray"] = fArray;
    return map;
  }
}


class MultiVersionStructV7 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1),
    const bindings.StructDataHeader(32, 3),
    const bindings.StructDataHeader(40, 5),
    const bindings.StructDataHeader(48, 7)
  ];
  int fInt32 = 0;
  core.MojoMessagePipeEndpoint fMessagePipe = null;
  rect_mojom.Rect fRect = null;
  String fString = null;
  List<int> fArray = null;
  bool fBool = false;

  MultiVersionStructV7() : super(kVersions.last.size);

  static MultiVersionStructV7 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MultiVersionStructV7 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MultiVersionStructV7 result = new MultiVersionStructV7();

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
      
      result.fInt32 = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 7) {
      
      result.fMessagePipe = decoder0.decodeMessagePipeHandle(12, true);
    }
    if (mainDataHeader.version >= 1) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fRect = rect_mojom.Rect.decode(decoder1);
    }
    if (mainDataHeader.version >= 3) {
      
      result.fString = decoder0.decodeString(24, true);
    }
    if (mainDataHeader.version >= 5) {
      
      result.fArray = decoder0.decodeInt8Array(32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 7) {
      
      result.fBool = decoder0.decodeBool(40, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(fInt32, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fInt32 of struct MultiVersionStructV7: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(fMessagePipe, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fMessagePipe of struct MultiVersionStructV7: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(fRect, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fRect of struct MultiVersionStructV7: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(fString, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fString of struct MultiVersionStructV7: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt8Array(fArray, 32, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fArray of struct MultiVersionStructV7: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(fBool, 40, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fBool of struct MultiVersionStructV7: $e";
      rethrow;
    }
  }

  String toString() {
    return "MultiVersionStructV7("
           "fInt32: $fInt32" ", "
           "fMessagePipe: $fMessagePipe" ", "
           "fRect: $fRect" ", "
           "fString: $fString" ", "
           "fArray: $fArray" ", "
           "fBool: $fBool" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ContainsInterface extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object someInterface = null;

  ContainsInterface() : super(kVersions.last.size);

  static ContainsInterface deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContainsInterface decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContainsInterface result = new ContainsInterface();

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
      
      result.someInterface = decoder0.decodeServiceInterface(8, false, SomeInterfaceProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(someInterface, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "someInterface of struct ContainsInterface: $e";
      rethrow;
    }
  }

  String toString() {
    return "ContainsInterface("
           "someInterface: $someInterface" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ContainsOther extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int other = 0;

  ContainsOther() : super(kVersions.last.size);

  static ContainsOther deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContainsOther decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContainsOther result = new ContainsOther();

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
      
      result.other = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(other, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "other of struct ContainsOther: $e";
      rethrow;
    }
  }

  String toString() {
    return "ContainsOther("
           "other: $other" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["other"] = other;
    return map;
  }
}


class ContainsInterfaceRequest extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object req = null;
  Object nullableReq = null;

  ContainsInterfaceRequest() : super(kVersions.last.size);

  static ContainsInterfaceRequest deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ContainsInterfaceRequest decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ContainsInterfaceRequest result = new ContainsInterfaceRequest();

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
      
      result.req = decoder0.decodeInterfaceRequest(8, false, SomeInterfaceStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.nullableReq = decoder0.decodeInterfaceRequest(12, true, SomeInterfaceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(req, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "req of struct ContainsInterfaceRequest: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(nullableReq, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "nullableReq of struct ContainsInterfaceRequest: $e";
      rethrow;
    }
  }

  String toString() {
    return "ContainsInterfaceRequest("
           "req: $req" ", "
           "nullableReq: $nullableReq" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class DartKeywordStructKeywords extends bindings.MojoEnum {
  static const DartKeywordStructKeywords await_ = const DartKeywordStructKeywords._(0);
  static const DartKeywordStructKeywords is_ = const DartKeywordStructKeywords._(1);
  static const DartKeywordStructKeywords rethrow_ = const DartKeywordStructKeywords._(2);

  const DartKeywordStructKeywords._(int v) : super(v);

  static const Map<String, DartKeywordStructKeywords> valuesMap = const {
    "await_": await_,
    "is_": is_,
    "rethrow_": rethrow_,
  };
  static const List<DartKeywordStructKeywords> values = const [
    await_,
    is_,
    rethrow_,
  ];

  static DartKeywordStructKeywords valueOf(String name) => valuesMap[name];

  factory DartKeywordStructKeywords(int v) {
    switch (v) {
      case 0:
        return DartKeywordStructKeywords.await_;
      case 1:
        return DartKeywordStructKeywords.is_;
      case 2:
        return DartKeywordStructKeywords.rethrow_;
      default:
        return null;
    }
  }

  static DartKeywordStructKeywords decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    DartKeywordStructKeywords result = new DartKeywordStructKeywords(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum DartKeywordStructKeywords.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case await_:
        return 'DartKeywordStructKeywords.await_';
      case is_:
        return 'DartKeywordStructKeywords.is_';
      case rethrow_:
        return 'DartKeywordStructKeywords.rethrow_';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class DartKeywordStruct extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  DartKeywordStructKeywords await_ = null;
  DartKeywordStructKeywords is_ = null;
  DartKeywordStructKeywords rethrow_ = null;

  DartKeywordStruct() : super(kVersions.last.size);

  static DartKeywordStruct deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DartKeywordStruct decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DartKeywordStruct result = new DartKeywordStruct();

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
      
        result.await_ = DartKeywordStructKeywords.decode(decoder0, 8);
        if (result.await_ == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable DartKeywordStructKeywords.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.is_ = DartKeywordStructKeywords.decode(decoder0, 12);
        if (result.is_ == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable DartKeywordStructKeywords.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
        result.rethrow_ = DartKeywordStructKeywords.decode(decoder0, 16);
        if (result.rethrow_ == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable DartKeywordStructKeywords.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(await_, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "await_ of struct DartKeywordStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(is_, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "is_ of struct DartKeywordStruct: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(rethrow_, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rethrow_ of struct DartKeywordStruct: $e";
      rethrow;
    }
  }

  String toString() {
    return "DartKeywordStruct("
           "await_: $await_" ", "
           "is_: $is_" ", "
           "rethrow_: $rethrow_" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["await_"] = await_;
    map["is_"] = is_;
    map["rethrow_"] = rethrow_;
    return map;
  }
}


class _SomeInterfaceSomeMethodParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  RectPair pair = null;

  _SomeInterfaceSomeMethodParams() : super(kVersions.last.size);

  static _SomeInterfaceSomeMethodParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SomeInterfaceSomeMethodParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SomeInterfaceSomeMethodParams result = new _SomeInterfaceSomeMethodParams();

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
      result.pair = RectPair.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(pair, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pair of struct _SomeInterfaceSomeMethodParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SomeInterfaceSomeMethodParams("
           "pair: $pair" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["pair"] = pair;
    return map;
  }
}


class SomeInterfaceSomeMethodResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  RectPair otherPair = null;

  SomeInterfaceSomeMethodResponseParams() : super(kVersions.last.size);

  static SomeInterfaceSomeMethodResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SomeInterfaceSomeMethodResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SomeInterfaceSomeMethodResponseParams result = new SomeInterfaceSomeMethodResponseParams();

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
      result.otherPair = RectPair.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(otherPair, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "otherPair of struct SomeInterfaceSomeMethodResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "SomeInterfaceSomeMethodResponseParams("
           "otherPair: $otherPair" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["otherPair"] = otherPair;
    return map;
  }
}



enum UnionOfStructsTag {
  nr,
  aNr,
  aRp,
  mNdfv,
  mHs,
  unknown
}

class UnionOfStructs extends bindings.Union {
  static final _tagToInt = const {
    UnionOfStructsTag.nr: 0,
    UnionOfStructsTag.aNr: 1,
    UnionOfStructsTag.aRp: 2,
    UnionOfStructsTag.mNdfv: 3,
    UnionOfStructsTag.mHs: 4,
  };

  static final _intToTag = const {
    0: UnionOfStructsTag.nr,
    1: UnionOfStructsTag.aNr,
    2: UnionOfStructsTag.aRp,
    3: UnionOfStructsTag.mNdfv,
    4: UnionOfStructsTag.mHs,
  };

  var _data;
  UnionOfStructsTag _tag = UnionOfStructsTag.unknown;

  UnionOfStructsTag get tag => _tag;
  NamedRegion get nr {
    if (_tag != UnionOfStructsTag.nr) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.nr);
    }
    return _data;
  }

  set nr(NamedRegion value) {
    _tag = UnionOfStructsTag.nr;
    _data = value;
  }
  List<NamedRegion> get aNr {
    if (_tag != UnionOfStructsTag.aNr) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.aNr);
    }
    return _data;
  }

  set aNr(List<NamedRegion> value) {
    _tag = UnionOfStructsTag.aNr;
    _data = value;
  }
  List<RectPair> get aRp {
    if (_tag != UnionOfStructsTag.aRp) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.aRp);
    }
    return _data;
  }

  set aRp(List<RectPair> value) {
    _tag = UnionOfStructsTag.aRp;
    _data = value;
  }
  Map<int, NoDefaultFieldValues> get mNdfv {
    if (_tag != UnionOfStructsTag.mNdfv) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.mNdfv);
    }
    return _data;
  }

  set mNdfv(Map<int, NoDefaultFieldValues> value) {
    _tag = UnionOfStructsTag.mNdfv;
    _data = value;
  }
  Map<int, HandleStruct> get mHs {
    if (_tag != UnionOfStructsTag.mHs) {
      throw new bindings.UnsetUnionTagError(_tag, UnionOfStructsTag.mHs);
    }
    return _data;
  }

  set mHs(Map<int, HandleStruct> value) {
    _tag = UnionOfStructsTag.mHs;
    _data = value;
  }

  static UnionOfStructs decode(bindings.Decoder decoder0, int offset) {
    int size = decoder0.decodeUint32(offset);
    if (size == 0) {
      return null;
    }
    UnionOfStructs result = new UnionOfStructs();

    
    UnionOfStructsTag tag = _intToTag[decoder0.decodeUint32(offset + 4)];
    switch (tag) {
      case UnionOfStructsTag.nr:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        result.nr = NamedRegion.decode(decoder1);
        break;
      case UnionOfStructsTag.aNr:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
          result.aNr = new List<NamedRegion>(si1.numElements);
          for (int i1 = 0; i1 < si1.numElements; ++i1) {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            result.aNr[i1] = NamedRegion.decode(decoder2);
          }
        }
        break;
      case UnionOfStructsTag.aRp:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
          result.aRp = new List<RectPair>(si1.numElements);
          for (int i1 = 0; i1 < si1.numElements; ++i1) {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            result.aRp[i1] = RectPair.decode(decoder2);
          }
        }
        break;
      case UnionOfStructsTag.mNdfv:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          decoder1.decodeDataHeaderForMap();
          List<int> keys0;
          List<NoDefaultFieldValues> values0;
          {
            
            keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          }
          {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
            {
              var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
              values0 = new List<NoDefaultFieldValues>(si2.numElements);
              for (int i2 = 0; i2 < si2.numElements; ++i2) {
                
                var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
                values0[i2] = NoDefaultFieldValues.decode(decoder3);
              }
            }
          }
          result.mNdfv = new Map<int, NoDefaultFieldValues>.fromIterables(
              keys0, values0);
        }
        break;
      case UnionOfStructsTag.mHs:
        
        var decoder1 = decoder0.decodePointer(offset + 8, false);
        {
          decoder1.decodeDataHeaderForMap();
          List<int> keys0;
          List<HandleStruct> values0;
          {
            
            keys0 = decoder1.decodeInt64Array(bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          }
          {
            
            var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, false);
            {
              var si2 = decoder2.decodeDataHeaderForPointerArray(keys0.length);
              values0 = new List<HandleStruct>(si2.numElements);
              for (int i2 = 0; i2 < si2.numElements; ++i2) {
                
                var decoder3 = decoder2.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i2, false);
                values0[i2] = HandleStruct.decode(decoder3);
              }
            }
          }
          result.mHs = new Map<int, HandleStruct>.fromIterables(
              keys0, values0);
        }
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
      case UnionOfStructsTag.nr:
        encoder0.encodeStruct(nr, offset + 8, false);
        break;
      case UnionOfStructsTag.aNr:
        if (aNr == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encodePointerArray(aNr.length, offset + 8, bindings.kUnspecifiedArrayLength);
          for (int i0 = 0; i0 < aNr.length; ++i0) {
            encoder1.encodeStruct(aNr[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
          }
        }
        break;
      case UnionOfStructsTag.aRp:
        if (aRp == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encodePointerArray(aRp.length, offset + 8, bindings.kUnspecifiedArrayLength);
          for (int i0 = 0; i0 < aRp.length; ++i0) {
            encoder1.encodeStruct(aRp[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
          }
        }
        break;
      case UnionOfStructsTag.mNdfv:
        if (mNdfv == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encoderForMap(offset + 8);
          var keys0 = mNdfv.keys.toList();
          var values0 = mNdfv.values.toList();
          encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          
          {
            var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
            for (int i1 = 0; i1 < values0.length; ++i1) {
              encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            }
          }
        }
        break;
      case UnionOfStructsTag.mHs:
        if (mHs == null) {
          encoder0.encodeNullPointer(offset + 8, false);
        } else {
          var encoder1 = encoder0.encoderForMap(offset + 8);
          var keys0 = mHs.keys.toList();
          var values0 = mHs.values.toList();
          encoder1.encodeInt64Array(keys0, bindings.ArrayDataHeader.kHeaderSize, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
          
          {
            var encoder2 = encoder1.encodePointerArray(values0.length, bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize, bindings.kUnspecifiedArrayLength);
            for (int i1 = 0; i1 < values0.length; ++i1) {
              encoder2.encodeStruct(values0[i1], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
            }
          }
        }
        break;
      default:
        throw new bindings.MojoCodecError("Bad union tag: $_tag");
    }
  }

  String toString() {
    String result = "UnionOfStructs(";
    switch (_tag) {
      case UnionOfStructsTag.nr:
        result += "nr";
        break;
      case UnionOfStructsTag.aNr:
        result += "aNr";
        break;
      case UnionOfStructsTag.aRp:
        result += "aRp";
        break;
      case UnionOfStructsTag.mNdfv:
        result += "mNdfv";
        break;
      case UnionOfStructsTag.mHs:
        result += "mHs";
        break;
      default:
        result += "unknown";
    }
    result += ": $_data)";
    return result;
  }
}
const int _someInterfaceMethodSomeMethodName = 0;

class _SomeInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class SomeInterface {
  static const String serviceName = null;
  dynamic someMethod(RectPair pair,[Function responseFactory = null]);
}

class _SomeInterfaceProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _SomeInterfaceProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SomeInterfaceProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _SomeInterfaceProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _SomeInterfaceServiceDescription();

  String get serviceName => SomeInterface.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _someInterfaceMethodSomeMethodName:
        var r = SomeInterfaceSomeMethodResponseParams.deserialize(
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
    return "_SomeInterfaceProxyControl($superString)";
  }
}

class SomeInterfaceProxy
    extends bindings.Proxy
    implements SomeInterface {
  SomeInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _SomeInterfaceProxyControl.fromEndpoint(endpoint));

  SomeInterfaceProxy.fromHandle(core.MojoHandle handle)
      : super(new _SomeInterfaceProxyControl.fromHandle(handle));

  SomeInterfaceProxy.unbound()
      : super(new _SomeInterfaceProxyControl.unbound());

  static SomeInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SomeInterfaceProxy"));
    return new SomeInterfaceProxy.fromEndpoint(endpoint);
  }

  factory SomeInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SomeInterfaceProxy p = new SomeInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic someMethod(RectPair pair,[Function responseFactory = null]) {
    var params = new _SomeInterfaceSomeMethodParams();
    params.pair = pair;
    return ctrl.sendMessageWithRequestId(
        params,
        _someInterfaceMethodSomeMethodName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _SomeInterfaceStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<SomeInterface> {
  SomeInterface _impl;

  _SomeInterfaceStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [SomeInterface impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _SomeInterfaceStubControl.fromHandle(
      core.MojoHandle handle, [SomeInterface impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _SomeInterfaceStubControl.unbound([this._impl]) : super.unbound();


  SomeInterfaceSomeMethodResponseParams _someInterfaceSomeMethodResponseParamsFactory(RectPair otherPair) {
    var result = new SomeInterfaceSomeMethodResponseParams();
    result.otherPair = otherPair;
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
      case _someInterfaceMethodSomeMethodName:
        var params = _SomeInterfaceSomeMethodParams.deserialize(
            message.payload);
        var response = _impl.someMethod(params.pair,_someInterfaceSomeMethodResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _someInterfaceMethodSomeMethodName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _someInterfaceMethodSomeMethodName,
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

  SomeInterface get impl => _impl;
  set impl(SomeInterface d) {
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
    return "_SomeInterfaceStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SomeInterfaceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class SomeInterfaceStub
    extends bindings.Stub<SomeInterface>
    implements SomeInterface {
  SomeInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [SomeInterface impl])
      : super(new _SomeInterfaceStubControl.fromEndpoint(endpoint, impl));

  SomeInterfaceStub.fromHandle(
      core.MojoHandle handle, [SomeInterface impl])
      : super(new _SomeInterfaceStubControl.fromHandle(handle, impl));

  SomeInterfaceStub.unbound([SomeInterface impl])
      : super(new _SomeInterfaceStubControl.unbound(impl));

  static SomeInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SomeInterfaceStub"));
    return new SomeInterfaceStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _SomeInterfaceStubControl.serviceDescription;


  dynamic someMethod(RectPair pair,[Function responseFactory = null]) {
    return impl.someMethod(pair,responseFactory);
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+ydWXAbR3qAZ3CQIHVBsg7Kkmyspcj0RQI8wU2yS9miQsWWxJVkmc5uloSIIQEbBGAAjCknznKzu1WsSjZRbr4kYTaX8pIox1apal9clYcoxyZKHlJ81CMfmWQrUVKb7M4Qf4szje7GdM+gp2GSVXB7qG5i5uue/v/+/7//7tHqP3Eok1Div0dlDCvxeuWOevnE/DxnfrZQPb1ejkOZg3INygdQPoYyHqqXaSinoVyBch3Kh1BuQhkLw3NAOQ3lCpT3oHwE5RMoeyJwf1DmoFyF8j6UG1A+gTIRrZeTUL5sfl4wPzffnZqYeXPi3c8ult4r9dWMaq3vQqWSuXMrU1gybt4pG9V6/ZfMz2fI9V/P13aaQHXtVfNzjlz/jVKxlskXq5eLNaMyn5kzrPqD5ucVl/WvGx+YX1Tb/p5e69nY7a7VckaFcT8XM5Xam8adD0uV7I1aZWlu+w8Pm5/XXNbvg6sqtPkRSjtjPrNUqF3KG4XsU1bnYfwR6k8slmt30B0x7v9SoZSpXV1avG1UdrrgRfPzPLn+ZKaYLRjwh/vgHgj1LN4LRsX5lxn3eyVTNkHAmGH0i1lvZ3QxeF0xYeVvGZVqvlR82jH98Gyu6t9KctZPcdYf5Kw/zFl/lMX7ambRyF43FszqTC5XS4SRx6q/VChkbhcMxzg5a9Y9Ra5/3ZirTWXylWbzyo25UtnImm9ltZYp1qo783ivq/p9E9aAYYyrG6VF4+kcwbqP7Se6Nl8vm89vbxdNwlh1Fr+3i9X8QtHIOl6cTb3ej5b8sUTHhr4jj6z/zXU7r1ePOq+nTjiv1045rzfPYHLwnPPft3qd1yvjzusHF7Dvu+m8fvKO81r7GGv/Ted1/FvO6+SfOa837mPf923n9fR3sO/7G+f1+ncxXv/ivH74Ped1+Ql2/X0nr559+tNrS9TeP6I76o8/u3NtifCVs85/j79av07g+gb08ywoIoD96Q/SY9DvfwA/0xr5xxoGh8wPLqStsXvS/DQR4w160J+bn07zkzU/X7LG9VK10l8ozWUK/Qul0kLB6M+Zr1X/R5VMv/Wn+6uVufr/lJduF/Jz/Xn0wlX7b+eL2XxxodpvfX39vzPV+kvTZzVZ3NaTzE+H7bmndae+9FTvQfpL1Mknbbv/EOhvbn5o3DUbd6RPkH664fvmk2SO1nA+KJFjArt3dB9hTYxXTICX7oZXiszrL2AcB80rIsgrLsAr5IbXAJnXXyrCKyrIq0eAV9gNr0Eyr79ShFeHIK+EAK+IG15DZF5/rQivkCCvXgFeUTe8hsm8vg3/HzQvXXPqNTHC+9Zh44jrJzH4A1tdfPrJFIXbcZCDuFEgAd9JMxvgfAd0uXrJOOhBiNMscFmFAXk/7LSrJODFznW2h34yaD7P4YDGq86Ql6rqJ0MB8ur0gZds/WQ4QF5dPvCSrZ+M6GqsF7Q20U9GTV7HAuYVss1DfvOUrb+k9bqsVo2n7hPPpADPDjc8R8g8x/S6/UVFniHC/MjSFzttvHB9EfnH1kJsrpOYvjhL4Woxs+QG0Slk/iC7cxP3UUN/FCXrjzhP0niN2hV2n/TBZBM9vGo+5Ux+BxXOqaQHt46x3wf6vTXHHzA/DmM+28/nqMoa1zrh+9C/J3TMv+pyXOcY8rGHNK7BeYn8Ey7dnA39tix5fPdg88iyzh7nstY9+8DmWTE+IHK6E5BeGmrR+OadVyKC6ybavGK5pfZb8ys4CWcAPM79I/OPHAmAeziAeSXEmFeQfSUR8se+gp7DEdwAvv4TxPmkXgPvn5qC8tFuX271vHEAvqsE/HA+S3r9XoPi41ZuoXkY95O51cc2KPoYMSiGqI+Ra+I8Pw5AXmku9F7ROJ8EzDXoe1ZRP4TUkItofGc+zORrBB5f0+uyM2i9z35fVp8gxKL9wss90iK7Yr5K1tu+vsdd2J7Lsk8egnVrxajlKqUPG7h/41PKnSU37PMTyf7D4p5uEo/ykPIcKE7R5e033NfPS5YTvHGh+LyP4oRnQ047XkJwfk+7tJug+f3COxcuW6FaAxB754Z7H2pE4P8VvT4nyuLfjJeueRun+Lx8+Ub9GsXvueJlNsI5rSjGKeTTuELz6PWJm5PXr72jDcE74ooTakQYV1+VzIumJ8+e8EdPflarr2+JQd0wp5x2ciPWxDl9UQtGT8blMi5X0PziKq697/1LpVK93V1YT6yiODnoh42QUwHrhfXLFPjVl8Gvvg438BDiE7YgTrZnP/TjAfDDH4TvOwT/fhjaH7EZLhjrTlxObwbkp/9pTf66HO930ryL8wpTeOmS/fRfVoBXGL6fxauTwisk2U8/o8m3a4jwilB4RST76WfbhFeMwqtDsp8+A/EYqvOKUnjFJPvhb7fJ+Oqi8Nov2c8+1ybjq4PCSyQuq9MNr1Eyr2ybjK9uCi+RuKyYG15pMi+jTcZXiMJLJC6ryw2vMTKv+TYZXzRe5wR4dbvwR8+nkkReCwrw2tHR3x2n8dIpvETi1Pa54pUi8sq1yftI4yUSh7bfFa8BIq+8AryajS/d5hdA7Z9g9Xh4HXDFa5DI672AeDWLw8P9Bfth7YMsK6L2GN7+GBfoj4Ou+mOI+Lzvg8yR3R+6Qv0RxfpDt/lrJgX645Cr/hgmPm9Bsn2lmd8McbeSDmi2uBdKXoKm8Zg0zlMCnOOuOI8QOS9K1gsSFLnllTPLH3kY7CmsOKmY7k+c1DPA3JFExfw5AzFUlDQrDf1yXvL4d8PRXg/nmAPDbO6Iv/FAxCQzxHggck2c63cU8XNMg7xB42gZynXMz90sP9RdLD8UIz9IA6A+dp4aQv0UZ/0BzvqDnPWHOOsPc9Yf4aw/ylk/zVl/rGHcfAL9jvJ5rYOhOg6GoBVwAGzBwJsFg8ejfU4/Fu/6QrZ/6m8D0Jfd6GPovm8lxd4/Xu6y96M+VJ17SoR7ipu77H2tf6c69wER7gPcdjLZ+2P/XlMj/prKfVCE+yA399OS/Xf/oDr3IRHuQ1Ls6F78gP+oOvdhEe7DUuzxXvyJ31Wd+4gI9xFNhl3fi1/yn1SXq6Mi3Eel+Ae8+Df/WXXuaRHuaW7uacl+0keqcx8T4T7GtFN12+xMNHvfctgfex/al+pIWqvVc64ed9innDVwLr1asPuqexn7qiOavP1jXdCvOcr4eQl+F4SfRteCzx+F4uQzVgqzmVwDn5dh7AWZDyRCiAtEDJvtZ+6hvLdpsGdtnPPHvnwKbPXEZONaPTf4Gcf7S66J8/83RezL92BuWrfJAbtgSqJ9CZgdGdkTt7D941PY+QL3oXwMZRzNp1CWkT0SO08ABdImoUzBO+0uD3wfMrNxt0sJthsQbDco2G5IsN2wYLsRwXajgu3Sgu1ATWD5u8n9nhRslxJsNyDYblCw3ZBgu2HBdiOC7UYF26UF242R58EemK/uwnwUg4DsFXQuC/hLyhB4vAn+klkION4Af8kU7Pd5CBP/OPg9HzwD89sx+P7jMI/CRL12EuZLyKO/eprtfwkr4n/Z0oLN2+HW/yIqT3j5y95v9O+q8095k8u8/GXvX/oP1fkPeNNvePmHJftl/lN1/oPe9ERe/hHJ/pnvqc5/yJu+TeNP2w/YIdlP819t4qcRXbfw8o9J9tf8d5v4a0TXf7z8uyX7bZ6ozn/U2zqal/9+yf6b/1Gdf9qbPYKX/0HJfpz/VZ3/mDe7Do1/1Md4LC/7576vKH9038jQJWof4+V/VIC/l/14/6c8/5QnOyMvf5G4OC/7+/5fef4Dnuy1vPxF4uO87Bf8gfL8Bz3ZvXn5i8TJedkfqOmq8x/y5D+g8e/wMW7Ly37AkPL8hz35YXj5i8RvedknGFae/4gnfxYvf5E4rsOu+I8SnzeiPP9RT35BXv7jAvyPuOKfJj5vVHn+aU/+VV7+IvvBn3HFf4z4vB3K8x/z5KdmxUVZa63pJvGMq3F/4hnR/uUrmfKbxp2dE7wb9y87a+B8flGyvyAHNjEU77UGXB6BozCGztcBhXIZBvZ98PdvAvgEGDanYX/kXTC0PWTskwxr6py3+Uua3PNP8PuPN7nm5Sd7v+M3FeEXplzz8pO9b/GXYb4Kml8n5ZqXn+z9h7+iCL8I5ZqXX0Kyn9rK+3xcAX4xyjUvP9nnc/6qIuMvSrnm5Sf7PM5fU2T8dVGuefmlJft5f12R8ddBueblNy7ZT/sbioy/bso1L79JyX7W31Rk/IUo17z8piT7SX9LkfGnU655+U1L9nP+tgL8dOy+dI19rh2pPcmOsV/b2ddHs2P0HvXHjoHOq7ySKW+bWpCdovG8SmcN/Dl/J2A7xgbKCwgLwIfIjoH2w2H7FWJgt1gHu8U0BKrch/0KvYfbw47xu2BzUuk9CDHegwTB16Jr5H2Q7WAH+T1N7j5Sv/jrLeIv246y3qb8m41/vU3sML8Pz9SO/EMEOex1/Mu243wL2rbz+A9pjflS9Rb1j2w70R+An6sd+0e31Y9Jen9k26H+EHRglfon6lJ+k/ysvHmhVbdz/ZFWz2GsUv+EGf3j9zpRdTvaH7fx/IbkT9g2fwXdf7LteH+ioB0l0kK+su189z4F6/OIj/Jdtp3wTz+F8iMiwc6I8uhP7WP3Ey2PFP6DzmO+slSo5W8ZlWq+VLQd+0A4j5lcE3/uz0k+j34c7JxovK8ieyzYHVfB7vgEHLGzYHe8H6O/L3a/rVt7Imq/TLEnlhn2GV2jn0+Bxif6OQIy5Eq+CH1R/z3KrzY/YxIcHGjol8/rdb1TZr/gXC2m4zrbTqhzcNV94Ko34XoQfKjzMxWDlP9wXDJXGesNndFPzeK6lin2RK/9FG7ST3H4G/MWMpMi3k8X9PrZLEGdk0XiHGJw7mkSP7JMsRt65Rx1Pc9sZ3JseB9e14PJ42i3n7PGJ5LXkxTuKF6sk4N7hPB7Xu6dTbgfh7lofmbRqFYzC8ZMOV82GuejN/R6PlqV8oyyfhICvKM+jPNO1/P+7VKp0Mj5oi53nUbjGqFweAHKLg6uHT5w7eLRU1IjDVwnJMvTNPQz7qdH61KkPyMuKwS9XSfIYR1b1/XY5qUwgV8U+rIX+30ndn89tn7ttP2etl5YDvmzXrDWAkeJ64V6Krrz4PdjrResmnh/T+rB5mfaLfr/ZcnvFWuda39faOO2N9LycZtyPW5TjeP2LT3YvOez+u4av1f21q8tWb9ebfP1K/5eJATlM20eWou2fB4adD0PDTb23xd0+ecN2+2l6DzPWHh3zUfX9+ajlsxHN/bsaW1hT7sZsD0Nn4d6MW5+rc9ocqGns+VyYdi1XBhufI/ekSwXeuE9QbzKwAmdr1GO7C75ML0nH1oiH97dkw9tIR9+as/fIsXf8kXF/C24HKDZVVttP6XJ7a2ulsvtUddye7RxfvuyZLmN279X0PlZ0KErILe3YKBOd+4uOT6zJ8dbIsdn9+R4W8jxzJ4clyLHb+/FTQQaNzG3FzchJW4iq8uPb48S7ENIz0Pxz7mA/fp4O5RX4IFP5z2j/IhXM4tG9rqxgDqsMT+iswbef6c1dc97tv5JVh4ApC8UTVoagdMZeD9Uk5uy9ukfgLFvaX+kPJvPgUwMUt5FNfI+Sj/0Q9HzotE6NX7W33Xq1dJFYz5jLkEv5Y1CdufA6MZ1Krkm3n+jkueBLXinUB5fdM7zk5BTAUHnosY7nHb6BHREL6z/k5DYKY32U6C8I5AvtQz5R1Yh/8g6PPgDyEPyCM5N3YRzUzU4N7UHzk1NnoB+AnCzcH7q2rPQHs5RjZ2B73+uXt57nr2+1iTNb83ynKQ1+fs8SDzClPuXfc7pmCI8Oin3L/vc0c9qcvNe03jQ4mNFzqH0kpfjRxXhEaPcv8i5kF7yZPyYVo9hDZpH1Ed9yEteih9XZHx0MfRdXh5e8kB8TpHx0aGx7Xk8PLzkXfi8IuOjW2Pb3Xh4eMlzMK7I+Ag1sc/w8PCSN+CCIuODYh4UyvPjZZ//6wqMD5Y9QiSvjpd9929I5uEmLwGLj0heGy/nBF5U0F4TYfA5J8DHyzl+E5r8/SP2tRwvn3EBPl7O2bukyc0rEsfWdrx8Lgrw8XIO3k8EyCcswEck74+Xc+om4Xcq+Z9YfN4S4OPlHLnLmlz/aBzz9/DyEclr5OWct58MkI/I+3VTgI+Xc9jeVFD/YfERyct01A2fAbK+/Fab6T9fEuBzzBUfsv58JaD5GdkqefnMCvA57ooPWX++qgUXJxQR8HfmBPiccMWHrD9fg/+X7e+06ya8eWFZ/MoC/Hpc8SPr15Y8PawgP1F/+7IAv5Ou+JH17y8ExE9v0fhbEeD3rCt+ZP38uib3fEW3/FjjL8rgtyrA75QrfmT9/YZWjw0L4v213wf6PYqHmlgs1+7YEh+ieAhCXIejKi/vuwK8T7viTV4P3AwwvqYVvFnxNJZdYb1JPM1y2Od4mqVCIXO7YExmitmCsfNAhHgaYk28v17T1I2rY+mZfseddEE/4/GY6D77FLST2P3I+HnjEZ/jUFAcWjZTy5D49GvyzxvXMLlk3d+/Rpx2flocHDVvBzoHu8l7m8be20mGv9a6Bys4byqTr6D8t86wPetfyOPuMwG/nzldTM77/X6iuM75fKVaI3B6QfL4o8kdP/f1sPj6HTeL4uerxlypmG3ke7bN+YrGxW4iOX6QzXkcmw+QHe0RVv8E6Ec35kplI/tGqVitZYq16vZ7ftIxL+A1yPPDUgDzA+4/IM23SRhrhP7AHqxvwjpJEJ930ja5e97d37k5cVXTLCvIK+7qX3jrxrWZ7UZaYz7vOARYbIIc+AQE7Rp2fuDjbnfzoz3vYCvmx2Zxs18J6P3VKO8vms+3O19gvNDOI+qhxMEgPhNJsfHJ279+61/N4oBXdmn/6nj/puT0r4j89RLX/NVd2r8hvH8H5PSvSNyplzjtX9il/RvG+3dQTv+KxNF6iTv/2i7t3wjev0P+9S/L/nFUoH+9xNF/PQD7B2k9g/czstciPZdXn+blLhKP7SVe/xuKckd2H7TIEF2XsNat9rh+/D6SOp/9Co8b+oQyT7wIa+0mr2vD/SxLXqe+DDah5rx3uNjffyQncqCArIGg6oGB30tZZ7hd16Up9gKtyboFPVcT/n0TlHXgHWTH1eTlZ2Rx0v3mlOLkRFlPfRQwJ3QfcX3n+XzlNMDJibIu+VnJnFA+EMSDxC3USm6DnNwo+v7PSebW6vVVs/d8n9/9MMTZDxS9/GNF5sOY7k5ujDeR2+jnGMjuG+bdX0b3aLOT23g5auB83tPlxmf2MOz9OraesetFONctFG8SFrOzJilcUf4hi9oVo5YrZcnj6n29Pk6Der/R88+G3D+39ZOmPDfyW+4892sV44Mlo1ojPz/6Uel8HZn+SuSfKoNnlzQ+jitkD8D91Ja/7xTdn/bUYS163g4anzmfxucpiPVxjM9q2ZQCRluNT+pGVq0181ipljMqM2Vq/IE1Tl/axeMU6ZHxLjH/r0bz/24/+LX5ekn0/2I1yP1zVPK6Gl8n30XnEoCcXUP59jvUmIeRvlikjO9jisaH4vnyGPGKjqok3jLzryG5l5kpEuXecWAeZDy9m/xrQfVH3Ge/4k5/VMqk/jihBRNfztsfXud/Uj+EGf3Q47P/D8VXLc4Us/M/Q17nnJU8j5M4d2DzdLN+Qc/bLN9fP9iOSe8LqQlvfyV89ueh92ZxJlclvTcnYdy1W38lbHqD9Yx4HDmy7xP6yVGVpU9FtcZzY+OYwderfQPlV367aE6zNiUpAd+5c9vOGvj97AOGQelPy8BjE9ZBU6A/PY7S7ZvWPz2WrCft/5TpSTS78WOXfgm/9KEDu0wfasY9JEnvObhL9B4S77CNd1iSfnNoT79xNGnWLxFJekx8l+sxuL0nDeDXjrP50/btbWD10bh5u1jNLxSN7NWlxdtGhZUHm1yzQR7rwcT943aDHPBHz38Xix9Bdt4ECNQpKNF5T/ehfIzsbMgeDGUZygHw9RH6kwSs71ZSsF1KsN2AYLtBwXZDgu2GBduNCLYbFWyXFmwHeSoZ8VaUfk8KtksR34MNNN5BwD7E7KIPYB9JEuzK9yBQIQGBx2uQDz4OeeBX43R7KooFI8XjtcqeSttn8pyuZjweum/heSEpxl92PvjnVeef8jYv8/KXnX8+oTr/AW/yjcY/RuEvO9/9C7r8fGtc/Ae96Qm8/GXn1z+rOv8hb/oWL3/Z+fzPqc5/2JveSuPfReEv+/yA86rzH/Gm//Pyl31ewYuq8x/1to7i5S+yD8rL+Qi9qvNPe1uP0vh3U/iL+JG9nMfwsur8x7yt63n5i/iFvZz/8Iqi/NF9i9s5kkL8Rc7f8HLexKvK8095sjOx/O77bf3ywwAAAP//o+iQDohLAQA=";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  rect_mojom.getAllMojomTypeDefinitions()
      .forEach((String s, mojom_types.UserDefinedType udt) {
          _runtimeTypeInfo.typeMap[s] = udt;
      });

  return _runtimeTypeInfo;
}
