// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library http_server_factory_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/http_server/http_server.mojom.dart' as http_server_mojom;
import 'package:mojo_services/mojo/net_address.mojom.dart' as net_address_mojom;



class _HttpServerFactoryCreateHttpServerParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  Object serverRequest = null;
  net_address_mojom.NetAddress localAddress = null;

  _HttpServerFactoryCreateHttpServerParams() : super(kVersions.last.size);

  static _HttpServerFactoryCreateHttpServerParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HttpServerFactoryCreateHttpServerParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HttpServerFactoryCreateHttpServerParams result = new _HttpServerFactoryCreateHttpServerParams();

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
      
      result.serverRequest = decoder0.decodeInterfaceRequest(8, false, http_server_mojom.HttpServerStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.localAddress = net_address_mojom.NetAddress.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(serverRequest, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "serverRequest of struct _HttpServerFactoryCreateHttpServerParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(localAddress, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "localAddress of struct _HttpServerFactoryCreateHttpServerParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HttpServerFactoryCreateHttpServerParams("
           "serverRequest: $serverRequest" ", "
           "localAddress: $localAddress" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _httpServerFactoryMethodCreateHttpServerName = 0;

class _HttpServerFactoryServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class HttpServerFactory {
  static const String serviceName = "http_server::HttpServerFactory";
  void createHttpServer(Object serverRequest, net_address_mojom.NetAddress localAddress);
}

class _HttpServerFactoryProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _HttpServerFactoryProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HttpServerFactoryProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _HttpServerFactoryProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _HttpServerFactoryServiceDescription();

  String get serviceName => HttpServerFactory.serviceName;

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
    return "_HttpServerFactoryProxyControl($superString)";
  }
}

class HttpServerFactoryProxy
    extends bindings.Proxy
    implements HttpServerFactory {
  HttpServerFactoryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _HttpServerFactoryProxyControl.fromEndpoint(endpoint));

  HttpServerFactoryProxy.fromHandle(core.MojoHandle handle)
      : super(new _HttpServerFactoryProxyControl.fromHandle(handle));

  HttpServerFactoryProxy.unbound()
      : super(new _HttpServerFactoryProxyControl.unbound());

  static HttpServerFactoryProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpServerFactoryProxy"));
    return new HttpServerFactoryProxy.fromEndpoint(endpoint);
  }

  factory HttpServerFactoryProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HttpServerFactoryProxy p = new HttpServerFactoryProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void createHttpServer(Object serverRequest, net_address_mojom.NetAddress localAddress) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _HttpServerFactoryCreateHttpServerParams();
    params.serverRequest = serverRequest;
    params.localAddress = localAddress;
    ctrl.sendMessage(params,
        _httpServerFactoryMethodCreateHttpServerName);
  }
}

class _HttpServerFactoryStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<HttpServerFactory> {
  HttpServerFactory _impl;

  _HttpServerFactoryStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HttpServerFactory impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _HttpServerFactoryStubControl.fromHandle(
      core.MojoHandle handle, [HttpServerFactory impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _HttpServerFactoryStubControl.unbound([this._impl]) : super.unbound();



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
      case _httpServerFactoryMethodCreateHttpServerName:
        var params = _HttpServerFactoryCreateHttpServerParams.deserialize(
            message.payload);
        _impl.createHttpServer(params.serverRequest, params.localAddress);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  HttpServerFactory get impl => _impl;
  set impl(HttpServerFactory d) {
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
    return "_HttpServerFactoryStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _HttpServerFactoryServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class HttpServerFactoryStub
    extends bindings.Stub<HttpServerFactory>
    implements HttpServerFactory {
  HttpServerFactoryStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HttpServerFactory impl])
      : super(new _HttpServerFactoryStubControl.fromEndpoint(endpoint, impl));

  HttpServerFactoryStub.fromHandle(
      core.MojoHandle handle, [HttpServerFactory impl])
      : super(new _HttpServerFactoryStubControl.fromHandle(handle, impl));

  HttpServerFactoryStub.unbound([HttpServerFactory impl])
      : super(new _HttpServerFactoryStubControl.unbound(impl));

  static HttpServerFactoryStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HttpServerFactoryStub"));
    return new HttpServerFactoryStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _HttpServerFactoryStubControl.serviceDescription;


  void createHttpServer(Object serverRequest, net_address_mojom.NetAddress localAddress) {
    return impl.createHttpServer(serverRequest, localAddress);
  }
}



