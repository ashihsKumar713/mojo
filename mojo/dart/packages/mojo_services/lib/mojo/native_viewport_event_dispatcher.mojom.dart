// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library native_viewport_event_dispatcher_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/input_events.mojom.dart' as input_events_mojom;



class _NativeViewportEventDispatcherOnEventParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  input_events_mojom.Event event = null;

  _NativeViewportEventDispatcherOnEventParams() : super(kVersions.last.size);

  static _NativeViewportEventDispatcherOnEventParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _NativeViewportEventDispatcherOnEventParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _NativeViewportEventDispatcherOnEventParams result = new _NativeViewportEventDispatcherOnEventParams();

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
          "event of struct _NativeViewportEventDispatcherOnEventParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_NativeViewportEventDispatcherOnEventParams("
           "event: $event" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["event"] = event;
    return map;
  }
}


class NativeViewportEventDispatcherOnEventResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  NativeViewportEventDispatcherOnEventResponseParams() : super(kVersions.last.size);

  static NativeViewportEventDispatcherOnEventResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static NativeViewportEventDispatcherOnEventResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    NativeViewportEventDispatcherOnEventResponseParams result = new NativeViewportEventDispatcherOnEventResponseParams();

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
    return "NativeViewportEventDispatcherOnEventResponseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _nativeViewportEventDispatcherMethodOnEventName = 0;

class _NativeViewportEventDispatcherServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class NativeViewportEventDispatcher {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _NativeViewportEventDispatcherServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static NativeViewportEventDispatcherProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    NativeViewportEventDispatcherProxy p = new NativeViewportEventDispatcherProxy.unbound();
    String name = serviceName ?? NativeViewportEventDispatcher.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic onEvent(input_events_mojom.Event event,[Function responseFactory = null]);
}

abstract class NativeViewportEventDispatcherInterface
    implements bindings.MojoInterface<NativeViewportEventDispatcher>,
               NativeViewportEventDispatcher {
  factory NativeViewportEventDispatcherInterface([NativeViewportEventDispatcher impl]) =>
      new NativeViewportEventDispatcherStub.unbound(impl);

  factory NativeViewportEventDispatcherInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [NativeViewportEventDispatcher impl]) =>
      new NativeViewportEventDispatcherStub.fromEndpoint(endpoint, impl);

  factory NativeViewportEventDispatcherInterface.fromMock(
      NativeViewportEventDispatcher mock) =>
      new NativeViewportEventDispatcherProxy.fromMock(mock);
}

abstract class NativeViewportEventDispatcherInterfaceRequest
    implements bindings.MojoInterface<NativeViewportEventDispatcher>,
               NativeViewportEventDispatcher {
  factory NativeViewportEventDispatcherInterfaceRequest() =>
      new NativeViewportEventDispatcherProxy.unbound();
}

class _NativeViewportEventDispatcherProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<NativeViewportEventDispatcher> {
  NativeViewportEventDispatcher impl;

  _NativeViewportEventDispatcherProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _NativeViewportEventDispatcherProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _NativeViewportEventDispatcherProxyControl.unbound() : super.unbound();

  String get serviceName => NativeViewportEventDispatcher.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _nativeViewportEventDispatcherMethodOnEventName:
        var r = NativeViewportEventDispatcherOnEventResponseParams.deserialize(
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
    return "_NativeViewportEventDispatcherProxyControl($superString)";
  }
}

class NativeViewportEventDispatcherProxy
    extends bindings.Proxy<NativeViewportEventDispatcher>
    implements NativeViewportEventDispatcher,
               NativeViewportEventDispatcherInterface,
               NativeViewportEventDispatcherInterfaceRequest {
  NativeViewportEventDispatcherProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _NativeViewportEventDispatcherProxyControl.fromEndpoint(endpoint));

  NativeViewportEventDispatcherProxy.fromHandle(core.MojoHandle handle)
      : super(new _NativeViewportEventDispatcherProxyControl.fromHandle(handle));

  NativeViewportEventDispatcherProxy.unbound()
      : super(new _NativeViewportEventDispatcherProxyControl.unbound());

  factory NativeViewportEventDispatcherProxy.fromMock(NativeViewportEventDispatcher mock) {
    NativeViewportEventDispatcherProxy newMockedProxy =
        new NativeViewportEventDispatcherProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static NativeViewportEventDispatcherProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NativeViewportEventDispatcherProxy"));
    return new NativeViewportEventDispatcherProxy.fromEndpoint(endpoint);
  }


  dynamic onEvent(input_events_mojom.Event event,[Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.onEvent(event,_NativeViewportEventDispatcherStubControl._nativeViewportEventDispatcherOnEventResponseParamsFactory));
    }
    var params = new _NativeViewportEventDispatcherOnEventParams();
    params.event = event;
    return ctrl.sendMessageWithRequestId(
        params,
        _nativeViewportEventDispatcherMethodOnEventName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _NativeViewportEventDispatcherStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<NativeViewportEventDispatcher> {
  NativeViewportEventDispatcher _impl;

  _NativeViewportEventDispatcherStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [NativeViewportEventDispatcher impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _NativeViewportEventDispatcherStubControl.fromHandle(
      core.MojoHandle handle, [NativeViewportEventDispatcher impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _NativeViewportEventDispatcherStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => NativeViewportEventDispatcher.serviceName;


  static NativeViewportEventDispatcherOnEventResponseParams _nativeViewportEventDispatcherOnEventResponseParamsFactory() {
    var result = new NativeViewportEventDispatcherOnEventResponseParams();
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
      case _nativeViewportEventDispatcherMethodOnEventName:
        var params = _NativeViewportEventDispatcherOnEventParams.deserialize(
            message.payload);
        var response = _impl.onEvent(params.event,_nativeViewportEventDispatcherOnEventResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _nativeViewportEventDispatcherMethodOnEventName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _nativeViewportEventDispatcherMethodOnEventName,
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

  NativeViewportEventDispatcher get impl => _impl;
  set impl(NativeViewportEventDispatcher d) {
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
    return "_NativeViewportEventDispatcherStubControl($superString)";
  }

  int get version => 0;
}

class NativeViewportEventDispatcherStub
    extends bindings.Stub<NativeViewportEventDispatcher>
    implements NativeViewportEventDispatcher,
               NativeViewportEventDispatcherInterface,
               NativeViewportEventDispatcherInterfaceRequest {
  NativeViewportEventDispatcherStub.unbound([NativeViewportEventDispatcher impl])
      : super(new _NativeViewportEventDispatcherStubControl.unbound(impl));

  NativeViewportEventDispatcherStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [NativeViewportEventDispatcher impl])
      : super(new _NativeViewportEventDispatcherStubControl.fromEndpoint(endpoint, impl));

  NativeViewportEventDispatcherStub.fromHandle(
      core.MojoHandle handle, [NativeViewportEventDispatcher impl])
      : super(new _NativeViewportEventDispatcherStubControl.fromHandle(handle, impl));

  static NativeViewportEventDispatcherStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For NativeViewportEventDispatcherStub"));
    return new NativeViewportEventDispatcherStub.fromEndpoint(endpoint);
  }


  dynamic onEvent(input_events_mojom.Event event,[Function responseFactory = null]) {
    return impl.onEvent(event,responseFactory);
  }
}



