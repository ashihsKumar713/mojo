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


class _SceneSchedulerScheduleFrameParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SceneSchedulerScheduleFrameParams() : super(kVersions.last.size);

  static _SceneSchedulerScheduleFrameParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SceneSchedulerScheduleFrameParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SceneSchedulerScheduleFrameParams result = new _SceneSchedulerScheduleFrameParams();

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
    return "_SceneSchedulerScheduleFrameParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class SceneSchedulerScheduleFrameResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  FrameInfo frameInfo = null;

  SceneSchedulerScheduleFrameResponseParams() : super(kVersions.last.size);

  static SceneSchedulerScheduleFrameResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SceneSchedulerScheduleFrameResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SceneSchedulerScheduleFrameResponseParams result = new SceneSchedulerScheduleFrameResponseParams();

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
          "frameInfo of struct SceneSchedulerScheduleFrameResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "SceneSchedulerScheduleFrameResponseParams("
           "frameInfo: $frameInfo" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["frameInfo"] = frameInfo;
    return map;
  }
}

const int _sceneSchedulerMethodScheduleFrameName = 0;

class _SceneSchedulerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class SceneScheduler {
  static const String serviceName = null;
  dynamic scheduleFrame([Function responseFactory = null]);
}

class _SceneSchedulerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _SceneSchedulerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SceneSchedulerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _SceneSchedulerProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _SceneSchedulerServiceDescription();

  String get serviceName => SceneScheduler.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _sceneSchedulerMethodScheduleFrameName:
        var r = SceneSchedulerScheduleFrameResponseParams.deserialize(
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
    return "_SceneSchedulerProxyControl($superString)";
  }
}

class SceneSchedulerProxy
    extends bindings.Proxy
    implements SceneScheduler {
  SceneSchedulerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _SceneSchedulerProxyControl.fromEndpoint(endpoint));

  SceneSchedulerProxy.fromHandle(core.MojoHandle handle)
      : super(new _SceneSchedulerProxyControl.fromHandle(handle));

  SceneSchedulerProxy.unbound()
      : super(new _SceneSchedulerProxyControl.unbound());

  static SceneSchedulerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SceneSchedulerProxy"));
    return new SceneSchedulerProxy.fromEndpoint(endpoint);
  }

  factory SceneSchedulerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SceneSchedulerProxy p = new SceneSchedulerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic scheduleFrame([Function responseFactory = null]) {
    var params = new _SceneSchedulerScheduleFrameParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _sceneSchedulerMethodScheduleFrameName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _SceneSchedulerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<SceneScheduler> {
  SceneScheduler _impl;

  _SceneSchedulerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [SceneScheduler impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _SceneSchedulerStubControl.fromHandle(
      core.MojoHandle handle, [SceneScheduler impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _SceneSchedulerStubControl.unbound([this._impl]) : super.unbound();


  SceneSchedulerScheduleFrameResponseParams _sceneSchedulerScheduleFrameResponseParamsFactory(FrameInfo frameInfo) {
    var result = new SceneSchedulerScheduleFrameResponseParams();
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
      case _sceneSchedulerMethodScheduleFrameName:
        var response = _impl.scheduleFrame(_sceneSchedulerScheduleFrameResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _sceneSchedulerMethodScheduleFrameName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _sceneSchedulerMethodScheduleFrameName,
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

  SceneScheduler get impl => _impl;
  set impl(SceneScheduler d) {
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
    return "_SceneSchedulerStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SceneSchedulerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class SceneSchedulerStub
    extends bindings.Stub<SceneScheduler>
    implements SceneScheduler {
  SceneSchedulerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [SceneScheduler impl])
      : super(new _SceneSchedulerStubControl.fromEndpoint(endpoint, impl));

  SceneSchedulerStub.fromHandle(
      core.MojoHandle handle, [SceneScheduler impl])
      : super(new _SceneSchedulerStubControl.fromHandle(handle, impl));

  SceneSchedulerStub.unbound([SceneScheduler impl])
      : super(new _SceneSchedulerStubControl.unbound(impl));

  static SceneSchedulerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SceneSchedulerStub"));
    return new SceneSchedulerStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _SceneSchedulerStubControl.serviceDescription;


  dynamic scheduleFrame([Function responseFactory = null]) {
    return impl.scheduleFrame(responseFactory);
  }
}



