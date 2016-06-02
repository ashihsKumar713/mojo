// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library location_service_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/location.mojom.dart' as location_mojom;



class _LocationServiceGetNextLocationParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  LocationServiceUpdatePriority priority = null;

  _LocationServiceGetNextLocationParams() : super(kVersions.last.size);

  static _LocationServiceGetNextLocationParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _LocationServiceGetNextLocationParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _LocationServiceGetNextLocationParams result = new _LocationServiceGetNextLocationParams();

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
      
        result.priority = LocationServiceUpdatePriority.decode(decoder0, 8);
        if (result.priority == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable LocationServiceUpdatePriority.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(priority, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "priority of struct _LocationServiceGetNextLocationParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_LocationServiceGetNextLocationParams("
           "priority: $priority" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["priority"] = priority;
    return map;
  }
}


class LocationServiceGetNextLocationResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  location_mojom.Location location = null;

  LocationServiceGetNextLocationResponseParams() : super(kVersions.last.size);

  static LocationServiceGetNextLocationResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static LocationServiceGetNextLocationResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    LocationServiceGetNextLocationResponseParams result = new LocationServiceGetNextLocationResponseParams();

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
      result.location = location_mojom.Location.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(location, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "location of struct LocationServiceGetNextLocationResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "LocationServiceGetNextLocationResponseParams("
           "location: $location" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["location"] = location;
    return map;
  }
}

const int _locationServiceMethodGetNextLocationName = 0;
  
class LocationServiceUpdatePriority extends bindings.MojoEnum {
  static const LocationServiceUpdatePriority priorityBalancedPowerAccuracy = const LocationServiceUpdatePriority._(0);
  static const LocationServiceUpdatePriority priorityHighAccuracy = const LocationServiceUpdatePriority._(1);
  static const LocationServiceUpdatePriority priorityLowPower = const LocationServiceUpdatePriority._(2);
  static const LocationServiceUpdatePriority priorityNoPower = const LocationServiceUpdatePriority._(3);

  const LocationServiceUpdatePriority._(int v) : super(v);

  static const Map<String, LocationServiceUpdatePriority> valuesMap = const {
    "priorityBalancedPowerAccuracy": priorityBalancedPowerAccuracy,
    "priorityHighAccuracy": priorityHighAccuracy,
    "priorityLowPower": priorityLowPower,
    "priorityNoPower": priorityNoPower,
  };
  static const List<LocationServiceUpdatePriority> values = const [
    priorityBalancedPowerAccuracy,
    priorityHighAccuracy,
    priorityLowPower,
    priorityNoPower,
  ];

  static LocationServiceUpdatePriority valueOf(String name) => valuesMap[name];

  factory LocationServiceUpdatePriority(int v) {
    switch (v) {
      case 0:
        return LocationServiceUpdatePriority.priorityBalancedPowerAccuracy;
      case 1:
        return LocationServiceUpdatePriority.priorityHighAccuracy;
      case 2:
        return LocationServiceUpdatePriority.priorityLowPower;
      case 3:
        return LocationServiceUpdatePriority.priorityNoPower;
      default:
        return null;
    }
  }

  static LocationServiceUpdatePriority decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    LocationServiceUpdatePriority result = new LocationServiceUpdatePriority(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum LocationServiceUpdatePriority.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case priorityBalancedPowerAccuracy:
        return 'LocationServiceUpdatePriority.priorityBalancedPowerAccuracy';
      case priorityHighAccuracy:
        return 'LocationServiceUpdatePriority.priorityHighAccuracy';
      case priorityLowPower:
        return 'LocationServiceUpdatePriority.priorityLowPower';
      case priorityNoPower:
        return 'LocationServiceUpdatePriority.priorityNoPower';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class _LocationServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class LocationService {
  static const String serviceName = "mojo::LocationService";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _LocationServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static LocationServiceProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    LocationServiceProxy p = new LocationServiceProxy.unbound();
    String name = serviceName ?? LocationService.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic getNextLocation(LocationServiceUpdatePriority priority,[Function responseFactory = null]);
}

abstract class LocationServiceInterface
    implements bindings.MojoInterface<LocationService>,
               LocationService {
  factory LocationServiceInterface([LocationService impl]) =>
      new LocationServiceStub.unbound(impl);

  factory LocationServiceInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [LocationService impl]) =>
      new LocationServiceStub.fromEndpoint(endpoint, impl);

  factory LocationServiceInterface.fromMock(
      LocationService mock) =>
      new LocationServiceProxy.fromMock(mock);
}

abstract class LocationServiceInterfaceRequest
    implements bindings.MojoInterface<LocationService>,
               LocationService {
  factory LocationServiceInterfaceRequest() =>
      new LocationServiceProxy.unbound();
}

class _LocationServiceProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<LocationService> {
  LocationService impl;

  _LocationServiceProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _LocationServiceProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _LocationServiceProxyControl.unbound() : super.unbound();

  String get serviceName => LocationService.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _locationServiceMethodGetNextLocationName:
        var r = LocationServiceGetNextLocationResponseParams.deserialize(
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
    return "_LocationServiceProxyControl($superString)";
  }
}

class LocationServiceProxy
    extends bindings.Proxy<LocationService>
    implements LocationService,
               LocationServiceInterface,
               LocationServiceInterfaceRequest {
  LocationServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _LocationServiceProxyControl.fromEndpoint(endpoint));

  LocationServiceProxy.fromHandle(core.MojoHandle handle)
      : super(new _LocationServiceProxyControl.fromHandle(handle));

  LocationServiceProxy.unbound()
      : super(new _LocationServiceProxyControl.unbound());

  factory LocationServiceProxy.fromMock(LocationService mock) {
    LocationServiceProxy newMockedProxy =
        new LocationServiceProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static LocationServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For LocationServiceProxy"));
    return new LocationServiceProxy.fromEndpoint(endpoint);
  }


  dynamic getNextLocation(LocationServiceUpdatePriority priority,[Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.getNextLocation(priority,_LocationServiceStubControl._locationServiceGetNextLocationResponseParamsFactory));
    }
    var params = new _LocationServiceGetNextLocationParams();
    params.priority = priority;
    return ctrl.sendMessageWithRequestId(
        params,
        _locationServiceMethodGetNextLocationName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _LocationServiceStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<LocationService> {
  LocationService _impl;

  _LocationServiceStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [LocationService impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _LocationServiceStubControl.fromHandle(
      core.MojoHandle handle, [LocationService impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _LocationServiceStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => LocationService.serviceName;


  static LocationServiceGetNextLocationResponseParams _locationServiceGetNextLocationResponseParamsFactory(location_mojom.Location location) {
    var result = new LocationServiceGetNextLocationResponseParams();
    result.location = location;
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
      case _locationServiceMethodGetNextLocationName:
        var params = _LocationServiceGetNextLocationParams.deserialize(
            message.payload);
        var response = _impl.getNextLocation(params.priority,_locationServiceGetNextLocationResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _locationServiceMethodGetNextLocationName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _locationServiceMethodGetNextLocationName,
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

  LocationService get impl => _impl;
  set impl(LocationService d) {
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
    return "_LocationServiceStubControl($superString)";
  }

  int get version => 0;
}

class LocationServiceStub
    extends bindings.Stub<LocationService>
    implements LocationService,
               LocationServiceInterface,
               LocationServiceInterfaceRequest {
  LocationServiceStub.unbound([LocationService impl])
      : super(new _LocationServiceStubControl.unbound(impl));

  LocationServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [LocationService impl])
      : super(new _LocationServiceStubControl.fromEndpoint(endpoint, impl));

  LocationServiceStub.fromHandle(
      core.MojoHandle handle, [LocationService impl])
      : super(new _LocationServiceStubControl.fromHandle(handle, impl));

  static LocationServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For LocationServiceStub"));
    return new LocationServiceStub.fromEndpoint(endpoint);
  }


  dynamic getNextLocation(LocationServiceUpdatePriority priority,[Function responseFactory = null]) {
    return impl.getNextLocation(priority,responseFactory);
  }
}



