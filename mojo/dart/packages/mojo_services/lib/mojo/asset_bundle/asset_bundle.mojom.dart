// WARNING: DO NOT EDIT. This file was generated by a program.
// See $MOJO_SDK/tools/bindings/mojom_bindings_generator.py.

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

  _AssetBundleGetAsStreamParams.init(
    String this.assetName
  ) : super(kVersions.last.size);

  static _AssetBundleGetAsStreamParams deserialize(bindings.Message message) =>
      bindings.Struct.deserialize(decode, message);

  static _AssetBundleGetAsStreamParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AssetBundleGetAsStreamParams result = new _AssetBundleGetAsStreamParams();
    var mainDataHeader = bindings.Struct.checkVersion(decoder0, kVersions);
    if (mainDataHeader.version >= 0) {
      
      result.assetName = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    const String structName = "_AssetBundleGetAsStreamParams";
    String fieldName;
    try {
      fieldName = "assetName";
      encoder0.encodeString(assetName, 8, false);
    } on bindings.MojoCodecError catch(e) {
      bindings.Struct.fixErrorMessage(e, fieldName, structName);
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

  AssetBundleGetAsStreamResponseParams.init(
    core.MojoDataPipeConsumer this.assetData
  ) : super(kVersions.last.size);

  static AssetBundleGetAsStreamResponseParams deserialize(bindings.Message message) =>
      bindings.Struct.deserialize(decode, message);

  static AssetBundleGetAsStreamResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AssetBundleGetAsStreamResponseParams result = new AssetBundleGetAsStreamResponseParams();
    var mainDataHeader = bindings.Struct.checkVersion(decoder0, kVersions);
    if (mainDataHeader.version >= 0) {
      
      result.assetData = decoder0.decodeConsumerHandle(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    const String structName = "AssetBundleGetAsStreamResponseParams";
    String fieldName;
    try {
      fieldName = "assetData";
      encoder0.encodeConsumerHandle(assetData, 8, false);
    } on bindings.MojoCodecError catch(e) {
      bindings.Struct.fixErrorMessage(e, fieldName, structName);
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

  _AssetUnpackerUnpackZipStreamParams.init(
    core.MojoDataPipeConsumer this.zippedAssets, 
    AssetBundleInterfaceRequest this.assetBundle
  ) : super(kVersions.last.size);

  static _AssetUnpackerUnpackZipStreamParams deserialize(bindings.Message message) =>
      bindings.Struct.deserialize(decode, message);

  static _AssetUnpackerUnpackZipStreamParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AssetUnpackerUnpackZipStreamParams result = new _AssetUnpackerUnpackZipStreamParams();
    var mainDataHeader = bindings.Struct.checkVersion(decoder0, kVersions);
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
    const String structName = "_AssetUnpackerUnpackZipStreamParams";
    String fieldName;
    try {
      fieldName = "zippedAssets";
      encoder0.encodeConsumerHandle(zippedAssets, 8, false);
      fieldName = "assetBundle";
      encoder0.encodeInterfaceRequest(assetBundle, 12, false);
    } on bindings.MojoCodecError catch(e) {
      bindings.Struct.fixErrorMessage(e, fieldName, structName);
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
  void getTopLevelInterface(Function responder) {
    responder(null);
  }

  void getTypeDefinition(String typeKey, Function responder) {
    responder(null);
  }

  void getAllTypeDefinitions(Function responder) {
    responder(null);
  }
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
  void getAsStream(String assetName,void callback(core.MojoDataPipeConsumer assetData));
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

  factory AssetBundleInterface.fromMock(
      AssetBundle mock) =>
      new AssetBundleProxy.fromMock(mock);
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
  AssetBundle impl;

  _AssetBundleProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _AssetBundleProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _AssetBundleProxyControl.unbound() : super.unbound();

  String get serviceName => AssetBundle.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _assetBundleMethodGetAsStreamName:
        Function callback = getCallback(message);
        if (callback != null) {
          var r = AssetBundleGetAsStreamResponseParams.deserialize(
              message.payload);
          callback(r.assetData );
        }
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

  factory AssetBundleProxy.fromMock(AssetBundle mock) {
    AssetBundleProxy newMockedProxy =
        new AssetBundleProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static AssetBundleProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AssetBundleProxy"));
    return new AssetBundleProxy.fromEndpoint(endpoint);
  }


  void getAsStream(String assetName,void callback(core.MojoDataPipeConsumer assetData)) {
    if (impl != null) {
      impl.getAsStream(assetName,callback ?? bindings.DoNothingFunction.fn);
      return;
    }
    var params = new _AssetBundleGetAsStreamParams();
    params.assetName = assetName;
    Function zonedCallback;
    if ((callback == null) || identical(Zone.current, Zone.ROOT)) {
      zonedCallback = callback;
    } else {
      Zone z = Zone.current;
      zonedCallback = ((core.MojoDataPipeConsumer assetData) {
        z.bindCallback(() {
          callback(assetData);
        })();
      });
    }
    ctrl.sendMessageWithRequestId(
        params,
        _assetBundleMethodGetAsStreamName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse,
        zonedCallback);
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


  Function _assetBundleGetAsStreamResponseParamsResponder(
      int requestId) {
  return (core.MojoDataPipeConsumer assetData) {
      var result = new AssetBundleGetAsStreamResponseParams();
      result.assetData = assetData;
      sendResponse(buildResponseWithId(
          result,
          _assetBundleMethodGetAsStreamName,
          requestId,
          bindings.MessageHeader.kMessageIsResponse));
    };
  }

  void handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      bindings.ControlMessageHandler.handleMessage(
          this, 0, message);
      return;
    }
    if (_impl == null) {
      throw new core.MojoApiError("$this has no implementation set");
    }
    switch (message.header.type) {
      case _assetBundleMethodGetAsStreamName:
        var params = _AssetBundleGetAsStreamParams.deserialize(
            message.payload);
        _impl.getAsStream(params.assetName, _assetBundleGetAsStreamResponseParamsResponder(message.header.requestId));
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
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


  void getAsStream(String assetName,void callback(core.MojoDataPipeConsumer assetData)) {
    return impl.getAsStream(assetName,callback);
  }
}

const int _assetUnpackerMethodUnpackZipStreamName = 0;

class _AssetUnpackerServiceDescription implements service_describer.ServiceDescription {
  void getTopLevelInterface(Function responder) {
    responder(null);
  }

  void getTypeDefinition(String typeKey, Function responder) {
    responder(null);
  }

  void getAllTypeDefinitions(Function responder) {
    responder(null);
  }
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

  factory AssetUnpackerInterface.fromMock(
      AssetUnpacker mock) =>
      new AssetUnpackerProxy.fromMock(mock);
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
  AssetUnpacker impl;

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

  factory AssetUnpackerProxy.fromMock(AssetUnpacker mock) {
    AssetUnpackerProxy newMockedProxy =
        new AssetUnpackerProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static AssetUnpackerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AssetUnpackerProxy"));
    return new AssetUnpackerProxy.fromEndpoint(endpoint);
  }


  void unpackZipStream(core.MojoDataPipeConsumer zippedAssets, AssetBundleInterfaceRequest assetBundle) {
    if (impl != null) {
      impl.unpackZipStream(zippedAssets, assetBundle);
      return;
    }
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



  void handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      bindings.ControlMessageHandler.handleMessage(
          this, 0, message);
      return;
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



