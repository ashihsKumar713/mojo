// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library timeline_controller_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/timelines.mojom.dart' as timelines_mojom;



class MediaTimelineControlSiteStatus extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  timelines_mojom.TimelineTransform timelineTransform = null;
  bool endOfStream = false;

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
          "timelineTransform of struct MediaTimelineControlSiteStatus: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(endOfStream, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "endOfStream of struct MediaTimelineControlSiteStatus: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaTimelineControlSiteStatus("
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


class _MediaTimelineControllerAddControlSiteParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  MediaTimelineControlSiteInterface controlSite = null;

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


class _MediaTimelineControllerGetControlSiteParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  MediaTimelineControlSiteInterfaceRequest controlSite = null;

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
  timelines_mojom.TimelineConsumerInterfaceRequest timelineConsumer = null;

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
const int _mediaTimelineControllerMethodGetControlSiteName = 1;

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
  void getControlSite(Object controlSite);
}

class _MediaTimelineControllerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<MediaTimelineController> {
  _MediaTimelineControllerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaTimelineControllerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _MediaTimelineControllerProxyControl.unbound() : super.unbound();

  String get serviceName => MediaTimelineController.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  MediaTimelineController get impl => null;
  set impl(MediaTimelineController _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_MediaTimelineControllerProxyControl($superString)";
  }
}

class MediaTimelineControllerProxy
    extends bindings.Proxy<MediaTimelineController>
    implements MediaTimelineController,
               MediaTimelineControllerInterface,
               MediaTimelineControllerInterfaceRequest {
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


  void addControlSite(MediaTimelineControlSiteInterface controlSite) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaTimelineControllerAddControlSiteParams();
    params.controlSite = controlSite;
    ctrl.sendMessage(params,
        _mediaTimelineControllerMethodAddControlSiteName);
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

class _MediaTimelineControllerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<MediaTimelineController> {
  MediaTimelineController _impl;

  _MediaTimelineControllerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaTimelineController impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _MediaTimelineControllerStubControl.fromHandle(
      core.MojoHandle handle, [MediaTimelineController impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _MediaTimelineControllerStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => MediaTimelineController.serviceName;



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

  @override
  String toString() {
    var superString = super.toString();
    return "_MediaTimelineControllerStubControl($superString)";
  }

  int get version => 0;
}

class MediaTimelineControllerStub
    extends bindings.Stub<MediaTimelineController>
    implements MediaTimelineController,
               MediaTimelineControllerInterface,
               MediaTimelineControllerInterfaceRequest {
  MediaTimelineControllerStub.unbound([MediaTimelineController impl])
      : super(new _MediaTimelineControllerStubControl.unbound(impl));

  MediaTimelineControllerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaTimelineController impl])
      : super(new _MediaTimelineControllerStubControl.fromEndpoint(endpoint, impl));

  MediaTimelineControllerStub.fromHandle(
      core.MojoHandle handle, [MediaTimelineController impl])
      : super(new _MediaTimelineControllerStubControl.fromHandle(handle, impl));

  static MediaTimelineControllerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaTimelineControllerStub"));
    return new MediaTimelineControllerStub.fromEndpoint(endpoint);
  }


  void addControlSite(MediaTimelineControlSiteInterface controlSite) {
    return impl.addControlSite(controlSite);
  }
  void getControlSite(Object controlSite) {
    return impl.getControlSite(controlSite);
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

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _MediaTimelineControlSiteServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static MediaTimelineControlSiteProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaTimelineControlSiteProxy p = new MediaTimelineControlSiteProxy.unbound();
    String name = serviceName ?? MediaTimelineControlSite.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]);
  void getTimelineConsumer(timelines_mojom.TimelineConsumerInterfaceRequest timelineConsumer);
  static const int kInitialStatus = 0;
}

abstract class MediaTimelineControlSiteInterface
    implements bindings.MojoInterface<MediaTimelineControlSite>,
               MediaTimelineControlSite {
  factory MediaTimelineControlSiteInterface([MediaTimelineControlSite impl]) =>
      new MediaTimelineControlSiteStub.unbound(impl);
  factory MediaTimelineControlSiteInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [MediaTimelineControlSite impl]) =>
      new MediaTimelineControlSiteStub.fromEndpoint(endpoint, impl);
}

abstract class MediaTimelineControlSiteInterfaceRequest
    implements bindings.MojoInterface<MediaTimelineControlSite>,
               MediaTimelineControlSite {
  factory MediaTimelineControlSiteInterfaceRequest() =>
      new MediaTimelineControlSiteProxy.unbound();
}

class _MediaTimelineControlSiteProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<MediaTimelineControlSite> {
  _MediaTimelineControlSiteProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaTimelineControlSiteProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _MediaTimelineControlSiteProxyControl.unbound() : super.unbound();

  String get serviceName => MediaTimelineControlSite.serviceName;

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

  MediaTimelineControlSite get impl => null;
  set impl(MediaTimelineControlSite _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_MediaTimelineControlSiteProxyControl($superString)";
  }
}

class MediaTimelineControlSiteProxy
    extends bindings.Proxy<MediaTimelineControlSite>
    implements MediaTimelineControlSite,
               MediaTimelineControlSiteInterface,
               MediaTimelineControlSiteInterfaceRequest {
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


  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]) {
    var params = new _MediaTimelineControlSiteGetStatusParams();
    params.versionLastSeen = versionLastSeen;
    return ctrl.sendMessageWithRequestId(
        params,
        _mediaTimelineControlSiteMethodGetStatusName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void getTimelineConsumer(timelines_mojom.TimelineConsumerInterfaceRequest timelineConsumer) {
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

class _MediaTimelineControlSiteStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<MediaTimelineControlSite> {
  MediaTimelineControlSite _impl;

  _MediaTimelineControlSiteStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaTimelineControlSite impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _MediaTimelineControlSiteStubControl.fromHandle(
      core.MojoHandle handle, [MediaTimelineControlSite impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _MediaTimelineControlSiteStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => MediaTimelineControlSite.serviceName;


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

  @override
  String toString() {
    var superString = super.toString();
    return "_MediaTimelineControlSiteStubControl($superString)";
  }

  int get version => 0;
}

class MediaTimelineControlSiteStub
    extends bindings.Stub<MediaTimelineControlSite>
    implements MediaTimelineControlSite,
               MediaTimelineControlSiteInterface,
               MediaTimelineControlSiteInterfaceRequest {
  MediaTimelineControlSiteStub.unbound([MediaTimelineControlSite impl])
      : super(new _MediaTimelineControlSiteStubControl.unbound(impl));

  MediaTimelineControlSiteStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaTimelineControlSite impl])
      : super(new _MediaTimelineControlSiteStubControl.fromEndpoint(endpoint, impl));

  MediaTimelineControlSiteStub.fromHandle(
      core.MojoHandle handle, [MediaTimelineControlSite impl])
      : super(new _MediaTimelineControlSiteStubControl.fromHandle(handle, impl));

  static MediaTimelineControlSiteStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaTimelineControlSiteStub"));
    return new MediaTimelineControlSiteStub.fromEndpoint(endpoint);
  }


  dynamic getStatus(int versionLastSeen,[Function responseFactory = null]) {
    return impl.getStatus(versionLastSeen,responseFactory);
  }
  void getTimelineConsumer(timelines_mojom.TimelineConsumerInterfaceRequest timelineConsumer) {
    return impl.getTimelineConsumer(timelineConsumer);
  }
}



