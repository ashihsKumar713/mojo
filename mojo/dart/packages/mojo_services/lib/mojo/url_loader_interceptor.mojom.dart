// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library url_loader_interceptor_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/url_request.mojom.dart' as url_request_mojom;
import 'package:mojo/mojo/url_response.mojom.dart' as url_response_mojom;



class UrlLoaderInterceptorResponse extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  url_request_mojom.UrlRequest request = null;
  url_response_mojom.UrlResponse response = null;

  UrlLoaderInterceptorResponse() : super(kVersions.last.size);

  static UrlLoaderInterceptorResponse deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderInterceptorResponse decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderInterceptorResponse result = new UrlLoaderInterceptorResponse();

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
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.request = url_request_mojom.UrlRequest.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(request, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "request of struct UrlLoaderInterceptorResponse: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(response, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct UrlLoaderInterceptorResponse: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderInterceptorResponse("
           "request: $request" ", "
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _UrlLoaderInterceptorFactoryCreateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object interceptor = null;

  _UrlLoaderInterceptorFactoryCreateParams() : super(kVersions.last.size);

  static _UrlLoaderInterceptorFactoryCreateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlLoaderInterceptorFactoryCreateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlLoaderInterceptorFactoryCreateParams result = new _UrlLoaderInterceptorFactoryCreateParams();

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
      
      result.interceptor = decoder0.decodeInterfaceRequest(8, false, UrlLoaderInterceptorStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(interceptor, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "interceptor of struct _UrlLoaderInterceptorFactoryCreateParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UrlLoaderInterceptorFactoryCreateParams("
           "interceptor: $interceptor" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _UrlLoaderInterceptorInterceptRequestParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_request_mojom.UrlRequest request = null;

  _UrlLoaderInterceptorInterceptRequestParams() : super(kVersions.last.size);

  static _UrlLoaderInterceptorInterceptRequestParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlLoaderInterceptorInterceptRequestParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlLoaderInterceptorInterceptRequestParams result = new _UrlLoaderInterceptorInterceptRequestParams();

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
      result.request = url_request_mojom.UrlRequest.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(request, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "request of struct _UrlLoaderInterceptorInterceptRequestParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UrlLoaderInterceptorInterceptRequestParams("
           "request: $request" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class UrlLoaderInterceptorInterceptRequestResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  UrlLoaderInterceptorResponse response = null;

  UrlLoaderInterceptorInterceptRequestResponseParams() : super(kVersions.last.size);

  static UrlLoaderInterceptorInterceptRequestResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderInterceptorInterceptRequestResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderInterceptorInterceptRequestResponseParams result = new UrlLoaderInterceptorInterceptRequestResponseParams();

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
      result.response = UrlLoaderInterceptorResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct UrlLoaderInterceptorInterceptRequestResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderInterceptorInterceptRequestResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _UrlLoaderInterceptorInterceptFollowRedirectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _UrlLoaderInterceptorInterceptFollowRedirectParams() : super(kVersions.last.size);

  static _UrlLoaderInterceptorInterceptFollowRedirectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlLoaderInterceptorInterceptFollowRedirectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlLoaderInterceptorInterceptFollowRedirectParams result = new _UrlLoaderInterceptorInterceptFollowRedirectParams();

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
    return "_UrlLoaderInterceptorInterceptFollowRedirectParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class UrlLoaderInterceptorInterceptFollowRedirectResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  UrlLoaderInterceptorResponse response = null;

  UrlLoaderInterceptorInterceptFollowRedirectResponseParams() : super(kVersions.last.size);

  static UrlLoaderInterceptorInterceptFollowRedirectResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderInterceptorInterceptFollowRedirectResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderInterceptorInterceptFollowRedirectResponseParams result = new UrlLoaderInterceptorInterceptFollowRedirectResponseParams();

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
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.response = UrlLoaderInterceptorResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct UrlLoaderInterceptorInterceptFollowRedirectResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderInterceptorInterceptFollowRedirectResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _UrlLoaderInterceptorInterceptResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_response_mojom.UrlResponse response = null;

  _UrlLoaderInterceptorInterceptResponseParams() : super(kVersions.last.size);

  static _UrlLoaderInterceptorInterceptResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlLoaderInterceptorInterceptResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlLoaderInterceptorInterceptResponseParams result = new _UrlLoaderInterceptorInterceptResponseParams();

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
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct _UrlLoaderInterceptorInterceptResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UrlLoaderInterceptorInterceptResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class UrlLoaderInterceptorInterceptResponseResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  UrlLoaderInterceptorResponse response = null;

  UrlLoaderInterceptorInterceptResponseResponseParams() : super(kVersions.last.size);

  static UrlLoaderInterceptorInterceptResponseResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlLoaderInterceptorInterceptResponseResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlLoaderInterceptorInterceptResponseResponseParams result = new UrlLoaderInterceptorInterceptResponseResponseParams();

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
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.response = UrlLoaderInterceptorResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct UrlLoaderInterceptorInterceptResponseResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlLoaderInterceptorInterceptResponseResponseParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _urlLoaderInterceptorFactoryMethodCreateName = 0;

class _UrlLoaderInterceptorFactoryServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class UrlLoaderInterceptorFactory {
  static const String serviceName = null;
  void create(Object interceptor);
}

class _UrlLoaderInterceptorFactoryProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _UrlLoaderInterceptorFactoryProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _UrlLoaderInterceptorFactoryProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _UrlLoaderInterceptorFactoryProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _UrlLoaderInterceptorFactoryServiceDescription();

  String get serviceName => UrlLoaderInterceptorFactory.serviceName;

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
    return "_UrlLoaderInterceptorFactoryProxyControl($superString)";
  }
}

class UrlLoaderInterceptorFactoryProxy
    extends bindings.Proxy
    implements UrlLoaderInterceptorFactory {
  UrlLoaderInterceptorFactoryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _UrlLoaderInterceptorFactoryProxyControl.fromEndpoint(endpoint));

  UrlLoaderInterceptorFactoryProxy.fromHandle(core.MojoHandle handle)
      : super(new _UrlLoaderInterceptorFactoryProxyControl.fromHandle(handle));

  UrlLoaderInterceptorFactoryProxy.unbound()
      : super(new _UrlLoaderInterceptorFactoryProxyControl.unbound());

  static UrlLoaderInterceptorFactoryProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderInterceptorFactoryProxy"));
    return new UrlLoaderInterceptorFactoryProxy.fromEndpoint(endpoint);
  }

  factory UrlLoaderInterceptorFactoryProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    UrlLoaderInterceptorFactoryProxy p = new UrlLoaderInterceptorFactoryProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void create(Object interceptor) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _UrlLoaderInterceptorFactoryCreateParams();
    params.interceptor = interceptor;
    ctrl.sendMessage(params,
        _urlLoaderInterceptorFactoryMethodCreateName);
  }
}

class _UrlLoaderInterceptorFactoryStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<UrlLoaderInterceptorFactory> {
  UrlLoaderInterceptorFactory _impl;

  _UrlLoaderInterceptorFactoryStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [UrlLoaderInterceptorFactory impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _UrlLoaderInterceptorFactoryStubControl.fromHandle(
      core.MojoHandle handle, [UrlLoaderInterceptorFactory impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _UrlLoaderInterceptorFactoryStubControl.unbound([this._impl]) : super.unbound();



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
      case _urlLoaderInterceptorFactoryMethodCreateName:
        var params = _UrlLoaderInterceptorFactoryCreateParams.deserialize(
            message.payload);
        _impl.create(params.interceptor);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  UrlLoaderInterceptorFactory get impl => _impl;
  set impl(UrlLoaderInterceptorFactory d) {
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
    return "_UrlLoaderInterceptorFactoryStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _UrlLoaderInterceptorFactoryServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class UrlLoaderInterceptorFactoryStub
    extends bindings.Stub<UrlLoaderInterceptorFactory>
    implements UrlLoaderInterceptorFactory {
  UrlLoaderInterceptorFactoryStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [UrlLoaderInterceptorFactory impl])
      : super(new _UrlLoaderInterceptorFactoryStubControl.fromEndpoint(endpoint, impl));

  UrlLoaderInterceptorFactoryStub.fromHandle(
      core.MojoHandle handle, [UrlLoaderInterceptorFactory impl])
      : super(new _UrlLoaderInterceptorFactoryStubControl.fromHandle(handle, impl));

  UrlLoaderInterceptorFactoryStub.unbound([UrlLoaderInterceptorFactory impl])
      : super(new _UrlLoaderInterceptorFactoryStubControl.unbound(impl));

  static UrlLoaderInterceptorFactoryStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderInterceptorFactoryStub"));
    return new UrlLoaderInterceptorFactoryStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _UrlLoaderInterceptorFactoryStubControl.serviceDescription;


  void create(Object interceptor) {
    return impl.create(interceptor);
  }
}

const int _urlLoaderInterceptorMethodInterceptRequestName = 0;
const int _urlLoaderInterceptorMethodInterceptFollowRedirectName = 1;
const int _urlLoaderInterceptorMethodInterceptResponseName = 2;

class _UrlLoaderInterceptorServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class UrlLoaderInterceptor {
  static const String serviceName = null;
  dynamic interceptRequest(url_request_mojom.UrlRequest request,[Function responseFactory = null]);
  dynamic interceptFollowRedirect([Function responseFactory = null]);
  dynamic interceptResponse(url_response_mojom.UrlResponse response,[Function responseFactory = null]);
}

class _UrlLoaderInterceptorProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _UrlLoaderInterceptorProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _UrlLoaderInterceptorProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _UrlLoaderInterceptorProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _UrlLoaderInterceptorServiceDescription();

  String get serviceName => UrlLoaderInterceptor.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _urlLoaderInterceptorMethodInterceptRequestName:
        var r = UrlLoaderInterceptorInterceptRequestResponseParams.deserialize(
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
      case _urlLoaderInterceptorMethodInterceptFollowRedirectName:
        var r = UrlLoaderInterceptorInterceptFollowRedirectResponseParams.deserialize(
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
      case _urlLoaderInterceptorMethodInterceptResponseName:
        var r = UrlLoaderInterceptorInterceptResponseResponseParams.deserialize(
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
    return "_UrlLoaderInterceptorProxyControl($superString)";
  }
}

class UrlLoaderInterceptorProxy
    extends bindings.Proxy
    implements UrlLoaderInterceptor {
  UrlLoaderInterceptorProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _UrlLoaderInterceptorProxyControl.fromEndpoint(endpoint));

  UrlLoaderInterceptorProxy.fromHandle(core.MojoHandle handle)
      : super(new _UrlLoaderInterceptorProxyControl.fromHandle(handle));

  UrlLoaderInterceptorProxy.unbound()
      : super(new _UrlLoaderInterceptorProxyControl.unbound());

  static UrlLoaderInterceptorProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderInterceptorProxy"));
    return new UrlLoaderInterceptorProxy.fromEndpoint(endpoint);
  }

  factory UrlLoaderInterceptorProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    UrlLoaderInterceptorProxy p = new UrlLoaderInterceptorProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic interceptRequest(url_request_mojom.UrlRequest request,[Function responseFactory = null]) {
    var params = new _UrlLoaderInterceptorInterceptRequestParams();
    params.request = request;
    return ctrl.sendMessageWithRequestId(
        params,
        _urlLoaderInterceptorMethodInterceptRequestName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic interceptFollowRedirect([Function responseFactory = null]) {
    var params = new _UrlLoaderInterceptorInterceptFollowRedirectParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _urlLoaderInterceptorMethodInterceptFollowRedirectName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic interceptResponse(url_response_mojom.UrlResponse response,[Function responseFactory = null]) {
    var params = new _UrlLoaderInterceptorInterceptResponseParams();
    params.response = response;
    return ctrl.sendMessageWithRequestId(
        params,
        _urlLoaderInterceptorMethodInterceptResponseName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _UrlLoaderInterceptorStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<UrlLoaderInterceptor> {
  UrlLoaderInterceptor _impl;

  _UrlLoaderInterceptorStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [UrlLoaderInterceptor impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _UrlLoaderInterceptorStubControl.fromHandle(
      core.MojoHandle handle, [UrlLoaderInterceptor impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _UrlLoaderInterceptorStubControl.unbound([this._impl]) : super.unbound();


  UrlLoaderInterceptorInterceptRequestResponseParams _urlLoaderInterceptorInterceptRequestResponseParamsFactory(UrlLoaderInterceptorResponse response) {
    var result = new UrlLoaderInterceptorInterceptRequestResponseParams();
    result.response = response;
    return result;
  }
  UrlLoaderInterceptorInterceptFollowRedirectResponseParams _urlLoaderInterceptorInterceptFollowRedirectResponseParamsFactory(UrlLoaderInterceptorResponse response) {
    var result = new UrlLoaderInterceptorInterceptFollowRedirectResponseParams();
    result.response = response;
    return result;
  }
  UrlLoaderInterceptorInterceptResponseResponseParams _urlLoaderInterceptorInterceptResponseResponseParamsFactory(UrlLoaderInterceptorResponse response) {
    var result = new UrlLoaderInterceptorInterceptResponseResponseParams();
    result.response = response;
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
      case _urlLoaderInterceptorMethodInterceptRequestName:
        var params = _UrlLoaderInterceptorInterceptRequestParams.deserialize(
            message.payload);
        var response = _impl.interceptRequest(params.request,_urlLoaderInterceptorInterceptRequestResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _urlLoaderInterceptorMethodInterceptRequestName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _urlLoaderInterceptorMethodInterceptRequestName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _urlLoaderInterceptorMethodInterceptFollowRedirectName:
        var response = _impl.interceptFollowRedirect(_urlLoaderInterceptorInterceptFollowRedirectResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _urlLoaderInterceptorMethodInterceptFollowRedirectName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _urlLoaderInterceptorMethodInterceptFollowRedirectName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _urlLoaderInterceptorMethodInterceptResponseName:
        var params = _UrlLoaderInterceptorInterceptResponseParams.deserialize(
            message.payload);
        var response = _impl.interceptResponse(params.response,_urlLoaderInterceptorInterceptResponseResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _urlLoaderInterceptorMethodInterceptResponseName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _urlLoaderInterceptorMethodInterceptResponseName,
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

  UrlLoaderInterceptor get impl => _impl;
  set impl(UrlLoaderInterceptor d) {
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
    return "_UrlLoaderInterceptorStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _UrlLoaderInterceptorServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class UrlLoaderInterceptorStub
    extends bindings.Stub<UrlLoaderInterceptor>
    implements UrlLoaderInterceptor {
  UrlLoaderInterceptorStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [UrlLoaderInterceptor impl])
      : super(new _UrlLoaderInterceptorStubControl.fromEndpoint(endpoint, impl));

  UrlLoaderInterceptorStub.fromHandle(
      core.MojoHandle handle, [UrlLoaderInterceptor impl])
      : super(new _UrlLoaderInterceptorStubControl.fromHandle(handle, impl));

  UrlLoaderInterceptorStub.unbound([UrlLoaderInterceptor impl])
      : super(new _UrlLoaderInterceptorStubControl.unbound(impl));

  static UrlLoaderInterceptorStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlLoaderInterceptorStub"));
    return new UrlLoaderInterceptorStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _UrlLoaderInterceptorStubControl.serviceDescription;


  dynamic interceptRequest(url_request_mojom.UrlRequest request,[Function responseFactory = null]) {
    return impl.interceptRequest(request,responseFactory);
  }
  dynamic interceptFollowRedirect([Function responseFactory = null]) {
    return impl.interceptFollowRedirect(responseFactory);
  }
  dynamic interceptResponse(url_response_mojom.UrlResponse response,[Function responseFactory = null]) {
    return impl.interceptResponse(response,responseFactory);
  }
}



