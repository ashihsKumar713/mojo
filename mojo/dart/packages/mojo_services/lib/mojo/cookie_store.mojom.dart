// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library cookie_store_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _CookieStoreGetParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String url = null;

  _CookieStoreGetParams() : super(kVersions.last.size);

  static _CookieStoreGetParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CookieStoreGetParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CookieStoreGetParams result = new _CookieStoreGetParams();

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
      
      result.url = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(url, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "url of struct _CookieStoreGetParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_CookieStoreGetParams("
           "url: $url" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["url"] = url;
    return map;
  }
}


class CookieStoreGetResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String cookies = null;

  CookieStoreGetResponseParams() : super(kVersions.last.size);

  static CookieStoreGetResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CookieStoreGetResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CookieStoreGetResponseParams result = new CookieStoreGetResponseParams();

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
      
      result.cookies = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(cookies, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "cookies of struct CookieStoreGetResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "CookieStoreGetResponseParams("
           "cookies: $cookies" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["cookies"] = cookies;
    return map;
  }
}


class _CookieStoreSetParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String url = null;
  String cookie = null;

  _CookieStoreSetParams() : super(kVersions.last.size);

  static _CookieStoreSetParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CookieStoreSetParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CookieStoreSetParams result = new _CookieStoreSetParams();

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
      
      result.url = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.cookie = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(url, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "url of struct _CookieStoreSetParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(cookie, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "cookie of struct _CookieStoreSetParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_CookieStoreSetParams("
           "url: $url" ", "
           "cookie: $cookie" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["url"] = url;
    map["cookie"] = cookie;
    return map;
  }
}


class CookieStoreSetResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  CookieStoreSetResponseParams() : super(kVersions.last.size);

  static CookieStoreSetResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CookieStoreSetResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CookieStoreSetResponseParams result = new CookieStoreSetResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(success, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "success of struct CookieStoreSetResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "CookieStoreSetResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}

const int _cookieStoreMethodGetName = 0;
const int _cookieStoreMethodSetName = 1;

class _CookieStoreServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class CookieStore {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _CookieStoreServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static CookieStoreProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CookieStoreProxy p = new CookieStoreProxy.unbound();
    String name = serviceName ?? CookieStore.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic get(String url,[Function responseFactory = null]);
  dynamic set(String url,String cookie,[Function responseFactory = null]);
}

abstract class CookieStoreInterface
    implements bindings.MojoInterface<CookieStore>,
               CookieStore {
  factory CookieStoreInterface([CookieStore impl]) =>
      new CookieStoreStub.unbound(impl);
  factory CookieStoreInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [CookieStore impl]) =>
      new CookieStoreStub.fromEndpoint(endpoint, impl);
}

abstract class CookieStoreInterfaceRequest
    implements bindings.MojoInterface<CookieStore>,
               CookieStore {
  factory CookieStoreInterfaceRequest() =>
      new CookieStoreProxy.unbound();
}

class _CookieStoreProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<CookieStore> {
  _CookieStoreProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CookieStoreProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _CookieStoreProxyControl.unbound() : super.unbound();

  String get serviceName => CookieStore.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _cookieStoreMethodGetName:
        var r = CookieStoreGetResponseParams.deserialize(
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
      case _cookieStoreMethodSetName:
        var r = CookieStoreSetResponseParams.deserialize(
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

  CookieStore get impl => null;
  set impl(CookieStore _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_CookieStoreProxyControl($superString)";
  }
}

class CookieStoreProxy
    extends bindings.Proxy<CookieStore>
    implements CookieStore,
               CookieStoreInterface,
               CookieStoreInterfaceRequest {
  CookieStoreProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _CookieStoreProxyControl.fromEndpoint(endpoint));

  CookieStoreProxy.fromHandle(core.MojoHandle handle)
      : super(new _CookieStoreProxyControl.fromHandle(handle));

  CookieStoreProxy.unbound()
      : super(new _CookieStoreProxyControl.unbound());

  static CookieStoreProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CookieStoreProxy"));
    return new CookieStoreProxy.fromEndpoint(endpoint);
  }


  dynamic get(String url,[Function responseFactory = null]) {
    var params = new _CookieStoreGetParams();
    params.url = url;
    return ctrl.sendMessageWithRequestId(
        params,
        _cookieStoreMethodGetName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic set(String url,String cookie,[Function responseFactory = null]) {
    var params = new _CookieStoreSetParams();
    params.url = url;
    params.cookie = cookie;
    return ctrl.sendMessageWithRequestId(
        params,
        _cookieStoreMethodSetName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _CookieStoreStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<CookieStore> {
  CookieStore _impl;

  _CookieStoreStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [CookieStore impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _CookieStoreStubControl.fromHandle(
      core.MojoHandle handle, [CookieStore impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _CookieStoreStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => CookieStore.serviceName;


  CookieStoreGetResponseParams _cookieStoreGetResponseParamsFactory(String cookies) {
    var result = new CookieStoreGetResponseParams();
    result.cookies = cookies;
    return result;
  }
  CookieStoreSetResponseParams _cookieStoreSetResponseParamsFactory(bool success) {
    var result = new CookieStoreSetResponseParams();
    result.success = success;
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
      case _cookieStoreMethodGetName:
        var params = _CookieStoreGetParams.deserialize(
            message.payload);
        var response = _impl.get(params.url,_cookieStoreGetResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _cookieStoreMethodGetName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _cookieStoreMethodGetName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _cookieStoreMethodSetName:
        var params = _CookieStoreSetParams.deserialize(
            message.payload);
        var response = _impl.set(params.url,params.cookie,_cookieStoreSetResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _cookieStoreMethodSetName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _cookieStoreMethodSetName,
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

  CookieStore get impl => _impl;
  set impl(CookieStore d) {
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
    return "_CookieStoreStubControl($superString)";
  }

  int get version => 0;
}

class CookieStoreStub
    extends bindings.Stub<CookieStore>
    implements CookieStore,
               CookieStoreInterface,
               CookieStoreInterfaceRequest {
  CookieStoreStub.unbound([CookieStore impl])
      : super(new _CookieStoreStubControl.unbound(impl));

  CookieStoreStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [CookieStore impl])
      : super(new _CookieStoreStubControl.fromEndpoint(endpoint, impl));

  CookieStoreStub.fromHandle(
      core.MojoHandle handle, [CookieStore impl])
      : super(new _CookieStoreStubControl.fromHandle(handle, impl));

  static CookieStoreStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CookieStoreStub"));
    return new CookieStoreStub.fromEndpoint(endpoint);
  }


  dynamic get(String url,[Function responseFactory = null]) {
    return impl.get(url,responseFactory);
  }
  dynamic set(String url,String cookie,[Function responseFactory = null]) {
    return impl.set(url,cookie,responseFactory);
  }
}



