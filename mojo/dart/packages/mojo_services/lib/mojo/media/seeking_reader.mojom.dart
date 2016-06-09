// WARNING: DO NOT EDIT. This file was generated by a program.
// See $MOJO_SDK/tools/bindings/mojom_bindings_generator.py.

library seeking_reader_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/media/media_common.mojom.dart' as media_common_mojom;



class _SeekingReaderDescribeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _SeekingReaderDescribeParams() : super(kVersions.last.size);

  _SeekingReaderDescribeParams.init(
  ) : super(kVersions.last.size);

  static _SeekingReaderDescribeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SeekingReaderDescribeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SeekingReaderDescribeParams result = new _SeekingReaderDescribeParams();

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
    return "_SeekingReaderDescribeParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class SeekingReaderDescribeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  media_common_mojom.MediaResult result = null;
  bool canSeek = false;
  int size = 0;

  SeekingReaderDescribeResponseParams() : super(kVersions.last.size);

  SeekingReaderDescribeResponseParams.init(
    media_common_mojom.MediaResult this.result, 
    bool this.canSeek, 
    int this.size
  ) : super(kVersions.last.size);

  static SeekingReaderDescribeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SeekingReaderDescribeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SeekingReaderDescribeResponseParams result = new SeekingReaderDescribeResponseParams();

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
      
        result.result = media_common_mojom.MediaResult.decode(decoder0, 8);
        if (result.result == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable media_common_mojom.MediaResult.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.canSeek = decoder0.decodeBool(12, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      result.size = decoder0.decodeUint64(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(result, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct SeekingReaderDescribeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(canSeek, 12, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "canSeek of struct SeekingReaderDescribeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint64(size, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "size of struct SeekingReaderDescribeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "SeekingReaderDescribeResponseParams("
           "result: $result" ", "
           "canSeek: $canSeek" ", "
           "size: $size" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["result"] = result;
    map["canSeek"] = canSeek;
    map["size"] = size;
    return map;
  }
}


class _SeekingReaderReadAtParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int position = 0;

  _SeekingReaderReadAtParams() : super(kVersions.last.size);

  _SeekingReaderReadAtParams.init(
    int this.position
  ) : super(kVersions.last.size);

  static _SeekingReaderReadAtParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _SeekingReaderReadAtParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _SeekingReaderReadAtParams result = new _SeekingReaderReadAtParams();

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
      
      result.position = decoder0.decodeUint64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(position, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "position of struct _SeekingReaderReadAtParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_SeekingReaderReadAtParams("
           "position: $position" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["position"] = position;
    return map;
  }
}


class SeekingReaderReadAtResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  media_common_mojom.MediaResult result = null;
  core.MojoDataPipeConsumer dataPipe = null;

  SeekingReaderReadAtResponseParams() : super(kVersions.last.size);

  SeekingReaderReadAtResponseParams.init(
    media_common_mojom.MediaResult this.result, 
    core.MojoDataPipeConsumer this.dataPipe
  ) : super(kVersions.last.size);

  static SeekingReaderReadAtResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static SeekingReaderReadAtResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    SeekingReaderReadAtResponseParams result = new SeekingReaderReadAtResponseParams();

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
      
        result.result = media_common_mojom.MediaResult.decode(decoder0, 8);
        if (result.result == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable media_common_mojom.MediaResult.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.dataPipe = decoder0.decodeConsumerHandle(12, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(result, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "result of struct SeekingReaderReadAtResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeConsumerHandle(dataPipe, 12, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "dataPipe of struct SeekingReaderReadAtResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "SeekingReaderReadAtResponseParams("
           "result: $result" ", "
           "dataPipe: $dataPipe" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _seekingReaderMethodDescribeName = 0;
const int _seekingReaderMethodReadAtName = 1;

class _SeekingReaderServiceDescription implements service_describer.ServiceDescription {
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

abstract class SeekingReader {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SeekingReaderServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static SeekingReaderProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SeekingReaderProxy p = new SeekingReaderProxy.unbound();
    String name = serviceName ?? SeekingReader.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void describe(void callback(media_common_mojom.MediaResult result, int size, bool canSeek));
  void readAt(int position,void callback(media_common_mojom.MediaResult result, core.MojoDataPipeConsumer dataPipe));
  static const int kUnknownSize = 18446744073709551615;
}

abstract class SeekingReaderInterface
    implements bindings.MojoInterface<SeekingReader>,
               SeekingReader {
  factory SeekingReaderInterface([SeekingReader impl]) =>
      new SeekingReaderStub.unbound(impl);

  factory SeekingReaderInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [SeekingReader impl]) =>
      new SeekingReaderStub.fromEndpoint(endpoint, impl);

  factory SeekingReaderInterface.fromMock(
      SeekingReader mock) =>
      new SeekingReaderProxy.fromMock(mock);
}

abstract class SeekingReaderInterfaceRequest
    implements bindings.MojoInterface<SeekingReader>,
               SeekingReader {
  factory SeekingReaderInterfaceRequest() =>
      new SeekingReaderProxy.unbound();
}

class _SeekingReaderProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<SeekingReader> {
  SeekingReader impl;

  _SeekingReaderProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SeekingReaderProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _SeekingReaderProxyControl.unbound() : super.unbound();

  String get serviceName => SeekingReader.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _seekingReaderMethodDescribeName:
        var r = SeekingReaderDescribeResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Function callback = callbackMap[message.header.requestId];
        if (callback == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        callbackMap.remove(message.header.requestId);
        callback(r.result , r.size , r.canSeek );
        break;
      case _seekingReaderMethodReadAtName:
        var r = SeekingReaderReadAtResponseParams.deserialize(
            message.payload);
        if (!message.header.hasRequestId) {
          proxyError("Expected a message with a valid request Id.");
          return;
        }
        Function callback = callbackMap[message.header.requestId];
        if (callback == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        callbackMap.remove(message.header.requestId);
        callback(r.result , r.dataPipe );
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
    return "_SeekingReaderProxyControl($superString)";
  }
}

class SeekingReaderProxy
    extends bindings.Proxy<SeekingReader>
    implements SeekingReader,
               SeekingReaderInterface,
               SeekingReaderInterfaceRequest {
  SeekingReaderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _SeekingReaderProxyControl.fromEndpoint(endpoint));

  SeekingReaderProxy.fromHandle(core.MojoHandle handle)
      : super(new _SeekingReaderProxyControl.fromHandle(handle));

  SeekingReaderProxy.unbound()
      : super(new _SeekingReaderProxyControl.unbound());

  factory SeekingReaderProxy.fromMock(SeekingReader mock) {
    SeekingReaderProxy newMockedProxy =
        new SeekingReaderProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static SeekingReaderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SeekingReaderProxy"));
    return new SeekingReaderProxy.fromEndpoint(endpoint);
  }


  void describe(void callback(media_common_mojom.MediaResult result, int size, bool canSeek)) {
    if (impl != null) {
      impl.describe(callback);
      return;
    }
    var params = new _SeekingReaderDescribeParams();
    ctrl.sendMessageWithRequestId(
        params,
        _seekingReaderMethodDescribeName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse,
        callback);
  }
  void readAt(int position,void callback(media_common_mojom.MediaResult result, core.MojoDataPipeConsumer dataPipe)) {
    if (impl != null) {
      impl.readAt(position,callback);
      return;
    }
    var params = new _SeekingReaderReadAtParams();
    params.position = position;
    ctrl.sendMessageWithRequestId(
        params,
        _seekingReaderMethodReadAtName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse,
        callback);
  }
}

class _SeekingReaderStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<SeekingReader> {
  SeekingReader _impl;

  _SeekingReaderStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [SeekingReader impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _SeekingReaderStubControl.fromHandle(
      core.MojoHandle handle, [SeekingReader impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _SeekingReaderStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => SeekingReader.serviceName;


  Function _seekingReaderDescribeResponseParamsResponder(
      int requestId) {
  return (media_common_mojom.MediaResult result, int size, bool canSeek) {
      var result = new SeekingReaderDescribeResponseParams();
      result.result = result;
      result.size = size;
      result.canSeek = canSeek;
      sendResponse(buildResponseWithId(
          result,
          _seekingReaderMethodDescribeName,
          requestId,
          bindings.MessageHeader.kMessageIsResponse));
    };
  }
  Function _seekingReaderReadAtResponseParamsResponder(
      int requestId) {
  return (media_common_mojom.MediaResult result, core.MojoDataPipeConsumer dataPipe) {
      var result = new SeekingReaderReadAtResponseParams();
      result.result = result;
      result.dataPipe = dataPipe;
      sendResponse(buildResponseWithId(
          result,
          _seekingReaderMethodReadAtName,
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
      case _seekingReaderMethodDescribeName:
        _impl.describe(_seekingReaderDescribeResponseParamsResponder(message.header.requestId));
        break;
      case _seekingReaderMethodReadAtName:
        var params = _SeekingReaderReadAtParams.deserialize(
            message.payload);
        _impl.readAt(params.position, _seekingReaderReadAtResponseParamsResponder(message.header.requestId));
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
  }

  SeekingReader get impl => _impl;
  set impl(SeekingReader d) {
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
    return "_SeekingReaderStubControl($superString)";
  }

  int get version => 0;
}

class SeekingReaderStub
    extends bindings.Stub<SeekingReader>
    implements SeekingReader,
               SeekingReaderInterface,
               SeekingReaderInterfaceRequest {
  SeekingReaderStub.unbound([SeekingReader impl])
      : super(new _SeekingReaderStubControl.unbound(impl));

  SeekingReaderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [SeekingReader impl])
      : super(new _SeekingReaderStubControl.fromEndpoint(endpoint, impl));

  SeekingReaderStub.fromHandle(
      core.MojoHandle handle, [SeekingReader impl])
      : super(new _SeekingReaderStubControl.fromHandle(handle, impl));

  static SeekingReaderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SeekingReaderStub"));
    return new SeekingReaderStub.fromEndpoint(endpoint);
  }


  void describe(void callback(media_common_mojom.MediaResult result, int size, bool canSeek)) {
    return impl.describe(callback);
  }
  void readAt(int position,void callback(media_common_mojom.MediaResult result, core.MojoDataPipeConsumer dataPipe)) {
    return impl.readAt(position,callback);
  }
}



