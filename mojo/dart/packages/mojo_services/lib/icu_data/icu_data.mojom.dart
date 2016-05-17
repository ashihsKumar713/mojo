// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library icu_data_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _IcuDataMapParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String sha1hash = null;

  _IcuDataMapParams() : super(kVersions.last.size);

  static _IcuDataMapParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _IcuDataMapParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _IcuDataMapParams result = new _IcuDataMapParams();

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
      
      result.sha1hash = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(sha1hash, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "sha1hash of struct _IcuDataMapParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_IcuDataMapParams("
           "sha1hash: $sha1hash" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["sha1hash"] = sha1hash;
    return map;
  }
}


class IcuDataMapResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoSharedBuffer icuData = null;

  IcuDataMapResponseParams() : super(kVersions.last.size);

  static IcuDataMapResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static IcuDataMapResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    IcuDataMapResponseParams result = new IcuDataMapResponseParams();

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
      
      result.icuData = decoder0.decodeSharedBufferHandle(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeSharedBufferHandle(icuData, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "icuData of struct IcuDataMapResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "IcuDataMapResponseParams("
           "icuData: $icuData" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _icuDataMethodMapName = 0;

class _IcuDataServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class IcuData {
  static const String serviceName = "icu_data::ICUData";
  dynamic map(String sha1hash,[Function responseFactory = null]);
}

class _IcuDataProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _IcuDataProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _IcuDataProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _IcuDataProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _IcuDataServiceDescription();

  String get serviceName => IcuData.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _icuDataMethodMapName:
        var r = IcuDataMapResponseParams.deserialize(
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
    return "_IcuDataProxyControl($superString)";
  }
}

class IcuDataProxy
    extends bindings.Proxy
    implements IcuData {
  IcuDataProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _IcuDataProxyControl.fromEndpoint(endpoint));

  IcuDataProxy.fromHandle(core.MojoHandle handle)
      : super(new _IcuDataProxyControl.fromHandle(handle));

  IcuDataProxy.unbound()
      : super(new _IcuDataProxyControl.unbound());

  static IcuDataProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For IcuDataProxy"));
    return new IcuDataProxy.fromEndpoint(endpoint);
  }

  factory IcuDataProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    IcuDataProxy p = new IcuDataProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic map(String sha1hash,[Function responseFactory = null]) {
    var params = new _IcuDataMapParams();
    params.sha1hash = sha1hash;
    return ctrl.sendMessageWithRequestId(
        params,
        _icuDataMethodMapName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _IcuDataStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<IcuData> {
  IcuData _impl;

  _IcuDataStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [IcuData impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _IcuDataStubControl.fromHandle(
      core.MojoHandle handle, [IcuData impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _IcuDataStubControl.unbound([this._impl]) : super.unbound();


  IcuDataMapResponseParams _icuDataMapResponseParamsFactory(core.MojoSharedBuffer icuData) {
    var result = new IcuDataMapResponseParams();
    result.icuData = icuData;
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
      case _icuDataMethodMapName:
        var params = _IcuDataMapParams.deserialize(
            message.payload);
        var response = _impl.map(params.sha1hash,_icuDataMapResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _icuDataMethodMapName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _icuDataMethodMapName,
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

  IcuData get impl => _impl;
  set impl(IcuData d) {
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
    return "_IcuDataStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _IcuDataServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class IcuDataStub
    extends bindings.Stub<IcuData>
    implements IcuData {
  IcuDataStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [IcuData impl])
      : super(new _IcuDataStubControl.fromEndpoint(endpoint, impl));

  IcuDataStub.fromHandle(
      core.MojoHandle handle, [IcuData impl])
      : super(new _IcuDataStubControl.fromHandle(handle, impl));

  IcuDataStub.unbound([IcuData impl])
      : super(new _IcuDataStubControl.unbound(impl));

  static IcuDataStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For IcuDataStub"));
    return new IcuDataStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _IcuDataStubControl.serviceDescription;


  dynamic map(String sha1hash,[Function responseFactory = null]) {
    return impl.map(sha1hash,responseFactory);
  }
}



