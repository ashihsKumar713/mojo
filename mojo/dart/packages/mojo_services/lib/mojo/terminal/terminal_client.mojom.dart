// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library terminal_client_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/files/file.mojom.dart' as file_mojom;



class _TerminalClientConnectToTerminalParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  file_mojom.FileInterface terminal = null;

  _TerminalClientConnectToTerminalParams() : super(kVersions.last.size);

  static _TerminalClientConnectToTerminalParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TerminalClientConnectToTerminalParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TerminalClientConnectToTerminalParams result = new _TerminalClientConnectToTerminalParams();

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
      
      result.terminal = decoder0.decodeServiceInterface(8, false, file_mojom.FileProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(terminal, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "terminal of struct _TerminalClientConnectToTerminalParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TerminalClientConnectToTerminalParams("
           "terminal: $terminal" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _terminalClientMethodConnectToTerminalName = 0;

class _TerminalClientServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class TerminalClient {
  static const String serviceName = "mojo::terminal::TerminalClient";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _TerminalClientServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static TerminalClientProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TerminalClientProxy p = new TerminalClientProxy.unbound();
    String name = serviceName ?? TerminalClient.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void connectToTerminal(file_mojom.FileInterface terminal);
}

abstract class TerminalClientInterface
    implements bindings.MojoInterface<TerminalClient>,
               TerminalClient {
  factory TerminalClientInterface([TerminalClient impl]) =>
      new TerminalClientStub.unbound(impl);

  factory TerminalClientInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [TerminalClient impl]) =>
      new TerminalClientStub.fromEndpoint(endpoint, impl);

  factory TerminalClientInterface.fromMock(
      TerminalClient mock) =>
      new TerminalClientProxy.fromMock(mock);
}

abstract class TerminalClientInterfaceRequest
    implements bindings.MojoInterface<TerminalClient>,
               TerminalClient {
  factory TerminalClientInterfaceRequest() =>
      new TerminalClientProxy.unbound();
}

class _TerminalClientProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<TerminalClient> {
  TerminalClient impl;

  _TerminalClientProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TerminalClientProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _TerminalClientProxyControl.unbound() : super.unbound();

  String get serviceName => TerminalClient.serviceName;

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
    return "_TerminalClientProxyControl($superString)";
  }
}

class TerminalClientProxy
    extends bindings.Proxy<TerminalClient>
    implements TerminalClient,
               TerminalClientInterface,
               TerminalClientInterfaceRequest {
  TerminalClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _TerminalClientProxyControl.fromEndpoint(endpoint));

  TerminalClientProxy.fromHandle(core.MojoHandle handle)
      : super(new _TerminalClientProxyControl.fromHandle(handle));

  TerminalClientProxy.unbound()
      : super(new _TerminalClientProxyControl.unbound());

  factory TerminalClientProxy.fromMock(TerminalClient mock) {
    TerminalClientProxy newMockedProxy =
        new TerminalClientProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static TerminalClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TerminalClientProxy"));
    return new TerminalClientProxy.fromEndpoint(endpoint);
  }


  void connectToTerminal(file_mojom.FileInterface terminal) {
    if (impl != null) {
      impl.connectToTerminal(terminal);
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _TerminalClientConnectToTerminalParams();
    params.terminal = terminal;
    ctrl.sendMessage(params,
        _terminalClientMethodConnectToTerminalName);
  }
}

class _TerminalClientStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<TerminalClient> {
  TerminalClient _impl;

  _TerminalClientStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [TerminalClient impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _TerminalClientStubControl.fromHandle(
      core.MojoHandle handle, [TerminalClient impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _TerminalClientStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => TerminalClient.serviceName;



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
      case _terminalClientMethodConnectToTerminalName:
        var params = _TerminalClientConnectToTerminalParams.deserialize(
            message.payload);
        _impl.connectToTerminal(params.terminal);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  TerminalClient get impl => _impl;
  set impl(TerminalClient d) {
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
    return "_TerminalClientStubControl($superString)";
  }

  int get version => 0;
}

class TerminalClientStub
    extends bindings.Stub<TerminalClient>
    implements TerminalClient,
               TerminalClientInterface,
               TerminalClientInterfaceRequest {
  TerminalClientStub.unbound([TerminalClient impl])
      : super(new _TerminalClientStubControl.unbound(impl));

  TerminalClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [TerminalClient impl])
      : super(new _TerminalClientStubControl.fromEndpoint(endpoint, impl));

  TerminalClientStub.fromHandle(
      core.MojoHandle handle, [TerminalClient impl])
      : super(new _TerminalClientStubControl.fromHandle(handle, impl));

  static TerminalClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TerminalClientStub"));
    return new TerminalClientStub.fromEndpoint(endpoint);
  }


  void connectToTerminal(file_mojom.FileInterface terminal) {
    return impl.connectToTerminal(terminal);
  }
}



