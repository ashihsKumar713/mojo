// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library media_sink_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/media/media_state.mojom.dart' as media_state_mojom;
import 'package:mojo_services/mojo/media/media_transport.mojom.dart' as media_transport_mojom;
import 'package:mojo_services/mojo/media/rate_control.mojom.dart' as rate_control_mojom;



class MediaSinkStatus extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  media_state_mojom.MediaState state = null;
  rate_control_mojom.TimelineTransform timelineTransform = null;

  MediaSinkStatus() : super(kVersions.last.size);

  static MediaSinkStatus deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSinkStatus decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSinkStatus result = new MediaSinkStatus();

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
      result.timelineTransform = rate_control_mojom.TimelineTransform.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(state, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "state of struct MediaSinkStatus: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(timelineTransform, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "timelineTransform of struct MediaSinkStatus: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaSinkStatus("
           "state: $state" ", "
           "timelineTransform: $timelineTransform" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["state"] = state;
    map["timelineTransform"] = timelineTransform;
    return map;
  }
}


class _MediaSinkGetConsumerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  media_transport_mojom.MediaConsumerInterfaceRequest consumer = null;

  _MediaSinkGetConsumerParams() : super(kVersions.last.size);

  static _MediaSinkGetConsumerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSinkGetConsumerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSinkGetConsumerParams result = new _MediaSinkGetConsumerParams();

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
      
      result.consumer = decoder0.decodeInterfaceRequest(8, false, media_transport_mojom.MediaConsumerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(consumer, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "consumer of struct _MediaSinkGetConsumerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaSinkGetConsumerParams("
           "consumer: $consumer" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _MediaSinkGetStatusParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int versionLastSeen = 0;

  _MediaSinkGetStatusParams() : super(kVersions.last.size);

  static _MediaSinkGetStatusParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSinkGetStatusParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSinkGetStatusParams result = new _MediaSinkGetStatusParams();

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
          "versionLastSeen of struct _MediaSinkGetStatusParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaSinkGetStatusParams("
           "versionLastSeen: $versionLastSeen" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["versionLastSeen"] = versionLastSeen;
    return map;
  }
}


class MediaSinkGetStatusResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int version = 0;
  MediaSinkStatus status = null;

  MediaSinkGetStatusResponseParams() : super(kVersions.last.size);

  static MediaSinkGetStatusResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaSinkGetStatusResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaSinkGetStatusResponseParams result = new MediaSinkGetStatusResponseParams();

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
      result.status = MediaSinkStatus.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(version, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "version of struct MediaSinkGetStatusResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(status, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "status of struct MediaSinkGetStatusResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaSinkGetStatusResponseParams("
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


class _MediaSinkPlayParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSinkPlayParams() : super(kVersions.last.size);

  static _MediaSinkPlayParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSinkPlayParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSinkPlayParams result = new _MediaSinkPlayParams();

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
    return "_MediaSinkPlayParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaSinkPauseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaSinkPauseParams() : super(kVersions.last.size);

  static _MediaSinkPauseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaSinkPauseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaSinkPauseParams result = new _MediaSinkPauseParams();

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
    return "_MediaSinkPauseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _mediaSinkMethodGetConsumerName = 0;
const int _mediaSinkMethodGetStatusName = 1;
const int _mediaSinkMethodPlayName = 2;
const int _mediaSinkMethodPauseName = 3;

class _MediaSinkServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class MediaSink {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _MediaSinkServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static MediaSinkProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaSinkProxy p = new MediaSinkProxy.unbound();
    String name = serviceName ?? MediaSink.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void getConsumer(media_transport_mojom.MediaConsumerInterfaceRequest consumer);
  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]);
  void play();
  void pause();
  static const int kInitialStatus = 0;
}

abstract class MediaSinkInterface
    implements bindings.MojoInterface<MediaSink>,
               MediaSink {
  factory MediaSinkInterface([MediaSink impl]) =>
      new MediaSinkStub.unbound(impl);
  factory MediaSinkInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [MediaSink impl]) =>
      new MediaSinkStub.fromEndpoint(endpoint, impl);
}

abstract class MediaSinkInterfaceRequest
    implements bindings.MojoInterface<MediaSink>,
               MediaSink {
  factory MediaSinkInterfaceRequest() =>
      new MediaSinkProxy.unbound();
}

class _MediaSinkProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<MediaSink> {
  _MediaSinkProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaSinkProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _MediaSinkProxyControl.unbound() : super.unbound();

  String get serviceName => MediaSink.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _mediaSinkMethodGetStatusName:
        var r = MediaSinkGetStatusResponseParams.deserialize(
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

  MediaSink get impl => null;
  set impl(MediaSink _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_MediaSinkProxyControl($superString)";
  }
}

class MediaSinkProxy
    extends bindings.Proxy<MediaSink>
    implements MediaSink,
               MediaSinkInterface,
               MediaSinkInterfaceRequest {
  MediaSinkProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _MediaSinkProxyControl.fromEndpoint(endpoint));

  MediaSinkProxy.fromHandle(core.MojoHandle handle)
      : super(new _MediaSinkProxyControl.fromHandle(handle));

  MediaSinkProxy.unbound()
      : super(new _MediaSinkProxyControl.unbound());

  static MediaSinkProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaSinkProxy"));
    return new MediaSinkProxy.fromEndpoint(endpoint);
  }


  void getConsumer(media_transport_mojom.MediaConsumerInterfaceRequest consumer) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaSinkGetConsumerParams();
    params.consumer = consumer;
    ctrl.sendMessage(params,
        _mediaSinkMethodGetConsumerName);
  }
  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]) {
    var params = new _MediaSinkGetStatusParams();
    params.versionLastSeen = versionLastSeen;
    return ctrl.sendMessageWithRequestId(
        params,
        _mediaSinkMethodGetStatusName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void play() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaSinkPlayParams();
    ctrl.sendMessage(params,
        _mediaSinkMethodPlayName);
  }
  void pause() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaSinkPauseParams();
    ctrl.sendMessage(params,
        _mediaSinkMethodPauseName);
  }
}

class _MediaSinkStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<MediaSink> {
  MediaSink _impl;

  _MediaSinkStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaSink impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _MediaSinkStubControl.fromHandle(
      core.MojoHandle handle, [MediaSink impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _MediaSinkStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => MediaSink.serviceName;


  MediaSinkGetStatusResponseParams _mediaSinkGetStatusResponseParamsFactory(int version, MediaSinkStatus status) {
    var result = new MediaSinkGetStatusResponseParams();
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
      case _mediaSinkMethodGetConsumerName:
        var params = _MediaSinkGetConsumerParams.deserialize(
            message.payload);
        _impl.getConsumer(params.consumer);
        break;
      case _mediaSinkMethodGetStatusName:
        var params = _MediaSinkGetStatusParams.deserialize(
            message.payload);
        var response = _impl.getStatus(params.versionLastSeen,_mediaSinkGetStatusResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _mediaSinkMethodGetStatusName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _mediaSinkMethodGetStatusName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _mediaSinkMethodPlayName:
        _impl.play();
        break;
      case _mediaSinkMethodPauseName:
        _impl.pause();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  MediaSink get impl => _impl;
  set impl(MediaSink d) {
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
    return "_MediaSinkStubControl($superString)";
  }

  int get version => 0;
}

class MediaSinkStub
    extends bindings.Stub<MediaSink>
    implements MediaSink,
               MediaSinkInterface,
               MediaSinkInterfaceRequest {
  MediaSinkStub.unbound([MediaSink impl])
      : super(new _MediaSinkStubControl.unbound(impl));

  MediaSinkStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaSink impl])
      : super(new _MediaSinkStubControl.fromEndpoint(endpoint, impl));

  MediaSinkStub.fromHandle(
      core.MojoHandle handle, [MediaSink impl])
      : super(new _MediaSinkStubControl.fromHandle(handle, impl));

  static MediaSinkStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaSinkStub"));
    return new MediaSinkStub.fromEndpoint(endpoint);
  }


  void getConsumer(media_transport_mojom.MediaConsumerInterfaceRequest consumer) {
    return impl.getConsumer(consumer);
  }
  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]) {
    return impl.getStatus(versionLastSeen,responseFactory);
  }
  void play() {
    return impl.play();
  }
  void pause() {
    return impl.pause();
  }
}



