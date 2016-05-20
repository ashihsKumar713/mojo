// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library surfaces_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/geometry.mojom.dart' as geometry_mojom;
import 'package:mojo_services/mojo/quads.mojom.dart' as quads_mojom;

class ResourceFormat extends bindings.MojoEnum {
  static const ResourceFormat rgba8888 = const ResourceFormat._(0);
  static const ResourceFormat rgba4444 = const ResourceFormat._(1);
  static const ResourceFormat bgra8888 = const ResourceFormat._(2);
  static const ResourceFormat alpha8 = const ResourceFormat._(3);
  static const ResourceFormat luminance8 = const ResourceFormat._(4);
  static const ResourceFormat rgb565 = const ResourceFormat._(5);
  static const ResourceFormat etc1 = const ResourceFormat._(6);

  const ResourceFormat._(int v) : super(v);

  static const Map<String, ResourceFormat> valuesMap = const {
    "rgba8888": rgba8888,
    "rgba4444": rgba4444,
    "bgra8888": bgra8888,
    "alpha8": alpha8,
    "luminance8": luminance8,
    "rgb565": rgb565,
    "etc1": etc1,
  };
  static const List<ResourceFormat> values = const [
    rgba8888,
    rgba4444,
    bgra8888,
    alpha8,
    luminance8,
    rgb565,
    etc1,
  ];

  static ResourceFormat valueOf(String name) => valuesMap[name];

  factory ResourceFormat(int v) {
    switch (v) {
      case 0:
        return ResourceFormat.rgba8888;
      case 1:
        return ResourceFormat.rgba4444;
      case 2:
        return ResourceFormat.bgra8888;
      case 3:
        return ResourceFormat.alpha8;
      case 4:
        return ResourceFormat.luminance8;
      case 5:
        return ResourceFormat.rgb565;
      case 6:
        return ResourceFormat.etc1;
      default:
        return null;
    }
  }

  static ResourceFormat decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    ResourceFormat result = new ResourceFormat(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum ResourceFormat.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case rgba8888:
        return 'ResourceFormat.rgba8888';
      case rgba4444:
        return 'ResourceFormat.rgba4444';
      case bgra8888:
        return 'ResourceFormat.bgra8888';
      case alpha8:
        return 'ResourceFormat.alpha8';
      case luminance8:
        return 'ResourceFormat.luminance8';
      case rgb565:
        return 'ResourceFormat.rgb565';
      case etc1:
        return 'ResourceFormat.etc1';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class Mailbox extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<int> name = null;

  Mailbox() : super(kVersions.last.size);

  static Mailbox deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Mailbox decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Mailbox result = new Mailbox();

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
      
      result.name = decoder0.decodeInt8Array(8, bindings.kNothingNullable, 64);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt8Array(name, 8, bindings.kNothingNullable, 64);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "name of struct Mailbox: $e";
      rethrow;
    }
  }

  String toString() {
    return "Mailbox("
           "name: $name" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["name"] = name;
    return map;
  }
}


class MailboxHolder extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Mailbox mailbox = null;
  int textureTarget = 0;
  int syncPoint = 0;

  MailboxHolder() : super(kVersions.last.size);

  static MailboxHolder deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MailboxHolder decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MailboxHolder result = new MailboxHolder();

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
      result.mailbox = Mailbox.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.textureTarget = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.syncPoint = decoder0.decodeUint32(20);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(mailbox, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mailbox of struct MailboxHolder: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(textureTarget, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "textureTarget of struct MailboxHolder: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(syncPoint, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "syncPoint of struct MailboxHolder: $e";
      rethrow;
    }
  }

  String toString() {
    return "MailboxHolder("
           "mailbox: $mailbox" ", "
           "textureTarget: $textureTarget" ", "
           "syncPoint: $syncPoint" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["mailbox"] = mailbox;
    map["textureTarget"] = textureTarget;
    map["syncPoint"] = syncPoint;
    return map;
  }
}


class TransferableResource extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  int id = 0;
  ResourceFormat format = null;
  int filter = 0;
  bool isRepeated = false;
  bool isSoftware = false;
  geometry_mojom.Size size = null;
  MailboxHolder mailboxHolder = null;

  TransferableResource() : super(kVersions.last.size);

  static TransferableResource deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TransferableResource decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TransferableResource result = new TransferableResource();

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
      
      result.id = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
        result.format = ResourceFormat.decode(decoder0, 12);
        if (result.format == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable ResourceFormat.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.filter = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.isRepeated = decoder0.decodeBool(20, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.isSoftware = decoder0.decodeBool(20, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.size = geometry_mojom.Size.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(32, false);
      result.mailboxHolder = MailboxHolder.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(id, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "id of struct TransferableResource: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(format, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "format of struct TransferableResource: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(filter, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "filter of struct TransferableResource: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(isRepeated, 20, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "isRepeated of struct TransferableResource: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(isSoftware, 20, 1);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "isSoftware of struct TransferableResource: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(size, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "size of struct TransferableResource: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(mailboxHolder, 32, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mailboxHolder of struct TransferableResource: $e";
      rethrow;
    }
  }

  String toString() {
    return "TransferableResource("
           "id: $id" ", "
           "format: $format" ", "
           "filter: $filter" ", "
           "isRepeated: $isRepeated" ", "
           "isSoftware: $isSoftware" ", "
           "size: $size" ", "
           "mailboxHolder: $mailboxHolder" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    map["format"] = format;
    map["filter"] = filter;
    map["isRepeated"] = isRepeated;
    map["isSoftware"] = isSoftware;
    map["size"] = size;
    map["mailboxHolder"] = mailboxHolder;
    return map;
  }
}


class ReturnedResource extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int id = 0;
  int syncPoint = 0;
  int count = 0;
  bool lost = false;

  ReturnedResource() : super(kVersions.last.size);

  static ReturnedResource deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ReturnedResource decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ReturnedResource result = new ReturnedResource();

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
      
      result.id = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.syncPoint = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.count = decoder0.decodeInt32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.lost = decoder0.decodeBool(20, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(id, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "id of struct ReturnedResource: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(syncPoint, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "syncPoint of struct ReturnedResource: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(count, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "count of struct ReturnedResource: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(lost, 20, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "lost of struct ReturnedResource: $e";
      rethrow;
    }
  }

  String toString() {
    return "ReturnedResource("
           "id: $id" ", "
           "syncPoint: $syncPoint" ", "
           "count: $count" ", "
           "lost: $lost" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    map["syncPoint"] = syncPoint;
    map["count"] = count;
    map["lost"] = lost;
    return map;
  }
}


class Frame extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  List<TransferableResource> resources = null;
  List<quads_mojom.Pass> passes = null;

  Frame() : super(kVersions.last.size);

  static Frame deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Frame decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Frame result = new Frame();

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
        result.resources = new List<TransferableResource>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.resources[i1] = TransferableResource.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.passes = new List<quads_mojom.Pass>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.passes[i1] = quads_mojom.Pass.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (resources == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(resources.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < resources.length; ++i0) {
          encoder1.encodeStruct(resources[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "resources of struct Frame: $e";
      rethrow;
    }
    try {
      if (passes == null) {
        encoder0.encodeNullPointer(16, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(passes.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < passes.length; ++i0) {
          encoder1.encodeStruct(passes[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "passes of struct Frame: $e";
      rethrow;
    }
  }

  String toString() {
    return "Frame("
           "resources: $resources" ", "
           "passes: $passes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["resources"] = resources;
    map["passes"] = passes;
    return map;
  }
}


class _ResourceReturnerReturnResourcesParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<ReturnedResource> resources = null;

  _ResourceReturnerReturnResourcesParams() : super(kVersions.last.size);

  static _ResourceReturnerReturnResourcesParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ResourceReturnerReturnResourcesParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ResourceReturnerReturnResourcesParams result = new _ResourceReturnerReturnResourcesParams();

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
        result.resources = new List<ReturnedResource>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.resources[i1] = ReturnedResource.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (resources == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(resources.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < resources.length; ++i0) {
          encoder1.encodeStruct(resources[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "resources of struct _ResourceReturnerReturnResourcesParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ResourceReturnerReturnResourcesParams("
           "resources: $resources" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["resources"] = resources;
    return map;
  }
}


class _SurfaceGetIdNamespaceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SurfaceGetIdNamespaceParams() : super(kVersions.last.size);

  static _SurfaceGetIdNamespaceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SurfaceGetIdNamespaceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SurfaceGetIdNamespaceParams result = new _SurfaceGetIdNamespaceParams();

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
    return "_SurfaceGetIdNamespaceParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class SurfaceGetIdNamespaceResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int idNamespace = 0;

  SurfaceGetIdNamespaceResponseParams() : super(kVersions.last.size);

  static SurfaceGetIdNamespaceResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SurfaceGetIdNamespaceResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SurfaceGetIdNamespaceResponseParams result = new SurfaceGetIdNamespaceResponseParams();

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
      
      result.idNamespace = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(idNamespace, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "idNamespace of struct SurfaceGetIdNamespaceResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "SurfaceGetIdNamespaceResponseParams("
           "idNamespace: $idNamespace" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["idNamespace"] = idNamespace;
    return map;
  }
}


class _SurfaceSetResourceReturnerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  ResourceReturnerInterface returner = null;

  _SurfaceSetResourceReturnerParams() : super(kVersions.last.size);

  static _SurfaceSetResourceReturnerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SurfaceSetResourceReturnerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SurfaceSetResourceReturnerParams result = new _SurfaceSetResourceReturnerParams();

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
      
      result.returner = decoder0.decodeServiceInterface(8, false, ResourceReturnerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(returner, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "returner of struct _SurfaceSetResourceReturnerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SurfaceSetResourceReturnerParams("
           "returner: $returner" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _SurfaceCreateSurfaceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int idLocal = 0;

  _SurfaceCreateSurfaceParams() : super(kVersions.last.size);

  static _SurfaceCreateSurfaceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SurfaceCreateSurfaceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SurfaceCreateSurfaceParams result = new _SurfaceCreateSurfaceParams();

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
      
      result.idLocal = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(idLocal, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "idLocal of struct _SurfaceCreateSurfaceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SurfaceCreateSurfaceParams("
           "idLocal: $idLocal" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["idLocal"] = idLocal;
    return map;
  }
}


class _SurfaceSubmitFrameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int idLocal = 0;
  Frame frame = null;

  _SurfaceSubmitFrameParams() : super(kVersions.last.size);

  static _SurfaceSubmitFrameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SurfaceSubmitFrameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SurfaceSubmitFrameParams result = new _SurfaceSubmitFrameParams();

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
      
      result.idLocal = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.frame = Frame.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(idLocal, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "idLocal of struct _SurfaceSubmitFrameParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(frame, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "frame of struct _SurfaceSubmitFrameParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SurfaceSubmitFrameParams("
           "idLocal: $idLocal" ", "
           "frame: $frame" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["idLocal"] = idLocal;
    map["frame"] = frame;
    return map;
  }
}


class SurfaceSubmitFrameResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  SurfaceSubmitFrameResponseParams() : super(kVersions.last.size);

  static SurfaceSubmitFrameResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SurfaceSubmitFrameResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SurfaceSubmitFrameResponseParams result = new SurfaceSubmitFrameResponseParams();

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
    return "SurfaceSubmitFrameResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _SurfaceDestroySurfaceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int idLocal = 0;

  _SurfaceDestroySurfaceParams() : super(kVersions.last.size);

  static _SurfaceDestroySurfaceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SurfaceDestroySurfaceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SurfaceDestroySurfaceParams result = new _SurfaceDestroySurfaceParams();

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
      
      result.idLocal = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(idLocal, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "idLocal of struct _SurfaceDestroySurfaceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SurfaceDestroySurfaceParams("
           "idLocal: $idLocal" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["idLocal"] = idLocal;
    return map;
  }
}

const int _resourceReturnerMethodReturnResourcesName = 0;

class _ResourceReturnerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ResourceReturner {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ResourceReturnerServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static ResourceReturnerProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ResourceReturnerProxy p = new ResourceReturnerProxy.unbound();
    String name = serviceName ?? ResourceReturner.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void returnResources(List<ReturnedResource> resources);
}

abstract class ResourceReturnerInterface
    implements bindings.MojoInterface<ResourceReturner>,
               ResourceReturner {
  factory ResourceReturnerInterface([ResourceReturner impl]) =>
      new ResourceReturnerStub.unbound(impl);
  factory ResourceReturnerInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [ResourceReturner impl]) =>
      new ResourceReturnerStub.fromEndpoint(endpoint, impl);
}

abstract class ResourceReturnerInterfaceRequest
    implements bindings.MojoInterface<ResourceReturner>,
               ResourceReturner {
  factory ResourceReturnerInterfaceRequest() =>
      new ResourceReturnerProxy.unbound();
}

class _ResourceReturnerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<ResourceReturner> {
  _ResourceReturnerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ResourceReturnerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ResourceReturnerProxyControl.unbound() : super.unbound();

  String get serviceName => ResourceReturner.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  ResourceReturner get impl => null;
  set impl(ResourceReturner _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_ResourceReturnerProxyControl($superString)";
  }
}

class ResourceReturnerProxy
    extends bindings.Proxy<ResourceReturner>
    implements ResourceReturner,
               ResourceReturnerInterface,
               ResourceReturnerInterfaceRequest {
  ResourceReturnerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _ResourceReturnerProxyControl.fromEndpoint(endpoint));

  ResourceReturnerProxy.fromHandle(core.MojoHandle handle)
      : super(new _ResourceReturnerProxyControl.fromHandle(handle));

  ResourceReturnerProxy.unbound()
      : super(new _ResourceReturnerProxyControl.unbound());

  static ResourceReturnerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ResourceReturnerProxy"));
    return new ResourceReturnerProxy.fromEndpoint(endpoint);
  }


  void returnResources(List<ReturnedResource> resources) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ResourceReturnerReturnResourcesParams();
    params.resources = resources;
    ctrl.sendMessage(params,
        _resourceReturnerMethodReturnResourcesName);
  }
}

class _ResourceReturnerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<ResourceReturner> {
  ResourceReturner _impl;

  _ResourceReturnerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ResourceReturner impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _ResourceReturnerStubControl.fromHandle(
      core.MojoHandle handle, [ResourceReturner impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _ResourceReturnerStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => ResourceReturner.serviceName;



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
      case _resourceReturnerMethodReturnResourcesName:
        var params = _ResourceReturnerReturnResourcesParams.deserialize(
            message.payload);
        _impl.returnResources(params.resources);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ResourceReturner get impl => _impl;
  set impl(ResourceReturner d) {
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
    return "_ResourceReturnerStubControl($superString)";
  }

  int get version => 0;
}

class ResourceReturnerStub
    extends bindings.Stub<ResourceReturner>
    implements ResourceReturner,
               ResourceReturnerInterface,
               ResourceReturnerInterfaceRequest {
  ResourceReturnerStub.unbound([ResourceReturner impl])
      : super(new _ResourceReturnerStubControl.unbound(impl));

  ResourceReturnerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ResourceReturner impl])
      : super(new _ResourceReturnerStubControl.fromEndpoint(endpoint, impl));

  ResourceReturnerStub.fromHandle(
      core.MojoHandle handle, [ResourceReturner impl])
      : super(new _ResourceReturnerStubControl.fromHandle(handle, impl));

  static ResourceReturnerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ResourceReturnerStub"));
    return new ResourceReturnerStub.fromEndpoint(endpoint);
  }


  void returnResources(List<ReturnedResource> resources) {
    return impl.returnResources(resources);
  }
}

const int _surfaceMethodGetIdNamespaceName = 0;
const int _surfaceMethodSetResourceReturnerName = 1;
const int _surfaceMethodCreateSurfaceName = 2;
const int _surfaceMethodSubmitFrameName = 3;
const int _surfaceMethodDestroySurfaceName = 4;

class _SurfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Surface {
  static const String serviceName = "mojo::Surface";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SurfaceServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static SurfaceProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SurfaceProxy p = new SurfaceProxy.unbound();
    String name = serviceName ?? Surface.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic getIdNamespace([Function responseFactory = null]);
  void setResourceReturner(ResourceReturnerInterface returner);
  void createSurface(int idLocal);
  dynamic submitFrame(int idLocal,Frame frame,[Function responseFactory = null]);
  void destroySurface(int idLocal);
}

abstract class SurfaceInterface
    implements bindings.MojoInterface<Surface>,
               Surface {
  factory SurfaceInterface([Surface impl]) =>
      new SurfaceStub.unbound(impl);
  factory SurfaceInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [Surface impl]) =>
      new SurfaceStub.fromEndpoint(endpoint, impl);
}

abstract class SurfaceInterfaceRequest
    implements bindings.MojoInterface<Surface>,
               Surface {
  factory SurfaceInterfaceRequest() =>
      new SurfaceProxy.unbound();
}

class _SurfaceProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<Surface> {
  _SurfaceProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SurfaceProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _SurfaceProxyControl.unbound() : super.unbound();

  String get serviceName => Surface.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _surfaceMethodGetIdNamespaceName:
        var r = SurfaceGetIdNamespaceResponseParams.deserialize(
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
      case _surfaceMethodSubmitFrameName:
        var r = SurfaceSubmitFrameResponseParams.deserialize(
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

  Surface get impl => null;
  set impl(Surface _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_SurfaceProxyControl($superString)";
  }
}

class SurfaceProxy
    extends bindings.Proxy<Surface>
    implements Surface,
               SurfaceInterface,
               SurfaceInterfaceRequest {
  SurfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _SurfaceProxyControl.fromEndpoint(endpoint));

  SurfaceProxy.fromHandle(core.MojoHandle handle)
      : super(new _SurfaceProxyControl.fromHandle(handle));

  SurfaceProxy.unbound()
      : super(new _SurfaceProxyControl.unbound());

  static SurfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SurfaceProxy"));
    return new SurfaceProxy.fromEndpoint(endpoint);
  }


  dynamic getIdNamespace([Function responseFactory = null]) {
    var params = new _SurfaceGetIdNamespaceParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _surfaceMethodGetIdNamespaceName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void setResourceReturner(ResourceReturnerInterface returner) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _SurfaceSetResourceReturnerParams();
    params.returner = returner;
    ctrl.sendMessage(params,
        _surfaceMethodSetResourceReturnerName);
  }
  void createSurface(int idLocal) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _SurfaceCreateSurfaceParams();
    params.idLocal = idLocal;
    ctrl.sendMessage(params,
        _surfaceMethodCreateSurfaceName);
  }
  dynamic submitFrame(int idLocal,Frame frame,[Function responseFactory = null]) {
    var params = new _SurfaceSubmitFrameParams();
    params.idLocal = idLocal;
    params.frame = frame;
    return ctrl.sendMessageWithRequestId(
        params,
        _surfaceMethodSubmitFrameName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void destroySurface(int idLocal) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _SurfaceDestroySurfaceParams();
    params.idLocal = idLocal;
    ctrl.sendMessage(params,
        _surfaceMethodDestroySurfaceName);
  }
}

class _SurfaceStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<Surface> {
  Surface _impl;

  _SurfaceStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Surface impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _SurfaceStubControl.fromHandle(
      core.MojoHandle handle, [Surface impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _SurfaceStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => Surface.serviceName;


  SurfaceGetIdNamespaceResponseParams _surfaceGetIdNamespaceResponseParamsFactory(int idNamespace) {
    var result = new SurfaceGetIdNamespaceResponseParams();
    result.idNamespace = idNamespace;
    return result;
  }
  SurfaceSubmitFrameResponseParams _surfaceSubmitFrameResponseParamsFactory() {
    var result = new SurfaceSubmitFrameResponseParams();
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
      case _surfaceMethodGetIdNamespaceName:
        var response = _impl.getIdNamespace(_surfaceGetIdNamespaceResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _surfaceMethodGetIdNamespaceName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _surfaceMethodGetIdNamespaceName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _surfaceMethodSetResourceReturnerName:
        var params = _SurfaceSetResourceReturnerParams.deserialize(
            message.payload);
        _impl.setResourceReturner(params.returner);
        break;
      case _surfaceMethodCreateSurfaceName:
        var params = _SurfaceCreateSurfaceParams.deserialize(
            message.payload);
        _impl.createSurface(params.idLocal);
        break;
      case _surfaceMethodSubmitFrameName:
        var params = _SurfaceSubmitFrameParams.deserialize(
            message.payload);
        var response = _impl.submitFrame(params.idLocal,params.frame,_surfaceSubmitFrameResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _surfaceMethodSubmitFrameName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _surfaceMethodSubmitFrameName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _surfaceMethodDestroySurfaceName:
        var params = _SurfaceDestroySurfaceParams.deserialize(
            message.payload);
        _impl.destroySurface(params.idLocal);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Surface get impl => _impl;
  set impl(Surface d) {
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
    return "_SurfaceStubControl($superString)";
  }

  int get version => 0;
}

class SurfaceStub
    extends bindings.Stub<Surface>
    implements Surface,
               SurfaceInterface,
               SurfaceInterfaceRequest {
  SurfaceStub.unbound([Surface impl])
      : super(new _SurfaceStubControl.unbound(impl));

  SurfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Surface impl])
      : super(new _SurfaceStubControl.fromEndpoint(endpoint, impl));

  SurfaceStub.fromHandle(
      core.MojoHandle handle, [Surface impl])
      : super(new _SurfaceStubControl.fromHandle(handle, impl));

  static SurfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SurfaceStub"));
    return new SurfaceStub.fromEndpoint(endpoint);
  }


  dynamic getIdNamespace([Function responseFactory = null]) {
    return impl.getIdNamespace(responseFactory);
  }
  void setResourceReturner(ResourceReturnerInterface returner) {
    return impl.setResourceReturner(returner);
  }
  void createSurface(int idLocal) {
    return impl.createSurface(idLocal);
  }
  dynamic submitFrame(int idLocal,Frame frame,[Function responseFactory = null]) {
    return impl.submitFrame(idLocal,frame,responseFactory);
  }
  void destroySurface(int idLocal) {
    return impl.destroySurface(idLocal);
  }
}



