// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library host_resolver_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/network_error.mojom.dart' as network_error_mojom;
import 'package:mojo_services/mojo/net_address.mojom.dart' as net_address_mojom;



class _HostResolverGetHostAddressesParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String host = null;
  net_address_mojom.NetAddressFamily family = null;

  _HostResolverGetHostAddressesParams() : super(kVersions.last.size);

  static _HostResolverGetHostAddressesParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HostResolverGetHostAddressesParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HostResolverGetHostAddressesParams result = new _HostResolverGetHostAddressesParams();

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
      
      result.host = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
        result.family = net_address_mojom.NetAddressFamily.decode(decoder0, 16);
        if (result.family == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable net_address_mojom.NetAddressFamily.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(host, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "host of struct _HostResolverGetHostAddressesParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(family, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "family of struct _HostResolverGetHostAddressesParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HostResolverGetHostAddressesParams("
           "host: $host" ", "
           "family: $family" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["host"] = host;
    map["family"] = family;
    return map;
  }
}


class HostResolverGetHostAddressesResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  network_error_mojom.NetworkError result = null;
  List<net_address_mojom.NetAddress> addresses = null;

  HostResolverGetHostAddressesResponseParams() : super(kVersions.last.size);

  static HostResolverGetHostAddressesResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HostResolverGetHostAddressesResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HostResolverGetHostAddressesResponseParams result = new HostResolverGetHostAddressesResponseParams();

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
      result.result = network_error_mojom.NetworkError.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.addresses = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.addresses = new List<net_address_mojom.NetAddress>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          var decoder2 = decoder1.decodePointer(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
          result.addresses[i1] = net_address_mojom.NetAddress.decode(decoder2);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(result, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct HostResolverGetHostAddressesResponseParams: $e";
      rethrow;
    }
    try {
      if (addresses == null) {
        encoder0.encodeNullPointer(16, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(addresses.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < addresses.length; ++i0) {
          encoder1.encodeStruct(addresses[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "addresses of struct HostResolverGetHostAddressesResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HostResolverGetHostAddressesResponseParams("
           "result: $result" ", "
           "addresses: $addresses" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    map["addresses"] = addresses;
    return map;
  }
}

const int _hostResolverMethodGetHostAddressesName = 0;

class _HostResolverServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class HostResolver {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _HostResolverServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static HostResolverProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HostResolverProxy p = new HostResolverProxy.unbound();
    String name = serviceName ?? HostResolver.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic getHostAddresses(String host,net_address_mojom.NetAddressFamily family,[Function responseFactory = null]);
}

abstract class HostResolverInterface
    implements bindings.MojoInterface<HostResolver>,
               HostResolver {
  factory HostResolverInterface([HostResolver impl]) =>
      new HostResolverStub.unbound(impl);
  factory HostResolverInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [HostResolver impl]) =>
      new HostResolverStub.fromEndpoint(endpoint, impl);
}

abstract class HostResolverInterfaceRequest
    implements bindings.MojoInterface<HostResolver>,
               HostResolver {
  factory HostResolverInterfaceRequest() =>
      new HostResolverProxy.unbound();
}

class _HostResolverProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<HostResolver> {
  _HostResolverProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HostResolverProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _HostResolverProxyControl.unbound() : super.unbound();

  String get serviceName => HostResolver.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _hostResolverMethodGetHostAddressesName:
        var r = HostResolverGetHostAddressesResponseParams.deserialize(
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

  HostResolver get impl => null;
  set impl(HostResolver _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_HostResolverProxyControl($superString)";
  }
}

class HostResolverProxy
    extends bindings.Proxy<HostResolver>
    implements HostResolver,
               HostResolverInterface,
               HostResolverInterfaceRequest {
  HostResolverProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _HostResolverProxyControl.fromEndpoint(endpoint));

  HostResolverProxy.fromHandle(core.MojoHandle handle)
      : super(new _HostResolverProxyControl.fromHandle(handle));

  HostResolverProxy.unbound()
      : super(new _HostResolverProxyControl.unbound());

  static HostResolverProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HostResolverProxy"));
    return new HostResolverProxy.fromEndpoint(endpoint);
  }


  dynamic getHostAddresses(String host,net_address_mojom.NetAddressFamily family,[Function responseFactory = null]) {
    var params = new _HostResolverGetHostAddressesParams();
    params.host = host;
    params.family = family;
    return ctrl.sendMessageWithRequestId(
        params,
        _hostResolverMethodGetHostAddressesName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _HostResolverStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<HostResolver> {
  HostResolver _impl;

  _HostResolverStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HostResolver impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _HostResolverStubControl.fromHandle(
      core.MojoHandle handle, [HostResolver impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _HostResolverStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => HostResolver.serviceName;


  HostResolverGetHostAddressesResponseParams _hostResolverGetHostAddressesResponseParamsFactory(network_error_mojom.NetworkError result, List<net_address_mojom.NetAddress> addresses) {
    var result = new HostResolverGetHostAddressesResponseParams();
    result.result = result;
    result.addresses = addresses;
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
      case _hostResolverMethodGetHostAddressesName:
        var params = _HostResolverGetHostAddressesParams.deserialize(
            message.payload);
        var response = _impl.getHostAddresses(params.host,params.family,_hostResolverGetHostAddressesResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _hostResolverMethodGetHostAddressesName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _hostResolverMethodGetHostAddressesName,
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

  HostResolver get impl => _impl;
  set impl(HostResolver d) {
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
    return "_HostResolverStubControl($superString)";
  }

  int get version => 0;
}

class HostResolverStub
    extends bindings.Stub<HostResolver>
    implements HostResolver,
               HostResolverInterface,
               HostResolverInterfaceRequest {
  HostResolverStub.unbound([HostResolver impl])
      : super(new _HostResolverStubControl.unbound(impl));

  HostResolverStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HostResolver impl])
      : super(new _HostResolverStubControl.fromEndpoint(endpoint, impl));

  HostResolverStub.fromHandle(
      core.MojoHandle handle, [HostResolver impl])
      : super(new _HostResolverStubControl.fromHandle(handle, impl));

  static HostResolverStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HostResolverStub"));
    return new HostResolverStub.fromEndpoint(endpoint);
  }


  dynamic getHostAddresses(String host,net_address_mojom.NetAddressFamily family,[Function responseFactory = null]) {
    return impl.getHostAddresses(host,family,responseFactory);
  }
}



