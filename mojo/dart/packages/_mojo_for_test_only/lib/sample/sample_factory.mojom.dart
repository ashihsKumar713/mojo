// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library sample_factory_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:_mojo_for_test_only/imported/sample_import.mojom.dart' as sample_import_mojom;



class Request extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int x = 0;
  core.MojoMessagePipeEndpoint pipe = null;
  List<core.MojoMessagePipeEndpoint> morePipes = null;
  sample_import_mojom.ImportedInterfaceInterface obj = null;

  Request() : super(kVersions.last.size);

  static Request deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Request decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Request result = new Request();

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
      
      result.x = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.pipe = decoder0.decodeMessagePipeHandle(12, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.morePipes = decoder0.decodeMessagePipeHandleArray(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.obj = decoder0.decodeServiceInterface(24, true, sample_import_mojom.ImportedInterfaceProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(x, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct Request: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(pipe, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pipe of struct Request: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandleArray(morePipes, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "morePipes of struct Request: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(obj, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "obj of struct Request: $e";
      rethrow;
    }
  }

  String toString() {
    return "Request("
           "x: $x" ", "
           "pipe: $pipe" ", "
           "morePipes: $morePipes" ", "
           "obj: $obj" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class Response extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int x = 0;
  core.MojoMessagePipeEndpoint pipe = null;

  Response() : super(kVersions.last.size);

  static Response deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Response decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Response result = new Response();

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
      
      result.x = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.pipe = decoder0.decodeMessagePipeHandle(12, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(x, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct Response: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(pipe, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pipe of struct Response: $e";
      rethrow;
    }
  }

  String toString() {
    return "Response("
           "x: $x" ", "
           "pipe: $pipe" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _NamedObjectSetNameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String name = null;

  _NamedObjectSetNameParams() : super(kVersions.last.size);

  static _NamedObjectSetNameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NamedObjectSetNameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NamedObjectSetNameParams result = new _NamedObjectSetNameParams();

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
      
      result.name = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(name, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "name of struct _NamedObjectSetNameParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NamedObjectSetNameParams("
           "name: $name" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["name"] = name;
    return map;
  }
}


class _NamedObjectGetNameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _NamedObjectGetNameParams() : super(kVersions.last.size);

  static _NamedObjectGetNameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NamedObjectGetNameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NamedObjectGetNameParams result = new _NamedObjectGetNameParams();

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
    return "_NamedObjectGetNameParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class NamedObjectGetNameResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String name = null;

  NamedObjectGetNameResponseParams() : super(kVersions.last.size);

  static NamedObjectGetNameResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NamedObjectGetNameResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NamedObjectGetNameResponseParams result = new NamedObjectGetNameResponseParams();

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
      
      result.name = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(name, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "name of struct NamedObjectGetNameResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "NamedObjectGetNameResponseParams("
           "name: $name" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["name"] = name;
    return map;
  }
}


class _FactoryDoStuffParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Request request = null;
  core.MojoMessagePipeEndpoint pipe = null;

  _FactoryDoStuffParams() : super(kVersions.last.size);

  static _FactoryDoStuffParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FactoryDoStuffParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FactoryDoStuffParams result = new _FactoryDoStuffParams();

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
      result.request = Request.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.pipe = decoder0.decodeMessagePipeHandle(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(request, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "request of struct _FactoryDoStuffParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeMessagePipeHandle(pipe, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pipe of struct _FactoryDoStuffParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FactoryDoStuffParams("
           "request: $request" ", "
           "pipe: $pipe" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FactoryDoStuffResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Response response = null;
  String text = null;

  FactoryDoStuffResponseParams() : super(kVersions.last.size);

  static FactoryDoStuffResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FactoryDoStuffResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FactoryDoStuffResponseParams result = new FactoryDoStuffResponseParams();

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
      result.response = Response.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.text = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct FactoryDoStuffResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(text, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "text of struct FactoryDoStuffResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FactoryDoStuffResponseParams("
           "response: $response" ", "
           "text: $text" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _FactoryDoStuff2Params extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoDataPipeConsumer pipe = null;

  _FactoryDoStuff2Params() : super(kVersions.last.size);

  static _FactoryDoStuff2Params deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FactoryDoStuff2Params decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FactoryDoStuff2Params result = new _FactoryDoStuff2Params();

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
      
      result.pipe = decoder0.decodeConsumerHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeConsumerHandle(pipe, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pipe of struct _FactoryDoStuff2Params: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FactoryDoStuff2Params("
           "pipe: $pipe" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FactoryDoStuff2ResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String text = null;

  FactoryDoStuff2ResponseParams() : super(kVersions.last.size);

  static FactoryDoStuff2ResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FactoryDoStuff2ResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FactoryDoStuff2ResponseParams result = new FactoryDoStuff2ResponseParams();

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
      
      result.text = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(text, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "text of struct FactoryDoStuff2ResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FactoryDoStuff2ResponseParams("
           "text: $text" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["text"] = text;
    return map;
  }
}


class _FactoryCreateNamedObjectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  NamedObjectInterfaceRequest obj = null;

  _FactoryCreateNamedObjectParams() : super(kVersions.last.size);

  static _FactoryCreateNamedObjectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FactoryCreateNamedObjectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FactoryCreateNamedObjectParams result = new _FactoryCreateNamedObjectParams();

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
      
      result.obj = decoder0.decodeInterfaceRequest(8, false, NamedObjectStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(obj, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "obj of struct _FactoryCreateNamedObjectParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FactoryCreateNamedObjectParams("
           "obj: $obj" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _FactoryRequestImportedInterfaceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  sample_import_mojom.ImportedInterfaceInterfaceRequest obj = null;

  _FactoryRequestImportedInterfaceParams() : super(kVersions.last.size);

  static _FactoryRequestImportedInterfaceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FactoryRequestImportedInterfaceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FactoryRequestImportedInterfaceParams result = new _FactoryRequestImportedInterfaceParams();

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
      
      result.obj = decoder0.decodeInterfaceRequest(8, false, sample_import_mojom.ImportedInterfaceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(obj, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "obj of struct _FactoryRequestImportedInterfaceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FactoryRequestImportedInterfaceParams("
           "obj: $obj" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FactoryRequestImportedInterfaceResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  sample_import_mojom.ImportedInterfaceInterfaceRequest obj = null;

  FactoryRequestImportedInterfaceResponseParams() : super(kVersions.last.size);

  static FactoryRequestImportedInterfaceResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FactoryRequestImportedInterfaceResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FactoryRequestImportedInterfaceResponseParams result = new FactoryRequestImportedInterfaceResponseParams();

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
      
      result.obj = decoder0.decodeInterfaceRequest(8, false, sample_import_mojom.ImportedInterfaceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(obj, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "obj of struct FactoryRequestImportedInterfaceResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FactoryRequestImportedInterfaceResponseParams("
           "obj: $obj" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _FactoryTakeImportedInterfaceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  sample_import_mojom.ImportedInterfaceInterface obj = null;

  _FactoryTakeImportedInterfaceParams() : super(kVersions.last.size);

  static _FactoryTakeImportedInterfaceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FactoryTakeImportedInterfaceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FactoryTakeImportedInterfaceParams result = new _FactoryTakeImportedInterfaceParams();

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
      
      result.obj = decoder0.decodeServiceInterface(8, false, sample_import_mojom.ImportedInterfaceProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(obj, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "obj of struct _FactoryTakeImportedInterfaceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FactoryTakeImportedInterfaceParams("
           "obj: $obj" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FactoryTakeImportedInterfaceResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  sample_import_mojom.ImportedInterfaceInterface obj = null;

  FactoryTakeImportedInterfaceResponseParams() : super(kVersions.last.size);

  static FactoryTakeImportedInterfaceResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FactoryTakeImportedInterfaceResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FactoryTakeImportedInterfaceResponseParams result = new FactoryTakeImportedInterfaceResponseParams();

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
      
      result.obj = decoder0.decodeServiceInterface(8, false, sample_import_mojom.ImportedInterfaceProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(obj, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "obj of struct FactoryTakeImportedInterfaceResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FactoryTakeImportedInterfaceResponseParams("
           "obj: $obj" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _namedObjectMethodSetNameName = 0;
const int _namedObjectMethodGetNameName = 1;

class _NamedObjectServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]){
    var interfaceTypeKey = getRuntimeTypeInfo().services["sample::NamedObject"];
    var userDefinedType = getAllMojomTypeDefinitions()[interfaceTypeKey];
    return responseFactory(userDefinedType.interfaceType);
  }

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions()[typeKey]);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions());
}

abstract class NamedObject {
  static const String serviceName = "sample::NamedObject";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _NamedObjectServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static NamedObjectProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NamedObjectProxy p = new NamedObjectProxy.unbound();
    String name = serviceName ?? NamedObject.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void setName(String name);
  dynamic getName([Function responseFactory = null]);
}

abstract class NamedObjectInterface
    implements bindings.MojoInterface<NamedObject>,
               NamedObject {
  factory NamedObjectInterface([NamedObject impl]) =>
      new NamedObjectStub.unbound(impl);
  factory NamedObjectInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [NamedObject impl]) =>
      new NamedObjectStub.fromEndpoint(endpoint, impl);
}

abstract class NamedObjectInterfaceRequest
    implements bindings.MojoInterface<NamedObject>,
               NamedObject {
  factory NamedObjectInterfaceRequest() =>
      new NamedObjectProxy.unbound();
}

class _NamedObjectProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<NamedObject> {
  _NamedObjectProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NamedObjectProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _NamedObjectProxyControl.unbound() : super.unbound();

  String get serviceName => NamedObject.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _namedObjectMethodGetNameName:
        var r = NamedObjectGetNameResponseParams.deserialize(
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

  NamedObject get impl => null;
  set impl(NamedObject _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_NamedObjectProxyControl($superString)";
  }
}

class NamedObjectProxy
    extends bindings.Proxy<NamedObject>
    implements NamedObject,
               NamedObjectInterface,
               NamedObjectInterfaceRequest {
  NamedObjectProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _NamedObjectProxyControl.fromEndpoint(endpoint));

  NamedObjectProxy.fromHandle(core.MojoHandle handle)
      : super(new _NamedObjectProxyControl.fromHandle(handle));

  NamedObjectProxy.unbound()
      : super(new _NamedObjectProxyControl.unbound());

  static NamedObjectProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NamedObjectProxy"));
    return new NamedObjectProxy.fromEndpoint(endpoint);
  }


  void setName(String name) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _NamedObjectSetNameParams();
    params.name = name;
    ctrl.sendMessage(params,
        _namedObjectMethodSetNameName);
  }
  dynamic getName([Function responseFactory = null]) {
    var params = new _NamedObjectGetNameParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _namedObjectMethodGetNameName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _NamedObjectStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<NamedObject> {
  NamedObject _impl;

  _NamedObjectStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [NamedObject impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _NamedObjectStubControl.fromHandle(
      core.MojoHandle handle, [NamedObject impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _NamedObjectStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => NamedObject.serviceName;


  NamedObjectGetNameResponseParams _namedObjectGetNameResponseParamsFactory(String name) {
    var result = new NamedObjectGetNameResponseParams();
    result.name = name;
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
      case _namedObjectMethodSetNameName:
        var params = _NamedObjectSetNameParams.deserialize(
            message.payload);
        _impl.setName(params.name);
        break;
      case _namedObjectMethodGetNameName:
        var response = _impl.getName(_namedObjectGetNameResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _namedObjectMethodGetNameName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _namedObjectMethodGetNameName,
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

  NamedObject get impl => _impl;
  set impl(NamedObject d) {
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
    return "_NamedObjectStubControl($superString)";
  }

  int get version => 0;
}

class NamedObjectStub
    extends bindings.Stub<NamedObject>
    implements NamedObject,
               NamedObjectInterface,
               NamedObjectInterfaceRequest {
  NamedObjectStub.unbound([NamedObject impl])
      : super(new _NamedObjectStubControl.unbound(impl));

  NamedObjectStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [NamedObject impl])
      : super(new _NamedObjectStubControl.fromEndpoint(endpoint, impl));

  NamedObjectStub.fromHandle(
      core.MojoHandle handle, [NamedObject impl])
      : super(new _NamedObjectStubControl.fromHandle(handle, impl));

  static NamedObjectStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NamedObjectStub"));
    return new NamedObjectStub.fromEndpoint(endpoint);
  }


  void setName(String name) {
    return impl.setName(name);
  }
  dynamic getName([Function responseFactory = null]) {
    return impl.getName(responseFactory);
  }
}

const int _factoryMethodDoStuffName = 0;
const int _factoryMethodDoStuff2Name = 1;
const int _factoryMethodCreateNamedObjectName = 2;
const int _factoryMethodRequestImportedInterfaceName = 3;
const int _factoryMethodTakeImportedInterfaceName = 4;

class _FactoryServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Factory {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _FactoryServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static FactoryProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    FactoryProxy p = new FactoryProxy.unbound();
    String name = serviceName ?? Factory.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic doStuff(Request request,core.MojoMessagePipeEndpoint pipe,[Function responseFactory = null]);
  dynamic doStuff2(core.MojoDataPipeConsumer pipe,[Function responseFactory = null]);
  void createNamedObject(NamedObjectInterfaceRequest obj);
  dynamic requestImportedInterface(sample_import_mojom.ImportedInterfaceInterfaceRequest obj,[Function responseFactory = null]);
  dynamic takeImportedInterface(sample_import_mojom.ImportedInterfaceInterface obj,[Function responseFactory = null]);
}

abstract class FactoryInterface
    implements bindings.MojoInterface<Factory>,
               Factory {
  factory FactoryInterface([Factory impl]) =>
      new FactoryStub.unbound(impl);
  factory FactoryInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [Factory impl]) =>
      new FactoryStub.fromEndpoint(endpoint, impl);
}

abstract class FactoryInterfaceRequest
    implements bindings.MojoInterface<Factory>,
               Factory {
  factory FactoryInterfaceRequest() =>
      new FactoryProxy.unbound();
}

class _FactoryProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<Factory> {
  _FactoryProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _FactoryProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _FactoryProxyControl.unbound() : super.unbound();

  String get serviceName => Factory.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _factoryMethodDoStuffName:
        var r = FactoryDoStuffResponseParams.deserialize(
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
      case _factoryMethodDoStuff2Name:
        var r = FactoryDoStuff2ResponseParams.deserialize(
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
      case _factoryMethodRequestImportedInterfaceName:
        var r = FactoryRequestImportedInterfaceResponseParams.deserialize(
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
      case _factoryMethodTakeImportedInterfaceName:
        var r = FactoryTakeImportedInterfaceResponseParams.deserialize(
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

  Factory get impl => null;
  set impl(Factory _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_FactoryProxyControl($superString)";
  }
}

class FactoryProxy
    extends bindings.Proxy<Factory>
    implements Factory,
               FactoryInterface,
               FactoryInterfaceRequest {
  FactoryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _FactoryProxyControl.fromEndpoint(endpoint));

  FactoryProxy.fromHandle(core.MojoHandle handle)
      : super(new _FactoryProxyControl.fromHandle(handle));

  FactoryProxy.unbound()
      : super(new _FactoryProxyControl.unbound());

  static FactoryProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FactoryProxy"));
    return new FactoryProxy.fromEndpoint(endpoint);
  }


  dynamic doStuff(Request request,core.MojoMessagePipeEndpoint pipe,[Function responseFactory = null]) {
    var params = new _FactoryDoStuffParams();
    params.request = request;
    params.pipe = pipe;
    return ctrl.sendMessageWithRequestId(
        params,
        _factoryMethodDoStuffName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic doStuff2(core.MojoDataPipeConsumer pipe,[Function responseFactory = null]) {
    var params = new _FactoryDoStuff2Params();
    params.pipe = pipe;
    return ctrl.sendMessageWithRequestId(
        params,
        _factoryMethodDoStuff2Name,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void createNamedObject(NamedObjectInterfaceRequest obj) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _FactoryCreateNamedObjectParams();
    params.obj = obj;
    ctrl.sendMessage(params,
        _factoryMethodCreateNamedObjectName);
  }
  dynamic requestImportedInterface(sample_import_mojom.ImportedInterfaceInterfaceRequest obj,[Function responseFactory = null]) {
    var params = new _FactoryRequestImportedInterfaceParams();
    params.obj = obj;
    return ctrl.sendMessageWithRequestId(
        params,
        _factoryMethodRequestImportedInterfaceName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic takeImportedInterface(sample_import_mojom.ImportedInterfaceInterface obj,[Function responseFactory = null]) {
    var params = new _FactoryTakeImportedInterfaceParams();
    params.obj = obj;
    return ctrl.sendMessageWithRequestId(
        params,
        _factoryMethodTakeImportedInterfaceName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _FactoryStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<Factory> {
  Factory _impl;

  _FactoryStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Factory impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _FactoryStubControl.fromHandle(
      core.MojoHandle handle, [Factory impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _FactoryStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => Factory.serviceName;


  FactoryDoStuffResponseParams _factoryDoStuffResponseParamsFactory(Response response, String text) {
    var result = new FactoryDoStuffResponseParams();
    result.response = response;
    result.text = text;
    return result;
  }
  FactoryDoStuff2ResponseParams _factoryDoStuff2ResponseParamsFactory(String text) {
    var result = new FactoryDoStuff2ResponseParams();
    result.text = text;
    return result;
  }
  FactoryRequestImportedInterfaceResponseParams _factoryRequestImportedInterfaceResponseParamsFactory(sample_import_mojom.ImportedInterfaceInterfaceRequest obj) {
    var result = new FactoryRequestImportedInterfaceResponseParams();
    result.obj = obj;
    return result;
  }
  FactoryTakeImportedInterfaceResponseParams _factoryTakeImportedInterfaceResponseParamsFactory(sample_import_mojom.ImportedInterfaceInterface obj) {
    var result = new FactoryTakeImportedInterfaceResponseParams();
    result.obj = obj;
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
      case _factoryMethodDoStuffName:
        var params = _FactoryDoStuffParams.deserialize(
            message.payload);
        var response = _impl.doStuff(params.request,params.pipe,_factoryDoStuffResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _factoryMethodDoStuffName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _factoryMethodDoStuffName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _factoryMethodDoStuff2Name:
        var params = _FactoryDoStuff2Params.deserialize(
            message.payload);
        var response = _impl.doStuff2(params.pipe,_factoryDoStuff2ResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _factoryMethodDoStuff2Name,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _factoryMethodDoStuff2Name,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _factoryMethodCreateNamedObjectName:
        var params = _FactoryCreateNamedObjectParams.deserialize(
            message.payload);
        _impl.createNamedObject(params.obj);
        break;
      case _factoryMethodRequestImportedInterfaceName:
        var params = _FactoryRequestImportedInterfaceParams.deserialize(
            message.payload);
        var response = _impl.requestImportedInterface(params.obj,_factoryRequestImportedInterfaceResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _factoryMethodRequestImportedInterfaceName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _factoryMethodRequestImportedInterfaceName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _factoryMethodTakeImportedInterfaceName:
        var params = _FactoryTakeImportedInterfaceParams.deserialize(
            message.payload);
        var response = _impl.takeImportedInterface(params.obj,_factoryTakeImportedInterfaceResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _factoryMethodTakeImportedInterfaceName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _factoryMethodTakeImportedInterfaceName,
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

  Factory get impl => _impl;
  set impl(Factory d) {
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
    return "_FactoryStubControl($superString)";
  }

  int get version => 0;
}

class FactoryStub
    extends bindings.Stub<Factory>
    implements Factory,
               FactoryInterface,
               FactoryInterfaceRequest {
  FactoryStub.unbound([Factory impl])
      : super(new _FactoryStubControl.unbound(impl));

  FactoryStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Factory impl])
      : super(new _FactoryStubControl.fromEndpoint(endpoint, impl));

  FactoryStub.fromHandle(
      core.MojoHandle handle, [Factory impl])
      : super(new _FactoryStubControl.fromHandle(handle, impl));

  static FactoryStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FactoryStub"));
    return new FactoryStub.fromEndpoint(endpoint);
  }


  dynamic doStuff(Request request,core.MojoMessagePipeEndpoint pipe,[Function responseFactory = null]) {
    return impl.doStuff(request,pipe,responseFactory);
  }
  dynamic doStuff2(core.MojoDataPipeConsumer pipe,[Function responseFactory = null]) {
    return impl.doStuff2(pipe,responseFactory);
  }
  void createNamedObject(NamedObjectInterfaceRequest obj) {
    return impl.createNamedObject(obj);
  }
  dynamic requestImportedInterface(sample_import_mojom.ImportedInterfaceInterfaceRequest obj,[Function responseFactory = null]) {
    return impl.requestImportedInterface(obj,responseFactory);
  }
  dynamic takeImportedInterface(sample_import_mojom.ImportedInterfaceInterface obj,[Function responseFactory = null]) {
    return impl.takeImportedInterface(obj,responseFactory);
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+xaT3PbRBTXH4eaf6nTDI0oberQNrgwRKYcyOTUGShNhhnIEA7kQkZ21omDbQlJZgwnjjlyzEfgI+Rj8DFy5MgNVtFbe73alSxHltYZ78zOWooU7fu93/uzu89QwlaB8RxG9v42da3iXobrD3Bfxd2zuk4H7ex8a3XR8XeNM9T0uc8/gXd+ONx/dfTNq8Od8MUt9j32+5cw1nAv4V5l5vUjjA6Mj3Ff43zna6vp2+5vE89D9H++R7/0kedfz8Pg/t1z7J6HdmG+gRw6g2NwfVEdx7X28fi1Ux/JrVByk/Yvc/2Sua4zOP0HjX2OtLu438Gd4HQf/14e6ncIX0Q/G7i/hXsL959wN/uea3bsptUxT2z7pIPMU7uLzN9dy+zaZ7bpuc3wh9NvdNpNs93zkduymsgzG+3ecbt34pk+Btgzwy8ftcIvbwUvdaPfJ/g8xH0Jfgf4aYBzicJjiXr+HIhZXQ7Hv1fC8dTg434F40VpMtwVCnf6/4lw/8o+8PutVkS+D0GWvPCtMn6AyD3QJ5c3aHWBvGsgM8j7qQv2xMpNWp680qjvn6rj8tL2u8SxP1HLih8inAJ+3CuAHwozD4OZL/GTSX6Uh28pBt/yFPiqMfi+A99z2g7ixZ8A389yxLdC+TCVE0cNau4adT1ruzVgLiO7DePcwm75rQI6E+H0BPInWeyWzJfkL0n5zUtBfpi33fpo4PPsNsD3aQF2qwjyZZHdivKMuj7yA1ngRfQL9vuCxeupJHlGRZuJv3pBEo2i/RXLi7TxL2s/lRT/Al5sFmRHWoIdqdQ8WT79Q65T8mlbgNP7uK+M8yl0hIJ1s4y8Ugvglcg/B7z6QlL/rHLWl1XBultLgZdG6UPEry9dZPmI3Y2I4vesYH9NcHBS2pdo/2EDMIjIP1whzo+d5Zlnvg37HHbjTMiTjQJ4ojHzIPdXYc4swyfdl7up3V5CXqWnwF+PsVuSJ8N6dq/r2K6PjvcIbKw+NiWx2/OM7LYGGIjkn6e8Sya73cw5Porstk7tgzzAvQ0K3opoOnzuE7DloR0nvDBtfkcWRn+m5PGuQB/PwU/G8Hju8j2Z+PxRzusI2fmcFJ9KKfRSiolPj3B/L5i/9TPizZh3nnKb4tMzwIArP5VbLuw5nT0H730uwf6lrPEpax4HvnM9hsckOC14nI7Hz8FHLHjMj0sDkmepfL0QvV7A+BfD58uY/Wh6PlVOXnWHs248QO6v7eb1BsFEdSii9eYDODcVLDMjPHmYc51DklxGzDmORumVPR/b1+PPHWZ1fn2A/GudsfN+dMvOHUh9A8grTX2DrPvDPTBkHi9W5nB/mPCprGV7fkfs6LXAjtYlsaMrJVs7ei2ZHZUn4IcSE9dmdc45wkmOuox58zfrwDnZ/Y1onWG8EY9T2jpQUp/F1IGS2xH83oX38sKPrQeukbofsKs/dDHvFGVUKzpr3r0J+hsI9g2XQed54Za23qCUc73dXbhXVL0dDx+NDuQZ1DVpnPuk3YN1Rtd20VEAksfnTTA+LiDeqyAD4U2ZE2fUKdb9lSlw1G+w7l8Fn18EfrKs+2n/KYor23o2cYWtLyT5HVNWGNHT/ZzjCrteNtT5iCNrizgS2Q8pMo4k1X+S5/8PAAD//wmWKGaINQAA";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  sample_import_mojom.getAllMojomTypeDefinitions()
      .forEach((String s, mojom_types.UserDefinedType udt) {
          _runtimeTypeInfo.typeMap[s] = udt;
      });

  return _runtimeTypeInfo;
}
