// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library url_loader_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/network_error.mojom.dart' as network_error_mojom;
import 'package:mojo/mojo/url_request.mojom.dart' as url_request_mojom;
import 'package:mojo/mojo/url_response.mojom.dart' as url_response_mojom;



class UrlLoaderStatus extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  network_error_mojom.NetworkError error = null;
  bool isLoading = false;

  UrlLoaderStatus() : super(kVersions.last.size);

  static UrlLoaderStatus deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderStatus decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderStatus result = new UrlLoaderStatus();

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
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.error = network_error_mojom.NetworkError.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.isLoading = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(error, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct UrlLoaderStatus: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(isLoading, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "isLoading of struct UrlLoaderStatus: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderStatus("
           "error: $error" ", "
           "isLoading: $isLoading" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["isLoading"] = isLoading;
    return map;
  }
}


class _UrlLoaderStartParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_request_mojom.UrlRequest request = null;

  _UrlLoaderStartParams() : super(kVersions.last.size);

  static _UrlLoaderStartParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlLoaderStartParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlLoaderStartParams result = new _UrlLoaderStartParams();

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
      result.request = url_request_mojom.UrlRequest.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(request, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "request of struct _UrlLoaderStartParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UrlLoaderStartParams("
           "request: $request" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class UrlLoaderStartResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_response_mojom.UrlResponse response = null;

  UrlLoaderStartResponseParams() : super(kVersions.last.size);

  static UrlLoaderStartResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderStartResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderStartResponseParams result = new UrlLoaderStartResponseParams();

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
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct UrlLoaderStartResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderStartResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _UrlLoaderFollowRedirectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _UrlLoaderFollowRedirectParams() : super(kVersions.last.size);

  static _UrlLoaderFollowRedirectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlLoaderFollowRedirectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlLoaderFollowRedirectParams result = new _UrlLoaderFollowRedirectParams();

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
    return "_UrlLoaderFollowRedirectParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class UrlLoaderFollowRedirectResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_response_mojom.UrlResponse response = null;

  UrlLoaderFollowRedirectResponseParams() : super(kVersions.last.size);

  static UrlLoaderFollowRedirectResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderFollowRedirectResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderFollowRedirectResponseParams result = new UrlLoaderFollowRedirectResponseParams();

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
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct UrlLoaderFollowRedirectResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderFollowRedirectResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _UrlLoaderQueryStatusParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _UrlLoaderQueryStatusParams() : super(kVersions.last.size);

  static _UrlLoaderQueryStatusParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlLoaderQueryStatusParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlLoaderQueryStatusParams result = new _UrlLoaderQueryStatusParams();

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
    return "_UrlLoaderQueryStatusParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class UrlLoaderQueryStatusResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  UrlLoaderStatus status = null;

  UrlLoaderQueryStatusResponseParams() : super(kVersions.last.size);

  static UrlLoaderQueryStatusResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderQueryStatusResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderQueryStatusResponseParams result = new UrlLoaderQueryStatusResponseParams();

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
      result.status = UrlLoaderStatus.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(status, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "status of struct UrlLoaderQueryStatusResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderQueryStatusResponseParams("
           "status: $status" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["status"] = status;
    return map;
  }
}

const int _urlLoaderMethodStartName = 0;
const int _urlLoaderMethodFollowRedirectName = 1;
const int _urlLoaderMethodQueryStatusName = 2;

class _UrlLoaderServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class UrlLoader {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _UrlLoaderServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static UrlLoaderProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    UrlLoaderProxy p = new UrlLoaderProxy.unbound();
    String name = serviceName ?? UrlLoader.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic start(url_request_mojom.UrlRequest request,[Function responseFactory = null]);
  dynamic followRedirect([Function responseFactory = null]);
  dynamic queryStatus([Function responseFactory = null]);
}

abstract class UrlLoaderInterface
    implements bindings.MojoInterface<UrlLoader>,
               UrlLoader {
  factory UrlLoaderInterface([UrlLoader impl]) =>
      new UrlLoaderStub.unbound(impl);

  factory UrlLoaderInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [UrlLoader impl]) =>
      new UrlLoaderStub.fromEndpoint(endpoint, impl);

  factory UrlLoaderInterface.fromMock(
      UrlLoader mock) =>
      new UrlLoaderProxy.fromMock(mock);
}

abstract class UrlLoaderInterfaceRequest
    implements bindings.MojoInterface<UrlLoader>,
               UrlLoader {
  factory UrlLoaderInterfaceRequest() =>
      new UrlLoaderProxy.unbound();
}

class _UrlLoaderProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<UrlLoader> {
  UrlLoader impl;

  _UrlLoaderProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _UrlLoaderProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _UrlLoaderProxyControl.unbound() : super.unbound();

  String get serviceName => UrlLoader.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _urlLoaderMethodStartName:
        var r = UrlLoaderStartResponseParams.deserialize(
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
      case _urlLoaderMethodFollowRedirectName:
        var r = UrlLoaderFollowRedirectResponseParams.deserialize(
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
      case _urlLoaderMethodQueryStatusName:
        var r = UrlLoaderQueryStatusResponseParams.deserialize(
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
    return "_UrlLoaderProxyControl($superString)";
  }
}

class UrlLoaderProxy
    extends bindings.Proxy<UrlLoader>
    implements UrlLoader,
               UrlLoaderInterface,
               UrlLoaderInterfaceRequest {
  UrlLoaderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _UrlLoaderProxyControl.fromEndpoint(endpoint));

  UrlLoaderProxy.fromHandle(core.MojoHandle handle)
      : super(new _UrlLoaderProxyControl.fromHandle(handle));

  UrlLoaderProxy.unbound()
      : super(new _UrlLoaderProxyControl.unbound());

  factory UrlLoaderProxy.fromMock(UrlLoader mock) {
    UrlLoaderProxy newMockedProxy =
        new UrlLoaderProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static UrlLoaderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderProxy"));
    return new UrlLoaderProxy.fromEndpoint(endpoint);
  }


  dynamic start(url_request_mojom.UrlRequest request,[Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.start(request,_UrlLoaderStubControl._urlLoaderStartResponseParamsFactory));
    }
    var params = new _UrlLoaderStartParams();
    params.request = request;
    return ctrl.sendMessageWithRequestId(
        params,
        _urlLoaderMethodStartName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic followRedirect([Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.followRedirect(_UrlLoaderStubControl._urlLoaderFollowRedirectResponseParamsFactory));
    }
    var params = new _UrlLoaderFollowRedirectParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _urlLoaderMethodFollowRedirectName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic queryStatus([Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.queryStatus(_UrlLoaderStubControl._urlLoaderQueryStatusResponseParamsFactory));
    }
    var params = new _UrlLoaderQueryStatusParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _urlLoaderMethodQueryStatusName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _UrlLoaderStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<UrlLoader> {
  UrlLoader _impl;

  _UrlLoaderStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [UrlLoader impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _UrlLoaderStubControl.fromHandle(
      core.MojoHandle handle, [UrlLoader impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _UrlLoaderStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => UrlLoader.serviceName;


  static UrlLoaderStartResponseParams _urlLoaderStartResponseParamsFactory(url_response_mojom.UrlResponse response) {
    var result = new UrlLoaderStartResponseParams();
    result.response = response;
    return result;
  }
  static UrlLoaderFollowRedirectResponseParams _urlLoaderFollowRedirectResponseParamsFactory(url_response_mojom.UrlResponse response) {
    var result = new UrlLoaderFollowRedirectResponseParams();
    result.response = response;
    return result;
  }
  static UrlLoaderQueryStatusResponseParams _urlLoaderQueryStatusResponseParamsFactory(UrlLoaderStatus status) {
    var result = new UrlLoaderQueryStatusResponseParams();
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
      case _urlLoaderMethodStartName:
        var params = _UrlLoaderStartParams.deserialize(
            message.payload);
        var response = _impl.start(params.request,_urlLoaderStartResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _urlLoaderMethodStartName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _urlLoaderMethodStartName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _urlLoaderMethodFollowRedirectName:
        var response = _impl.followRedirect(_urlLoaderFollowRedirectResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _urlLoaderMethodFollowRedirectName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _urlLoaderMethodFollowRedirectName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _urlLoaderMethodQueryStatusName:
        var response = _impl.queryStatus(_urlLoaderQueryStatusResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _urlLoaderMethodQueryStatusName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _urlLoaderMethodQueryStatusName,
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

  UrlLoader get impl => _impl;
  set impl(UrlLoader d) {
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
    return "_UrlLoaderStubControl($superString)";
  }

  int get version => 0;
}

class UrlLoaderStub
    extends bindings.Stub<UrlLoader>
    implements UrlLoader,
               UrlLoaderInterface,
               UrlLoaderInterfaceRequest {
  UrlLoaderStub.unbound([UrlLoader impl])
      : super(new _UrlLoaderStubControl.unbound(impl));

  UrlLoaderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [UrlLoader impl])
      : super(new _UrlLoaderStubControl.fromEndpoint(endpoint, impl));

  UrlLoaderStub.fromHandle(
      core.MojoHandle handle, [UrlLoader impl])
      : super(new _UrlLoaderStubControl.fromHandle(handle, impl));

  static UrlLoaderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderStub"));
    return new UrlLoaderStub.fromEndpoint(endpoint);
  }


  dynamic start(url_request_mojom.UrlRequest request,[Function responseFactory = null]) {
    return impl.start(request,responseFactory);
  }
  dynamic followRedirect([Function responseFactory = null]) {
    return impl.followRedirect(responseFactory);
  }
  dynamic queryStatus([Function responseFactory = null]) {
    return impl.queryStatus(responseFactory);
  }
}



