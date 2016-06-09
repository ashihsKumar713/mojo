// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library echo_service_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _EchoServiceEchoStringParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  _EchoServiceEchoStringParams() : super(kVersions.last.size);

  static _EchoServiceEchoStringParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _EchoServiceEchoStringParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _EchoServiceEchoStringParams result = new _EchoServiceEchoStringParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(value, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct _EchoServiceEchoStringParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_EchoServiceEchoStringParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class EchoServiceEchoStringResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  EchoServiceEchoStringResponseParams() : super(kVersions.last.size);

  static EchoServiceEchoStringResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoServiceEchoStringResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoServiceEchoStringResponseParams result = new EchoServiceEchoStringResponseParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(value, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct EchoServiceEchoStringResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "EchoServiceEchoStringResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class _EchoServiceDelayedEchoStringParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String value = null;
  int millis = 0;

  _EchoServiceDelayedEchoStringParams() : super(kVersions.last.size);

  static _EchoServiceDelayedEchoStringParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _EchoServiceDelayedEchoStringParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _EchoServiceDelayedEchoStringParams result = new _EchoServiceDelayedEchoStringParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.millis = decoder0.decodeInt32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(value, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct _EchoServiceDelayedEchoStringParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(millis, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "millis of struct _EchoServiceDelayedEchoStringParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_EchoServiceDelayedEchoStringParams("
           "value: $value" ", "
           "millis: $millis" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    map["millis"] = millis;
    return map;
  }
}


class EchoServiceDelayedEchoStringResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  EchoServiceDelayedEchoStringResponseParams() : super(kVersions.last.size);

  static EchoServiceDelayedEchoStringResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoServiceDelayedEchoStringResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoServiceDelayedEchoStringResponseParams result = new EchoServiceDelayedEchoStringResponseParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(value, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct EchoServiceDelayedEchoStringResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "EchoServiceDelayedEchoStringResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class _EchoServiceSwapParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _EchoServiceSwapParams() : super(kVersions.last.size);

  static _EchoServiceSwapParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _EchoServiceSwapParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _EchoServiceSwapParams result = new _EchoServiceSwapParams();

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
    return "_EchoServiceSwapParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _EchoServiceQuitParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _EchoServiceQuitParams() : super(kVersions.last.size);

  static _EchoServiceQuitParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _EchoServiceQuitParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _EchoServiceQuitParams result = new _EchoServiceQuitParams();

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
    return "_EchoServiceQuitParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _echoServiceMethodEchoStringName = 0;
const int _echoServiceMethodDelayedEchoStringName = 1;
const int _echoServiceMethodSwapName = 2;
const int _echoServiceMethodQuitName = 3;

class _EchoServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]){
    var interfaceTypeKey = getRuntimeTypeInfo().services["test::EchoService"];
    var userDefinedType = getAllMojomTypeDefinitions()[interfaceTypeKey];
    return responseFactory(userDefinedType.interfaceType);
  }

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions()[typeKey]);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions());
}

abstract class EchoService {
  static const String serviceName = "test::EchoService";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _EchoServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static EchoServiceProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    EchoServiceProxy p = new EchoServiceProxy.unbound();
    String name = serviceName ?? EchoService.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic echoString(String value,[Function responseFactory = null]);
  dynamic delayedEchoString(String value,int millis,[Function responseFactory = null]);
  void swap();
  void quit();
}

abstract class EchoServiceInterface
    implements bindings.MojoInterface<EchoService>,
               EchoService {
  factory EchoServiceInterface([EchoService impl]) =>
      new EchoServiceStub.unbound(impl);

  factory EchoServiceInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [EchoService impl]) =>
      new EchoServiceStub.fromEndpoint(endpoint, impl);

  factory EchoServiceInterface.fromMock(
      EchoService mock) =>
      new EchoServiceProxy.fromMock(mock);
}

abstract class EchoServiceInterfaceRequest
    implements bindings.MojoInterface<EchoService>,
               EchoService {
  factory EchoServiceInterfaceRequest() =>
      new EchoServiceProxy.unbound();
}

class _EchoServiceProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<EchoService> {
  EchoService impl;

  _EchoServiceProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _EchoServiceProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _EchoServiceProxyControl.unbound() : super.unbound();

  String get serviceName => EchoService.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _echoServiceMethodEchoStringName:
        var r = EchoServiceEchoStringResponseParams.deserialize(
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
      case _echoServiceMethodDelayedEchoStringName:
        var r = EchoServiceDelayedEchoStringResponseParams.deserialize(
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
    return "_EchoServiceProxyControl($superString)";
  }
}

class EchoServiceProxy
    extends bindings.Proxy<EchoService>
    implements EchoService,
               EchoServiceInterface,
               EchoServiceInterfaceRequest {
  EchoServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _EchoServiceProxyControl.fromEndpoint(endpoint));

  EchoServiceProxy.fromHandle(core.MojoHandle handle)
      : super(new _EchoServiceProxyControl.fromHandle(handle));

  EchoServiceProxy.unbound()
      : super(new _EchoServiceProxyControl.unbound());

  factory EchoServiceProxy.fromMock(EchoService mock) {
    EchoServiceProxy newMockedProxy =
        new EchoServiceProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static EchoServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For EchoServiceProxy"));
    return new EchoServiceProxy.fromEndpoint(endpoint);
  }


  dynamic echoString(String value,[Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.echoString(value,_EchoServiceStubControl._echoServiceEchoStringResponseParamsFactory));
    }
    var params = new _EchoServiceEchoStringParams();
    params.value = value;
    return ctrl.sendMessageWithRequestId(
        params,
        _echoServiceMethodEchoStringName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic delayedEchoString(String value,int millis,[Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.delayedEchoString(value,millis,_EchoServiceStubControl._echoServiceDelayedEchoStringResponseParamsFactory));
    }
    var params = new _EchoServiceDelayedEchoStringParams();
    params.value = value;
    params.millis = millis;
    return ctrl.sendMessageWithRequestId(
        params,
        _echoServiceMethodDelayedEchoStringName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void swap() {
    if (impl != null) {
      impl.swap();
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _EchoServiceSwapParams();
    ctrl.sendMessage(params,
        _echoServiceMethodSwapName);
  }
  void quit() {
    if (impl != null) {
      impl.quit();
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _EchoServiceQuitParams();
    ctrl.sendMessage(params,
        _echoServiceMethodQuitName);
  }
}

class _EchoServiceStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<EchoService> {
  EchoService _impl;

  _EchoServiceStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [EchoService impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _EchoServiceStubControl.fromHandle(
      core.MojoHandle handle, [EchoService impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _EchoServiceStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => EchoService.serviceName;


  static EchoServiceEchoStringResponseParams _echoServiceEchoStringResponseParamsFactory(String value) {
    var result = new EchoServiceEchoStringResponseParams();
    result.value = value;
    return result;
  }
  static EchoServiceDelayedEchoStringResponseParams _echoServiceDelayedEchoStringResponseParamsFactory(String value) {
    var result = new EchoServiceDelayedEchoStringResponseParams();
    result.value = value;
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
      case _echoServiceMethodEchoStringName:
        var params = _EchoServiceEchoStringParams.deserialize(
            message.payload);
        var response = _impl.echoString(params.value,_echoServiceEchoStringResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _echoServiceMethodEchoStringName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _echoServiceMethodEchoStringName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _echoServiceMethodDelayedEchoStringName:
        var params = _EchoServiceDelayedEchoStringParams.deserialize(
            message.payload);
        var response = _impl.delayedEchoString(params.value,params.millis,_echoServiceDelayedEchoStringResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _echoServiceMethodDelayedEchoStringName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _echoServiceMethodDelayedEchoStringName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _echoServiceMethodSwapName:
        _impl.swap();
        break;
      case _echoServiceMethodQuitName:
        _impl.quit();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  EchoService get impl => _impl;
  set impl(EchoService d) {
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
    return "_EchoServiceStubControl($superString)";
  }

  int get version => 0;
}

class EchoServiceStub
    extends bindings.Stub<EchoService>
    implements EchoService,
               EchoServiceInterface,
               EchoServiceInterfaceRequest {
  EchoServiceStub.unbound([EchoService impl])
      : super(new _EchoServiceStubControl.unbound(impl));

  EchoServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [EchoService impl])
      : super(new _EchoServiceStubControl.fromEndpoint(endpoint, impl));

  EchoServiceStub.fromHandle(
      core.MojoHandle handle, [EchoService impl])
      : super(new _EchoServiceStubControl.fromHandle(handle, impl));

  static EchoServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For EchoServiceStub"));
    return new EchoServiceStub.fromEndpoint(endpoint);
  }


  dynamic echoString(String value,[Function responseFactory = null]) {
    return impl.echoString(value,responseFactory);
  }
  dynamic delayedEchoString(String value,int millis,[Function responseFactory = null]) {
    return impl.delayedEchoString(value,millis,responseFactory);
  }
  void swap() {
    return impl.swap();
  }
  void quit() {
    return impl.quit();
  }
}


mojom_types.RuntimeTypeInfo getRuntimeTypeInfo() => _runtimeTypeInfo ??
    _initRuntimeTypeInfo();

Map<String, mojom_types.UserDefinedType> getAllMojomTypeDefinitions() {
  return getRuntimeTypeInfo().typeMap;
}

var _runtimeTypeInfo;
mojom_types.RuntimeTypeInfo  _initRuntimeTypeInfo() {
  // serializedRuntimeTypeInfo contains the bytes of the Mojo serialization of
  // a mojom_types.RuntimeTypeInfo struct describing the Mojom types in this
  // file. The string contains the base64 encoding of the gzip-compressed bytes.
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+xYS28TMRDeR4HQBlReUngcAqdwoOZYRULKgUiVkFBRuVQcolViyKLsA3u3iBtHfgJHjhz5ST1y5B+AzY7BmdiRFzUsQRlpOvE2s/b3+ZvxbjpeZbsQP0DE1/e1sS+8BeObwq8ILygv+v3heJodUXYSj6nl+3ch5/nx4XD0ZHjcl4l7i3l4/sEZ3M+H/FDL70HsQpz6VXwP0UPzKx4+QvwM8TvYF89seN1dA84L2vVrwneEA4qnUUKd+FZ5+D8dmAPTg3mW69sW/kLOLZxMs4QSVk6yJE4pI0n2OiOcjasPk4gVJMpzeVdO5N+RGHESpwVlL6Mx5YSKuUa8mmxPJiVOOPC6dL624LPkM4D97MF19b1P56p40K7i4WXzfn9VOgjN+63sIRrLvTZdV3YVePyJrGBx+sqM6yJgWDXfWG8Kdytwxytt34L3FmD+jfcBo29KsUIzbmWrxo3rbmDpZ988N3PVRc+Sf0m4lOZJNCupRQ83/hIvqoZMPHW0NfuWOlyFjm5DD5vTEc+zlNONjmrqqPcP6wj3YcXbwdb8/Vx48rV9wKbOmcd0Fr2jE9yOF3jbbqgfK/zdsF4dDSy41XPRAu75ttxYPXWA5199xV+PupL6uNNAXZl48WCtJmv9AS/+El7k49N54Uk8m8XczMv9Bvqw3l8CbWyrr93gbOrrHjzzmOpLO64251WNunq0RufVKcIX1OApWMJTG95jjt5GuUk/Ow2dT6coutaP7f3oOmCVOPUjqal6aTnowVvyuwHWQ1iDp9BBD8/K2MhP+z/Tg8S5jnr4EQAA//+qos9XSBMAAA==";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
