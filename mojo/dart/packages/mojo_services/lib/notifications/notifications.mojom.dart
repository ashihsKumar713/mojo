// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library notifications_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class NotificationData extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  String title = null;
  String text = null;
  bool playSound = false;
  bool vibrate = false;
  bool setLights = false;

  NotificationData() : super(kVersions.last.size);

  static NotificationData deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NotificationData decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NotificationData result = new NotificationData();

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
      
      result.title = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.text = decoder0.decodeString(16, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.playSound = decoder0.decodeBool(24, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.vibrate = decoder0.decodeBool(24, 1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.setLights = decoder0.decodeBool(24, 2);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(title, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "title of struct NotificationData: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(text, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "text of struct NotificationData: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(playSound, 24, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "playSound of struct NotificationData: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(vibrate, 24, 1);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "vibrate of struct NotificationData: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(setLights, 24, 2);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "setLights of struct NotificationData: $e";
      rethrow;
    }
  }

  String toString() {
    return "NotificationData("
           "title: $title" ", "
           "text: $text" ", "
           "playSound: $playSound" ", "
           "vibrate: $vibrate" ", "
           "setLights: $setLights" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["title"] = title;
    map["text"] = text;
    map["playSound"] = playSound;
    map["vibrate"] = vibrate;
    map["setLights"] = setLights;
    return map;
  }
}


class _NotificationClientOnSelectedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _NotificationClientOnSelectedParams() : super(kVersions.last.size);

  static _NotificationClientOnSelectedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NotificationClientOnSelectedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NotificationClientOnSelectedParams result = new _NotificationClientOnSelectedParams();

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
    return "_NotificationClientOnSelectedParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _NotificationClientOnDismissedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _NotificationClientOnDismissedParams() : super(kVersions.last.size);

  static _NotificationClientOnDismissedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NotificationClientOnDismissedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NotificationClientOnDismissedParams result = new _NotificationClientOnDismissedParams();

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
    return "_NotificationClientOnDismissedParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _NotificationUpdateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  NotificationData notificationData = null;

  _NotificationUpdateParams() : super(kVersions.last.size);

  static _NotificationUpdateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NotificationUpdateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NotificationUpdateParams result = new _NotificationUpdateParams();

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
      result.notificationData = NotificationData.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(notificationData, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "notificationData of struct _NotificationUpdateParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NotificationUpdateParams("
           "notificationData: $notificationData" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["notificationData"] = notificationData;
    return map;
  }
}


class _NotificationCancelParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _NotificationCancelParams() : super(kVersions.last.size);

  static _NotificationCancelParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NotificationCancelParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NotificationCancelParams result = new _NotificationCancelParams();

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
    return "_NotificationCancelParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _NotificationServicePostParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  NotificationData notificationData = null;
  Object client = null;
  Object notification = null;

  _NotificationServicePostParams() : super(kVersions.last.size);

  static _NotificationServicePostParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NotificationServicePostParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NotificationServicePostParams result = new _NotificationServicePostParams();

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
      result.notificationData = NotificationData.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.client = decoder0.decodeServiceInterface(16, true, NotificationClientProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.notification = decoder0.decodeInterfaceRequest(24, true, NotificationStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(notificationData, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "notificationData of struct _NotificationServicePostParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(client, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "client of struct _NotificationServicePostParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(notification, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "notification of struct _NotificationServicePostParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NotificationServicePostParams("
           "notificationData: $notificationData" ", "
           "client: $client" ", "
           "notification: $notification" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _notificationClientMethodOnSelectedName = 0;
const int _notificationClientMethodOnDismissedName = 1;

class _NotificationClientServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class NotificationClient {
  static const String serviceName = null;
  void onSelected();
  void onDismissed();
}

class _NotificationClientProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _NotificationClientProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NotificationClientProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _NotificationClientProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _NotificationClientServiceDescription();

  String get serviceName => NotificationClient.serviceName;

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
    return "_NotificationClientProxyControl($superString)";
  }
}

class NotificationClientProxy
    extends bindings.Proxy
    implements NotificationClient {
  NotificationClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _NotificationClientProxyControl.fromEndpoint(endpoint));

  NotificationClientProxy.fromHandle(core.MojoHandle handle)
      : super(new _NotificationClientProxyControl.fromHandle(handle));

  NotificationClientProxy.unbound()
      : super(new _NotificationClientProxyControl.unbound());

  static NotificationClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NotificationClientProxy"));
    return new NotificationClientProxy.fromEndpoint(endpoint);
  }

  factory NotificationClientProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NotificationClientProxy p = new NotificationClientProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void onSelected() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _NotificationClientOnSelectedParams();
    ctrl.sendMessage(params,
        _notificationClientMethodOnSelectedName);
  }
  void onDismissed() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _NotificationClientOnDismissedParams();
    ctrl.sendMessage(params,
        _notificationClientMethodOnDismissedName);
  }
}

class _NotificationClientStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<NotificationClient> {
  NotificationClient _impl;

  _NotificationClientStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [NotificationClient impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _NotificationClientStubControl.fromHandle(
      core.MojoHandle handle, [NotificationClient impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _NotificationClientStubControl.unbound([this._impl]) : super.unbound();



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
      case _notificationClientMethodOnSelectedName:
        _impl.onSelected();
        break;
      case _notificationClientMethodOnDismissedName:
        _impl.onDismissed();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  NotificationClient get impl => _impl;
  set impl(NotificationClient d) {
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
    return "_NotificationClientStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _NotificationClientServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class NotificationClientStub
    extends bindings.Stub<NotificationClient>
    implements NotificationClient {
  NotificationClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [NotificationClient impl])
      : super(new _NotificationClientStubControl.fromEndpoint(endpoint, impl));

  NotificationClientStub.fromHandle(
      core.MojoHandle handle, [NotificationClient impl])
      : super(new _NotificationClientStubControl.fromHandle(handle, impl));

  NotificationClientStub.unbound([NotificationClient impl])
      : super(new _NotificationClientStubControl.unbound(impl));

  static NotificationClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NotificationClientStub"));
    return new NotificationClientStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _NotificationClientStubControl.serviceDescription;


  void onSelected() {
    return impl.onSelected();
  }
  void onDismissed() {
    return impl.onDismissed();
  }
}

const int _notificationMethodUpdateName = 0;
const int _notificationMethodCancelName = 1;

class _NotificationServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Notification {
  static const String serviceName = null;
  void update(NotificationData notificationData);
  void cancel();
}

class _NotificationProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _NotificationProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NotificationProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _NotificationProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _NotificationServiceDescription();

  String get serviceName => Notification.serviceName;

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
    return "_NotificationProxyControl($superString)";
  }
}

class NotificationProxy
    extends bindings.Proxy
    implements Notification {
  NotificationProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _NotificationProxyControl.fromEndpoint(endpoint));

  NotificationProxy.fromHandle(core.MojoHandle handle)
      : super(new _NotificationProxyControl.fromHandle(handle));

  NotificationProxy.unbound()
      : super(new _NotificationProxyControl.unbound());

  static NotificationProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NotificationProxy"));
    return new NotificationProxy.fromEndpoint(endpoint);
  }

  factory NotificationProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NotificationProxy p = new NotificationProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void update(NotificationData notificationData) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _NotificationUpdateParams();
    params.notificationData = notificationData;
    ctrl.sendMessage(params,
        _notificationMethodUpdateName);
  }
  void cancel() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _NotificationCancelParams();
    ctrl.sendMessage(params,
        _notificationMethodCancelName);
  }
}

class _NotificationStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<Notification> {
  Notification _impl;

  _NotificationStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Notification impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _NotificationStubControl.fromHandle(
      core.MojoHandle handle, [Notification impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _NotificationStubControl.unbound([this._impl]) : super.unbound();



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
      case _notificationMethodUpdateName:
        var params = _NotificationUpdateParams.deserialize(
            message.payload);
        _impl.update(params.notificationData);
        break;
      case _notificationMethodCancelName:
        _impl.cancel();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  Notification get impl => _impl;
  set impl(Notification d) {
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
    return "_NotificationStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _NotificationServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class NotificationStub
    extends bindings.Stub<Notification>
    implements Notification {
  NotificationStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Notification impl])
      : super(new _NotificationStubControl.fromEndpoint(endpoint, impl));

  NotificationStub.fromHandle(
      core.MojoHandle handle, [Notification impl])
      : super(new _NotificationStubControl.fromHandle(handle, impl));

  NotificationStub.unbound([Notification impl])
      : super(new _NotificationStubControl.unbound(impl));

  static NotificationStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NotificationStub"));
    return new NotificationStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _NotificationStubControl.serviceDescription;


  void update(NotificationData notificationData) {
    return impl.update(notificationData);
  }
  void cancel() {
    return impl.cancel();
  }
}

const int _notificationServiceMethodPostName = 0;

class _NotificationServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class NotificationService {
  static const String serviceName = "notifications::NotificationService";
  void post(NotificationData notificationData, Object client, Object notification);
}

class _NotificationServiceProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _NotificationServiceProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NotificationServiceProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _NotificationServiceProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _NotificationServiceServiceDescription();

  String get serviceName => NotificationService.serviceName;

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
    return "_NotificationServiceProxyControl($superString)";
  }
}

class NotificationServiceProxy
    extends bindings.Proxy
    implements NotificationService {
  NotificationServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _NotificationServiceProxyControl.fromEndpoint(endpoint));

  NotificationServiceProxy.fromHandle(core.MojoHandle handle)
      : super(new _NotificationServiceProxyControl.fromHandle(handle));

  NotificationServiceProxy.unbound()
      : super(new _NotificationServiceProxyControl.unbound());

  static NotificationServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NotificationServiceProxy"));
    return new NotificationServiceProxy.fromEndpoint(endpoint);
  }

  factory NotificationServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NotificationServiceProxy p = new NotificationServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void post(NotificationData notificationData, Object client, Object notification) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _NotificationServicePostParams();
    params.notificationData = notificationData;
    params.client = client;
    params.notification = notification;
    ctrl.sendMessage(params,
        _notificationServiceMethodPostName);
  }
}

class _NotificationServiceStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<NotificationService> {
  NotificationService _impl;

  _NotificationServiceStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [NotificationService impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _NotificationServiceStubControl.fromHandle(
      core.MojoHandle handle, [NotificationService impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _NotificationServiceStubControl.unbound([this._impl]) : super.unbound();



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
      case _notificationServiceMethodPostName:
        var params = _NotificationServicePostParams.deserialize(
            message.payload);
        _impl.post(params.notificationData, params.client, params.notification);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  NotificationService get impl => _impl;
  set impl(NotificationService d) {
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
    return "_NotificationServiceStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _NotificationServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class NotificationServiceStub
    extends bindings.Stub<NotificationService>
    implements NotificationService {
  NotificationServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [NotificationService impl])
      : super(new _NotificationServiceStubControl.fromEndpoint(endpoint, impl));

  NotificationServiceStub.fromHandle(
      core.MojoHandle handle, [NotificationService impl])
      : super(new _NotificationServiceStubControl.fromHandle(handle, impl));

  NotificationServiceStub.unbound([NotificationService impl])
      : super(new _NotificationServiceStubControl.unbound(impl));

  static NotificationServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NotificationServiceStub"));
    return new NotificationServiceStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _NotificationServiceStubControl.serviceDescription;


  void post(NotificationData notificationData, Object client, Object notification) {
    return impl.post(notificationData, client, notification);
  }
}



