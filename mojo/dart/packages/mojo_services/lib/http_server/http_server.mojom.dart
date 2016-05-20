// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library http_server_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/http_server/http_request.mojom.dart' as http_request_mojom;
import 'package:mojo_services/http_server/http_response.mojom.dart' as http_response_mojom;



class _HttpServerSetHandlerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String pattern = null;
  HttpHandlerInterface handler = null;

  _HttpServerSetHandlerParams() : super(kVersions.last.size);

  static _HttpServerSetHandlerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpServerSetHandlerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpServerSetHandlerParams result = new _HttpServerSetHandlerParams();

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
      
      result.pattern = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.handler = decoder0.decodeServiceInterface(16, false, HttpHandlerProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(pattern, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "pattern of struct _HttpServerSetHandlerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(handler, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "handler of struct _HttpServerSetHandlerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HttpServerSetHandlerParams("
           "pattern: $pattern" ", "
           "handler: $handler" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class HttpServerSetHandlerResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  HttpServerSetHandlerResponseParams() : super(kVersions.last.size);

  static HttpServerSetHandlerResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpServerSetHandlerResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpServerSetHandlerResponseParams result = new HttpServerSetHandlerResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(success, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "success of struct HttpServerSetHandlerResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HttpServerSetHandlerResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class _HttpServerGetPortParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _HttpServerGetPortParams() : super(kVersions.last.size);

  static _HttpServerGetPortParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpServerGetPortParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpServerGetPortParams result = new _HttpServerGetPortParams();

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
    return "_HttpServerGetPortParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class HttpServerGetPortResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int port = 0;

  HttpServerGetPortResponseParams() : super(kVersions.last.size);

  static HttpServerGetPortResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpServerGetPortResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpServerGetPortResponseParams result = new HttpServerGetPortResponseParams();

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
      
      result.port = decoder0.decodeUint16(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint16(port, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "port of struct HttpServerGetPortResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HttpServerGetPortResponseParams("
           "port: $port" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["port"] = port;
    return map;
  }
}


class _HttpHandlerHandleRequestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  http_request_mojom.HttpRequest request = null;

  _HttpHandlerHandleRequestParams() : super(kVersions.last.size);

  static _HttpHandlerHandleRequestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpHandlerHandleRequestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpHandlerHandleRequestParams result = new _HttpHandlerHandleRequestParams();

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
      result.request = http_request_mojom.HttpRequest.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(request, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "request of struct _HttpHandlerHandleRequestParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HttpHandlerHandleRequestParams("
           "request: $request" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class HttpHandlerHandleRequestResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  http_response_mojom.HttpResponse response = null;

  HttpHandlerHandleRequestResponseParams() : super(kVersions.last.size);

  static HttpHandlerHandleRequestResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpHandlerHandleRequestResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpHandlerHandleRequestResponseParams result = new HttpHandlerHandleRequestResponseParams();

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
      result.response = http_response_mojom.HttpResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct HttpHandlerHandleRequestResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HttpHandlerHandleRequestResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _httpServerMethodSetHandlerName = 0;
const int _httpServerMethodGetPortName = 1;

class _HttpServerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class HttpServer {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _HttpServerServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static HttpServerProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HttpServerProxy p = new HttpServerProxy.unbound();
    String name = serviceName ?? HttpServer.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic setHandler(String pattern,HttpHandlerInterface handler,[Function responseFactory = null]);
  dynamic getPort([Function responseFactory = null]);
}

abstract class HttpServerInterface
    implements bindings.MojoInterface<HttpServer>,
               HttpServer {
  factory HttpServerInterface([HttpServer impl]) =>
      new HttpServerStub.unbound(impl);
  factory HttpServerInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [HttpServer impl]) =>
      new HttpServerStub.fromEndpoint(endpoint, impl);
}

abstract class HttpServerInterfaceRequest
    implements bindings.MojoInterface<HttpServer>,
               HttpServer {
  factory HttpServerInterfaceRequest() =>
      new HttpServerProxy.unbound();
}

class _HttpServerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<HttpServer> {
  _HttpServerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HttpServerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _HttpServerProxyControl.unbound() : super.unbound();

  String get serviceName => HttpServer.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _httpServerMethodSetHandlerName:
        var r = HttpServerSetHandlerResponseParams.deserialize(
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
      case _httpServerMethodGetPortName:
        var r = HttpServerGetPortResponseParams.deserialize(
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

  HttpServer get impl => null;
  set impl(HttpServer _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_HttpServerProxyControl($superString)";
  }
}

class HttpServerProxy
    extends bindings.Proxy<HttpServer>
    implements HttpServer,
               HttpServerInterface,
               HttpServerInterfaceRequest {
  HttpServerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _HttpServerProxyControl.fromEndpoint(endpoint));

  HttpServerProxy.fromHandle(core.MojoHandle handle)
      : super(new _HttpServerProxyControl.fromHandle(handle));

  HttpServerProxy.unbound()
      : super(new _HttpServerProxyControl.unbound());

  static HttpServerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpServerProxy"));
    return new HttpServerProxy.fromEndpoint(endpoint);
  }


  dynamic setHandler(String pattern,HttpHandlerInterface handler,[Function responseFactory = null]) {
    var params = new _HttpServerSetHandlerParams();
    params.pattern = pattern;
    params.handler = handler;
    return ctrl.sendMessageWithRequestId(
        params,
        _httpServerMethodSetHandlerName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic getPort([Function responseFactory = null]) {
    var params = new _HttpServerGetPortParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _httpServerMethodGetPortName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _HttpServerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<HttpServer> {
  HttpServer _impl;

  _HttpServerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HttpServer impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _HttpServerStubControl.fromHandle(
      core.MojoHandle handle, [HttpServer impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _HttpServerStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => HttpServer.serviceName;


  HttpServerSetHandlerResponseParams _httpServerSetHandlerResponseParamsFactory(bool success) {
    var result = new HttpServerSetHandlerResponseParams();
    result.success = success;
    return result;
  }
  HttpServerGetPortResponseParams _httpServerGetPortResponseParamsFactory(int port) {
    var result = new HttpServerGetPortResponseParams();
    result.port = port;
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
      case _httpServerMethodSetHandlerName:
        var params = _HttpServerSetHandlerParams.deserialize(
            message.payload);
        var response = _impl.setHandler(params.pattern,params.handler,_httpServerSetHandlerResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _httpServerMethodSetHandlerName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _httpServerMethodSetHandlerName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _httpServerMethodGetPortName:
        var response = _impl.getPort(_httpServerGetPortResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _httpServerMethodGetPortName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _httpServerMethodGetPortName,
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

  HttpServer get impl => _impl;
  set impl(HttpServer d) {
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
    return "_HttpServerStubControl($superString)";
  }

  int get version => 0;
}

class HttpServerStub
    extends bindings.Stub<HttpServer>
    implements HttpServer,
               HttpServerInterface,
               HttpServerInterfaceRequest {
  HttpServerStub.unbound([HttpServer impl])
      : super(new _HttpServerStubControl.unbound(impl));

  HttpServerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HttpServer impl])
      : super(new _HttpServerStubControl.fromEndpoint(endpoint, impl));

  HttpServerStub.fromHandle(
      core.MojoHandle handle, [HttpServer impl])
      : super(new _HttpServerStubControl.fromHandle(handle, impl));

  static HttpServerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpServerStub"));
    return new HttpServerStub.fromEndpoint(endpoint);
  }


  dynamic setHandler(String pattern,HttpHandlerInterface handler,[Function responseFactory = null]) {
    return impl.setHandler(pattern,handler,responseFactory);
  }
  dynamic getPort([Function responseFactory = null]) {
    return impl.getPort(responseFactory);
  }
}

const int _httpHandlerMethodHandleRequestName = 0;

class _HttpHandlerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class HttpHandler {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _HttpHandlerServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static HttpHandlerProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HttpHandlerProxy p = new HttpHandlerProxy.unbound();
    String name = serviceName ?? HttpHandler.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic handleRequest(http_request_mojom.HttpRequest request,[Function responseFactory = null]);
}

abstract class HttpHandlerInterface
    implements bindings.MojoInterface<HttpHandler>,
               HttpHandler {
  factory HttpHandlerInterface([HttpHandler impl]) =>
      new HttpHandlerStub.unbound(impl);
  factory HttpHandlerInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [HttpHandler impl]) =>
      new HttpHandlerStub.fromEndpoint(endpoint, impl);
}

abstract class HttpHandlerInterfaceRequest
    implements bindings.MojoInterface<HttpHandler>,
               HttpHandler {
  factory HttpHandlerInterfaceRequest() =>
      new HttpHandlerProxy.unbound();
}

class _HttpHandlerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<HttpHandler> {
  _HttpHandlerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HttpHandlerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _HttpHandlerProxyControl.unbound() : super.unbound();

  String get serviceName => HttpHandler.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _httpHandlerMethodHandleRequestName:
        var r = HttpHandlerHandleRequestResponseParams.deserialize(
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

  HttpHandler get impl => null;
  set impl(HttpHandler _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_HttpHandlerProxyControl($superString)";
  }
}

class HttpHandlerProxy
    extends bindings.Proxy<HttpHandler>
    implements HttpHandler,
               HttpHandlerInterface,
               HttpHandlerInterfaceRequest {
  HttpHandlerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _HttpHandlerProxyControl.fromEndpoint(endpoint));

  HttpHandlerProxy.fromHandle(core.MojoHandle handle)
      : super(new _HttpHandlerProxyControl.fromHandle(handle));

  HttpHandlerProxy.unbound()
      : super(new _HttpHandlerProxyControl.unbound());

  static HttpHandlerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpHandlerProxy"));
    return new HttpHandlerProxy.fromEndpoint(endpoint);
  }


  dynamic handleRequest(http_request_mojom.HttpRequest request,[Function responseFactory = null]) {
    var params = new _HttpHandlerHandleRequestParams();
    params.request = request;
    return ctrl.sendMessageWithRequestId(
        params,
        _httpHandlerMethodHandleRequestName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _HttpHandlerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<HttpHandler> {
  HttpHandler _impl;

  _HttpHandlerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HttpHandler impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _HttpHandlerStubControl.fromHandle(
      core.MojoHandle handle, [HttpHandler impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _HttpHandlerStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => HttpHandler.serviceName;


  HttpHandlerHandleRequestResponseParams _httpHandlerHandleRequestResponseParamsFactory(http_response_mojom.HttpResponse response) {
    var result = new HttpHandlerHandleRequestResponseParams();
    result.response = response;
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
      case _httpHandlerMethodHandleRequestName:
        var params = _HttpHandlerHandleRequestParams.deserialize(
            message.payload);
        var response = _impl.handleRequest(params.request,_httpHandlerHandleRequestResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _httpHandlerMethodHandleRequestName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _httpHandlerMethodHandleRequestName,
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

  HttpHandler get impl => _impl;
  set impl(HttpHandler d) {
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
    return "_HttpHandlerStubControl($superString)";
  }

  int get version => 0;
}

class HttpHandlerStub
    extends bindings.Stub<HttpHandler>
    implements HttpHandler,
               HttpHandlerInterface,
               HttpHandlerInterfaceRequest {
  HttpHandlerStub.unbound([HttpHandler impl])
      : super(new _HttpHandlerStubControl.unbound(impl));

  HttpHandlerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HttpHandler impl])
      : super(new _HttpHandlerStubControl.fromEndpoint(endpoint, impl));

  HttpHandlerStub.fromHandle(
      core.MojoHandle handle, [HttpHandler impl])
      : super(new _HttpHandlerStubControl.fromHandle(handle, impl));

  static HttpHandlerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpHandlerStub"));
    return new HttpHandlerStub.fromEndpoint(endpoint);
  }


  dynamic handleRequest(http_request_mojom.HttpRequest request,[Function responseFactory = null]) {
    return impl.handleRequest(request,responseFactory);
  }
}



