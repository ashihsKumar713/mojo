// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library scheduling_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class FrameInfo extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  int frameTime = 0;
  int frameInterval = 0;
  int frameDeadline = 0;
  int presentationTime = 0;

  FrameInfo() : super(kVersions.last.size);

  static FrameInfo deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FrameInfo decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FrameInfo result = new FrameInfo();

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
      
      result.frameTime = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.frameInterval = decoder0.decodeUint64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.frameDeadline = decoder0.decodeInt64(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.presentationTime = decoder0.decodeInt64(32);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(frameTime, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "frameTime of struct FrameInfo: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(frameInterval, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "frameInterval of struct FrameInfo: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(frameDeadline, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "frameDeadline of struct FrameInfo: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt64(presentationTime, 32);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "presentationTime of struct FrameInfo: $e";
      rethrow;
    }
  }

  String toString() {
    return "FrameInfo("
           "frameTime: $frameTime" ", "
           "frameInterval: $frameInterval" ", "
           "frameDeadline: $frameDeadline" ", "
           "presentationTime: $presentationTime" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["frameTime"] = frameTime;
    map["frameInterval"] = frameInterval;
    map["frameDeadline"] = frameDeadline;
    map["presentationTime"] = presentationTime;
    return map;
  }
}


class _FrameSchedulerScheduleFrameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _FrameSchedulerScheduleFrameParams() : super(kVersions.last.size);

  static _FrameSchedulerScheduleFrameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FrameSchedulerScheduleFrameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FrameSchedulerScheduleFrameParams result = new _FrameSchedulerScheduleFrameParams();

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
    return "_FrameSchedulerScheduleFrameParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class FrameSchedulerScheduleFrameResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  FrameInfo frameInfo = null;

  FrameSchedulerScheduleFrameResponseParams() : super(kVersions.last.size);

  static FrameSchedulerScheduleFrameResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FrameSchedulerScheduleFrameResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FrameSchedulerScheduleFrameResponseParams result = new FrameSchedulerScheduleFrameResponseParams();

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
      result.frameInfo = FrameInfo.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(frameInfo, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "frameInfo of struct FrameSchedulerScheduleFrameResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FrameSchedulerScheduleFrameResponseParams("
           "frameInfo: $frameInfo" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["frameInfo"] = frameInfo;
    return map;
  }
}

const int _frameSchedulerMethodScheduleFrameName = 0;

class _FrameSchedulerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class FrameScheduler {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _FrameSchedulerServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static FrameSchedulerProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    FrameSchedulerProxy p = new FrameSchedulerProxy.unbound();
    String name = serviceName ?? FrameScheduler.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic scheduleFrame([Function responseFactory = null]);
}

abstract class FrameSchedulerInterface
    implements bindings.MojoInterface<FrameScheduler>,
               FrameScheduler {
  factory FrameSchedulerInterface([FrameScheduler impl]) =>
      new FrameSchedulerStub.unbound(impl);

  factory FrameSchedulerInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [FrameScheduler impl]) =>
      new FrameSchedulerStub.fromEndpoint(endpoint, impl);

  factory FrameSchedulerInterface.fromMock(
      FrameScheduler mock) =>
      new FrameSchedulerProxy.fromMock(mock);
}

abstract class FrameSchedulerInterfaceRequest
    implements bindings.MojoInterface<FrameScheduler>,
               FrameScheduler {
  factory FrameSchedulerInterfaceRequest() =>
      new FrameSchedulerProxy.unbound();
}

class _FrameSchedulerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<FrameScheduler> {
  FrameScheduler impl;

  _FrameSchedulerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _FrameSchedulerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _FrameSchedulerProxyControl.unbound() : super.unbound();

  String get serviceName => FrameScheduler.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _frameSchedulerMethodScheduleFrameName:
        var r = FrameSchedulerScheduleFrameResponseParams.deserialize(
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
    return "_FrameSchedulerProxyControl($superString)";
  }
}

class FrameSchedulerProxy
    extends bindings.Proxy<FrameScheduler>
    implements FrameScheduler,
               FrameSchedulerInterface,
               FrameSchedulerInterfaceRequest {
  FrameSchedulerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _FrameSchedulerProxyControl.fromEndpoint(endpoint));

  FrameSchedulerProxy.fromHandle(core.MojoHandle handle)
      : super(new _FrameSchedulerProxyControl.fromHandle(handle));

  FrameSchedulerProxy.unbound()
      : super(new _FrameSchedulerProxyControl.unbound());

  factory FrameSchedulerProxy.fromMock(FrameScheduler mock) {
    FrameSchedulerProxy newMockedProxy =
        new FrameSchedulerProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static FrameSchedulerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FrameSchedulerProxy"));
    return new FrameSchedulerProxy.fromEndpoint(endpoint);
  }


  dynamic scheduleFrame([Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.scheduleFrame(_FrameSchedulerStubControl._frameSchedulerScheduleFrameResponseParamsFactory));
    }
    var params = new _FrameSchedulerScheduleFrameParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _frameSchedulerMethodScheduleFrameName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _FrameSchedulerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<FrameScheduler> {
  FrameScheduler _impl;

  _FrameSchedulerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [FrameScheduler impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _FrameSchedulerStubControl.fromHandle(
      core.MojoHandle handle, [FrameScheduler impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _FrameSchedulerStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => FrameScheduler.serviceName;


  static FrameSchedulerScheduleFrameResponseParams _frameSchedulerScheduleFrameResponseParamsFactory(FrameInfo frameInfo) {
    var result = new FrameSchedulerScheduleFrameResponseParams();
    result.frameInfo = frameInfo;
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
      case _frameSchedulerMethodScheduleFrameName:
        var response = _impl.scheduleFrame(_frameSchedulerScheduleFrameResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _frameSchedulerMethodScheduleFrameName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _frameSchedulerMethodScheduleFrameName,
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

  FrameScheduler get impl => _impl;
  set impl(FrameScheduler d) {
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
    return "_FrameSchedulerStubControl($superString)";
  }

  int get version => 0;
}

class FrameSchedulerStub
    extends bindings.Stub<FrameScheduler>
    implements FrameScheduler,
               FrameSchedulerInterface,
               FrameSchedulerInterfaceRequest {
  FrameSchedulerStub.unbound([FrameScheduler impl])
      : super(new _FrameSchedulerStubControl.unbound(impl));

  FrameSchedulerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [FrameScheduler impl])
      : super(new _FrameSchedulerStubControl.fromEndpoint(endpoint, impl));

  FrameSchedulerStub.fromHandle(
      core.MojoHandle handle, [FrameScheduler impl])
      : super(new _FrameSchedulerStubControl.fromHandle(handle, impl));

  static FrameSchedulerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FrameSchedulerStub"));
    return new FrameSchedulerStub.fromEndpoint(endpoint);
  }


  dynamic scheduleFrame([Function responseFactory = null]) {
    return impl.scheduleFrame(responseFactory);
  }
}



