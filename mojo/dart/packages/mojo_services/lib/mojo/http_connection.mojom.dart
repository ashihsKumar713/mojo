// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library http_connection_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/network_error.mojom.dart' as network_error_mojom;
import 'package:mojo_services/mojo/http_message.mojom.dart' as http_message_mojom;
import 'package:mojo_services/mojo/web_socket.mojom.dart' as web_socket_mojom;



class _HttpConnectionSetSendBufferSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int size = 0;

  _HttpConnectionSetSendBufferSizeParams() : super(kVersions.last.size);

  static _HttpConnectionSetSendBufferSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpConnectionSetSendBufferSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpConnectionSetSendBufferSizeParams result = new _HttpConnectionSetSendBufferSizeParams();

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
      
      result.size = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(size, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "size of struct _HttpConnectionSetSendBufferSizeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HttpConnectionSetSendBufferSizeParams("
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["size"] = size;
    return map;
  }
}


class HttpConnectionSetSendBufferSizeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  HttpConnectionSetSendBufferSizeResponseParams() : super(kVersions.last.size);

  static HttpConnectionSetSendBufferSizeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpConnectionSetSendBufferSizeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpConnectionSetSendBufferSizeResponseParams result = new HttpConnectionSetSendBufferSizeResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct HttpConnectionSetSendBufferSizeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HttpConnectionSetSendBufferSizeResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _HttpConnectionSetReceiveBufferSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int size = 0;

  _HttpConnectionSetReceiveBufferSizeParams() : super(kVersions.last.size);

  static _HttpConnectionSetReceiveBufferSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpConnectionSetReceiveBufferSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpConnectionSetReceiveBufferSizeParams result = new _HttpConnectionSetReceiveBufferSizeParams();

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
      
      result.size = decoder0.decodeUint32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(size, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "size of struct _HttpConnectionSetReceiveBufferSizeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HttpConnectionSetReceiveBufferSizeParams("
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["size"] = size;
    return map;
  }
}


class HttpConnectionSetReceiveBufferSizeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  HttpConnectionSetReceiveBufferSizeResponseParams() : super(kVersions.last.size);

  static HttpConnectionSetReceiveBufferSizeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpConnectionSetReceiveBufferSizeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpConnectionSetReceiveBufferSizeResponseParams result = new HttpConnectionSetReceiveBufferSizeResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct HttpConnectionSetReceiveBufferSizeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HttpConnectionSetReceiveBufferSizeResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _HttpConnectionDelegateOnReceivedRequestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  http_message_mojom.HttpRequest request = null;

  _HttpConnectionDelegateOnReceivedRequestParams() : super(kVersions.last.size);

  static _HttpConnectionDelegateOnReceivedRequestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpConnectionDelegateOnReceivedRequestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpConnectionDelegateOnReceivedRequestParams result = new _HttpConnectionDelegateOnReceivedRequestParams();

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
      result.request = http_message_mojom.HttpRequest.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(request, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "request of struct _HttpConnectionDelegateOnReceivedRequestParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HttpConnectionDelegateOnReceivedRequestParams("
           "request: $request" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class HttpConnectionDelegateOnReceivedRequestResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  http_message_mojom.HttpResponse response = null;

  HttpConnectionDelegateOnReceivedRequestResponseParams() : super(kVersions.last.size);

  static HttpConnectionDelegateOnReceivedRequestResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpConnectionDelegateOnReceivedRequestResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpConnectionDelegateOnReceivedRequestResponseParams result = new HttpConnectionDelegateOnReceivedRequestResponseParams();

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
      result.response = http_message_mojom.HttpResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct HttpConnectionDelegateOnReceivedRequestResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HttpConnectionDelegateOnReceivedRequestResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _HttpConnectionDelegateOnReceivedWebSocketRequestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  http_message_mojom.HttpRequest request = null;

  _HttpConnectionDelegateOnReceivedWebSocketRequestParams() : super(kVersions.last.size);

  static _HttpConnectionDelegateOnReceivedWebSocketRequestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpConnectionDelegateOnReceivedWebSocketRequestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpConnectionDelegateOnReceivedWebSocketRequestParams result = new _HttpConnectionDelegateOnReceivedWebSocketRequestParams();

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
      result.request = http_message_mojom.HttpRequest.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(request, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "request of struct _HttpConnectionDelegateOnReceivedWebSocketRequestParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HttpConnectionDelegateOnReceivedWebSocketRequestParams("
           "request: $request" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object webSocket = null;
  core.MojoDataPipeConsumer sendStream = null;
  Object client = null;

  HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams() : super(kVersions.last.size);

  static HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams result = new HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams();

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
      
      result.webSocket = decoder0.decodeInterfaceRequest(8, true, web_socket_mojom.WebSocketStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.sendStream = decoder0.decodeConsumerHandle(12, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.client = decoder0.decodeServiceInterface(16, true, web_socket_mojom.WebSocketClientProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(webSocket, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "webSocket of struct HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandle(sendStream, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sendStream of struct HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(client, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "client of struct HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams("
           "webSocket: $webSocket" ", "
           "sendStream: $sendStream" ", "
           "client: $client" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _httpConnectionMethodSetSendBufferSizeName = 0;
const int _httpConnectionMethodSetReceiveBufferSizeName = 1;

class _HttpConnectionServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class HttpConnection {
  static const String serviceName = null;
  dynamic setSendBufferSize(int size,[Function responseFactory = null]);
  dynamic setReceiveBufferSize(int size,[Function responseFactory = null]);
}

class _HttpConnectionProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _HttpConnectionProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HttpConnectionProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _HttpConnectionProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _HttpConnectionServiceDescription();

  String get serviceName => HttpConnection.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _httpConnectionMethodSetSendBufferSizeName:
        var r = HttpConnectionSetSendBufferSizeResponseParams.deserialize(
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
      case _httpConnectionMethodSetReceiveBufferSizeName:
        var r = HttpConnectionSetReceiveBufferSizeResponseParams.deserialize(
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
    return "_HttpConnectionProxyControl($superString)";
  }
}

class HttpConnectionProxy
    extends bindings.Proxy
    implements HttpConnection {
  HttpConnectionProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _HttpConnectionProxyControl.fromEndpoint(endpoint));

  HttpConnectionProxy.fromHandle(core.MojoHandle handle)
      : super(new _HttpConnectionProxyControl.fromHandle(handle));

  HttpConnectionProxy.unbound()
      : super(new _HttpConnectionProxyControl.unbound());

  static HttpConnectionProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpConnectionProxy"));
    return new HttpConnectionProxy.fromEndpoint(endpoint);
  }

  factory HttpConnectionProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HttpConnectionProxy p = new HttpConnectionProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic setSendBufferSize(int size,[Function responseFactory = null]) {
    var params = new _HttpConnectionSetSendBufferSizeParams();
    params.size = size;
    return ctrl.sendMessageWithRequestId(
        params,
        _httpConnectionMethodSetSendBufferSizeName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic setReceiveBufferSize(int size,[Function responseFactory = null]) {
    var params = new _HttpConnectionSetReceiveBufferSizeParams();
    params.size = size;
    return ctrl.sendMessageWithRequestId(
        params,
        _httpConnectionMethodSetReceiveBufferSizeName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _HttpConnectionStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<HttpConnection> {
  HttpConnection _impl;

  _HttpConnectionStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HttpConnection impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _HttpConnectionStubControl.fromHandle(
      core.MojoHandle handle, [HttpConnection impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _HttpConnectionStubControl.unbound([this._impl]) : super.unbound();


  HttpConnectionSetSendBufferSizeResponseParams _httpConnectionSetSendBufferSizeResponseParamsFactory(network_error_mojom.NetworkError result) {
    var result = new HttpConnectionSetSendBufferSizeResponseParams();
    result.result = result;
    return result;
  }
  HttpConnectionSetReceiveBufferSizeResponseParams _httpConnectionSetReceiveBufferSizeResponseParamsFactory(network_error_mojom.NetworkError result) {
    var result = new HttpConnectionSetReceiveBufferSizeResponseParams();
    result.result = result;
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
      case _httpConnectionMethodSetSendBufferSizeName:
        var params = _HttpConnectionSetSendBufferSizeParams.deserialize(
            message.payload);
        var response = _impl.setSendBufferSize(params.size,_httpConnectionSetSendBufferSizeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _httpConnectionMethodSetSendBufferSizeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _httpConnectionMethodSetSendBufferSizeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _httpConnectionMethodSetReceiveBufferSizeName:
        var params = _HttpConnectionSetReceiveBufferSizeParams.deserialize(
            message.payload);
        var response = _impl.setReceiveBufferSize(params.size,_httpConnectionSetReceiveBufferSizeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _httpConnectionMethodSetReceiveBufferSizeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _httpConnectionMethodSetReceiveBufferSizeName,
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

  HttpConnection get impl => _impl;
  set impl(HttpConnection d) {
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
    return "_HttpConnectionStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _HttpConnectionServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class HttpConnectionStub
    extends bindings.Stub<HttpConnection>
    implements HttpConnection {
  HttpConnectionStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HttpConnection impl])
      : super(new _HttpConnectionStubControl.fromEndpoint(endpoint, impl));

  HttpConnectionStub.fromHandle(
      core.MojoHandle handle, [HttpConnection impl])
      : super(new _HttpConnectionStubControl.fromHandle(handle, impl));

  HttpConnectionStub.unbound([HttpConnection impl])
      : super(new _HttpConnectionStubControl.unbound(impl));

  static HttpConnectionStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpConnectionStub"));
    return new HttpConnectionStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _HttpConnectionStubControl.serviceDescription;


  dynamic setSendBufferSize(int size,[Function responseFactory = null]) {
    return impl.setSendBufferSize(size,responseFactory);
  }
  dynamic setReceiveBufferSize(int size,[Function responseFactory = null]) {
    return impl.setReceiveBufferSize(size,responseFactory);
  }
}

const int _httpConnectionDelegateMethodOnReceivedRequestName = 0;
const int _httpConnectionDelegateMethodOnReceivedWebSocketRequestName = 1;

class _HttpConnectionDelegateServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class HttpConnectionDelegate {
  static const String serviceName = null;
  dynamic onReceivedRequest(http_message_mojom.HttpRequest request,[Function responseFactory = null]);
  dynamic onReceivedWebSocketRequest(http_message_mojom.HttpRequest request,[Function responseFactory = null]);
}

class _HttpConnectionDelegateProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _HttpConnectionDelegateProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HttpConnectionDelegateProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _HttpConnectionDelegateProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _HttpConnectionDelegateServiceDescription();

  String get serviceName => HttpConnectionDelegate.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _httpConnectionDelegateMethodOnReceivedRequestName:
        var r = HttpConnectionDelegateOnReceivedRequestResponseParams.deserialize(
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
      case _httpConnectionDelegateMethodOnReceivedWebSocketRequestName:
        var r = HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams.deserialize(
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
    return "_HttpConnectionDelegateProxyControl($superString)";
  }
}

class HttpConnectionDelegateProxy
    extends bindings.Proxy
    implements HttpConnectionDelegate {
  HttpConnectionDelegateProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _HttpConnectionDelegateProxyControl.fromEndpoint(endpoint));

  HttpConnectionDelegateProxy.fromHandle(core.MojoHandle handle)
      : super(new _HttpConnectionDelegateProxyControl.fromHandle(handle));

  HttpConnectionDelegateProxy.unbound()
      : super(new _HttpConnectionDelegateProxyControl.unbound());

  static HttpConnectionDelegateProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpConnectionDelegateProxy"));
    return new HttpConnectionDelegateProxy.fromEndpoint(endpoint);
  }

  factory HttpConnectionDelegateProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HttpConnectionDelegateProxy p = new HttpConnectionDelegateProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic onReceivedRequest(http_message_mojom.HttpRequest request,[Function responseFactory = null]) {
    var params = new _HttpConnectionDelegateOnReceivedRequestParams();
    params.request = request;
    return ctrl.sendMessageWithRequestId(
        params,
        _httpConnectionDelegateMethodOnReceivedRequestName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic onReceivedWebSocketRequest(http_message_mojom.HttpRequest request,[Function responseFactory = null]) {
    var params = new _HttpConnectionDelegateOnReceivedWebSocketRequestParams();
    params.request = request;
    return ctrl.sendMessageWithRequestId(
        params,
        _httpConnectionDelegateMethodOnReceivedWebSocketRequestName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _HttpConnectionDelegateStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<HttpConnectionDelegate> {
  HttpConnectionDelegate _impl;

  _HttpConnectionDelegateStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HttpConnectionDelegate impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _HttpConnectionDelegateStubControl.fromHandle(
      core.MojoHandle handle, [HttpConnectionDelegate impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _HttpConnectionDelegateStubControl.unbound([this._impl]) : super.unbound();


  HttpConnectionDelegateOnReceivedRequestResponseParams _httpConnectionDelegateOnReceivedRequestResponseParamsFactory(http_message_mojom.HttpResponse response) {
    var result = new HttpConnectionDelegateOnReceivedRequestResponseParams();
    result.response = response;
    return result;
  }
  HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams _httpConnectionDelegateOnReceivedWebSocketRequestResponseParamsFactory(Object webSocket, core.MojoDataPipeConsumer sendStream, Object client) {
    var result = new HttpConnectionDelegateOnReceivedWebSocketRequestResponseParams();
    result.webSocket = webSocket;
    result.sendStream = sendStream;
    result.client = client;
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
      case _httpConnectionDelegateMethodOnReceivedRequestName:
        var params = _HttpConnectionDelegateOnReceivedRequestParams.deserialize(
            message.payload);
        var response = _impl.onReceivedRequest(params.request,_httpConnectionDelegateOnReceivedRequestResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _httpConnectionDelegateMethodOnReceivedRequestName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _httpConnectionDelegateMethodOnReceivedRequestName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _httpConnectionDelegateMethodOnReceivedWebSocketRequestName:
        var params = _HttpConnectionDelegateOnReceivedWebSocketRequestParams.deserialize(
            message.payload);
        var response = _impl.onReceivedWebSocketRequest(params.request,_httpConnectionDelegateOnReceivedWebSocketRequestResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _httpConnectionDelegateMethodOnReceivedWebSocketRequestName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _httpConnectionDelegateMethodOnReceivedWebSocketRequestName,
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

  HttpConnectionDelegate get impl => _impl;
  set impl(HttpConnectionDelegate d) {
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
    return "_HttpConnectionDelegateStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _HttpConnectionDelegateServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class HttpConnectionDelegateStub
    extends bindings.Stub<HttpConnectionDelegate>
    implements HttpConnectionDelegate {
  HttpConnectionDelegateStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HttpConnectionDelegate impl])
      : super(new _HttpConnectionDelegateStubControl.fromEndpoint(endpoint, impl));

  HttpConnectionDelegateStub.fromHandle(
      core.MojoHandle handle, [HttpConnectionDelegate impl])
      : super(new _HttpConnectionDelegateStubControl.fromHandle(handle, impl));

  HttpConnectionDelegateStub.unbound([HttpConnectionDelegate impl])
      : super(new _HttpConnectionDelegateStubControl.unbound(impl));

  static HttpConnectionDelegateStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpConnectionDelegateStub"));
    return new HttpConnectionDelegateStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _HttpConnectionDelegateStubControl.serviceDescription;


  dynamic onReceivedRequest(http_message_mojom.HttpRequest request,[Function responseFactory = null]) {
    return impl.onReceivedRequest(request,responseFactory);
  }
  dynamic onReceivedWebSocketRequest(http_message_mojom.HttpRequest request,[Function responseFactory = null]) {
    return impl.onReceivedWebSocketRequest(request,responseFactory);
  }
}



