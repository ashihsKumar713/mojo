// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library rate_control_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class TimelineQuad extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int referenceOffset = 0;
  int targetOffset = 0;
  int referenceDelta = 0;
  int targetDelta = 1;

  TimelineQuad() : super(kVersions.last.size);

  static TimelineQuad deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TimelineQuad decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TimelineQuad result = new TimelineQuad();

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
      
      result.referenceOffset = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.targetOffset = decoder0.decodeInt64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.referenceDelta = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.targetDelta = decoder0.decodeUint32(28);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(referenceOffset, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "referenceOffset of struct TimelineQuad: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(targetOffset, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "targetOffset of struct TimelineQuad: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(referenceDelta, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "referenceDelta of struct TimelineQuad: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(targetDelta, 28);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "targetDelta of struct TimelineQuad: $e";
      rethrow;
    }
  }

  String toString() {
    return "TimelineQuad("
           "referenceOffset: $referenceOffset" ", "
           "targetOffset: $targetOffset" ", "
           "referenceDelta: $referenceDelta" ", "
           "targetDelta: $targetDelta" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["referenceOffset"] = referenceOffset;
    map["targetOffset"] = targetOffset;
    map["referenceDelta"] = referenceDelta;
    map["targetDelta"] = targetDelta;
    return map;
  }
}


class TimelineTransform extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  static const int kLocalTimeId = 4294967295;
  static const int kContextual = 4294967294;
  TimelineQuad quad = null;
  int referenceTimelineId = 4294967294;
  int targetTimelineId = 4294967295;

  TimelineTransform() : super(kVersions.last.size);

  static TimelineTransform deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TimelineTransform decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TimelineTransform result = new TimelineTransform();

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
      result.quad = TimelineQuad.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.referenceTimelineId = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.targetTimelineId = decoder0.decodeUint32(20);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(quad, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "quad of struct TimelineTransform: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(referenceTimelineId, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "referenceTimelineId of struct TimelineTransform: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(targetTimelineId, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "targetTimelineId of struct TimelineTransform: $e";
      rethrow;
    }
  }

  String toString() {
    return "TimelineTransform("
           "quad: $quad" ", "
           "referenceTimelineId: $referenceTimelineId" ", "
           "targetTimelineId: $targetTimelineId" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["quad"] = quad;
    map["referenceTimelineId"] = referenceTimelineId;
    map["targetTimelineId"] = targetTimelineId;
    return map;
  }
}


class _RateControlGetCurrentTransformParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _RateControlGetCurrentTransformParams() : super(kVersions.last.size);

  static _RateControlGetCurrentTransformParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _RateControlGetCurrentTransformParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _RateControlGetCurrentTransformParams result = new _RateControlGetCurrentTransformParams();

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
    return "_RateControlGetCurrentTransformParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class RateControlGetCurrentTransformResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  TimelineTransform trans = null;

  RateControlGetCurrentTransformResponseParams() : super(kVersions.last.size);

  static RateControlGetCurrentTransformResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static RateControlGetCurrentTransformResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    RateControlGetCurrentTransformResponseParams result = new RateControlGetCurrentTransformResponseParams();

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
      result.trans = TimelineTransform.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(trans, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "trans of struct RateControlGetCurrentTransformResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "RateControlGetCurrentTransformResponseParams("
           "trans: $trans" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["trans"] = trans;
    return map;
  }
}


class _RateControlSetCurrentQuadParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  TimelineQuad quad = null;

  _RateControlSetCurrentQuadParams() : super(kVersions.last.size);

  static _RateControlSetCurrentQuadParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _RateControlSetCurrentQuadParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _RateControlSetCurrentQuadParams result = new _RateControlSetCurrentQuadParams();

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
      result.quad = TimelineQuad.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(quad, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "quad of struct _RateControlSetCurrentQuadParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_RateControlSetCurrentQuadParams("
           "quad: $quad" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["quad"] = quad;
    return map;
  }
}


class _RateControlSetTargetTimelineIdParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int id = 0;

  _RateControlSetTargetTimelineIdParams() : super(kVersions.last.size);

  static _RateControlSetTargetTimelineIdParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _RateControlSetTargetTimelineIdParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _RateControlSetTargetTimelineIdParams result = new _RateControlSetTargetTimelineIdParams();

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
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(id, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "id of struct _RateControlSetTargetTimelineIdParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_RateControlSetTargetTimelineIdParams("
           "id: $id" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    return map;
  }
}


class _RateControlSetRateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int referenceDelta = 0;
  int targetDelta = 0;

  _RateControlSetRateParams() : super(kVersions.last.size);

  static _RateControlSetRateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _RateControlSetRateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _RateControlSetRateParams result = new _RateControlSetRateParams();

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
      
      result.referenceDelta = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.targetDelta = decoder0.decodeUint32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(referenceDelta, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "referenceDelta of struct _RateControlSetRateParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(targetDelta, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "targetDelta of struct _RateControlSetRateParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_RateControlSetRateParams("
           "referenceDelta: $referenceDelta" ", "
           "targetDelta: $targetDelta" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["referenceDelta"] = referenceDelta;
    map["targetDelta"] = targetDelta;
    return map;
  }
}


class _RateControlSetRateAtReferenceTimeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int referenceDelta = 0;
  int targetDelta = 0;
  int referenceTime = 0;

  _RateControlSetRateAtReferenceTimeParams() : super(kVersions.last.size);

  static _RateControlSetRateAtReferenceTimeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _RateControlSetRateAtReferenceTimeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _RateControlSetRateAtReferenceTimeParams result = new _RateControlSetRateAtReferenceTimeParams();

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
      
      result.referenceDelta = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.targetDelta = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.referenceTime = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(referenceDelta, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "referenceDelta of struct _RateControlSetRateAtReferenceTimeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(targetDelta, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "targetDelta of struct _RateControlSetRateAtReferenceTimeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(referenceTime, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "referenceTime of struct _RateControlSetRateAtReferenceTimeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_RateControlSetRateAtReferenceTimeParams("
           "referenceDelta: $referenceDelta" ", "
           "targetDelta: $targetDelta" ", "
           "referenceTime: $referenceTime" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["referenceDelta"] = referenceDelta;
    map["targetDelta"] = targetDelta;
    map["referenceTime"] = referenceTime;
    return map;
  }
}


class _RateControlSetRateAtTargetTimeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int referenceDelta = 0;
  int targetDelta = 0;
  int targetTime = 0;

  _RateControlSetRateAtTargetTimeParams() : super(kVersions.last.size);

  static _RateControlSetRateAtTargetTimeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _RateControlSetRateAtTargetTimeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _RateControlSetRateAtTargetTimeParams result = new _RateControlSetRateAtTargetTimeParams();

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
      
      result.referenceDelta = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.targetDelta = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.targetTime = decoder0.decodeInt64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(referenceDelta, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "referenceDelta of struct _RateControlSetRateAtTargetTimeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(targetDelta, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "targetDelta of struct _RateControlSetRateAtTargetTimeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(targetTime, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "targetTime of struct _RateControlSetRateAtTargetTimeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_RateControlSetRateAtTargetTimeParams("
           "referenceDelta: $referenceDelta" ", "
           "targetDelta: $targetDelta" ", "
           "targetTime: $targetTime" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["referenceDelta"] = referenceDelta;
    map["targetDelta"] = targetDelta;
    map["targetTime"] = targetTime;
    return map;
  }
}


class _RateControlCancelPendingChangesParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _RateControlCancelPendingChangesParams() : super(kVersions.last.size);

  static _RateControlCancelPendingChangesParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _RateControlCancelPendingChangesParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _RateControlCancelPendingChangesParams result = new _RateControlCancelPendingChangesParams();

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
    return "_RateControlCancelPendingChangesParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _rateControlMethodGetCurrentTransformName = 0;
const int _rateControlMethodSetCurrentQuadName = 1;
const int _rateControlMethodSetTargetTimelineIdName = 2;
const int _rateControlMethodSetRateName = 3;
const int _rateControlMethodSetRateAtReferenceTimeName = 4;
const int _rateControlMethodSetRateAtTargetTimeName = 5;
const int _rateControlMethodCancelPendingChangesName = 6;

class _RateControlServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class RateControl {
  static const String serviceName = null;
  dynamic getCurrentTransform([Function responseFactory = null]);
  void setCurrentQuad(TimelineQuad quad);
  void setTargetTimelineId(int id);
  void setRate(int referenceDelta, int targetDelta);
  void setRateAtReferenceTime(int referenceDelta, int targetDelta, int referenceTime);
  void setRateAtTargetTime(int referenceDelta, int targetDelta, int targetTime);
  void cancelPendingChanges();
}

class _RateControlProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _RateControlProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _RateControlProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _RateControlProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _RateControlServiceDescription();

  String get serviceName => RateControl.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _rateControlMethodGetCurrentTransformName:
        var r = RateControlGetCurrentTransformResponseParams.deserialize(
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
    return "_RateControlProxyControl($superString)";
  }
}

class RateControlProxy
    extends bindings.Proxy
    implements RateControl {
  RateControlProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _RateControlProxyControl.fromEndpoint(endpoint));

  RateControlProxy.fromHandle(core.MojoHandle handle)
      : super(new _RateControlProxyControl.fromHandle(handle));

  RateControlProxy.unbound()
      : super(new _RateControlProxyControl.unbound());

  static RateControlProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For RateControlProxy"));
    return new RateControlProxy.fromEndpoint(endpoint);
  }

  factory RateControlProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    RateControlProxy p = new RateControlProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic getCurrentTransform([Function responseFactory = null]) {
    var params = new _RateControlGetCurrentTransformParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _rateControlMethodGetCurrentTransformName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void setCurrentQuad(TimelineQuad quad) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _RateControlSetCurrentQuadParams();
    params.quad = quad;
    ctrl.sendMessage(params,
        _rateControlMethodSetCurrentQuadName);
  }
  void setTargetTimelineId(int id) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _RateControlSetTargetTimelineIdParams();
    params.id = id;
    ctrl.sendMessage(params,
        _rateControlMethodSetTargetTimelineIdName);
  }
  void setRate(int referenceDelta, int targetDelta) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _RateControlSetRateParams();
    params.referenceDelta = referenceDelta;
    params.targetDelta = targetDelta;
    ctrl.sendMessage(params,
        _rateControlMethodSetRateName);
  }
  void setRateAtReferenceTime(int referenceDelta, int targetDelta, int referenceTime) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _RateControlSetRateAtReferenceTimeParams();
    params.referenceDelta = referenceDelta;
    params.targetDelta = targetDelta;
    params.referenceTime = referenceTime;
    ctrl.sendMessage(params,
        _rateControlMethodSetRateAtReferenceTimeName);
  }
  void setRateAtTargetTime(int referenceDelta, int targetDelta, int targetTime) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _RateControlSetRateAtTargetTimeParams();
    params.referenceDelta = referenceDelta;
    params.targetDelta = targetDelta;
    params.targetTime = targetTime;
    ctrl.sendMessage(params,
        _rateControlMethodSetRateAtTargetTimeName);
  }
  void cancelPendingChanges() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _RateControlCancelPendingChangesParams();
    ctrl.sendMessage(params,
        _rateControlMethodCancelPendingChangesName);
  }
}

class _RateControlStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<RateControl> {
  RateControl _impl;

  _RateControlStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [RateControl impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _RateControlStubControl.fromHandle(
      core.MojoHandle handle, [RateControl impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _RateControlStubControl.unbound([this._impl]) : super.unbound();


  RateControlGetCurrentTransformResponseParams _rateControlGetCurrentTransformResponseParamsFactory(TimelineTransform trans) {
    var result = new RateControlGetCurrentTransformResponseParams();
    result.trans = trans;
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
      case _rateControlMethodGetCurrentTransformName:
        var response = _impl.getCurrentTransform(_rateControlGetCurrentTransformResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _rateControlMethodGetCurrentTransformName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _rateControlMethodGetCurrentTransformName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _rateControlMethodSetCurrentQuadName:
        var params = _RateControlSetCurrentQuadParams.deserialize(
            message.payload);
        _impl.setCurrentQuad(params.quad);
        break;
      case _rateControlMethodSetTargetTimelineIdName:
        var params = _RateControlSetTargetTimelineIdParams.deserialize(
            message.payload);
        _impl.setTargetTimelineId(params.id);
        break;
      case _rateControlMethodSetRateName:
        var params = _RateControlSetRateParams.deserialize(
            message.payload);
        _impl.setRate(params.referenceDelta, params.targetDelta);
        break;
      case _rateControlMethodSetRateAtReferenceTimeName:
        var params = _RateControlSetRateAtReferenceTimeParams.deserialize(
            message.payload);
        _impl.setRateAtReferenceTime(params.referenceDelta, params.targetDelta, params.referenceTime);
        break;
      case _rateControlMethodSetRateAtTargetTimeName:
        var params = _RateControlSetRateAtTargetTimeParams.deserialize(
            message.payload);
        _impl.setRateAtTargetTime(params.referenceDelta, params.targetDelta, params.targetTime);
        break;
      case _rateControlMethodCancelPendingChangesName:
        _impl.cancelPendingChanges();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  RateControl get impl => _impl;
  set impl(RateControl d) {
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
    return "_RateControlStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _RateControlServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class RateControlStub
    extends bindings.Stub<RateControl>
    implements RateControl {
  RateControlStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [RateControl impl])
      : super(new _RateControlStubControl.fromEndpoint(endpoint, impl));

  RateControlStub.fromHandle(
      core.MojoHandle handle, [RateControl impl])
      : super(new _RateControlStubControl.fromHandle(handle, impl));

  RateControlStub.unbound([RateControl impl])
      : super(new _RateControlStubControl.unbound(impl));

  static RateControlStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For RateControlStub"));
    return new RateControlStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _RateControlStubControl.serviceDescription;


  dynamic getCurrentTransform([Function responseFactory = null]) {
    return impl.getCurrentTransform(responseFactory);
  }
  void setCurrentQuad(TimelineQuad quad) {
    return impl.setCurrentQuad(quad);
  }
  void setTargetTimelineId(int id) {
    return impl.setTargetTimelineId(id);
  }
  void setRate(int referenceDelta, int targetDelta) {
    return impl.setRate(referenceDelta, targetDelta);
  }
  void setRateAtReferenceTime(int referenceDelta, int targetDelta, int referenceTime) {
    return impl.setRateAtReferenceTime(referenceDelta, targetDelta, referenceTime);
  }
  void setRateAtTargetTime(int referenceDelta, int targetDelta, int targetTime) {
    return impl.setRateAtTargetTime(referenceDelta, targetDelta, targetTime);
  }
  void cancelPendingChanges() {
    return impl.cancelPendingChanges();
  }
}



