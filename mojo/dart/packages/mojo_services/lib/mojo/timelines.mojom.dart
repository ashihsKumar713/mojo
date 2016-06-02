// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library timelines_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
const int kUnspecifiedTime = 9223372036854775807;



class TimelineTransform extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int referenceTime = 0;
  int subjectTime = 0;
  int referenceDelta = 1;
  int subjectDelta = 0;

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
      
      result.referenceTime = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.subjectTime = decoder0.decodeInt64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.referenceDelta = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.subjectDelta = decoder0.decodeUint32(28);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(referenceTime, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "referenceTime of struct TimelineTransform: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(subjectTime, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "subjectTime of struct TimelineTransform: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(referenceDelta, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "referenceDelta of struct TimelineTransform: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(subjectDelta, 28);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "subjectDelta of struct TimelineTransform: $e";
      rethrow;
    }
  }

  String toString() {
    return "TimelineTransform("
           "referenceTime: $referenceTime" ", "
           "subjectTime: $subjectTime" ", "
           "referenceDelta: $referenceDelta" ", "
           "subjectDelta: $subjectDelta" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["referenceTime"] = referenceTime;
    map["subjectTime"] = subjectTime;
    map["referenceDelta"] = referenceDelta;
    map["subjectDelta"] = subjectDelta;
    return map;
  }
}


class _TimelineConsumerSetTimelineTransformParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  int subjectTime = 0;
  int referenceDelta = 0;
  int subjectDelta = 0;
  int effectiveReferenceTime = 0;
  int effectiveSubjectTime = 0;

  _TimelineConsumerSetTimelineTransformParams() : super(kVersions.last.size);

  static _TimelineConsumerSetTimelineTransformParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TimelineConsumerSetTimelineTransformParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TimelineConsumerSetTimelineTransformParams result = new _TimelineConsumerSetTimelineTransformParams();

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
      
      result.referenceDelta = decoder0.decodeUint32(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.subjectDelta = decoder0.decodeUint32(20);
    }
    if (mainDataHeader.version >= 0) {
      
      result.effectiveReferenceTime = decoder0.decodeInt64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.effectiveSubjectTime = decoder0.decodeInt64(32);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(subjectTime, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "subjectTime of struct _TimelineConsumerSetTimelineTransformParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(referenceDelta, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "referenceDelta of struct _TimelineConsumerSetTimelineTransformParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(subjectDelta, 20);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "subjectDelta of struct _TimelineConsumerSetTimelineTransformParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(effectiveReferenceTime, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "effectiveReferenceTime of struct _TimelineConsumerSetTimelineTransformParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(effectiveSubjectTime, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "effectiveSubjectTime of struct _TimelineConsumerSetTimelineTransformParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TimelineConsumerSetTimelineTransformParams("
           "subjectTime: $subjectTime" ", "
           "referenceDelta: $referenceDelta" ", "
           "subjectDelta: $subjectDelta" ", "
           "effectiveReferenceTime: $effectiveReferenceTime" ", "
           "effectiveSubjectTime: $effectiveSubjectTime" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["subjectTime"] = subjectTime;
    map["referenceDelta"] = referenceDelta;
    map["subjectDelta"] = subjectDelta;
    map["effectiveReferenceTime"] = effectiveReferenceTime;
    map["effectiveSubjectTime"] = effectiveSubjectTime;
    return map;
  }
}


class TimelineConsumerSetTimelineTransformResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool completed = false;

  TimelineConsumerSetTimelineTransformResponseParams() : super(kVersions.last.size);

  static TimelineConsumerSetTimelineTransformResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TimelineConsumerSetTimelineTransformResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TimelineConsumerSetTimelineTransformResponseParams result = new TimelineConsumerSetTimelineTransformResponseParams();

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
          "completed of struct TimelineConsumerSetTimelineTransformResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "TimelineConsumerSetTimelineTransformResponseParams("
           "completed: $completed" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["completed"] = completed;
    return map;
  }
}

const int _timelineConsumerMethodSetTimelineTransformName = 0;

class _TimelineConsumerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class TimelineConsumer {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _TimelineConsumerServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static TimelineConsumerProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TimelineConsumerProxy p = new TimelineConsumerProxy.unbound();
    String name = serviceName ?? TimelineConsumer.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic setTimelineTransform(int subjectTime,int referenceDelta,int subjectDelta,int effectiveReferenceTime,int effectiveSubjectTime,[Function responseFactory = null]);
}

abstract class TimelineConsumerInterface
    implements bindings.MojoInterface<TimelineConsumer>,
               TimelineConsumer {
  factory TimelineConsumerInterface([TimelineConsumer impl]) =>
      new TimelineConsumerStub.unbound(impl);

  factory TimelineConsumerInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [TimelineConsumer impl]) =>
      new TimelineConsumerStub.fromEndpoint(endpoint, impl);

  factory TimelineConsumerInterface.fromMock(
      TimelineConsumer mock) =>
      new TimelineConsumerProxy.fromMock(mock);
}

abstract class TimelineConsumerInterfaceRequest
    implements bindings.MojoInterface<TimelineConsumer>,
               TimelineConsumer {
  factory TimelineConsumerInterfaceRequest() =>
      new TimelineConsumerProxy.unbound();
}

class _TimelineConsumerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<TimelineConsumer> {
  TimelineConsumer impl;

  _TimelineConsumerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TimelineConsumerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _TimelineConsumerProxyControl.unbound() : super.unbound();

  String get serviceName => TimelineConsumer.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _timelineConsumerMethodSetTimelineTransformName:
        var r = TimelineConsumerSetTimelineTransformResponseParams.deserialize(
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
    return "_TimelineConsumerProxyControl($superString)";
  }
}

class TimelineConsumerProxy
    extends bindings.Proxy<TimelineConsumer>
    implements TimelineConsumer,
               TimelineConsumerInterface,
               TimelineConsumerInterfaceRequest {
  TimelineConsumerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _TimelineConsumerProxyControl.fromEndpoint(endpoint));

  TimelineConsumerProxy.fromHandle(core.MojoHandle handle)
      : super(new _TimelineConsumerProxyControl.fromHandle(handle));

  TimelineConsumerProxy.unbound()
      : super(new _TimelineConsumerProxyControl.unbound());

  factory TimelineConsumerProxy.fromMock(TimelineConsumer mock) {
    TimelineConsumerProxy newMockedProxy =
        new TimelineConsumerProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static TimelineConsumerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TimelineConsumerProxy"));
    return new TimelineConsumerProxy.fromEndpoint(endpoint);
  }


  dynamic setTimelineTransform(int subjectTime,int referenceDelta,int subjectDelta,int effectiveReferenceTime,int effectiveSubjectTime,[Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.setTimelineTransform(subjectTime,referenceDelta,subjectDelta,effectiveReferenceTime,effectiveSubjectTime,_TimelineConsumerStubControl._timelineConsumerSetTimelineTransformResponseParamsFactory));
    }
    var params = new _TimelineConsumerSetTimelineTransformParams();
    params.subjectTime = subjectTime;
    params.referenceDelta = referenceDelta;
    params.subjectDelta = subjectDelta;
    params.effectiveReferenceTime = effectiveReferenceTime;
    params.effectiveSubjectTime = effectiveSubjectTime;
    return ctrl.sendMessageWithRequestId(
        params,
        _timelineConsumerMethodSetTimelineTransformName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _TimelineConsumerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<TimelineConsumer> {
  TimelineConsumer _impl;

  _TimelineConsumerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [TimelineConsumer impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _TimelineConsumerStubControl.fromHandle(
      core.MojoHandle handle, [TimelineConsumer impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _TimelineConsumerStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => TimelineConsumer.serviceName;


  static TimelineConsumerSetTimelineTransformResponseParams _timelineConsumerSetTimelineTransformResponseParamsFactory(bool completed) {
    var result = new TimelineConsumerSetTimelineTransformResponseParams();
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
      case _timelineConsumerMethodSetTimelineTransformName:
        var params = _TimelineConsumerSetTimelineTransformParams.deserialize(
            message.payload);
        var response = _impl.setTimelineTransform(params.subjectTime,params.referenceDelta,params.subjectDelta,params.effectiveReferenceTime,params.effectiveSubjectTime,_timelineConsumerSetTimelineTransformResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _timelineConsumerMethodSetTimelineTransformName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _timelineConsumerMethodSetTimelineTransformName,
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

  TimelineConsumer get impl => _impl;
  set impl(TimelineConsumer d) {
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
    return "_TimelineConsumerStubControl($superString)";
  }

  int get version => 0;
}

class TimelineConsumerStub
    extends bindings.Stub<TimelineConsumer>
    implements TimelineConsumer,
               TimelineConsumerInterface,
               TimelineConsumerInterfaceRequest {
  TimelineConsumerStub.unbound([TimelineConsumer impl])
      : super(new _TimelineConsumerStubControl.unbound(impl));

  TimelineConsumerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [TimelineConsumer impl])
      : super(new _TimelineConsumerStubControl.fromEndpoint(endpoint, impl));

  TimelineConsumerStub.fromHandle(
      core.MojoHandle handle, [TimelineConsumer impl])
      : super(new _TimelineConsumerStubControl.fromHandle(handle, impl));

  static TimelineConsumerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TimelineConsumerStub"));
    return new TimelineConsumerStub.fromEndpoint(endpoint);
  }


  dynamic setTimelineTransform(int subjectTime,int referenceDelta,int subjectDelta,int effectiveReferenceTime,int effectiveSubjectTime,[Function responseFactory = null]) {
    return impl.setTimelineTransform(subjectTime,referenceDelta,subjectDelta,effectiveReferenceTime,effectiveSubjectTime,responseFactory);
  }
}



