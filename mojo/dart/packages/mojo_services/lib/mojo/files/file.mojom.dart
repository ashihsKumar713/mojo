// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library file_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/files/types.mojom.dart' as types_mojom;



class _FileCloseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _FileCloseParams() : super(kVersions.last.size);

  static _FileCloseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FileCloseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FileCloseParams result = new _FileCloseParams();

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
    return "_FileCloseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class FileCloseResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error err = null;

  FileCloseResponseParams() : super(kVersions.last.size);

  static FileCloseResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileCloseResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileCloseResponseParams result = new FileCloseResponseParams();

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
      
        result.err = types_mojom.Error.decode(decoder0, 8);
        if (result.err == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(err, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "err of struct FileCloseResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FileCloseResponseParams("
           "err: $err" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["err"] = err;
    return map;
  }
}


class _FileReadParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int numBytesToRead = 0;
  types_mojom.Whence whence = null;
  int offset = 0;

  _FileReadParams() : super(kVersions.last.size);

  static _FileReadParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FileReadParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FileReadParams result = new _FileReadParams();

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
      
      result.numBytesToRead = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
        result.whence = types_mojom.Whence.decode(decoder0, 12);
        if (result.whence == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Whence.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.offset = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(numBytesToRead, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "numBytesToRead of struct _FileReadParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(whence, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "whence of struct _FileReadParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(offset, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "offset of struct _FileReadParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FileReadParams("
           "numBytesToRead: $numBytesToRead" ", "
           "whence: $whence" ", "
           "offset: $offset" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["numBytesToRead"] = numBytesToRead;
    map["whence"] = whence;
    map["offset"] = offset;
    return map;
  }
}


class FileReadResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  List<int> bytesRead = null;

  FileReadResponseParams() : super(kVersions.last.size);

  static FileReadResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileReadResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileReadResponseParams result = new FileReadResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.bytesRead = decoder0.decodeUint8Array(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FileReadResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(bytesRead, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "bytesRead of struct FileReadResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FileReadResponseParams("
           "error: $error" ", "
           "bytesRead: $bytesRead" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["bytesRead"] = bytesRead;
    return map;
  }
}


class _FileWriteParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  List<int> bytesToWrite = null;
  int offset = 0;
  types_mojom.Whence whence = null;

  _FileWriteParams() : super(kVersions.last.size);

  static _FileWriteParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FileWriteParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FileWriteParams result = new _FileWriteParams();

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
      
      result.bytesToWrite = decoder0.decodeUint8Array(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.offset = decoder0.decodeInt64(16);
    }
    if (mainDataHeader.version >= 0) {
      
        result.whence = types_mojom.Whence.decode(decoder0, 24);
        if (result.whence == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Whence.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8Array(bytesToWrite, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "bytesToWrite of struct _FileWriteParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(offset, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "offset of struct _FileWriteParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(whence, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "whence of struct _FileWriteParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FileWriteParams("
           "bytesToWrite: $bytesToWrite" ", "
           "offset: $offset" ", "
           "whence: $whence" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["bytesToWrite"] = bytesToWrite;
    map["offset"] = offset;
    map["whence"] = whence;
    return map;
  }
}


class FileWriteResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;
  int numBytesWritten = 0;

  FileWriteResponseParams() : super(kVersions.last.size);

  static FileWriteResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileWriteResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileWriteResponseParams result = new FileWriteResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.numBytesWritten = decoder0.decodeUint32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FileWriteResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(numBytesWritten, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "numBytesWritten of struct FileWriteResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FileWriteResponseParams("
           "error: $error" ", "
           "numBytesWritten: $numBytesWritten" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["numBytesWritten"] = numBytesWritten;
    return map;
  }
}


class _FileReadToStreamParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  core.MojoDataPipeProducer source = null;
  types_mojom.Whence whence = null;
  int offset = 0;
  int numBytesToRead = 0;

  _FileReadToStreamParams() : super(kVersions.last.size);

  static _FileReadToStreamParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FileReadToStreamParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FileReadToStreamParams result = new _FileReadToStreamParams();

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
      
      result.source = decoder0.decodeProducerHandle(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
        result.whence = types_mojom.Whence.decode(decoder0, 12);
        if (result.whence == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Whence.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.offset = decoder0.decodeInt64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.numBytesToRead = decoder0.decodeInt64(24);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeProducerHandle(source, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "source of struct _FileReadToStreamParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(whence, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "whence of struct _FileReadToStreamParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(offset, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "offset of struct _FileReadToStreamParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(numBytesToRead, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "numBytesToRead of struct _FileReadToStreamParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FileReadToStreamParams("
           "source: $source" ", "
           "whence: $whence" ", "
           "offset: $offset" ", "
           "numBytesToRead: $numBytesToRead" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FileReadToStreamResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  FileReadToStreamResponseParams() : super(kVersions.last.size);

  static FileReadToStreamResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileReadToStreamResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileReadToStreamResponseParams result = new FileReadToStreamResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FileReadToStreamResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FileReadToStreamResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _FileWriteFromStreamParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  core.MojoDataPipeConsumer sink = null;
  types_mojom.Whence whence = null;
  int offset = 0;

  _FileWriteFromStreamParams() : super(kVersions.last.size);

  static _FileWriteFromStreamParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FileWriteFromStreamParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FileWriteFromStreamParams result = new _FileWriteFromStreamParams();

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
      
      result.sink = decoder0.decodeConsumerHandle(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
        result.whence = types_mojom.Whence.decode(decoder0, 12);
        if (result.whence == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Whence.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.offset = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeConsumerHandle(sink, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sink of struct _FileWriteFromStreamParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(whence, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "whence of struct _FileWriteFromStreamParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(offset, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "offset of struct _FileWriteFromStreamParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FileWriteFromStreamParams("
           "sink: $sink" ", "
           "whence: $whence" ", "
           "offset: $offset" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FileWriteFromStreamResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  FileWriteFromStreamResponseParams() : super(kVersions.last.size);

  static FileWriteFromStreamResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileWriteFromStreamResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileWriteFromStreamResponseParams result = new FileWriteFromStreamResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FileWriteFromStreamResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FileWriteFromStreamResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _FileTellParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _FileTellParams() : super(kVersions.last.size);

  static _FileTellParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FileTellParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FileTellParams result = new _FileTellParams();

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
    return "_FileTellParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class FileTellResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  int position = 0;

  FileTellResponseParams() : super(kVersions.last.size);

  static FileTellResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileTellResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileTellResponseParams result = new FileTellResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.position = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FileTellResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(position, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "position of struct FileTellResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FileTellResponseParams("
           "error: $error" ", "
           "position: $position" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["position"] = position;
    return map;
  }
}


class _FileSeekParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int offset = 0;
  types_mojom.Whence whence = null;

  _FileSeekParams() : super(kVersions.last.size);

  static _FileSeekParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FileSeekParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FileSeekParams result = new _FileSeekParams();

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
      
      result.offset = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
        result.whence = types_mojom.Whence.decode(decoder0, 16);
        if (result.whence == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Whence.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(offset, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "offset of struct _FileSeekParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(whence, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "whence of struct _FileSeekParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FileSeekParams("
           "offset: $offset" ", "
           "whence: $whence" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["offset"] = offset;
    map["whence"] = whence;
    return map;
  }
}


class FileSeekResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  int position = 0;

  FileSeekResponseParams() : super(kVersions.last.size);

  static FileSeekResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileSeekResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileSeekResponseParams result = new FileSeekResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.position = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FileSeekResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(position, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "position of struct FileSeekResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FileSeekResponseParams("
           "error: $error" ", "
           "position: $position" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["position"] = position;
    return map;
  }
}


class _FileStatParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _FileStatParams() : super(kVersions.last.size);

  static _FileStatParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FileStatParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FileStatParams result = new _FileStatParams();

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
    return "_FileStatParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class FileStatResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  types_mojom.FileInformation fileInformation = null;

  FileStatResponseParams() : super(kVersions.last.size);

  static FileStatResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileStatResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileStatResponseParams result = new FileStatResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.fileInformation = types_mojom.FileInformation.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FileStatResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(fileInformation, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fileInformation of struct FileStatResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FileStatResponseParams("
           "error: $error" ", "
           "fileInformation: $fileInformation" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["fileInformation"] = fileInformation;
    return map;
  }
}


class _FileTruncateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int size = 0;

  _FileTruncateParams() : super(kVersions.last.size);

  static _FileTruncateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FileTruncateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FileTruncateParams result = new _FileTruncateParams();

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
      
      result.size = decoder0.decodeInt64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(size, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "size of struct _FileTruncateParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FileTruncateParams("
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["size"] = size;
    return map;
  }
}


class FileTruncateResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  FileTruncateResponseParams() : super(kVersions.last.size);

  static FileTruncateResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileTruncateResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileTruncateResponseParams result = new FileTruncateResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FileTruncateResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FileTruncateResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _FileTouchParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.TimespecOrNow atime = null;
  types_mojom.TimespecOrNow mtime = null;

  _FileTouchParams() : super(kVersions.last.size);

  static _FileTouchParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FileTouchParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FileTouchParams result = new _FileTouchParams();

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
      result.atime = types_mojom.TimespecOrNow.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.mtime = types_mojom.TimespecOrNow.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(atime, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "atime of struct _FileTouchParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(mtime, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mtime of struct _FileTouchParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FileTouchParams("
           "atime: $atime" ", "
           "mtime: $mtime" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["atime"] = atime;
    map["mtime"] = mtime;
    return map;
  }
}


class FileTouchResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  FileTouchResponseParams() : super(kVersions.last.size);

  static FileTouchResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileTouchResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileTouchResponseParams result = new FileTouchResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FileTouchResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FileTouchResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _FileDupParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object file = null;

  _FileDupParams() : super(kVersions.last.size);

  static _FileDupParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FileDupParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FileDupParams result = new _FileDupParams();

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
      
      result.file = decoder0.decodeInterfaceRequest(8, false, FileStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(file, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "file of struct _FileDupParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FileDupParams("
           "file: $file" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FileDupResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  FileDupResponseParams() : super(kVersions.last.size);

  static FileDupResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileDupResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileDupResponseParams result = new FileDupResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FileDupResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FileDupResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _FileReopenParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object file = null;
  int openFlags = 0;

  _FileReopenParams() : super(kVersions.last.size);

  static _FileReopenParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FileReopenParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FileReopenParams result = new _FileReopenParams();

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
      
      result.file = decoder0.decodeInterfaceRequest(8, false, FileStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.openFlags = decoder0.decodeUint32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(file, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "file of struct _FileReopenParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(openFlags, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "openFlags of struct _FileReopenParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FileReopenParams("
           "file: $file" ", "
           "openFlags: $openFlags" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FileReopenResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  FileReopenResponseParams() : super(kVersions.last.size);

  static FileReopenResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileReopenResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileReopenResponseParams result = new FileReopenResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FileReopenResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FileReopenResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _FileAsBufferParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _FileAsBufferParams() : super(kVersions.last.size);

  static _FileAsBufferParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FileAsBufferParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FileAsBufferParams result = new _FileAsBufferParams();

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
    return "_FileAsBufferParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class FileAsBufferResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;
  core.MojoSharedBuffer buffer = null;

  FileAsBufferResponseParams() : super(kVersions.last.size);

  static FileAsBufferResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileAsBufferResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileAsBufferResponseParams result = new FileAsBufferResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.buffer = decoder0.decodeSharedBufferHandle(12, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FileAsBufferResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeSharedBufferHandle(buffer, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "buffer of struct FileAsBufferResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FileAsBufferResponseParams("
           "error: $error" ", "
           "buffer: $buffer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _FileIoctlParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int request = 0;
  List<int> inValues = null;

  _FileIoctlParams() : super(kVersions.last.size);

  static _FileIoctlParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FileIoctlParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FileIoctlParams result = new _FileIoctlParams();

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
      
      result.request = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.inValues = decoder0.decodeUint32Array(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(request, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "request of struct _FileIoctlParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32Array(inValues, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "inValues of struct _FileIoctlParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FileIoctlParams("
           "request: $request" ", "
           "inValues: $inValues" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["request"] = request;
    map["inValues"] = inValues;
    return map;
  }
}


class FileIoctlResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  List<int> outValues = null;

  FileIoctlResponseParams() : super(kVersions.last.size);

  static FileIoctlResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FileIoctlResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FileIoctlResponseParams result = new FileIoctlResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.outValues = decoder0.decodeUint32Array(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct FileIoctlResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32Array(outValues, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "outValues of struct FileIoctlResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FileIoctlResponseParams("
           "error: $error" ", "
           "outValues: $outValues" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["outValues"] = outValues;
    return map;
  }
}

const int _fileMethodCloseName = 0;
const int _fileMethodReadName = 1;
const int _fileMethodWriteName = 2;
const int _fileMethodReadToStreamName = 3;
const int _fileMethodWriteFromStreamName = 4;
const int _fileMethodTellName = 5;
const int _fileMethodSeekName = 6;
const int _fileMethodStatName = 7;
const int _fileMethodTruncateName = 8;
const int _fileMethodTouchName = 9;
const int _fileMethodDupName = 10;
const int _fileMethodReopenName = 11;
const int _fileMethodAsBufferName = 12;
const int _fileMethodIoctlName = 13;

class _FileServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class File {
  static const String serviceName = null;
  dynamic close_([Function responseFactory = null]);
  dynamic read(int numBytesToRead,int offset,types_mojom.Whence whence,[Function responseFactory = null]);
  dynamic write(List<int> bytesToWrite,int offset,types_mojom.Whence whence,[Function responseFactory = null]);
  dynamic readToStream(core.MojoDataPipeProducer source,int offset,types_mojom.Whence whence,int numBytesToRead,[Function responseFactory = null]);
  dynamic writeFromStream(core.MojoDataPipeConsumer sink,int offset,types_mojom.Whence whence,[Function responseFactory = null]);
  dynamic tell([Function responseFactory = null]);
  dynamic seek(int offset,types_mojom.Whence whence,[Function responseFactory = null]);
  dynamic stat([Function responseFactory = null]);
  dynamic truncate(int size,[Function responseFactory = null]);
  dynamic touch(types_mojom.TimespecOrNow atime,types_mojom.TimespecOrNow mtime,[Function responseFactory = null]);
  dynamic dup(Object file,[Function responseFactory = null]);
  dynamic reopen(Object file,int openFlags,[Function responseFactory = null]);
  dynamic asBuffer([Function responseFactory = null]);
  dynamic ioctl(int request,List<int> inValues,[Function responseFactory = null]);
}

class _FileProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _FileProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _FileProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _FileProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _FileServiceDescription();

  String get serviceName => File.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _fileMethodCloseName:
        var r = FileCloseResponseParams.deserialize(
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
      case _fileMethodReadName:
        var r = FileReadResponseParams.deserialize(
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
      case _fileMethodWriteName:
        var r = FileWriteResponseParams.deserialize(
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
      case _fileMethodReadToStreamName:
        var r = FileReadToStreamResponseParams.deserialize(
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
      case _fileMethodWriteFromStreamName:
        var r = FileWriteFromStreamResponseParams.deserialize(
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
      case _fileMethodTellName:
        var r = FileTellResponseParams.deserialize(
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
      case _fileMethodSeekName:
        var r = FileSeekResponseParams.deserialize(
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
      case _fileMethodStatName:
        var r = FileStatResponseParams.deserialize(
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
      case _fileMethodTruncateName:
        var r = FileTruncateResponseParams.deserialize(
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
      case _fileMethodTouchName:
        var r = FileTouchResponseParams.deserialize(
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
      case _fileMethodDupName:
        var r = FileDupResponseParams.deserialize(
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
      case _fileMethodReopenName:
        var r = FileReopenResponseParams.deserialize(
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
      case _fileMethodAsBufferName:
        var r = FileAsBufferResponseParams.deserialize(
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
      case _fileMethodIoctlName:
        var r = FileIoctlResponseParams.deserialize(
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
    return "_FileProxyControl($superString)";
  }
}

class FileProxy
    extends bindings.Proxy
    implements File {
  FileProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _FileProxyControl.fromEndpoint(endpoint));

  FileProxy.fromHandle(core.MojoHandle handle)
      : super(new _FileProxyControl.fromHandle(handle));

  FileProxy.unbound()
      : super(new _FileProxyControl.unbound());

  static FileProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FileProxy"));
    return new FileProxy.fromEndpoint(endpoint);
  }

  factory FileProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    FileProxy p = new FileProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic close_([Function responseFactory = null]) {
    var params = new _FileCloseParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _fileMethodCloseName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic read(int numBytesToRead,int offset,types_mojom.Whence whence,[Function responseFactory = null]) {
    var params = new _FileReadParams();
    params.numBytesToRead = numBytesToRead;
    params.offset = offset;
    params.whence = whence;
    return ctrl.sendMessageWithRequestId(
        params,
        _fileMethodReadName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic write(List<int> bytesToWrite,int offset,types_mojom.Whence whence,[Function responseFactory = null]) {
    var params = new _FileWriteParams();
    params.bytesToWrite = bytesToWrite;
    params.offset = offset;
    params.whence = whence;
    return ctrl.sendMessageWithRequestId(
        params,
        _fileMethodWriteName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic readToStream(core.MojoDataPipeProducer source,int offset,types_mojom.Whence whence,int numBytesToRead,[Function responseFactory = null]) {
    var params = new _FileReadToStreamParams();
    params.source = source;
    params.offset = offset;
    params.whence = whence;
    params.numBytesToRead = numBytesToRead;
    return ctrl.sendMessageWithRequestId(
        params,
        _fileMethodReadToStreamName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic writeFromStream(core.MojoDataPipeConsumer sink,int offset,types_mojom.Whence whence,[Function responseFactory = null]) {
    var params = new _FileWriteFromStreamParams();
    params.sink = sink;
    params.offset = offset;
    params.whence = whence;
    return ctrl.sendMessageWithRequestId(
        params,
        _fileMethodWriteFromStreamName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic tell([Function responseFactory = null]) {
    var params = new _FileTellParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _fileMethodTellName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic seek(int offset,types_mojom.Whence whence,[Function responseFactory = null]) {
    var params = new _FileSeekParams();
    params.offset = offset;
    params.whence = whence;
    return ctrl.sendMessageWithRequestId(
        params,
        _fileMethodSeekName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic stat([Function responseFactory = null]) {
    var params = new _FileStatParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _fileMethodStatName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic truncate(int size,[Function responseFactory = null]) {
    var params = new _FileTruncateParams();
    params.size = size;
    return ctrl.sendMessageWithRequestId(
        params,
        _fileMethodTruncateName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic touch(types_mojom.TimespecOrNow atime,types_mojom.TimespecOrNow mtime,[Function responseFactory = null]) {
    var params = new _FileTouchParams();
    params.atime = atime;
    params.mtime = mtime;
    return ctrl.sendMessageWithRequestId(
        params,
        _fileMethodTouchName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic dup(Object file,[Function responseFactory = null]) {
    var params = new _FileDupParams();
    params.file = file;
    return ctrl.sendMessageWithRequestId(
        params,
        _fileMethodDupName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic reopen(Object file,int openFlags,[Function responseFactory = null]) {
    var params = new _FileReopenParams();
    params.file = file;
    params.openFlags = openFlags;
    return ctrl.sendMessageWithRequestId(
        params,
        _fileMethodReopenName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic asBuffer([Function responseFactory = null]) {
    var params = new _FileAsBufferParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _fileMethodAsBufferName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic ioctl(int request,List<int> inValues,[Function responseFactory = null]) {
    var params = new _FileIoctlParams();
    params.request = request;
    params.inValues = inValues;
    return ctrl.sendMessageWithRequestId(
        params,
        _fileMethodIoctlName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _FileStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<File> {
  File _impl;

  _FileStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [File impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _FileStubControl.fromHandle(
      core.MojoHandle handle, [File impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _FileStubControl.unbound([this._impl]) : super.unbound();


  FileCloseResponseParams _fileCloseResponseParamsFactory(types_mojom.Error err) {
    var result = new FileCloseResponseParams();
    result.err = err;
    return result;
  }
  FileReadResponseParams _fileReadResponseParamsFactory(types_mojom.Error error, List<int> bytesRead) {
    var result = new FileReadResponseParams();
    result.error = error;
    result.bytesRead = bytesRead;
    return result;
  }
  FileWriteResponseParams _fileWriteResponseParamsFactory(types_mojom.Error error, int numBytesWritten) {
    var result = new FileWriteResponseParams();
    result.error = error;
    result.numBytesWritten = numBytesWritten;
    return result;
  }
  FileReadToStreamResponseParams _fileReadToStreamResponseParamsFactory(types_mojom.Error error) {
    var result = new FileReadToStreamResponseParams();
    result.error = error;
    return result;
  }
  FileWriteFromStreamResponseParams _fileWriteFromStreamResponseParamsFactory(types_mojom.Error error) {
    var result = new FileWriteFromStreamResponseParams();
    result.error = error;
    return result;
  }
  FileTellResponseParams _fileTellResponseParamsFactory(types_mojom.Error error, int position) {
    var result = new FileTellResponseParams();
    result.error = error;
    result.position = position;
    return result;
  }
  FileSeekResponseParams _fileSeekResponseParamsFactory(types_mojom.Error error, int position) {
    var result = new FileSeekResponseParams();
    result.error = error;
    result.position = position;
    return result;
  }
  FileStatResponseParams _fileStatResponseParamsFactory(types_mojom.Error error, types_mojom.FileInformation fileInformation) {
    var result = new FileStatResponseParams();
    result.error = error;
    result.fileInformation = fileInformation;
    return result;
  }
  FileTruncateResponseParams _fileTruncateResponseParamsFactory(types_mojom.Error error) {
    var result = new FileTruncateResponseParams();
    result.error = error;
    return result;
  }
  FileTouchResponseParams _fileTouchResponseParamsFactory(types_mojom.Error error) {
    var result = new FileTouchResponseParams();
    result.error = error;
    return result;
  }
  FileDupResponseParams _fileDupResponseParamsFactory(types_mojom.Error error) {
    var result = new FileDupResponseParams();
    result.error = error;
    return result;
  }
  FileReopenResponseParams _fileReopenResponseParamsFactory(types_mojom.Error error) {
    var result = new FileReopenResponseParams();
    result.error = error;
    return result;
  }
  FileAsBufferResponseParams _fileAsBufferResponseParamsFactory(types_mojom.Error error, core.MojoSharedBuffer buffer) {
    var result = new FileAsBufferResponseParams();
    result.error = error;
    result.buffer = buffer;
    return result;
  }
  FileIoctlResponseParams _fileIoctlResponseParamsFactory(types_mojom.Error error, List<int> outValues) {
    var result = new FileIoctlResponseParams();
    result.error = error;
    result.outValues = outValues;
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
      case _fileMethodCloseName:
        var response = _impl.close_(_fileCloseResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _fileMethodCloseName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _fileMethodCloseName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _fileMethodReadName:
        var params = _FileReadParams.deserialize(
            message.payload);
        var response = _impl.read(params.numBytesToRead,params.offset,params.whence,_fileReadResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _fileMethodReadName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _fileMethodReadName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _fileMethodWriteName:
        var params = _FileWriteParams.deserialize(
            message.payload);
        var response = _impl.write(params.bytesToWrite,params.offset,params.whence,_fileWriteResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _fileMethodWriteName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _fileMethodWriteName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _fileMethodReadToStreamName:
        var params = _FileReadToStreamParams.deserialize(
            message.payload);
        var response = _impl.readToStream(params.source,params.offset,params.whence,params.numBytesToRead,_fileReadToStreamResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _fileMethodReadToStreamName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _fileMethodReadToStreamName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _fileMethodWriteFromStreamName:
        var params = _FileWriteFromStreamParams.deserialize(
            message.payload);
        var response = _impl.writeFromStream(params.sink,params.offset,params.whence,_fileWriteFromStreamResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _fileMethodWriteFromStreamName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _fileMethodWriteFromStreamName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _fileMethodTellName:
        var response = _impl.tell(_fileTellResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _fileMethodTellName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _fileMethodTellName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _fileMethodSeekName:
        var params = _FileSeekParams.deserialize(
            message.payload);
        var response = _impl.seek(params.offset,params.whence,_fileSeekResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _fileMethodSeekName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _fileMethodSeekName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _fileMethodStatName:
        var response = _impl.stat(_fileStatResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _fileMethodStatName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _fileMethodStatName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _fileMethodTruncateName:
        var params = _FileTruncateParams.deserialize(
            message.payload);
        var response = _impl.truncate(params.size,_fileTruncateResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _fileMethodTruncateName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _fileMethodTruncateName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _fileMethodTouchName:
        var params = _FileTouchParams.deserialize(
            message.payload);
        var response = _impl.touch(params.atime,params.mtime,_fileTouchResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _fileMethodTouchName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _fileMethodTouchName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _fileMethodDupName:
        var params = _FileDupParams.deserialize(
            message.payload);
        var response = _impl.dup(params.file,_fileDupResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _fileMethodDupName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _fileMethodDupName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _fileMethodReopenName:
        var params = _FileReopenParams.deserialize(
            message.payload);
        var response = _impl.reopen(params.file,params.openFlags,_fileReopenResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _fileMethodReopenName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _fileMethodReopenName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _fileMethodAsBufferName:
        var response = _impl.asBuffer(_fileAsBufferResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _fileMethodAsBufferName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _fileMethodAsBufferName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _fileMethodIoctlName:
        var params = _FileIoctlParams.deserialize(
            message.payload);
        var response = _impl.ioctl(params.request,params.inValues,_fileIoctlResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _fileMethodIoctlName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _fileMethodIoctlName,
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

  File get impl => _impl;
  set impl(File d) {
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
    return "_FileStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _FileServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class FileStub
    extends bindings.Stub<File>
    implements File {
  FileStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [File impl])
      : super(new _FileStubControl.fromEndpoint(endpoint, impl));

  FileStub.fromHandle(
      core.MojoHandle handle, [File impl])
      : super(new _FileStubControl.fromHandle(handle, impl));

  FileStub.unbound([File impl])
      : super(new _FileStubControl.unbound(impl));

  static FileStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FileStub"));
    return new FileStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _FileStubControl.serviceDescription;


  dynamic close_([Function responseFactory = null]) {
    return impl.close_(responseFactory);
  }
  dynamic read(int numBytesToRead,int offset,types_mojom.Whence whence,[Function responseFactory = null]) {
    return impl.read(numBytesToRead,offset,whence,responseFactory);
  }
  dynamic write(List<int> bytesToWrite,int offset,types_mojom.Whence whence,[Function responseFactory = null]) {
    return impl.write(bytesToWrite,offset,whence,responseFactory);
  }
  dynamic readToStream(core.MojoDataPipeProducer source,int offset,types_mojom.Whence whence,int numBytesToRead,[Function responseFactory = null]) {
    return impl.readToStream(source,offset,whence,numBytesToRead,responseFactory);
  }
  dynamic writeFromStream(core.MojoDataPipeConsumer sink,int offset,types_mojom.Whence whence,[Function responseFactory = null]) {
    return impl.writeFromStream(sink,offset,whence,responseFactory);
  }
  dynamic tell([Function responseFactory = null]) {
    return impl.tell(responseFactory);
  }
  dynamic seek(int offset,types_mojom.Whence whence,[Function responseFactory = null]) {
    return impl.seek(offset,whence,responseFactory);
  }
  dynamic stat([Function responseFactory = null]) {
    return impl.stat(responseFactory);
  }
  dynamic truncate(int size,[Function responseFactory = null]) {
    return impl.truncate(size,responseFactory);
  }
  dynamic touch(types_mojom.TimespecOrNow atime,types_mojom.TimespecOrNow mtime,[Function responseFactory = null]) {
    return impl.touch(atime,mtime,responseFactory);
  }
  dynamic dup(Object file,[Function responseFactory = null]) {
    return impl.dup(file,responseFactory);
  }
  dynamic reopen(Object file,int openFlags,[Function responseFactory = null]) {
    return impl.reopen(file,openFlags,responseFactory);
  }
  dynamic asBuffer([Function responseFactory = null]) {
    return impl.asBuffer(responseFactory);
  }
  dynamic ioctl(int request,List<int> inValues,[Function responseFactory = null]) {
    return impl.ioctl(request,inValues,responseFactory);
  }
}



