// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_source_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/media/media_metadata.mojom.dart' as media_metadata_mojom;
import 'package:mojo_services/mojo/media/media_state.mojom.dart' as media_state_mojom;
import 'package:mojo_services/mojo/media/media_transport.mojom.dart' as media_transport_mojom;
import 'package:mojo_services/mojo/media/media_types.mojom.dart' as media_types_mojom;



class MediaSourceStreamDescriptor extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int index = 0;
  media_types_mojom.MediaType mediaType = null;
  media_types_mojom.MediaType originalMediaType = null;

  MediaSourceStreamDescriptor() : super(kVersions.last.size);

  static MediaSourceStreamDescriptor deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceStreamDescriptor decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceStreamDescriptor result = new MediaSourceStreamDescriptor();

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
      
      result.index = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.mediaType = media_types_mojom.MediaType.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, false);
      result.originalMediaType = media_types_mojom.MediaType.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(index, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "index of struct MediaSourceStreamDescriptor: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(mediaType, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mediaType of struct MediaSourceStreamDescriptor: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(originalMediaType, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "originalMediaType of struct MediaSourceStreamDescriptor: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaSourceStreamDescriptor("
           "index: $index" ", "
           "mediaType: $mediaType" ", "
           "originalMediaType: $originalMediaType" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["index"] = index;
    map["mediaType"] = mediaType;
    map["originalMediaType"] = originalMediaType;
    return map;
  }
}


class MediaSourceStatus extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  media_state_mojom.MediaState state = null;
  media_metadata_mojom.MediaMetadata metadata = null;

  MediaSourceStatus() : super(kVersions.last.size);

  static MediaSourceStatus deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceStatus decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceStatus result = new MediaSourceStatus();

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
      
        result.state = media_state_mojom.MediaState.decode(decoder0, 8);
        if (result.state == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable media_state_mojom.MediaState.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.metadata = media_metadata_mojom.MediaMetadata.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(state, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "state of struct MediaSourceStatus: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(metadata, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "metadata of struct MediaSourceStatus: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaSourceStatus("
           "state: $state" ", "
           "metadata: $metadata" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["state"] = state;
    map["metadata"] = metadata;
    return map;
  }
}


class _MediaSourceGetStreamsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSourceGetStreamsParams() : super(kVersions.last.size);

  static _MediaSourceGetStreamsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceGetStreamsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceGetStreamsParams result = new _MediaSourceGetStreamsParams();

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
    return "_MediaSourceGetStreamsParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaSourceGetStreamsResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<MediaSourceStreamDescriptor> streams = null;

  MediaSourceGetStreamsResponseParams() : super(kVersions.last.size);

  static MediaSourceGetStreamsResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceGetStreamsResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceGetStreamsResponseParams result = new MediaSourceGetStreamsResponseParams();

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
        result.streams = new List<MediaSourceStreamDescriptor>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.streams[i1] = MediaSourceStreamDescriptor.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (streams == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(streams.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < streams.length; ++i0) {
          encoder1.encodeStruct(streams[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "streams of struct MediaSourceGetStreamsResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaSourceGetStreamsResponseParams("
           "streams: $streams" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["streams"] = streams;
    return map;
  }
}


class _MediaSourceGetProducerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int streamIndex = 0;
  Object producer = null;

  _MediaSourceGetProducerParams() : super(kVersions.last.size);

  static _MediaSourceGetProducerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceGetProducerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceGetProducerParams result = new _MediaSourceGetProducerParams();

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
      
      result.streamIndex = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.producer = decoder0.decodeInterfaceRequest(12, false, media_transport_mojom.MediaProducerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(streamIndex, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "streamIndex of struct _MediaSourceGetProducerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(producer, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "producer of struct _MediaSourceGetProducerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaSourceGetProducerParams("
           "streamIndex: $streamIndex" ", "
           "producer: $producer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaSourceGetPullModeProducerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int streamIndex = 0;
  Object producer = null;

  _MediaSourceGetPullModeProducerParams() : super(kVersions.last.size);

  static _MediaSourceGetPullModeProducerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceGetPullModeProducerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceGetPullModeProducerParams result = new _MediaSourceGetPullModeProducerParams();

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
      
      result.streamIndex = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.producer = decoder0.decodeInterfaceRequest(12, false, media_transport_mojom.MediaPullModeProducerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(streamIndex, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "streamIndex of struct _MediaSourceGetPullModeProducerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(producer, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "producer of struct _MediaSourceGetPullModeProducerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaSourceGetPullModeProducerParams("
           "streamIndex: $streamIndex" ", "
           "producer: $producer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaSourceGetStatusParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int versionLastSeen = 0;

  _MediaSourceGetStatusParams() : super(kVersions.last.size);

  static _MediaSourceGetStatusParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceGetStatusParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceGetStatusParams result = new _MediaSourceGetStatusParams();

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
      
      result.versionLastSeen = decoder0.decodeUint64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(versionLastSeen, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "versionLastSeen of struct _MediaSourceGetStatusParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaSourceGetStatusParams("
           "versionLastSeen: $versionLastSeen" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["versionLastSeen"] = versionLastSeen;
    return map;
  }
}


class MediaSourceGetStatusResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int version = 0;
  MediaSourceStatus status = null;

  MediaSourceGetStatusResponseParams() : super(kVersions.last.size);

  static MediaSourceGetStatusResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceGetStatusResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceGetStatusResponseParams result = new MediaSourceGetStatusResponseParams();

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
      
      result.version = decoder0.decodeUint64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.status = MediaSourceStatus.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(version, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "version of struct MediaSourceGetStatusResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(status, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "status of struct MediaSourceGetStatusResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaSourceGetStatusResponseParams("
           "version: $version" ", "
           "status: $status" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["version"] = version;
    map["status"] = status;
    return map;
  }
}


class _MediaSourcePrepareParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSourcePrepareParams() : super(kVersions.last.size);

  static _MediaSourcePrepareParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourcePrepareParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourcePrepareParams result = new _MediaSourcePrepareParams();

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
    return "_MediaSourcePrepareParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaSourcePrepareResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaSourcePrepareResponseParams() : super(kVersions.last.size);

  static MediaSourcePrepareResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourcePrepareResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourcePrepareResponseParams result = new MediaSourcePrepareResponseParams();

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
    return "MediaSourcePrepareResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaSourcePrimeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSourcePrimeParams() : super(kVersions.last.size);

  static _MediaSourcePrimeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourcePrimeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourcePrimeParams result = new _MediaSourcePrimeParams();

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
    return "_MediaSourcePrimeParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaSourcePrimeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaSourcePrimeResponseParams() : super(kVersions.last.size);

  static MediaSourcePrimeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourcePrimeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourcePrimeResponseParams result = new MediaSourcePrimeResponseParams();

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
    return "MediaSourcePrimeResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaSourceFlushParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSourceFlushParams() : super(kVersions.last.size);

  static _MediaSourceFlushParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceFlushParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceFlushParams result = new _MediaSourceFlushParams();

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
    return "_MediaSourceFlushParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class MediaSourceFlushResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaSourceFlushResponseParams() : super(kVersions.last.size);

  static MediaSourceFlushResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceFlushResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceFlushResponseParams result = new MediaSourceFlushResponseParams();

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
    return "MediaSourceFlushResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaSourceSeekParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int position = 0;

  _MediaSourceSeekParams() : super(kVersions.last.size);

  static _MediaSourceSeekParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSourceSeekParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSourceSeekParams result = new _MediaSourceSeekParams();

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
      
      result.position = decoder0.decodeInt64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(position, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "position of struct _MediaSourceSeekParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaSourceSeekParams("
           "position: $position" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["position"] = position;
    return map;
  }
}


class MediaSourceSeekResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  MediaSourceSeekResponseParams() : super(kVersions.last.size);

  static MediaSourceSeekResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSourceSeekResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSourceSeekResponseParams result = new MediaSourceSeekResponseParams();

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
    return "MediaSourceSeekResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _mediaSourceMethodGetStreamsName = 0;
const int _mediaSourceMethodGetProducerName = 1;
const int _mediaSourceMethodGetPullModeProducerName = 2;
const int _mediaSourceMethodGetStatusName = 3;
const int _mediaSourceMethodPrepareName = 4;
const int _mediaSourceMethodPrimeName = 5;
const int _mediaSourceMethodFlushName = 6;
const int _mediaSourceMethodSeekName = 7;

class _MediaSourceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class MediaSource {
  static const String serviceName = null;
  dynamic getStreams([Function responseFactory = null]);
  void getProducer(int streamIndex, Object producer);
  void getPullModeProducer(int streamIndex, Object producer);
  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]);
  dynamic prepare([Function responseFactory = null]);
  dynamic prime([Function responseFactory = null]);
  dynamic flush([Function responseFactory = null]);
  dynamic seek(int position,[Function responseFactory = null]);
  static const int kInitialStatus = 0;
}

class _MediaSourceProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _MediaSourceProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaSourceProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _MediaSourceProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _MediaSourceServiceDescription();

  String get serviceName => MediaSource.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _mediaSourceMethodGetStreamsName:
        var r = MediaSourceGetStreamsResponseParams.deserialize(
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
      case _mediaSourceMethodGetStatusName:
        var r = MediaSourceGetStatusResponseParams.deserialize(
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
      case _mediaSourceMethodPrepareName:
        var r = MediaSourcePrepareResponseParams.deserialize(
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
      case _mediaSourceMethodPrimeName:
        var r = MediaSourcePrimeResponseParams.deserialize(
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
      case _mediaSourceMethodFlushName:
        var r = MediaSourceFlushResponseParams.deserialize(
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
      case _mediaSourceMethodSeekName:
        var r = MediaSourceSeekResponseParams.deserialize(
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
    return "_MediaSourceProxyControl($superString)";
  }
}

class MediaSourceProxy
    extends bindings.Proxy
    implements MediaSource {
  MediaSourceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _MediaSourceProxyControl.fromEndpoint(endpoint));

  MediaSourceProxy.fromHandle(core.MojoHandle handle)
      : super(new _MediaSourceProxyControl.fromHandle(handle));

  MediaSourceProxy.unbound()
      : super(new _MediaSourceProxyControl.unbound());

  static MediaSourceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaSourceProxy"));
    return new MediaSourceProxy.fromEndpoint(endpoint);
  }

  factory MediaSourceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaSourceProxy p = new MediaSourceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic getStreams([Function responseFactory = null]) {
    var params = new _MediaSourceGetStreamsParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _mediaSourceMethodGetStreamsName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void getProducer(int streamIndex, Object producer) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaSourceGetProducerParams();
    params.streamIndex = streamIndex;
    params.producer = producer;
    ctrl.sendMessage(params,
        _mediaSourceMethodGetProducerName);
  }
  void getPullModeProducer(int streamIndex, Object producer) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaSourceGetPullModeProducerParams();
    params.streamIndex = streamIndex;
    params.producer = producer;
    ctrl.sendMessage(params,
        _mediaSourceMethodGetPullModeProducerName);
  }
  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]) {
    var params = new _MediaSourceGetStatusParams();
    params.versionLastSeen = versionLastSeen;
    return ctrl.sendMessageWithRequestId(
        params,
        _mediaSourceMethodGetStatusName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic prepare([Function responseFactory = null]) {
    var params = new _MediaSourcePrepareParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _mediaSourceMethodPrepareName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic prime([Function responseFactory = null]) {
    var params = new _MediaSourcePrimeParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _mediaSourceMethodPrimeName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic flush([Function responseFactory = null]) {
    var params = new _MediaSourceFlushParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _mediaSourceMethodFlushName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic seek(int position,[Function responseFactory = null]) {
    var params = new _MediaSourceSeekParams();
    params.position = position;
    return ctrl.sendMessageWithRequestId(
        params,
        _mediaSourceMethodSeekName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _MediaSourceStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<MediaSource> {
  MediaSource _impl;

  _MediaSourceStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaSource impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _MediaSourceStubControl.fromHandle(
      core.MojoHandle handle, [MediaSource impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _MediaSourceStubControl.unbound([this._impl]) : super.unbound();


  MediaSourceGetStreamsResponseParams _mediaSourceGetStreamsResponseParamsFactory(List<MediaSourceStreamDescriptor> streams) {
    var result = new MediaSourceGetStreamsResponseParams();
    result.streams = streams;
    return result;
  }
  MediaSourceGetStatusResponseParams _mediaSourceGetStatusResponseParamsFactory(int version, MediaSourceStatus status) {
    var result = new MediaSourceGetStatusResponseParams();
    result.version = version;
    result.status = status;
    return result;
  }
  MediaSourcePrepareResponseParams _mediaSourcePrepareResponseParamsFactory() {
    var result = new MediaSourcePrepareResponseParams();
    return result;
  }
  MediaSourcePrimeResponseParams _mediaSourcePrimeResponseParamsFactory() {
    var result = new MediaSourcePrimeResponseParams();
    return result;
  }
  MediaSourceFlushResponseParams _mediaSourceFlushResponseParamsFactory() {
    var result = new MediaSourceFlushResponseParams();
    return result;
  }
  MediaSourceSeekResponseParams _mediaSourceSeekResponseParamsFactory() {
    var result = new MediaSourceSeekResponseParams();
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
      case _mediaSourceMethodGetStreamsName:
        var response = _impl.getStreams(_mediaSourceGetStreamsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaSourceMethodGetStreamsName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaSourceMethodGetStreamsName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaSourceMethodGetProducerName:
        var params = _MediaSourceGetProducerParams.deserialize(
            message.payload);
        _impl.getProducer(params.streamIndex, params.producer);
        break;
      case _mediaSourceMethodGetPullModeProducerName:
        var params = _MediaSourceGetPullModeProducerParams.deserialize(
            message.payload);
        _impl.getPullModeProducer(params.streamIndex, params.producer);
        break;
      case _mediaSourceMethodGetStatusName:
        var params = _MediaSourceGetStatusParams.deserialize(
            message.payload);
        var response = _impl.getStatus(params.versionLastSeen,_mediaSourceGetStatusResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaSourceMethodGetStatusName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaSourceMethodGetStatusName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaSourceMethodPrepareName:
        var response = _impl.prepare(_mediaSourcePrepareResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaSourceMethodPrepareName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaSourceMethodPrepareName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaSourceMethodPrimeName:
        var response = _impl.prime(_mediaSourcePrimeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaSourceMethodPrimeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaSourceMethodPrimeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaSourceMethodFlushName:
        var response = _impl.flush(_mediaSourceFlushResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaSourceMethodFlushName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaSourceMethodFlushName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaSourceMethodSeekName:
        var params = _MediaSourceSeekParams.deserialize(
            message.payload);
        var response = _impl.seek(params.position,_mediaSourceSeekResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaSourceMethodSeekName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaSourceMethodSeekName,
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

  MediaSource get impl => _impl;
  set impl(MediaSource d) {
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
    return "_MediaSourceStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _MediaSourceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class MediaSourceStub
    extends bindings.Stub<MediaSource>
    implements MediaSource {
  MediaSourceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaSource impl])
      : super(new _MediaSourceStubControl.fromEndpoint(endpoint, impl));

  MediaSourceStub.fromHandle(
      core.MojoHandle handle, [MediaSource impl])
      : super(new _MediaSourceStubControl.fromHandle(handle, impl));

  MediaSourceStub.unbound([MediaSource impl])
      : super(new _MediaSourceStubControl.unbound(impl));

  static MediaSourceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaSourceStub"));
    return new MediaSourceStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _MediaSourceStubControl.serviceDescription;


  dynamic getStreams([Function responseFactory = null]) {
    return impl.getStreams(responseFactory);
  }
  void getProducer(int streamIndex, Object producer) {
    return impl.getProducer(streamIndex, producer);
  }
  void getPullModeProducer(int streamIndex, Object producer) {
    return impl.getPullModeProducer(streamIndex, producer);
  }
  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]) {
    return impl.getStatus(versionLastSeen,responseFactory);
  }
  dynamic prepare([Function responseFactory = null]) {
    return impl.prepare(responseFactory);
  }
  dynamic prime([Function responseFactory = null]) {
    return impl.prime(responseFactory);
  }
  dynamic flush([Function responseFactory = null]) {
    return impl.flush(responseFactory);
  }
  dynamic seek(int position,[Function responseFactory = null]) {
    return impl.seek(position,responseFactory);
  }
}



