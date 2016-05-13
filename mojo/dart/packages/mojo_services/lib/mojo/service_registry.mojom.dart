// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library service_registry_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/service_provider.mojom.dart' as service_provider_mojom;



class _ServiceRegistryAddServicesParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  List<String> interfaceNames = null;
  Object serviceProvider = null;

  _ServiceRegistryAddServicesParams() : super(kVersions.last.size);

  static _ServiceRegistryAddServicesParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ServiceRegistryAddServicesParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ServiceRegistryAddServicesParams result = new _ServiceRegistryAddServicesParams();

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
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.interfaceNames = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.interfaceNames[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.serviceProvider = decoder0.decodeServiceInterface(16, false, service_provider_mojom.ServiceProviderProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (interfaceNames == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(interfaceNames.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < interfaceNames.length; ++i0) {
          encoder1.encodeString(interfaceNames[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "interfaceNames of struct _ServiceRegistryAddServicesParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(serviceProvider, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "serviceProvider of struct _ServiceRegistryAddServicesParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ServiceRegistryAddServicesParams("
           "interfaceNames: $interfaceNames" ", "
           "serviceProvider: $serviceProvider" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _serviceRegistryMethodAddServicesName = 0;

class _ServiceRegistryServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ServiceRegistry {
  static const String serviceName = "mojo::ServiceRegistry";
  void addServices(List<String> interfaceNames, Object serviceProvider);
}


class _ServiceRegistryProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _ServiceRegistryProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ServiceRegistryProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ServiceRegistryProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _ServiceRegistryServiceDescription();

  String get serviceName => ServiceRegistry.serviceName;

  @override
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
    return "_ServiceRegistryProxyControl($superString)";
  }
}


class ServiceRegistryProxy extends bindings.Proxy
                              implements ServiceRegistry {
  ServiceRegistryProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _ServiceRegistryProxyControl.fromEndpoint(endpoint));

  ServiceRegistryProxy.fromHandle(core.MojoHandle handle)
      : super(new _ServiceRegistryProxyControl.fromHandle(handle));

  ServiceRegistryProxy.unbound()
      : super(new _ServiceRegistryProxyControl.unbound());

  static ServiceRegistryProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ServiceRegistryProxy"));
    return new ServiceRegistryProxy.fromEndpoint(endpoint);
  }

  factory ServiceRegistryProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ServiceRegistryProxy p = new ServiceRegistryProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void addServices(List<String> interfaceNames, Object serviceProvider) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ServiceRegistryAddServicesParams();
    params.interfaceNames = interfaceNames;
    params.serviceProvider = serviceProvider;
    ctrl.sendMessage(params,
        _serviceRegistryMethodAddServicesName);
  }
}


class ServiceRegistryStub extends bindings.Stub {
  ServiceRegistry _impl;

  ServiceRegistryStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ServiceRegistry impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  ServiceRegistryStub.fromHandle(
      core.MojoHandle handle, [ServiceRegistry impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  ServiceRegistryStub.unbound([this._impl]) : super.unbound();

  static ServiceRegistryStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ServiceRegistryStub"));
    return new ServiceRegistryStub.fromEndpoint(endpoint);
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
      case _serviceRegistryMethodAddServicesName:
        var params = _ServiceRegistryAddServicesParams.deserialize(
            message.payload);
        _impl.addServices(params.interfaceNames, params.serviceProvider);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ServiceRegistry get impl => _impl;
  set impl(ServiceRegistry d) {
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

  String toString() {
    var superString = super.toString();
    return "ServiceRegistryStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ServiceRegistryServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



