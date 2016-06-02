// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library echo_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _EchoEchoStringParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  _EchoEchoStringParams() : super(kVersions.last.size);

  static _EchoEchoStringParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _EchoEchoStringParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _EchoEchoStringParams result = new _EchoEchoStringParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(value, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct _EchoEchoStringParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_EchoEchoStringParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class EchoEchoStringResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String value = null;

  EchoEchoStringResponseParams() : super(kVersions.last.size);

  static EchoEchoStringResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static EchoEchoStringResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    EchoEchoStringResponseParams result = new EchoEchoStringResponseParams();

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
      
      result.value = decoder0.decodeString(8, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(value, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct EchoEchoStringResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "EchoEchoStringResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}

const int _echoMethodEchoStringName = 0;

class _EchoServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]){
    var interfaceTypeKey = getRuntimeTypeInfo().services["mojo::examples::Echo"];
    var userDefinedType = getAllMojomTypeDefinitions()[interfaceTypeKey];
    return responseFactory(userDefinedType.interfaceType);
  }

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions()[typeKey]);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions());
}

abstract class Echo {
  static const String serviceName = "mojo::examples::Echo";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _EchoServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static EchoProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    EchoProxy p = new EchoProxy.unbound();
    String name = serviceName ?? Echo.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic echoString(String value,[Function responseFactory = null]);
}

abstract class EchoInterface
    implements bindings.MojoInterface<Echo>,
               Echo {
  factory EchoInterface([Echo impl]) =>
      new EchoStub.unbound(impl);

  factory EchoInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [Echo impl]) =>
      new EchoStub.fromEndpoint(endpoint, impl);

  factory EchoInterface.fromMock(
      Echo mock) =>
      new EchoProxy.fromMock(mock);
}

abstract class EchoInterfaceRequest
    implements bindings.MojoInterface<Echo>,
               Echo {
  factory EchoInterfaceRequest() =>
      new EchoProxy.unbound();
}

class _EchoProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<Echo> {
  Echo impl;

  _EchoProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _EchoProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _EchoProxyControl.unbound() : super.unbound();

  String get serviceName => Echo.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _echoMethodEchoStringName:
        var r = EchoEchoStringResponseParams.deserialize(
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
    return "_EchoProxyControl($superString)";
  }
}

class EchoProxy
    extends bindings.Proxy<Echo>
    implements Echo,
               EchoInterface,
               EchoInterfaceRequest {
  EchoProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _EchoProxyControl.fromEndpoint(endpoint));

  EchoProxy.fromHandle(core.MojoHandle handle)
      : super(new _EchoProxyControl.fromHandle(handle));

  EchoProxy.unbound()
      : super(new _EchoProxyControl.unbound());

  factory EchoProxy.fromMock(Echo mock) {
    EchoProxy newMockedProxy =
        new EchoProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static EchoProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For EchoProxy"));
    return new EchoProxy.fromEndpoint(endpoint);
  }


  dynamic echoString(String value,[Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.echoString(value,_EchoStubControl._echoEchoStringResponseParamsFactory));
    }
    var params = new _EchoEchoStringParams();
    params.value = value;
    return ctrl.sendMessageWithRequestId(
        params,
        _echoMethodEchoStringName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _EchoStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<Echo> {
  Echo _impl;

  _EchoStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Echo impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _EchoStubControl.fromHandle(
      core.MojoHandle handle, [Echo impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _EchoStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => Echo.serviceName;


  static EchoEchoStringResponseParams _echoEchoStringResponseParamsFactory(String value) {
    var result = new EchoEchoStringResponseParams();
    result.value = value;
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
      case _echoMethodEchoStringName:
        var params = _EchoEchoStringParams.deserialize(
            message.payload);
        var response = _impl.echoString(params.value,_echoEchoStringResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _echoMethodEchoStringName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _echoMethodEchoStringName,
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

  Echo get impl => _impl;
  set impl(Echo d) {
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
    return "_EchoStubControl($superString)";
  }

  int get version => 0;
}

class EchoStub
    extends bindings.Stub<Echo>
    implements Echo,
               EchoInterface,
               EchoInterfaceRequest {
  EchoStub.unbound([Echo impl])
      : super(new _EchoStubControl.unbound(impl));

  EchoStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Echo impl])
      : super(new _EchoStubControl.fromEndpoint(endpoint, impl));

  EchoStub.fromHandle(
      core.MojoHandle handle, [Echo impl])
      : super(new _EchoStubControl.fromHandle(handle, impl));

  static EchoStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For EchoStub"));
    return new EchoStub.fromEndpoint(endpoint);
  }


  dynamic echoString(String value,[Function responseFactory = null]) {
    return impl.echoString(value,responseFactory);
  }
}


mojom_types.RuntimeTypeInfo getRuntimeTypeInfo() => _runtimeTypeInfo ??
    _initRuntimeTypeInfo();

Map<String, mojom_types.UserDefinedType> getAllMojomTypeDefinitions() {
  return getRuntimeTypeInfo().typeMap;
}

var _runtimeTypeInfo;
mojom_types.RuntimeTypeInfo  _initRuntimeTypeInfo() {
  // serializedRuntimeTypeInfo contains the bytes of the Mojo serialization of
  // a mojom_types.RuntimeTypeInfo struct describing the Mojom types in this
  // file. The string contains the base64 encoding of the gzip-compressed bytes.
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/5JggAABKN0BpdHFLZD4jEDMAeXLALEIEOfmZ+VbWaVWJOYW5KQWW1m5JmfkY1OvDMTSQBwSGeAa7+0aaQXSqAfTpwfThmG/Aw77STGPEaqfGUm/BpRWgNIBjBA6A0ozoNkPC4cZUHoBlP4PBRsYsAN0dytgCWd2JHFhIOYG4uDUorLM5FS/xNxUosKbB4hZgBjGlwJiIah6LMGCEc6cQMwFxC5AbAPE+qXFRfo5+cmJOfrp+fnpOan6Gfm5qfpVRYn6ICP1i4uS9WHG6qcCjQUTeiC5XGLci24/jM8DDS9c4Ycebxeg9AMm7PEGAwZofFCcYROHASFoeIDcG1xSlJmXjj3cQGqYqBhu6OkD5r8bjMT7CwQscPgLli4Q/tItSi0sTS0uwe4/GKCW/9Dj0wFHOXODgThAbDxr4NDPC8SsQFyWmFOaiiN+RansfwakNI4eHhJIbmNEUk/rdCENLXtQ0kVxQX5ecepousCRLjQGQboABAAA///YBJ9/yAcAAA==";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
