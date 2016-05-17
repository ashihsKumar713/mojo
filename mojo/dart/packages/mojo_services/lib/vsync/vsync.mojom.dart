// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library vsync_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _VSyncProviderAwaitVSyncParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _VSyncProviderAwaitVSyncParams() : super(kVersions.last.size);

  static _VSyncProviderAwaitVSyncParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _VSyncProviderAwaitVSyncParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _VSyncProviderAwaitVSyncParams result = new _VSyncProviderAwaitVSyncParams();

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
    return "_VSyncProviderAwaitVSyncParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class VSyncProviderAwaitVSyncResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int timeStamp = 0;

  VSyncProviderAwaitVSyncResponseParams() : super(kVersions.last.size);

  static VSyncProviderAwaitVSyncResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static VSyncProviderAwaitVSyncResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    VSyncProviderAwaitVSyncResponseParams result = new VSyncProviderAwaitVSyncResponseParams();

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
      
      result.timeStamp = decoder0.decodeInt64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(timeStamp, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "timeStamp of struct VSyncProviderAwaitVSyncResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "VSyncProviderAwaitVSyncResponseParams("
           "timeStamp: $timeStamp" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["timeStamp"] = timeStamp;
    return map;
  }
}

const int _vSyncProviderMethodAwaitVSyncName = 0;

class _VSyncProviderServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class VSyncProvider {
  static const String serviceName = "vsync::VSyncProvider";
  dynamic awaitVSync([Function responseFactory = null]);
}

class _VSyncProviderProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _VSyncProviderProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _VSyncProviderProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _VSyncProviderProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _VSyncProviderServiceDescription();

  String get serviceName => VSyncProvider.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _vSyncProviderMethodAwaitVSyncName:
        var r = VSyncProviderAwaitVSyncResponseParams.deserialize(
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
    return "_VSyncProviderProxyControl($superString)";
  }
}

class VSyncProviderProxy
    extends bindings.Proxy
    implements VSyncProvider {
  VSyncProviderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _VSyncProviderProxyControl.fromEndpoint(endpoint));

  VSyncProviderProxy.fromHandle(core.MojoHandle handle)
      : super(new _VSyncProviderProxyControl.fromHandle(handle));

  VSyncProviderProxy.unbound()
      : super(new _VSyncProviderProxyControl.unbound());

  static VSyncProviderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For VSyncProviderProxy"));
    return new VSyncProviderProxy.fromEndpoint(endpoint);
  }

  factory VSyncProviderProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    VSyncProviderProxy p = new VSyncProviderProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic awaitVSync([Function responseFactory = null]) {
    var params = new _VSyncProviderAwaitVSyncParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _vSyncProviderMethodAwaitVSyncName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _VSyncProviderStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<VSyncProvider> {
  VSyncProvider _impl;

  _VSyncProviderStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [VSyncProvider impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _VSyncProviderStubControl.fromHandle(
      core.MojoHandle handle, [VSyncProvider impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _VSyncProviderStubControl.unbound([this._impl]) : super.unbound();


  VSyncProviderAwaitVSyncResponseParams _vSyncProviderAwaitVSyncResponseParamsFactory(int timeStamp) {
    var result = new VSyncProviderAwaitVSyncResponseParams();
    result.timeStamp = timeStamp;
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
      case _vSyncProviderMethodAwaitVSyncName:
        var response = _impl.awaitVSync(_vSyncProviderAwaitVSyncResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _vSyncProviderMethodAwaitVSyncName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _vSyncProviderMethodAwaitVSyncName,
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

  VSyncProvider get impl => _impl;
  set impl(VSyncProvider d) {
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
    return "_VSyncProviderStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _VSyncProviderServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class VSyncProviderStub
    extends bindings.Stub<VSyncProvider>
    implements VSyncProvider {
  VSyncProviderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [VSyncProvider impl])
      : super(new _VSyncProviderStubControl.fromEndpoint(endpoint, impl));

  VSyncProviderStub.fromHandle(
      core.MojoHandle handle, [VSyncProvider impl])
      : super(new _VSyncProviderStubControl.fromHandle(handle, impl));

  VSyncProviderStub.unbound([VSyncProvider impl])
      : super(new _VSyncProviderStubControl.unbound(impl));

  static VSyncProviderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For VSyncProviderStub"));
    return new VSyncProviderStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _VSyncProviderStubControl.serviceDescription;


  dynamic awaitVSync([Function responseFactory = null]) {
    return impl.awaitVSync(responseFactory);
  }
}



