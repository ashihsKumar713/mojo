// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library device_info_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _DeviceInfoGetDeviceTypeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _DeviceInfoGetDeviceTypeParams() : super(kVersions.last.size);

  static _DeviceInfoGetDeviceTypeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _DeviceInfoGetDeviceTypeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _DeviceInfoGetDeviceTypeParams result = new _DeviceInfoGetDeviceTypeParams();

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
    return "_DeviceInfoGetDeviceTypeParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class DeviceInfoGetDeviceTypeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  DeviceInfoDeviceType deviceType = null;

  DeviceInfoGetDeviceTypeResponseParams() : super(kVersions.last.size);

  static DeviceInfoGetDeviceTypeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static DeviceInfoGetDeviceTypeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    DeviceInfoGetDeviceTypeResponseParams result = new DeviceInfoGetDeviceTypeResponseParams();

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
      
        result.deviceType = DeviceInfoDeviceType.decode(decoder0, 8);
        if (result.deviceType == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable DeviceInfoDeviceType.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(deviceType, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "deviceType of struct DeviceInfoGetDeviceTypeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "DeviceInfoGetDeviceTypeResponseParams("
           "deviceType: $deviceType" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["deviceType"] = deviceType;
    return map;
  }
}

const int _deviceInfoMethodGetDeviceTypeName = 0;
  
class DeviceInfoDeviceType extends bindings.MojoEnum {
  static const DeviceInfoDeviceType unknown = const DeviceInfoDeviceType._(0);
  static const DeviceInfoDeviceType headless = const DeviceInfoDeviceType._(1);
  static const DeviceInfoDeviceType watch = const DeviceInfoDeviceType._(2);
  static const DeviceInfoDeviceType phone = const DeviceInfoDeviceType._(3);
  static const DeviceInfoDeviceType tablet = const DeviceInfoDeviceType._(4);
  static const DeviceInfoDeviceType desktop = const DeviceInfoDeviceType._(5);
  static const DeviceInfoDeviceType tv = const DeviceInfoDeviceType._(6);

  const DeviceInfoDeviceType._(int v) : super(v);

  static const Map<String, DeviceInfoDeviceType> valuesMap = const {
    "unknown": unknown,
    "headless": headless,
    "watch": watch,
    "phone": phone,
    "tablet": tablet,
    "desktop": desktop,
    "tv": tv,
  };
  static const List<DeviceInfoDeviceType> values = const [
    unknown,
    headless,
    watch,
    phone,
    tablet,
    desktop,
    tv,
  ];

  static DeviceInfoDeviceType valueOf(String name) => valuesMap[name];

  factory DeviceInfoDeviceType(int v) {
    switch (v) {
      case 0:
        return DeviceInfoDeviceType.unknown;
      case 1:
        return DeviceInfoDeviceType.headless;
      case 2:
        return DeviceInfoDeviceType.watch;
      case 3:
        return DeviceInfoDeviceType.phone;
      case 4:
        return DeviceInfoDeviceType.tablet;
      case 5:
        return DeviceInfoDeviceType.desktop;
      case 6:
        return DeviceInfoDeviceType.tv;
      default:
        return null;
    }
  }

  static DeviceInfoDeviceType decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    DeviceInfoDeviceType result = new DeviceInfoDeviceType(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum DeviceInfoDeviceType.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case unknown:
        return 'DeviceInfoDeviceType.unknown';
      case headless:
        return 'DeviceInfoDeviceType.headless';
      case watch:
        return 'DeviceInfoDeviceType.watch';
      case phone:
        return 'DeviceInfoDeviceType.phone';
      case tablet:
        return 'DeviceInfoDeviceType.tablet';
      case desktop:
        return 'DeviceInfoDeviceType.desktop';
      case tv:
        return 'DeviceInfoDeviceType.tv';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class _DeviceInfoServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class DeviceInfo {
  static const String serviceName = "mojo::DeviceInfo";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _DeviceInfoServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static DeviceInfoProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    DeviceInfoProxy p = new DeviceInfoProxy.unbound();
    String name = serviceName ?? DeviceInfo.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic getDeviceType([Function responseFactory = null]);
}

abstract class DeviceInfoInterface
    implements bindings.MojoInterface<DeviceInfo>,
               DeviceInfo {
  factory DeviceInfoInterface([DeviceInfo impl]) =>
      new DeviceInfoStub.unbound(impl);

  factory DeviceInfoInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [DeviceInfo impl]) =>
      new DeviceInfoStub.fromEndpoint(endpoint, impl);

  factory DeviceInfoInterface.fromMock(
      DeviceInfo mock) =>
      new DeviceInfoProxy.fromMock(mock);
}

abstract class DeviceInfoInterfaceRequest
    implements bindings.MojoInterface<DeviceInfo>,
               DeviceInfo {
  factory DeviceInfoInterfaceRequest() =>
      new DeviceInfoProxy.unbound();
}

class _DeviceInfoProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<DeviceInfo> {
  DeviceInfo impl;

  _DeviceInfoProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _DeviceInfoProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _DeviceInfoProxyControl.unbound() : super.unbound();

  String get serviceName => DeviceInfo.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _deviceInfoMethodGetDeviceTypeName:
        var r = DeviceInfoGetDeviceTypeResponseParams.deserialize(
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
    return "_DeviceInfoProxyControl($superString)";
  }
}

class DeviceInfoProxy
    extends bindings.Proxy<DeviceInfo>
    implements DeviceInfo,
               DeviceInfoInterface,
               DeviceInfoInterfaceRequest {
  DeviceInfoProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _DeviceInfoProxyControl.fromEndpoint(endpoint));

  DeviceInfoProxy.fromHandle(core.MojoHandle handle)
      : super(new _DeviceInfoProxyControl.fromHandle(handle));

  DeviceInfoProxy.unbound()
      : super(new _DeviceInfoProxyControl.unbound());

  factory DeviceInfoProxy.fromMock(DeviceInfo mock) {
    DeviceInfoProxy newMockedProxy =
        new DeviceInfoProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static DeviceInfoProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DeviceInfoProxy"));
    return new DeviceInfoProxy.fromEndpoint(endpoint);
  }


  dynamic getDeviceType([Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.getDeviceType(_DeviceInfoStubControl._deviceInfoGetDeviceTypeResponseParamsFactory));
    }
    var params = new _DeviceInfoGetDeviceTypeParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _deviceInfoMethodGetDeviceTypeName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _DeviceInfoStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<DeviceInfo> {
  DeviceInfo _impl;

  _DeviceInfoStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [DeviceInfo impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _DeviceInfoStubControl.fromHandle(
      core.MojoHandle handle, [DeviceInfo impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _DeviceInfoStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => DeviceInfo.serviceName;


  static DeviceInfoGetDeviceTypeResponseParams _deviceInfoGetDeviceTypeResponseParamsFactory(DeviceInfoDeviceType deviceType) {
    var result = new DeviceInfoGetDeviceTypeResponseParams();
    result.deviceType = deviceType;
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
      case _deviceInfoMethodGetDeviceTypeName:
        var response = _impl.getDeviceType(_deviceInfoGetDeviceTypeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _deviceInfoMethodGetDeviceTypeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _deviceInfoMethodGetDeviceTypeName,
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

  DeviceInfo get impl => _impl;
  set impl(DeviceInfo d) {
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
    return "_DeviceInfoStubControl($superString)";
  }

  int get version => 0;
}

class DeviceInfoStub
    extends bindings.Stub<DeviceInfo>
    implements DeviceInfo,
               DeviceInfoInterface,
               DeviceInfoInterfaceRequest {
  DeviceInfoStub.unbound([DeviceInfo impl])
      : super(new _DeviceInfoStubControl.unbound(impl));

  DeviceInfoStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [DeviceInfo impl])
      : super(new _DeviceInfoStubControl.fromEndpoint(endpoint, impl));

  DeviceInfoStub.fromHandle(
      core.MojoHandle handle, [DeviceInfo impl])
      : super(new _DeviceInfoStubControl.fromHandle(handle, impl));

  static DeviceInfoStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For DeviceInfoStub"));
    return new DeviceInfoStub.fromEndpoint(endpoint);
  }


  dynamic getDeviceType([Function responseFactory = null]) {
    return impl.getDeviceType(responseFactory);
  }
}



