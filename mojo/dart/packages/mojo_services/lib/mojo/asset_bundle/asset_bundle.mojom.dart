// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library asset_bundle_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _AssetBundleGetAsStreamParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String assetName = null;

  _AssetBundleGetAsStreamParams() : super(kVersions.last.size);

  static _AssetBundleGetAsStreamParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AssetBundleGetAsStreamParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AssetBundleGetAsStreamParams result = new _AssetBundleGetAsStreamParams();

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
      
      result.assetName = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(assetName, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "assetName of struct _AssetBundleGetAsStreamParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_AssetBundleGetAsStreamParams("
           "assetName: $assetName" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["assetName"] = assetName;
    return map;
  }
}


class AssetBundleGetAsStreamResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoDataPipeConsumer assetData = null;

  AssetBundleGetAsStreamResponseParams() : super(kVersions.last.size);

  static AssetBundleGetAsStreamResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AssetBundleGetAsStreamResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AssetBundleGetAsStreamResponseParams result = new AssetBundleGetAsStreamResponseParams();

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
      
      result.assetData = decoder0.decodeConsumerHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeConsumerHandle(assetData, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "assetData of struct AssetBundleGetAsStreamResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "AssetBundleGetAsStreamResponseParams("
           "assetData: $assetData" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _AssetUnpackerUnpackZipStreamParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  core.MojoDataPipeConsumer zippedAssets = null;
  AssetBundleInterfaceRequest assetBundle = null;

  _AssetUnpackerUnpackZipStreamParams() : super(kVersions.last.size);

  static _AssetUnpackerUnpackZipStreamParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AssetUnpackerUnpackZipStreamParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AssetUnpackerUnpackZipStreamParams result = new _AssetUnpackerUnpackZipStreamParams();

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
      
      result.zippedAssets = decoder0.decodeConsumerHandle(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.assetBundle = decoder0.decodeInterfaceRequest(12, false, AssetBundleStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeConsumerHandle(zippedAssets, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "zippedAssets of struct _AssetUnpackerUnpackZipStreamParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(assetBundle, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "assetBundle of struct _AssetUnpackerUnpackZipStreamParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_AssetUnpackerUnpackZipStreamParams("
           "zippedAssets: $zippedAssets" ", "
           "assetBundle: $assetBundle" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _assetBundleMethodGetAsStreamName = 0;

class _AssetBundleServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class AssetBundle {
  static const String serviceName = "mojo::asset_bundle::AssetBundle";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _AssetBundleServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static AssetBundleProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    AssetBundleProxy p = new AssetBundleProxy.unbound();
    String name = serviceName ?? AssetBundle.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic getAsStream(String assetName,[Function responseFactory = null]);
}

abstract class AssetBundleInterface
    implements bindings.MojoInterface<AssetBundle>,
               AssetBundle {
  factory AssetBundleInterface([AssetBundle impl]) =>
      new AssetBundleStub.unbound(impl);
  factory AssetBundleInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [AssetBundle impl]) =>
      new AssetBundleStub.fromEndpoint(endpoint, impl);
}

abstract class AssetBundleInterfaceRequest
    implements bindings.MojoInterface<AssetBundle>,
               AssetBundle {
  factory AssetBundleInterfaceRequest() =>
      new AssetBundleProxy.unbound();
}

class _AssetBundleProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<AssetBundle> {
  _AssetBundleProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _AssetBundleProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _AssetBundleProxyControl.unbound() : super.unbound();

  String get serviceName => AssetBundle.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _assetBundleMethodGetAsStreamName:
        var r = AssetBundleGetAsStreamResponseParams.deserialize(
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

  AssetBundle get impl => null;
  set impl(AssetBundle _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_AssetBundleProxyControl($superString)";
  }
}

class AssetBundleProxy
    extends bindings.Proxy<AssetBundle>
    implements AssetBundle,
               AssetBundleInterface,
               AssetBundleInterfaceRequest {
  AssetBundleProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _AssetBundleProxyControl.fromEndpoint(endpoint));

  AssetBundleProxy.fromHandle(core.MojoHandle handle)
      : super(new _AssetBundleProxyControl.fromHandle(handle));

  AssetBundleProxy.unbound()
      : super(new _AssetBundleProxyControl.unbound());

  static AssetBundleProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AssetBundleProxy"));
    return new AssetBundleProxy.fromEndpoint(endpoint);
  }


  dynamic getAsStream(String assetName,[Function responseFactory = null]) {
    var params = new _AssetBundleGetAsStreamParams();
    params.assetName = assetName;
    return ctrl.sendMessageWithRequestId(
        params,
        _assetBundleMethodGetAsStreamName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _AssetBundleStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<AssetBundle> {
  AssetBundle _impl;

  _AssetBundleStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [AssetBundle impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _AssetBundleStubControl.fromHandle(
      core.MojoHandle handle, [AssetBundle impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _AssetBundleStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => AssetBundle.serviceName;


  AssetBundleGetAsStreamResponseParams _assetBundleGetAsStreamResponseParamsFactory(core.MojoDataPipeConsumer assetData) {
    var result = new AssetBundleGetAsStreamResponseParams();
    result.assetData = assetData;
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
      case _assetBundleMethodGetAsStreamName:
        var params = _AssetBundleGetAsStreamParams.deserialize(
            message.payload);
        var response = _impl.getAsStream(params.assetName,_assetBundleGetAsStreamResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _assetBundleMethodGetAsStreamName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _assetBundleMethodGetAsStreamName,
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

  AssetBundle get impl => _impl;
  set impl(AssetBundle d) {
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
    return "_AssetBundleStubControl($superString)";
  }

  int get version => 0;
}

class AssetBundleStub
    extends bindings.Stub<AssetBundle>
    implements AssetBundle,
               AssetBundleInterface,
               AssetBundleInterfaceRequest {
  AssetBundleStub.unbound([AssetBundle impl])
      : super(new _AssetBundleStubControl.unbound(impl));

  AssetBundleStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [AssetBundle impl])
      : super(new _AssetBundleStubControl.fromEndpoint(endpoint, impl));

  AssetBundleStub.fromHandle(
      core.MojoHandle handle, [AssetBundle impl])
      : super(new _AssetBundleStubControl.fromHandle(handle, impl));

  static AssetBundleStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AssetBundleStub"));
    return new AssetBundleStub.fromEndpoint(endpoint);
  }


  dynamic getAsStream(String assetName,[Function responseFactory = null]) {
    return impl.getAsStream(assetName,responseFactory);
  }
}

const int _assetUnpackerMethodUnpackZipStreamName = 0;

class _AssetUnpackerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class AssetUnpacker {
  static const String serviceName = "mojo::asset_bundle::AssetUnpacker";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _AssetUnpackerServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static AssetUnpackerProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    AssetUnpackerProxy p = new AssetUnpackerProxy.unbound();
    String name = serviceName ?? AssetUnpacker.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void unpackZipStream(core.MojoDataPipeConsumer zippedAssets, AssetBundleInterfaceRequest assetBundle);
}

abstract class AssetUnpackerInterface
    implements bindings.MojoInterface<AssetUnpacker>,
               AssetUnpacker {
  factory AssetUnpackerInterface([AssetUnpacker impl]) =>
      new AssetUnpackerStub.unbound(impl);
  factory AssetUnpackerInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [AssetUnpacker impl]) =>
      new AssetUnpackerStub.fromEndpoint(endpoint, impl);
}

abstract class AssetUnpackerInterfaceRequest
    implements bindings.MojoInterface<AssetUnpacker>,
               AssetUnpacker {
  factory AssetUnpackerInterfaceRequest() =>
      new AssetUnpackerProxy.unbound();
}

class _AssetUnpackerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<AssetUnpacker> {
  _AssetUnpackerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _AssetUnpackerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _AssetUnpackerProxyControl.unbound() : super.unbound();

  String get serviceName => AssetUnpacker.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  AssetUnpacker get impl => null;
  set impl(AssetUnpacker _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_AssetUnpackerProxyControl($superString)";
  }
}

class AssetUnpackerProxy
    extends bindings.Proxy<AssetUnpacker>
    implements AssetUnpacker,
               AssetUnpackerInterface,
               AssetUnpackerInterfaceRequest {
  AssetUnpackerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _AssetUnpackerProxyControl.fromEndpoint(endpoint));

  AssetUnpackerProxy.fromHandle(core.MojoHandle handle)
      : super(new _AssetUnpackerProxyControl.fromHandle(handle));

  AssetUnpackerProxy.unbound()
      : super(new _AssetUnpackerProxyControl.unbound());

  static AssetUnpackerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AssetUnpackerProxy"));
    return new AssetUnpackerProxy.fromEndpoint(endpoint);
  }


  void unpackZipStream(core.MojoDataPipeConsumer zippedAssets, AssetBundleInterfaceRequest assetBundle) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _AssetUnpackerUnpackZipStreamParams();
    params.zippedAssets = zippedAssets;
    params.assetBundle = assetBundle;
    ctrl.sendMessage(params,
        _assetUnpackerMethodUnpackZipStreamName);
  }
}

class _AssetUnpackerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<AssetUnpacker> {
  AssetUnpacker _impl;

  _AssetUnpackerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [AssetUnpacker impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _AssetUnpackerStubControl.fromHandle(
      core.MojoHandle handle, [AssetUnpacker impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _AssetUnpackerStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => AssetUnpacker.serviceName;



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
      case _assetUnpackerMethodUnpackZipStreamName:
        var params = _AssetUnpackerUnpackZipStreamParams.deserialize(
            message.payload);
        _impl.unpackZipStream(params.zippedAssets, params.assetBundle);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  AssetUnpacker get impl => _impl;
  set impl(AssetUnpacker d) {
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
    return "_AssetUnpackerStubControl($superString)";
  }

  int get version => 0;
}

class AssetUnpackerStub
    extends bindings.Stub<AssetUnpacker>
    implements AssetUnpacker,
               AssetUnpackerInterface,
               AssetUnpackerInterfaceRequest {
  AssetUnpackerStub.unbound([AssetUnpacker impl])
      : super(new _AssetUnpackerStubControl.unbound(impl));

  AssetUnpackerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [AssetUnpacker impl])
      : super(new _AssetUnpackerStubControl.fromEndpoint(endpoint, impl));

  AssetUnpackerStub.fromHandle(
      core.MojoHandle handle, [AssetUnpacker impl])
      : super(new _AssetUnpackerStubControl.fromHandle(handle, impl));

  static AssetUnpackerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AssetUnpackerStub"));
    return new AssetUnpackerStub.fromEndpoint(endpoint);
  }


  void unpackZipStream(core.MojoDataPipeConsumer zippedAssets, AssetBundleInterfaceRequest assetBundle) {
    return impl.unpackZipStream(zippedAssets, assetBundle);
  }
}



