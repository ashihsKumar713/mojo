// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library serialization_test_structs_mojom;
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;




class Struct1 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int i = 0;

  Struct1() : super(kVersions.last.size);

  static Struct1 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Struct1 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Struct1 result = new Struct1();

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
      
      result.i = decoder0.decodeUint8(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8(i, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "i of struct Struct1: $e";
      rethrow;
    }
  }

  String toString() {
    return "Struct1("
           "i: $i" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["i"] = i;
    return map;
  }
}


class Struct2 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoHandle hdl = null;

  Struct2() : super(kVersions.last.size);

  static Struct2 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Struct2 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Struct2 result = new Struct2();

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
      
      result.hdl = decoder0.decodeHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeHandle(hdl, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "hdl of struct Struct2: $e";
      rethrow;
    }
  }

  String toString() {
    return "Struct2("
           "hdl: $hdl" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class Struct3 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Struct1 struct1 = null;

  Struct3() : super(kVersions.last.size);

  static Struct3 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Struct3 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Struct3 result = new Struct3();

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
      result.struct1 = Struct1.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(struct1, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "struct1 of struct Struct3: $e";
      rethrow;
    }
  }

  String toString() {
    return "Struct3("
           "struct1: $struct1" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["struct1"] = struct1;
    return map;
  }
}


class Struct4 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<Struct1> data = null;

  Struct4() : super(kVersions.last.size);

  static Struct4 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Struct4 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Struct4 result = new Struct4();

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
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.data = new List<Struct1>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.data[i1] = Struct1.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (data == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(data.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < data.length; ++i0) {
          encoder1.encodeStruct(data[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "data of struct Struct4: $e";
      rethrow;
    }
  }

  String toString() {
    return "Struct4("
           "data: $data" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["data"] = data;
    return map;
  }
}


class Struct5 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<Struct1> pair = null;

  Struct5() : super(kVersions.last.size);

  static Struct5 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Struct5 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Struct5 result = new Struct5();

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
        var si1 = decoder1.decodeDataHeaderForPointerArray(2);
        result.pair = new List<Struct1>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.pair[i1] = Struct1.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (pair == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(pair.length, 8, 2);
        for (int i0 = 0; i0 < pair.length; ++i0) {
          encoder1.encodeStruct(pair[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pair of struct Struct5: $e";
      rethrow;
    }
  }

  String toString() {
    return "Struct5("
           "pair: $pair" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["pair"] = pair;
    return map;
  }
}


class Struct6 extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String str = null;

  Struct6() : super(kVersions.last.size);

  static Struct6 deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Struct6 decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Struct6 result = new Struct6();

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
      
      result.str = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(str, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "str of struct Struct6: $e";
      rethrow;
    }
  }

  String toString() {
    return "Struct6("
           "str: $str" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["str"] = str;
    return map;
  }
}


class StructOfNullables extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  core.MojoHandle hdl = null;
  Struct1 struct1 = null;
  String str = null;

  StructOfNullables() : super(kVersions.last.size);

  static StructOfNullables deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static StructOfNullables decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    StructOfNullables result = new StructOfNullables();

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
      
      result.hdl = decoder0.decodeHandle(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.struct1 = Struct1.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.str = decoder0.decodeString(24, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeHandle(hdl, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "hdl of struct StructOfNullables: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(struct1, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "struct1 of struct StructOfNullables: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(str, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "str of struct StructOfNullables: $e";
      rethrow;
    }
  }

  String toString() {
    return "StructOfNullables("
           "hdl: $hdl" ", "
           "struct1: $struct1" ", "
           "str: $str" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+yYzW7TQBDHbbdV3NKqQQLJ5UMKLYccUNzmSxUnLpUqIQESHOjJOInbLHLsyOtIiBOPwJFH4MiRR+mjcIPdeqyuF0/kxvgDwUqj8Vpje/yfn2c3MZRoNMEfgpfPx16XvBw3VSP/jFmD2TGcfwv+A/gv4L+DvwT/A/w+s3vM3py9OrGen5w9nfnv/U7o0LDzOgwW4/AoY1w3Y1wvY1w/Y9wgY9wwinvC7PGyuJfnLxaua49ch8Y6NkB3LvlUqAOff9OSc30jOf/aSM6nW8l5eyc5/7QbzVtS3RWot6Fd110cMU8xBz9hnCrpYxfeKy7yHju+zQwp/2/86XD9BTOLmTn1Z44ZLCb+jHhOYPL7mDQYRwfzxcglY5N4oROc22OHmiPiTYh3QU3+LGpSJyC2Sz7aIfE9i5+z6NXzaYffYHatr5J8/2Mpr4aSbWD6KYJ+3LeR6zchH4Loswm5VqWPIeSqCnlhXLUL4aqLctVFdNuuIVfrQr8smqtbzNZ4n5i4qfrsAFtl6iOOvJzNC+Gsh3LWW7LO1o2zjRI5a0IuUZbWkawP13KrRH1aKfmJdZPXq6z7lry8fi6E1z7Kax/h9U4NedVK5HUb+vDEDu00fe6CnlXwynOPv19d4unf4HmA8jxAeDb+83zF89wmQZo+e/DNV8GzJqxHdee5mH3rEOV5iPD8oIY8qxXsW1mWqfo8/Ev3rQZwdrm+XKdTibN3iE4xV6l/NrBxwOx+CndypKxvq2T+WlDvOI9DZH2p6++oRyXvb5vJtnXj/b++gj5qjv3/PmhY9vqj/uH15aZ9sbmCzlqOvnhQMYfL+uKa0A9/BQAA//9CnCj5wBYAAA==";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
