// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library tcp_bound_socket_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/network_error.mojom.dart' as network_error_mojom;
import 'package:mojo_services/mojo/net_address.mojom.dart' as net_address_mojom;
import 'package:mojo_services/mojo/tcp_connected_socket.mojom.dart' as tcp_connected_socket_mojom;
import 'package:mojo_services/mojo/tcp_server_socket.mojom.dart' as tcp_server_socket_mojom;



class _TcpBoundSocketStartListeningParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  tcp_server_socket_mojom.TcpServerSocketInterfaceRequest server = null;

  _TcpBoundSocketStartListeningParams() : super(kVersions.last.size);

  static _TcpBoundSocketStartListeningParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TcpBoundSocketStartListeningParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TcpBoundSocketStartListeningParams result = new _TcpBoundSocketStartListeningParams();

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
      
      result.server = decoder0.decodeInterfaceRequest(8, false, tcp_server_socket_mojom.TcpServerSocketStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(server, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "server of struct _TcpBoundSocketStartListeningParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TcpBoundSocketStartListeningParams("
           "server: $server" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class TcpBoundSocketStartListeningResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  TcpBoundSocketStartListeningResponseParams() : super(kVersions.last.size);

  static TcpBoundSocketStartListeningResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TcpBoundSocketStartListeningResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TcpBoundSocketStartListeningResponseParams result = new TcpBoundSocketStartListeningResponseParams();

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
          "result of struct TcpBoundSocketStartListeningResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "TcpBoundSocketStartListeningResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}


class _TcpBoundSocketConnectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  net_address_mojom.NetAddress remoteAddress = null;
  core.MojoDataPipeConsumer sendStream = null;
  core.MojoDataPipeProducer receiveStream = null;
  tcp_connected_socket_mojom.TcpConnectedSocketInterfaceRequest clientSocket = null;

  _TcpBoundSocketConnectParams() : super(kVersions.last.size);

  static _TcpBoundSocketConnectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TcpBoundSocketConnectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TcpBoundSocketConnectParams result = new _TcpBoundSocketConnectParams();

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
      result.remoteAddress = net_address_mojom.NetAddress.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.sendStream = decoder0.decodeConsumerHandle(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.receiveStream = decoder0.decodeProducerHandle(20, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.clientSocket = decoder0.decodeInterfaceRequest(24, false, tcp_connected_socket_mojom.TcpConnectedSocketStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(remoteAddress, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "remoteAddress of struct _TcpBoundSocketConnectParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandle(sendStream, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sendStream of struct _TcpBoundSocketConnectParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeProducerHandle(receiveStream, 20, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "receiveStream of struct _TcpBoundSocketConnectParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(clientSocket, 24, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "clientSocket of struct _TcpBoundSocketConnectParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TcpBoundSocketConnectParams("
           "remoteAddress: $remoteAddress" ", "
           "sendStream: $sendStream" ", "
           "receiveStream: $receiveStream" ", "
           "clientSocket: $clientSocket" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class TcpBoundSocketConnectResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  network_error_mojom.NetworkError result = null;

  TcpBoundSocketConnectResponseParams() : super(kVersions.last.size);

  static TcpBoundSocketConnectResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TcpBoundSocketConnectResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TcpBoundSocketConnectResponseParams result = new TcpBoundSocketConnectResponseParams();

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
          "result of struct TcpBoundSocketConnectResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "TcpBoundSocketConnectResponseParams("
           "result: $result" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    return map;
  }
}

const int _tcpBoundSocketMethodStartListeningName = 0;
const int _tcpBoundSocketMethodConnectName = 1;

class _TcpBoundSocketServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class TcpBoundSocket {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _TcpBoundSocketServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static TcpBoundSocketProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TcpBoundSocketProxy p = new TcpBoundSocketProxy.unbound();
    String name = serviceName ?? TcpBoundSocket.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic startListening(tcp_server_socket_mojom.TcpServerSocketInterfaceRequest server,[Function responseFactory = null]);
  dynamic connect(net_address_mojom.NetAddress remoteAddress,core.MojoDataPipeConsumer sendStream,core.MojoDataPipeProducer receiveStream,tcp_connected_socket_mojom.TcpConnectedSocketInterfaceRequest clientSocket,[Function responseFactory = null]);
}

abstract class TcpBoundSocketInterface
    implements bindings.MojoInterface<TcpBoundSocket>,
               TcpBoundSocket {
  factory TcpBoundSocketInterface([TcpBoundSocket impl]) =>
      new TcpBoundSocketStub.unbound(impl);
  factory TcpBoundSocketInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [TcpBoundSocket impl]) =>
      new TcpBoundSocketStub.fromEndpoint(endpoint, impl);
}

abstract class TcpBoundSocketInterfaceRequest
    implements bindings.MojoInterface<TcpBoundSocket>,
               TcpBoundSocket {
  factory TcpBoundSocketInterfaceRequest() =>
      new TcpBoundSocketProxy.unbound();
}

class _TcpBoundSocketProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<TcpBoundSocket> {
  _TcpBoundSocketProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TcpBoundSocketProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _TcpBoundSocketProxyControl.unbound() : super.unbound();

  String get serviceName => TcpBoundSocket.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _tcpBoundSocketMethodStartListeningName:
        var r = TcpBoundSocketStartListeningResponseParams.deserialize(
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
      case _tcpBoundSocketMethodConnectName:
        var r = TcpBoundSocketConnectResponseParams.deserialize(
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

  TcpBoundSocket get impl => null;
  set impl(TcpBoundSocket _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_TcpBoundSocketProxyControl($superString)";
  }
}

class TcpBoundSocketProxy
    extends bindings.Proxy<TcpBoundSocket>
    implements TcpBoundSocket,
               TcpBoundSocketInterface,
               TcpBoundSocketInterfaceRequest {
  TcpBoundSocketProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _TcpBoundSocketProxyControl.fromEndpoint(endpoint));

  TcpBoundSocketProxy.fromHandle(core.MojoHandle handle)
      : super(new _TcpBoundSocketProxyControl.fromHandle(handle));

  TcpBoundSocketProxy.unbound()
      : super(new _TcpBoundSocketProxyControl.unbound());

  static TcpBoundSocketProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TcpBoundSocketProxy"));
    return new TcpBoundSocketProxy.fromEndpoint(endpoint);
  }


  dynamic startListening(tcp_server_socket_mojom.TcpServerSocketInterfaceRequest server,[Function responseFactory = null]) {
    var params = new _TcpBoundSocketStartListeningParams();
    params.server = server;
    return ctrl.sendMessageWithRequestId(
        params,
        _tcpBoundSocketMethodStartListeningName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic connect(net_address_mojom.NetAddress remoteAddress,core.MojoDataPipeConsumer sendStream,core.MojoDataPipeProducer receiveStream,tcp_connected_socket_mojom.TcpConnectedSocketInterfaceRequest clientSocket,[Function responseFactory = null]) {
    var params = new _TcpBoundSocketConnectParams();
    params.remoteAddress = remoteAddress;
    params.sendStream = sendStream;
    params.receiveStream = receiveStream;
    params.clientSocket = clientSocket;
    return ctrl.sendMessageWithRequestId(
        params,
        _tcpBoundSocketMethodConnectName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _TcpBoundSocketStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<TcpBoundSocket> {
  TcpBoundSocket _impl;

  _TcpBoundSocketStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [TcpBoundSocket impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _TcpBoundSocketStubControl.fromHandle(
      core.MojoHandle handle, [TcpBoundSocket impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _TcpBoundSocketStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => TcpBoundSocket.serviceName;


  TcpBoundSocketStartListeningResponseParams _tcpBoundSocketStartListeningResponseParamsFactory(network_error_mojom.NetworkError result) {
    var result = new TcpBoundSocketStartListeningResponseParams();
    result.result = result;
    return result;
  }
  TcpBoundSocketConnectResponseParams _tcpBoundSocketConnectResponseParamsFactory(network_error_mojom.NetworkError result) {
    var result = new TcpBoundSocketConnectResponseParams();
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
      case _tcpBoundSocketMethodStartListeningName:
        var params = _TcpBoundSocketStartListeningParams.deserialize(
            message.payload);
        var response = _impl.startListening(params.server,_tcpBoundSocketStartListeningResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _tcpBoundSocketMethodStartListeningName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _tcpBoundSocketMethodStartListeningName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _tcpBoundSocketMethodConnectName:
        var params = _TcpBoundSocketConnectParams.deserialize(
            message.payload);
        var response = _impl.connect(params.remoteAddress,params.sendStream,params.receiveStream,params.clientSocket,_tcpBoundSocketConnectResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _tcpBoundSocketMethodConnectName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _tcpBoundSocketMethodConnectName,
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

  TcpBoundSocket get impl => _impl;
  set impl(TcpBoundSocket d) {
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
    return "_TcpBoundSocketStubControl($superString)";
  }

  int get version => 0;
}

class TcpBoundSocketStub
    extends bindings.Stub<TcpBoundSocket>
    implements TcpBoundSocket,
               TcpBoundSocketInterface,
               TcpBoundSocketInterfaceRequest {
  TcpBoundSocketStub.unbound([TcpBoundSocket impl])
      : super(new _TcpBoundSocketStubControl.unbound(impl));

  TcpBoundSocketStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [TcpBoundSocket impl])
      : super(new _TcpBoundSocketStubControl.fromEndpoint(endpoint, impl));

  TcpBoundSocketStub.fromHandle(
      core.MojoHandle handle, [TcpBoundSocket impl])
      : super(new _TcpBoundSocketStubControl.fromHandle(handle, impl));

  static TcpBoundSocketStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TcpBoundSocketStub"));
    return new TcpBoundSocketStub.fromEndpoint(endpoint);
  }


  dynamic startListening(tcp_server_socket_mojom.TcpServerSocketInterfaceRequest server,[Function responseFactory = null]) {
    return impl.startListening(server,responseFactory);
  }
  dynamic connect(net_address_mojom.NetAddress remoteAddress,core.MojoDataPipeConsumer sendStream,core.MojoDataPipeProducer receiveStream,tcp_connected_socket_mojom.TcpConnectedSocketInterfaceRequest clientSocket,[Function responseFactory = null]) {
    return impl.connect(remoteAddress,sendStream,receiveStream,clientSocket,responseFactory);
  }
}



