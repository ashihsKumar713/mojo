// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library input_dispatcher_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/input_events.mojom.dart' as input_events_mojom;



class _InputDispatcherDispatchEventParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  input_events_mojom.Event event = null;

  _InputDispatcherDispatchEventParams() : super(kVersions.last.size);

  static _InputDispatcherDispatchEventParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _InputDispatcherDispatchEventParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _InputDispatcherDispatchEventParams result = new _InputDispatcherDispatchEventParams();

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
      result.event = input_events_mojom.Event.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(event, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "event of struct _InputDispatcherDispatchEventParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_InputDispatcherDispatchEventParams("
           "event: $event" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["event"] = event;
    return map;
  }
}

const int _inputDispatcherMethodDispatchEventName = 0;

class _InputDispatcherServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class InputDispatcher {
  static const String serviceName = "mojo::ui::InputDispatcher";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _InputDispatcherServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static InputDispatcherProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    InputDispatcherProxy p = new InputDispatcherProxy.unbound();
    String name = serviceName ?? InputDispatcher.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void dispatchEvent(input_events_mojom.Event event);
}

abstract class InputDispatcherInterface
    implements bindings.MojoInterface<InputDispatcher>,
               InputDispatcher {
  factory InputDispatcherInterface([InputDispatcher impl]) =>
      new InputDispatcherStub.unbound(impl);
  factory InputDispatcherInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [InputDispatcher impl]) =>
      new InputDispatcherStub.fromEndpoint(endpoint, impl);
}

abstract class InputDispatcherInterfaceRequest
    implements bindings.MojoInterface<InputDispatcher>,
               InputDispatcher {
  factory InputDispatcherInterfaceRequest() =>
      new InputDispatcherProxy.unbound();
}

class _InputDispatcherProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<InputDispatcher> {
  _InputDispatcherProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _InputDispatcherProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _InputDispatcherProxyControl.unbound() : super.unbound();

  String get serviceName => InputDispatcher.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  InputDispatcher get impl => null;
  set impl(InputDispatcher _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_InputDispatcherProxyControl($superString)";
  }
}

class InputDispatcherProxy
    extends bindings.Proxy<InputDispatcher>
    implements InputDispatcher,
               InputDispatcherInterface,
               InputDispatcherInterfaceRequest {
  InputDispatcherProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _InputDispatcherProxyControl.fromEndpoint(endpoint));

  InputDispatcherProxy.fromHandle(core.MojoHandle handle)
      : super(new _InputDispatcherProxyControl.fromHandle(handle));

  InputDispatcherProxy.unbound()
      : super(new _InputDispatcherProxyControl.unbound());

  static InputDispatcherProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputDispatcherProxy"));
    return new InputDispatcherProxy.fromEndpoint(endpoint);
  }


  void dispatchEvent(input_events_mojom.Event event) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _InputDispatcherDispatchEventParams();
    params.event = event;
    ctrl.sendMessage(params,
        _inputDispatcherMethodDispatchEventName);
  }
}

class _InputDispatcherStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<InputDispatcher> {
  InputDispatcher _impl;

  _InputDispatcherStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [InputDispatcher impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _InputDispatcherStubControl.fromHandle(
      core.MojoHandle handle, [InputDispatcher impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _InputDispatcherStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => InputDispatcher.serviceName;



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
      case _inputDispatcherMethodDispatchEventName:
        var params = _InputDispatcherDispatchEventParams.deserialize(
            message.payload);
        _impl.dispatchEvent(params.event);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  InputDispatcher get impl => _impl;
  set impl(InputDispatcher d) {
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
    return "_InputDispatcherStubControl($superString)";
  }

  int get version => 0;
}

class InputDispatcherStub
    extends bindings.Stub<InputDispatcher>
    implements InputDispatcher,
               InputDispatcherInterface,
               InputDispatcherInterfaceRequest {
  InputDispatcherStub.unbound([InputDispatcher impl])
      : super(new _InputDispatcherStubControl.unbound(impl));

  InputDispatcherStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [InputDispatcher impl])
      : super(new _InputDispatcherStubControl.fromEndpoint(endpoint, impl));

  InputDispatcherStub.fromHandle(
      core.MojoHandle handle, [InputDispatcher impl])
      : super(new _InputDispatcherStubControl.fromHandle(handle, impl));

  static InputDispatcherStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For InputDispatcherStub"));
    return new InputDispatcherStub.fromEndpoint(endpoint);
  }


  void dispatchEvent(input_events_mojom.Event event) {
    return impl.dispatchEvent(event);
  }
}



