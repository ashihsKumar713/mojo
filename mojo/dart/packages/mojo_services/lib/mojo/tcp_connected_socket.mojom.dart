// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library tcp_connected_socket_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _TcpConnectedSocketServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class TcpConnectedSocket {
  static const String serviceName = null;
}


class _TcpConnectedSocketProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _TcpConnectedSocketProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TcpConnectedSocketProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _TcpConnectedSocketProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _TcpConnectedSocketServiceDescription();

  String get serviceName => TcpConnectedSocket.serviceName;

  @override
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
    return "_TcpConnectedSocketProxyControl($superString)";
  }
}


class TcpConnectedSocketProxy extends bindings.Proxy
                              implements TcpConnectedSocket {
  TcpConnectedSocketProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _TcpConnectedSocketProxyControl.fromEndpoint(endpoint));

  TcpConnectedSocketProxy.fromHandle(core.MojoHandle handle)
      : super(new _TcpConnectedSocketProxyControl.fromHandle(handle));

  TcpConnectedSocketProxy.unbound()
      : super(new _TcpConnectedSocketProxyControl.unbound());

  static TcpConnectedSocketProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TcpConnectedSocketProxy"));
    return new TcpConnectedSocketProxy.fromEndpoint(endpoint);
  }

  factory TcpConnectedSocketProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TcpConnectedSocketProxy p = new TcpConnectedSocketProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


}


class TcpConnectedSocketStub extends bindings.Stub {
  TcpConnectedSocket _impl;

  TcpConnectedSocketStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [TcpConnectedSocket impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  TcpConnectedSocketStub.fromHandle(
      core.MojoHandle handle, [TcpConnectedSocket impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  TcpConnectedSocketStub.unbound([this._impl]) : super.unbound();

  static TcpConnectedSocketStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TcpConnectedSocketStub"));
    return new TcpConnectedSocketStub.fromEndpoint(endpoint);
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
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  TcpConnectedSocket get impl => _impl;
  set impl(TcpConnectedSocket d) {
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

  String toString() {
    var superString = super.toString();
    return "TcpConnectedSocketStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _TcpConnectedSocketServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



