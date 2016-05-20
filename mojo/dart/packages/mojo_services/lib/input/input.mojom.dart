// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library input_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _InputClientOnBackButtonParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _InputClientOnBackButtonParams() : super(kVersions.last.size);

  static _InputClientOnBackButtonParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _InputClientOnBackButtonParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _InputClientOnBackButtonParams result = new _InputClientOnBackButtonParams();

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
    return "_InputClientOnBackButtonParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class InputClientOnBackButtonResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  InputClientOnBackButtonResponseParams() : super(kVersions.last.size);

  static InputClientOnBackButtonResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static InputClientOnBackButtonResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    InputClientOnBackButtonResponseParams result = new InputClientOnBackButtonResponseParams();

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
    return "InputClientOnBackButtonResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _InputServiceSetClientParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  InputClientInterface client = null;

  _InputServiceSetClientParams() : super(kVersions.last.size);

  static _InputServiceSetClientParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _InputServiceSetClientParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _InputServiceSetClientParams result = new _InputServiceSetClientParams();

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
      
      result.client = decoder0.decodeServiceInterface(8, false, InputClientProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(client, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "client of struct _InputServiceSetClientParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_InputServiceSetClientParams("
           "client: $client" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _inputClientMethodOnBackButtonName = 0;

class _InputClientServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class InputClient {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _InputClientServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static InputClientProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    InputClientProxy p = new InputClientProxy.unbound();
    String name = serviceName ?? InputClient.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic onBackButton([Function responseFactory = null]);
}

abstract class InputClientInterface
    implements bindings.MojoInterface<InputClient>,
               InputClient {
  factory InputClientInterface([InputClient impl]) =>
      new InputClientStub.unbound(impl);
  factory InputClientInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [InputClient impl]) =>
      new InputClientStub.fromEndpoint(endpoint, impl);
}

abstract class InputClientInterfaceRequest
    implements bindings.MojoInterface<InputClient>,
               InputClient {
  factory InputClientInterfaceRequest() =>
      new InputClientProxy.unbound();
}

class _InputClientProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<InputClient> {
  _InputClientProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _InputClientProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _InputClientProxyControl.unbound() : super.unbound();

  String get serviceName => InputClient.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _inputClientMethodOnBackButtonName:
        var r = InputClientOnBackButtonResponseParams.deserialize(
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

  InputClient get impl => null;
  set impl(InputClient _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_InputClientProxyControl($superString)";
  }
}

class InputClientProxy
    extends bindings.Proxy<InputClient>
    implements InputClient,
               InputClientInterface,
               InputClientInterfaceRequest {
  InputClientProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _InputClientProxyControl.fromEndpoint(endpoint));

  InputClientProxy.fromHandle(core.MojoHandle handle)
      : super(new _InputClientProxyControl.fromHandle(handle));

  InputClientProxy.unbound()
      : super(new _InputClientProxyControl.unbound());

  static InputClientProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputClientProxy"));
    return new InputClientProxy.fromEndpoint(endpoint);
  }


  dynamic onBackButton([Function responseFactory = null]) {
    var params = new _InputClientOnBackButtonParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _inputClientMethodOnBackButtonName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _InputClientStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<InputClient> {
  InputClient _impl;

  _InputClientStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [InputClient impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _InputClientStubControl.fromHandle(
      core.MojoHandle handle, [InputClient impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _InputClientStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => InputClient.serviceName;


  InputClientOnBackButtonResponseParams _inputClientOnBackButtonResponseParamsFactory() {
    var result = new InputClientOnBackButtonResponseParams();
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
      case _inputClientMethodOnBackButtonName:
        var response = _impl.onBackButton(_inputClientOnBackButtonResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _inputClientMethodOnBackButtonName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _inputClientMethodOnBackButtonName,
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

  InputClient get impl => _impl;
  set impl(InputClient d) {
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
    return "_InputClientStubControl($superString)";
  }

  int get version => 0;
}

class InputClientStub
    extends bindings.Stub<InputClient>
    implements InputClient,
               InputClientInterface,
               InputClientInterfaceRequest {
  InputClientStub.unbound([InputClient impl])
      : super(new _InputClientStubControl.unbound(impl));

  InputClientStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [InputClient impl])
      : super(new _InputClientStubControl.fromEndpoint(endpoint, impl));

  InputClientStub.fromHandle(
      core.MojoHandle handle, [InputClient impl])
      : super(new _InputClientStubControl.fromHandle(handle, impl));

  static InputClientStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputClientStub"));
    return new InputClientStub.fromEndpoint(endpoint);
  }


  dynamic onBackButton([Function responseFactory = null]) {
    return impl.onBackButton(responseFactory);
  }
}

const int _inputServiceMethodSetClientName = 0;

class _InputServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class InputService {
  static const String serviceName = "input::InputService";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _InputServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static InputServiceProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    InputServiceProxy p = new InputServiceProxy.unbound();
    String name = serviceName ?? InputService.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void setClient(InputClientInterface client);
}

abstract class InputServiceInterface
    implements bindings.MojoInterface<InputService>,
               InputService {
  factory InputServiceInterface([InputService impl]) =>
      new InputServiceStub.unbound(impl);
  factory InputServiceInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [InputService impl]) =>
      new InputServiceStub.fromEndpoint(endpoint, impl);
}

abstract class InputServiceInterfaceRequest
    implements bindings.MojoInterface<InputService>,
               InputService {
  factory InputServiceInterfaceRequest() =>
      new InputServiceProxy.unbound();
}

class _InputServiceProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<InputService> {
  _InputServiceProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _InputServiceProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _InputServiceProxyControl.unbound() : super.unbound();

  String get serviceName => InputService.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  InputService get impl => null;
  set impl(InputService _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_InputServiceProxyControl($superString)";
  }
}

class InputServiceProxy
    extends bindings.Proxy<InputService>
    implements InputService,
               InputServiceInterface,
               InputServiceInterfaceRequest {
  InputServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _InputServiceProxyControl.fromEndpoint(endpoint));

  InputServiceProxy.fromHandle(core.MojoHandle handle)
      : super(new _InputServiceProxyControl.fromHandle(handle));

  InputServiceProxy.unbound()
      : super(new _InputServiceProxyControl.unbound());

  static InputServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputServiceProxy"));
    return new InputServiceProxy.fromEndpoint(endpoint);
  }


  void setClient(InputClientInterface client) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _InputServiceSetClientParams();
    params.client = client;
    ctrl.sendMessage(params,
        _inputServiceMethodSetClientName);
  }
}

class _InputServiceStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<InputService> {
  InputService _impl;

  _InputServiceStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [InputService impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _InputServiceStubControl.fromHandle(
      core.MojoHandle handle, [InputService impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _InputServiceStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => InputService.serviceName;



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
      case _inputServiceMethodSetClientName:
        var params = _InputServiceSetClientParams.deserialize(
            message.payload);
        _impl.setClient(params.client);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  InputService get impl => _impl;
  set impl(InputService d) {
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
    return "_InputServiceStubControl($superString)";
  }

  int get version => 0;
}

class InputServiceStub
    extends bindings.Stub<InputService>
    implements InputService,
               InputServiceInterface,
               InputServiceInterfaceRequest {
  InputServiceStub.unbound([InputService impl])
      : super(new _InputServiceStubControl.unbound(impl));

  InputServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [InputService impl])
      : super(new _InputServiceStubControl.fromEndpoint(endpoint, impl));

  InputServiceStub.fromHandle(
      core.MojoHandle handle, [InputService impl])
      : super(new _InputServiceStubControl.fromHandle(handle, impl));

  static InputServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputServiceStub"));
    return new InputServiceStub.fromEndpoint(endpoint);
  }


  void setClient(InputClientInterface client) {
    return impl.setClient(client);
  }
}



