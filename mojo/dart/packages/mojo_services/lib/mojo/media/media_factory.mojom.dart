// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_factory_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/media/media_demux.mojom.dart' as media_demux_mojom;
import 'package:mojo_services/mojo/media/media_player.mojom.dart' as media_player_mojom;
import 'package:mojo_services/mojo/media/media_sink.mojom.dart' as media_sink_mojom;
import 'package:mojo_services/mojo/media/media_source.mojom.dart' as media_source_mojom;
import 'package:mojo_services/mojo/media/media_type_converter.mojom.dart' as media_type_converter_mojom;
import 'package:mojo_services/mojo/media/media_types.mojom.dart' as media_types_mojom;
import 'package:mojo_services/mojo/media/seeking_reader.mojom.dart' as seeking_reader_mojom;
import 'package:mojo_services/mojo/media/timeline_controller.mojom.dart' as timeline_controller_mojom;



class _MediaFactoryCreatePlayerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  seeking_reader_mojom.SeekingReaderInterface reader = null;
  media_player_mojom.MediaPlayerInterfaceRequest player = null;

  _MediaFactoryCreatePlayerParams() : super(kVersions.last.size);

  static _MediaFactoryCreatePlayerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaFactoryCreatePlayerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaFactoryCreatePlayerParams result = new _MediaFactoryCreatePlayerParams();

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
      
      result.reader = decoder0.decodeServiceInterface(8, false, seeking_reader_mojom.SeekingReaderProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.player = decoder0.decodeInterfaceRequest(16, false, media_player_mojom.MediaPlayerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(reader, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "reader of struct _MediaFactoryCreatePlayerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(player, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "player of struct _MediaFactoryCreatePlayerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaFactoryCreatePlayerParams("
           "reader: $reader" ", "
           "player: $player" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaFactoryCreateSourceParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  seeking_reader_mojom.SeekingReaderInterface reader = null;
  List<media_types_mojom.MediaTypeSet> allowedMediaTypes = null;
  media_source_mojom.MediaSourceInterfaceRequest source = null;

  _MediaFactoryCreateSourceParams() : super(kVersions.last.size);

  static _MediaFactoryCreateSourceParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaFactoryCreateSourceParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaFactoryCreateSourceParams result = new _MediaFactoryCreateSourceParams();

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
      
      result.reader = decoder0.decodeServiceInterface(8, false, seeking_reader_mojom.SeekingReaderProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.allowedMediaTypes = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.allowedMediaTypes = new List<media_types_mojom.MediaTypeSet>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.allowedMediaTypes[i1] = media_types_mojom.MediaTypeSet.decode(decoder2);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.source = decoder0.decodeInterfaceRequest(24, false, media_source_mojom.MediaSourceStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(reader, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "reader of struct _MediaFactoryCreateSourceParams: $e";
      rethrow;
    }
    try {
      if (allowedMediaTypes == null) {
        encoder0.encodeNullPointer(16, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(allowedMediaTypes.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < allowedMediaTypes.length; ++i0) {
          encoder1.encodeStruct(allowedMediaTypes[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "allowedMediaTypes of struct _MediaFactoryCreateSourceParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(source, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "source of struct _MediaFactoryCreateSourceParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaFactoryCreateSourceParams("
           "reader: $reader" ", "
           "allowedMediaTypes: $allowedMediaTypes" ", "
           "source: $source" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaFactoryCreateSinkParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  String destinationUrl = null;
  media_types_mojom.MediaType mediaType = null;
  media_sink_mojom.MediaSinkInterfaceRequest sink = null;

  _MediaFactoryCreateSinkParams() : super(kVersions.last.size);

  static _MediaFactoryCreateSinkParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaFactoryCreateSinkParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaFactoryCreateSinkParams result = new _MediaFactoryCreateSinkParams();

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
      
      result.destinationUrl = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.mediaType = media_types_mojom.MediaType.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.sink = decoder0.decodeInterfaceRequest(24, false, media_sink_mojom.MediaSinkStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(destinationUrl, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "destinationUrl of struct _MediaFactoryCreateSinkParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(mediaType, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "mediaType of struct _MediaFactoryCreateSinkParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(sink, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sink of struct _MediaFactoryCreateSinkParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaFactoryCreateSinkParams("
           "destinationUrl: $destinationUrl" ", "
           "mediaType: $mediaType" ", "
           "sink: $sink" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaFactoryCreateDemuxParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  seeking_reader_mojom.SeekingReaderInterface reader = null;
  media_demux_mojom.MediaDemuxInterfaceRequest demux = null;

  _MediaFactoryCreateDemuxParams() : super(kVersions.last.size);

  static _MediaFactoryCreateDemuxParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaFactoryCreateDemuxParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaFactoryCreateDemuxParams result = new _MediaFactoryCreateDemuxParams();

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
      
      result.reader = decoder0.decodeServiceInterface(8, false, seeking_reader_mojom.SeekingReaderProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.demux = decoder0.decodeInterfaceRequest(16, false, media_demux_mojom.MediaDemuxStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(reader, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "reader of struct _MediaFactoryCreateDemuxParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(demux, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "demux of struct _MediaFactoryCreateDemuxParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaFactoryCreateDemuxParams("
           "reader: $reader" ", "
           "demux: $demux" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaFactoryCreateDecoderParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  media_types_mojom.MediaType inputMediaType = null;
  media_type_converter_mojom.MediaTypeConverterInterfaceRequest decoder = null;

  _MediaFactoryCreateDecoderParams() : super(kVersions.last.size);

  static _MediaFactoryCreateDecoderParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaFactoryCreateDecoderParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaFactoryCreateDecoderParams result = new _MediaFactoryCreateDecoderParams();

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
      result.inputMediaType = media_types_mojom.MediaType.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.decoder = decoder0.decodeInterfaceRequest(16, false, media_type_converter_mojom.MediaTypeConverterStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(inputMediaType, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "inputMediaType of struct _MediaFactoryCreateDecoderParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(decoder, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "decoder of struct _MediaFactoryCreateDecoderParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaFactoryCreateDecoderParams("
           "inputMediaType: $inputMediaType" ", "
           "decoder: $decoder" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaFactoryCreateNetworkReaderParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String url = null;
  seeking_reader_mojom.SeekingReaderInterfaceRequest reader = null;

  _MediaFactoryCreateNetworkReaderParams() : super(kVersions.last.size);

  static _MediaFactoryCreateNetworkReaderParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaFactoryCreateNetworkReaderParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaFactoryCreateNetworkReaderParams result = new _MediaFactoryCreateNetworkReaderParams();

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
      
      result.url = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.reader = decoder0.decodeInterfaceRequest(16, false, seeking_reader_mojom.SeekingReaderStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(url, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "url of struct _MediaFactoryCreateNetworkReaderParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(reader, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "reader of struct _MediaFactoryCreateNetworkReaderParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaFactoryCreateNetworkReaderParams("
           "url: $url" ", "
           "reader: $reader" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaFactoryCreateTimelineControllerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  timeline_controller_mojom.MediaTimelineControllerInterfaceRequest timelineController = null;

  _MediaFactoryCreateTimelineControllerParams() : super(kVersions.last.size);

  static _MediaFactoryCreateTimelineControllerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaFactoryCreateTimelineControllerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaFactoryCreateTimelineControllerParams result = new _MediaFactoryCreateTimelineControllerParams();

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
      
      result.timelineController = decoder0.decodeInterfaceRequest(8, false, timeline_controller_mojom.MediaTimelineControllerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(timelineController, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "timelineController of struct _MediaFactoryCreateTimelineControllerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaFactoryCreateTimelineControllerParams("
           "timelineController: $timelineController" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _mediaFactoryMethodCreatePlayerName = 0;
const int _mediaFactoryMethodCreateSourceName = 1;
const int _mediaFactoryMethodCreateSinkName = 2;
const int _mediaFactoryMethodCreateDemuxName = 3;
const int _mediaFactoryMethodCreateDecoderName = 4;
const int _mediaFactoryMethodCreateNetworkReaderName = 5;
const int _mediaFactoryMethodCreateTimelineControllerName = 6;

class _MediaFactoryServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class MediaFactory {
  static const String serviceName = "mojo::media::MediaFactory";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _MediaFactoryServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static MediaFactoryProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaFactoryProxy p = new MediaFactoryProxy.unbound();
    String name = serviceName ?? MediaFactory.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void createPlayer(seeking_reader_mojom.SeekingReaderInterface reader, media_player_mojom.MediaPlayerInterfaceRequest player);
  void createSource(seeking_reader_mojom.SeekingReaderInterface reader, List<media_types_mojom.MediaTypeSet> allowedMediaTypes, media_source_mojom.MediaSourceInterfaceRequest source);
  void createSink(String destinationUrl, media_types_mojom.MediaType mediaType, media_sink_mojom.MediaSinkInterfaceRequest sink);
  void createDemux(seeking_reader_mojom.SeekingReaderInterface reader, media_demux_mojom.MediaDemuxInterfaceRequest demux);
  void createDecoder(media_types_mojom.MediaType inputMediaType, media_type_converter_mojom.MediaTypeConverterInterfaceRequest decoder);
  void createNetworkReader(String url, seeking_reader_mojom.SeekingReaderInterfaceRequest reader);
  void createTimelineController(timeline_controller_mojom.MediaTimelineControllerInterfaceRequest timelineController);
}

abstract class MediaFactoryInterface
    implements bindings.MojoInterface<MediaFactory>,
               MediaFactory {
  factory MediaFactoryInterface([MediaFactory impl]) =>
      new MediaFactoryStub.unbound(impl);

  factory MediaFactoryInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [MediaFactory impl]) =>
      new MediaFactoryStub.fromEndpoint(endpoint, impl);

  factory MediaFactoryInterface.fromMock(
      MediaFactory mock) =>
      new MediaFactoryProxy.fromMock(mock);
}

abstract class MediaFactoryInterfaceRequest
    implements bindings.MojoInterface<MediaFactory>,
               MediaFactory {
  factory MediaFactoryInterfaceRequest() =>
      new MediaFactoryProxy.unbound();
}

class _MediaFactoryProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<MediaFactory> {
  MediaFactory impl;

  _MediaFactoryProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaFactoryProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _MediaFactoryProxyControl.unbound() : super.unbound();

  String get serviceName => MediaFactory.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_MediaFactoryProxyControl($superString)";
  }
}

class MediaFactoryProxy
    extends bindings.Proxy<MediaFactory>
    implements MediaFactory,
               MediaFactoryInterface,
               MediaFactoryInterfaceRequest {
  MediaFactoryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _MediaFactoryProxyControl.fromEndpoint(endpoint));

  MediaFactoryProxy.fromHandle(core.MojoHandle handle)
      : super(new _MediaFactoryProxyControl.fromHandle(handle));

  MediaFactoryProxy.unbound()
      : super(new _MediaFactoryProxyControl.unbound());

  factory MediaFactoryProxy.fromMock(MediaFactory mock) {
    MediaFactoryProxy newMockedProxy =
        new MediaFactoryProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static MediaFactoryProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaFactoryProxy"));
    return new MediaFactoryProxy.fromEndpoint(endpoint);
  }


  void createPlayer(seeking_reader_mojom.SeekingReaderInterface reader, media_player_mojom.MediaPlayerInterfaceRequest player) {
    if (impl != null) {
      impl.createPlayer(reader, player);
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaFactoryCreatePlayerParams();
    params.reader = reader;
    params.player = player;
    ctrl.sendMessage(params,
        _mediaFactoryMethodCreatePlayerName);
  }
  void createSource(seeking_reader_mojom.SeekingReaderInterface reader, List<media_types_mojom.MediaTypeSet> allowedMediaTypes, media_source_mojom.MediaSourceInterfaceRequest source) {
    if (impl != null) {
      impl.createSource(reader, allowedMediaTypes, source);
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaFactoryCreateSourceParams();
    params.reader = reader;
    params.allowedMediaTypes = allowedMediaTypes;
    params.source = source;
    ctrl.sendMessage(params,
        _mediaFactoryMethodCreateSourceName);
  }
  void createSink(String destinationUrl, media_types_mojom.MediaType mediaType, media_sink_mojom.MediaSinkInterfaceRequest sink) {
    if (impl != null) {
      impl.createSink(destinationUrl, mediaType, sink);
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaFactoryCreateSinkParams();
    params.destinationUrl = destinationUrl;
    params.mediaType = mediaType;
    params.sink = sink;
    ctrl.sendMessage(params,
        _mediaFactoryMethodCreateSinkName);
  }
  void createDemux(seeking_reader_mojom.SeekingReaderInterface reader, media_demux_mojom.MediaDemuxInterfaceRequest demux) {
    if (impl != null) {
      impl.createDemux(reader, demux);
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaFactoryCreateDemuxParams();
    params.reader = reader;
    params.demux = demux;
    ctrl.sendMessage(params,
        _mediaFactoryMethodCreateDemuxName);
  }
  void createDecoder(media_types_mojom.MediaType inputMediaType, media_type_converter_mojom.MediaTypeConverterInterfaceRequest decoder) {
    if (impl != null) {
      impl.createDecoder(inputMediaType, decoder);
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaFactoryCreateDecoderParams();
    params.inputMediaType = inputMediaType;
    params.decoder = decoder;
    ctrl.sendMessage(params,
        _mediaFactoryMethodCreateDecoderName);
  }
  void createNetworkReader(String url, seeking_reader_mojom.SeekingReaderInterfaceRequest reader) {
    if (impl != null) {
      impl.createNetworkReader(url, reader);
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaFactoryCreateNetworkReaderParams();
    params.url = url;
    params.reader = reader;
    ctrl.sendMessage(params,
        _mediaFactoryMethodCreateNetworkReaderName);
  }
  void createTimelineController(timeline_controller_mojom.MediaTimelineControllerInterfaceRequest timelineController) {
    if (impl != null) {
      impl.createTimelineController(timelineController);
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaFactoryCreateTimelineControllerParams();
    params.timelineController = timelineController;
    ctrl.sendMessage(params,
        _mediaFactoryMethodCreateTimelineControllerName);
  }
}

class _MediaFactoryStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<MediaFactory> {
  MediaFactory _impl;

  _MediaFactoryStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaFactory impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _MediaFactoryStubControl.fromHandle(
      core.MojoHandle handle, [MediaFactory impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _MediaFactoryStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => MediaFactory.serviceName;



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
      case _mediaFactoryMethodCreatePlayerName:
        var params = _MediaFactoryCreatePlayerParams.deserialize(
            message.payload);
        _impl.createPlayer(params.reader, params.player);
        break;
      case _mediaFactoryMethodCreateSourceName:
        var params = _MediaFactoryCreateSourceParams.deserialize(
            message.payload);
        _impl.createSource(params.reader, params.allowedMediaTypes, params.source);
        break;
      case _mediaFactoryMethodCreateSinkName:
        var params = _MediaFactoryCreateSinkParams.deserialize(
            message.payload);
        _impl.createSink(params.destinationUrl, params.mediaType, params.sink);
        break;
      case _mediaFactoryMethodCreateDemuxName:
        var params = _MediaFactoryCreateDemuxParams.deserialize(
            message.payload);
        _impl.createDemux(params.reader, params.demux);
        break;
      case _mediaFactoryMethodCreateDecoderName:
        var params = _MediaFactoryCreateDecoderParams.deserialize(
            message.payload);
        _impl.createDecoder(params.inputMediaType, params.decoder);
        break;
      case _mediaFactoryMethodCreateNetworkReaderName:
        var params = _MediaFactoryCreateNetworkReaderParams.deserialize(
            message.payload);
        _impl.createNetworkReader(params.url, params.reader);
        break;
      case _mediaFactoryMethodCreateTimelineControllerName:
        var params = _MediaFactoryCreateTimelineControllerParams.deserialize(
            message.payload);
        _impl.createTimelineController(params.timelineController);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  MediaFactory get impl => _impl;
  set impl(MediaFactory d) {
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
    return "_MediaFactoryStubControl($superString)";
  }

  int get version => 0;
}

class MediaFactoryStub
    extends bindings.Stub<MediaFactory>
    implements MediaFactory,
               MediaFactoryInterface,
               MediaFactoryInterfaceRequest {
  MediaFactoryStub.unbound([MediaFactory impl])
      : super(new _MediaFactoryStubControl.unbound(impl));

  MediaFactoryStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaFactory impl])
      : super(new _MediaFactoryStubControl.fromEndpoint(endpoint, impl));

  MediaFactoryStub.fromHandle(
      core.MojoHandle handle, [MediaFactory impl])
      : super(new _MediaFactoryStubControl.fromHandle(handle, impl));

  static MediaFactoryStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaFactoryStub"));
    return new MediaFactoryStub.fromEndpoint(endpoint);
  }


  void createPlayer(seeking_reader_mojom.SeekingReaderInterface reader, media_player_mojom.MediaPlayerInterfaceRequest player) {
    return impl.createPlayer(reader, player);
  }
  void createSource(seeking_reader_mojom.SeekingReaderInterface reader, List<media_types_mojom.MediaTypeSet> allowedMediaTypes, media_source_mojom.MediaSourceInterfaceRequest source) {
    return impl.createSource(reader, allowedMediaTypes, source);
  }
  void createSink(String destinationUrl, media_types_mojom.MediaType mediaType, media_sink_mojom.MediaSinkInterfaceRequest sink) {
    return impl.createSink(destinationUrl, mediaType, sink);
  }
  void createDemux(seeking_reader_mojom.SeekingReaderInterface reader, media_demux_mojom.MediaDemuxInterfaceRequest demux) {
    return impl.createDemux(reader, demux);
  }
  void createDecoder(media_types_mojom.MediaType inputMediaType, media_type_converter_mojom.MediaTypeConverterInterfaceRequest decoder) {
    return impl.createDecoder(inputMediaType, decoder);
  }
  void createNetworkReader(String url, seeking_reader_mojom.SeekingReaderInterfaceRequest reader) {
    return impl.createNetworkReader(url, reader);
  }
  void createTimelineController(timeline_controller_mojom.MediaTimelineControllerInterfaceRequest timelineController) {
    return impl.createTimelineController(timelineController);
  }
}



