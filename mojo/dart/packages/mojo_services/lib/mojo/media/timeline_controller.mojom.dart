// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library timeline_controller_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/timelines.mojom.dart' as timelines_mojom;



class MediaTimelineControllerStatus extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  timelines_mojom.TimelineTransform timelineTransform = null;
  bool endOfStream = false;

  MediaTimelineControllerStatus() : super(kVersions.last.size);

  static MediaTimelineControllerStatus deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaTimelineControllerStatus decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaTimelineControllerStatus result = new MediaTimelineControllerStatus();

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
      result.timelineTransform = timelines_mojom.TimelineTransform.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.endOfStream = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(timelineTransform, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "timelineTransform of struct MediaTimelineControllerStatus: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(endOfStream, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "endOfStream of struct MediaTimelineControllerStatus: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaTimelineControllerStatus("
           "timelineTransform: $timelineTransform" ", "
           "endOfStream: $endOfStream" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["timelineTransform"] = timelineTransform;
    map["endOfStream"] = endOfStream;
    return map;
  }
}


class MediaTimelineControlSiteStatus extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool endOfStream = false;
  bool starving = false;

  MediaTimelineControlSiteStatus() : super(kVersions.last.size);

  static MediaTimelineControlSiteStatus deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaTimelineControlSiteStatus decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaTimelineControlSiteStatus result = new MediaTimelineControlSiteStatus();

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
      
      result.endOfStream = decoder0.decodeBool(8, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.starving = decoder0.decodeBool(8, 1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(endOfStream, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "endOfStream of struct MediaTimelineControlSiteStatus: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(starving, 8, 1);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "starving of struct MediaTimelineControlSiteStatus: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaTimelineControlSiteStatus("
           "endOfStream: $endOfStream" ", "
           "starving: $starving" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["endOfStream"] = endOfStream;
    map["starving"] = starving;
    return map;
  }
}


class _MediaTimelineControllerAddControlSiteParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object controlSite = null;

  _MediaTimelineControllerAddControlSiteParams() : super(kVersions.last.size);

  static _MediaTimelineControllerAddControlSiteParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaTimelineControllerAddControlSiteParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaTimelineControllerAddControlSiteParams result = new _MediaTimelineControllerAddControlSiteParams();

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
      
      result.controlSite = decoder0.decodeServiceInterface(8, false, MediaTimelineControlSiteProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(controlSite, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "controlSite of struct _MediaTimelineControllerAddControlSiteParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaTimelineControllerAddControlSiteParams("
           "controlSite: $controlSite" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaTimelineControllerGetStatusParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int versionLastSeen = 0;

  _MediaTimelineControllerGetStatusParams() : super(kVersions.last.size);

  static _MediaTimelineControllerGetStatusParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaTimelineControllerGetStatusParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaTimelineControllerGetStatusParams result = new _MediaTimelineControllerGetStatusParams();

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
          "versionLastSeen of struct _MediaTimelineControllerGetStatusParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaTimelineControllerGetStatusParams("
           "versionLastSeen: $versionLastSeen" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["versionLastSeen"] = versionLastSeen;
    return map;
  }
}


class MediaTimelineControllerGetStatusResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int version = 0;
  MediaTimelineControllerStatus status = null;

  MediaTimelineControllerGetStatusResponseParams() : super(kVersions.last.size);

  static MediaTimelineControllerGetStatusResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaTimelineControllerGetStatusResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaTimelineControllerGetStatusResponseParams result = new MediaTimelineControllerGetStatusResponseParams();

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
      result.status = MediaTimelineControllerStatus.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(version, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "version of struct MediaTimelineControllerGetStatusResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(status, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "status of struct MediaTimelineControllerGetStatusResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaTimelineControllerGetStatusResponseParams("
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


class _MediaTimelineControllerSetTimelineTransformParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  int subjectTime = 0;
  int subjectDelta = 0;
  int referenceDelta = 0;
  int effectiveSubjectTime = 0;
  int effectiveReferenceTime = 0;

  _MediaTimelineControllerSetTimelineTransformParams() : super(kVersions.last.size);

  static _MediaTimelineControllerSetTimelineTransformParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaTimelineControllerSetTimelineTransformParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaTimelineControllerSetTimelineTransformParams result = new _MediaTimelineControllerSetTimelineTransformParams();

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
      
      result.subjectTime = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.subjectDelta = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.referenceDelta = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.effectiveSubjectTime = decoder0.decodeInt64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.effectiveReferenceTime = decoder0.decodeInt64(32);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(subjectTime, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "subjectTime of struct _MediaTimelineControllerSetTimelineTransformParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(subjectDelta, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "subjectDelta of struct _MediaTimelineControllerSetTimelineTransformParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(referenceDelta, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "referenceDelta of struct _MediaTimelineControllerSetTimelineTransformParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(effectiveSubjectTime, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "effectiveSubjectTime of struct _MediaTimelineControllerSetTimelineTransformParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(effectiveReferenceTime, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "effectiveReferenceTime of struct _MediaTimelineControllerSetTimelineTransformParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaTimelineControllerSetTimelineTransformParams("
           "subjectTime: $subjectTime" ", "
           "subjectDelta: $subjectDelta" ", "
           "referenceDelta: $referenceDelta" ", "
           "effectiveSubjectTime: $effectiveSubjectTime" ", "
           "effectiveReferenceTime: $effectiveReferenceTime" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["subjectTime"] = subjectTime;
    map["subjectDelta"] = subjectDelta;
    map["referenceDelta"] = referenceDelta;
    map["effectiveSubjectTime"] = effectiveSubjectTime;
    map["effectiveReferenceTime"] = effectiveReferenceTime;
    return map;
  }
}


class MediaTimelineControllerSetTimelineTransformResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool completed = false;

  MediaTimelineControllerSetTimelineTransformResponseParams() : super(kVersions.last.size);

  static MediaTimelineControllerSetTimelineTransformResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaTimelineControllerSetTimelineTransformResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaTimelineControllerSetTimelineTransformResponseParams result = new MediaTimelineControllerSetTimelineTransformResponseParams();

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
      
      result.completed = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(completed, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "completed of struct MediaTimelineControllerSetTimelineTransformResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaTimelineControllerSetTimelineTransformResponseParams("
           "completed: $completed" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["completed"] = completed;
    return map;
  }
}


class _MediaTimelineControllerGetControlSiteParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object controlSite = null;

  _MediaTimelineControllerGetControlSiteParams() : super(kVersions.last.size);

  static _MediaTimelineControllerGetControlSiteParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaTimelineControllerGetControlSiteParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaTimelineControllerGetControlSiteParams result = new _MediaTimelineControllerGetControlSiteParams();

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
      
      result.controlSite = decoder0.decodeInterfaceRequest(8, false, MediaTimelineControlSiteStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(controlSite, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "controlSite of struct _MediaTimelineControllerGetControlSiteParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaTimelineControllerGetControlSiteParams("
           "controlSite: $controlSite" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaTimelineControlSiteGetStatusParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int versionLastSeen = 0;

  _MediaTimelineControlSiteGetStatusParams() : super(kVersions.last.size);

  static _MediaTimelineControlSiteGetStatusParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaTimelineControlSiteGetStatusParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaTimelineControlSiteGetStatusParams result = new _MediaTimelineControlSiteGetStatusParams();

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
          "versionLastSeen of struct _MediaTimelineControlSiteGetStatusParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaTimelineControlSiteGetStatusParams("
           "versionLastSeen: $versionLastSeen" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["versionLastSeen"] = versionLastSeen;
    return map;
  }
}


class MediaTimelineControlSiteGetStatusResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int version = 0;
  MediaTimelineControlSiteStatus status = null;

  MediaTimelineControlSiteGetStatusResponseParams() : super(kVersions.last.size);

  static MediaTimelineControlSiteGetStatusResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaTimelineControlSiteGetStatusResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaTimelineControlSiteGetStatusResponseParams result = new MediaTimelineControlSiteGetStatusResponseParams();

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
      result.status = MediaTimelineControlSiteStatus.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(version, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "version of struct MediaTimelineControlSiteGetStatusResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(status, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "status of struct MediaTimelineControlSiteGetStatusResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaTimelineControlSiteGetStatusResponseParams("
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


class _MediaTimelineControlSiteGetTimelineConsumerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object timelineConsumer = null;

  _MediaTimelineControlSiteGetTimelineConsumerParams() : super(kVersions.last.size);

  static _MediaTimelineControlSiteGetTimelineConsumerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaTimelineControlSiteGetTimelineConsumerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaTimelineControlSiteGetTimelineConsumerParams result = new _MediaTimelineControlSiteGetTimelineConsumerParams();

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
      
      result.timelineConsumer = decoder0.decodeInterfaceRequest(8, false, timelines_mojom.TimelineConsumerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(timelineConsumer, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "timelineConsumer of struct _MediaTimelineControlSiteGetTimelineConsumerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaTimelineControlSiteGetTimelineConsumerParams("
           "timelineConsumer: $timelineConsumer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _mediaTimelineControllerMethodAddControlSiteName = 0;
const int _mediaTimelineControllerMethodGetStatusName = 1;
const int _mediaTimelineControllerMethodSetTimelineTransformName = 2;
const int _mediaTimelineControllerMethodGetControlSiteName = 3;

class _MediaTimelineControllerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class MediaTimelineController {
  static const String serviceName = null;
  void addControlSite(Object controlSite);
  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]);
  dynamic setTimelineTransform(int subjectTime,int subjectDelta,int referenceDelta,int effectiveSubjectTime,int effectiveReferenceTime,[Function responseFactory = null]);
  void getControlSite(Object controlSite);
  static const int kUnspecifiedTime = 9223372036854775807;
  static const int kInitialStatus = 0;
}


class _MediaTimelineControllerProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _MediaTimelineControllerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaTimelineControllerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _MediaTimelineControllerProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _MediaTimelineControllerServiceDescription();

  String get serviceName => MediaTimelineController.serviceName;

  @override
  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _mediaTimelineControllerMethodGetStatusName:
        var r = MediaTimelineControllerGetStatusResponseParams.deserialize(
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
      case _mediaTimelineControllerMethodSetTimelineTransformName:
        var r = MediaTimelineControllerSetTimelineTransformResponseParams.deserialize(
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
    return "_MediaTimelineControllerProxyControl($superString)";
  }
}


class MediaTimelineControllerProxy extends bindings.Proxy
                              implements MediaTimelineController {
  MediaTimelineControllerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _MediaTimelineControllerProxyControl.fromEndpoint(endpoint));

  MediaTimelineControllerProxy.fromHandle(core.MojoHandle handle)
      : super(new _MediaTimelineControllerProxyControl.fromHandle(handle));

  MediaTimelineControllerProxy.unbound()
      : super(new _MediaTimelineControllerProxyControl.unbound());

  static MediaTimelineControllerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaTimelineControllerProxy"));
    return new MediaTimelineControllerProxy.fromEndpoint(endpoint);
  }

  factory MediaTimelineControllerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaTimelineControllerProxy p = new MediaTimelineControllerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void addControlSite(Object controlSite) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaTimelineControllerAddControlSiteParams();
    params.controlSite = controlSite;
    ctrl.sendMessage(params,
        _mediaTimelineControllerMethodAddControlSiteName);
  }
  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]) {
    var params = new _MediaTimelineControllerGetStatusParams();
    params.versionLastSeen = versionLastSeen;
    return ctrl.sendMessageWithRequestId(
        params,
        _mediaTimelineControllerMethodGetStatusName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic setTimelineTransform(int subjectTime,int subjectDelta,int referenceDelta,int effectiveSubjectTime,int effectiveReferenceTime,[Function responseFactory = null]) {
    var params = new _MediaTimelineControllerSetTimelineTransformParams();
    params.subjectTime = subjectTime;
    params.subjectDelta = subjectDelta;
    params.referenceDelta = referenceDelta;
    params.effectiveSubjectTime = effectiveSubjectTime;
    params.effectiveReferenceTime = effectiveReferenceTime;
    return ctrl.sendMessageWithRequestId(
        params,
        _mediaTimelineControllerMethodSetTimelineTransformName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void getControlSite(Object controlSite) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaTimelineControllerGetControlSiteParams();
    params.controlSite = controlSite;
    ctrl.sendMessage(params,
        _mediaTimelineControllerMethodGetControlSiteName);
  }
}


class MediaTimelineControllerStub extends bindings.Stub {
  MediaTimelineController _impl;

  MediaTimelineControllerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaTimelineController impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  MediaTimelineControllerStub.fromHandle(
      core.MojoHandle handle, [MediaTimelineController impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  MediaTimelineControllerStub.unbound([this._impl]) : super.unbound();

  static MediaTimelineControllerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaTimelineControllerStub"));
    return new MediaTimelineControllerStub.fromEndpoint(endpoint);
  }


  MediaTimelineControllerGetStatusResponseParams _mediaTimelineControllerGetStatusResponseParamsFactory(int version, MediaTimelineControllerStatus status) {
    var result = new MediaTimelineControllerGetStatusResponseParams();
    result.version = version;
    result.status = status;
    return result;
  }
  MediaTimelineControllerSetTimelineTransformResponseParams _mediaTimelineControllerSetTimelineTransformResponseParamsFactory(bool completed) {
    var result = new MediaTimelineControllerSetTimelineTransformResponseParams();
    result.completed = completed;
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
      case _mediaTimelineControllerMethodAddControlSiteName:
        var params = _MediaTimelineControllerAddControlSiteParams.deserialize(
            message.payload);
        _impl.addControlSite(params.controlSite);
        break;
      case _mediaTimelineControllerMethodGetStatusName:
        var params = _MediaTimelineControllerGetStatusParams.deserialize(
            message.payload);
        var response = _impl.getStatus(params.versionLastSeen,_mediaTimelineControllerGetStatusResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaTimelineControllerMethodGetStatusName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaTimelineControllerMethodGetStatusName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaTimelineControllerMethodSetTimelineTransformName:
        var params = _MediaTimelineControllerSetTimelineTransformParams.deserialize(
            message.payload);
        var response = _impl.setTimelineTransform(params.subjectTime,params.subjectDelta,params.referenceDelta,params.effectiveSubjectTime,params.effectiveReferenceTime,_mediaTimelineControllerSetTimelineTransformResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaTimelineControllerMethodSetTimelineTransformName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaTimelineControllerMethodSetTimelineTransformName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaTimelineControllerMethodGetControlSiteName:
        var params = _MediaTimelineControllerGetControlSiteParams.deserialize(
            message.payload);
        _impl.getControlSite(params.controlSite);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  MediaTimelineController get impl => _impl;
  set impl(MediaTimelineController d) {
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

  String toString() {
    var superString = super.toString();
    return "MediaTimelineControllerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _MediaTimelineControllerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _mediaTimelineControlSiteMethodGetStatusName = 0;
const int _mediaTimelineControlSiteMethodGetTimelineConsumerName = 1;

class _MediaTimelineControlSiteServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class MediaTimelineControlSite {
  static const String serviceName = null;
  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]);
  void getTimelineConsumer(Object timelineConsumer);
  static const int kInitialStatus = 0;
}


class _MediaTimelineControlSiteProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _MediaTimelineControlSiteProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaTimelineControlSiteProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _MediaTimelineControlSiteProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _MediaTimelineControlSiteServiceDescription();

  String get serviceName => MediaTimelineControlSite.serviceName;

  @override
  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _mediaTimelineControlSiteMethodGetStatusName:
        var r = MediaTimelineControlSiteGetStatusResponseParams.deserialize(
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
    return "_MediaTimelineControlSiteProxyControl($superString)";
  }
}


class MediaTimelineControlSiteProxy extends bindings.Proxy
                              implements MediaTimelineControlSite {
  MediaTimelineControlSiteProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _MediaTimelineControlSiteProxyControl.fromEndpoint(endpoint));

  MediaTimelineControlSiteProxy.fromHandle(core.MojoHandle handle)
      : super(new _MediaTimelineControlSiteProxyControl.fromHandle(handle));

  MediaTimelineControlSiteProxy.unbound()
      : super(new _MediaTimelineControlSiteProxyControl.unbound());

  static MediaTimelineControlSiteProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaTimelineControlSiteProxy"));
    return new MediaTimelineControlSiteProxy.fromEndpoint(endpoint);
  }

  factory MediaTimelineControlSiteProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaTimelineControlSiteProxy p = new MediaTimelineControlSiteProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]) {
    var params = new _MediaTimelineControlSiteGetStatusParams();
    params.versionLastSeen = versionLastSeen;
    return ctrl.sendMessageWithRequestId(
        params,
        _mediaTimelineControlSiteMethodGetStatusName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void getTimelineConsumer(Object timelineConsumer) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaTimelineControlSiteGetTimelineConsumerParams();
    params.timelineConsumer = timelineConsumer;
    ctrl.sendMessage(params,
        _mediaTimelineControlSiteMethodGetTimelineConsumerName);
  }
}


class MediaTimelineControlSiteStub extends bindings.Stub {
  MediaTimelineControlSite _impl;

  MediaTimelineControlSiteStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaTimelineControlSite impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  MediaTimelineControlSiteStub.fromHandle(
      core.MojoHandle handle, [MediaTimelineControlSite impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  MediaTimelineControlSiteStub.unbound([this._impl]) : super.unbound();

  static MediaTimelineControlSiteStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaTimelineControlSiteStub"));
    return new MediaTimelineControlSiteStub.fromEndpoint(endpoint);
  }


  MediaTimelineControlSiteGetStatusResponseParams _mediaTimelineControlSiteGetStatusResponseParamsFactory(int version, MediaTimelineControlSiteStatus status) {
    var result = new MediaTimelineControlSiteGetStatusResponseParams();
    result.version = version;
    result.status = status;
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
      case _mediaTimelineControlSiteMethodGetStatusName:
        var params = _MediaTimelineControlSiteGetStatusParams.deserialize(
            message.payload);
        var response = _impl.getStatus(params.versionLastSeen,_mediaTimelineControlSiteGetStatusResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaTimelineControlSiteMethodGetStatusName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaTimelineControlSiteMethodGetStatusName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaTimelineControlSiteMethodGetTimelineConsumerName:
        var params = _MediaTimelineControlSiteGetTimelineConsumerParams.deserialize(
            message.payload);
        _impl.getTimelineConsumer(params.timelineConsumer);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  MediaTimelineControlSite get impl => _impl;
  set impl(MediaTimelineControlSite d) {
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

  String toString() {
    var superString = super.toString();
    return "MediaTimelineControlSiteStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _MediaTimelineControlSiteServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



