// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class SeekingReader {
  static const String serviceName = null;
  dynamic describe([Function responseFactory = null]);
  dynamic readAt(int position,[Function responseFactory = null]);
  static const int kUnknownSize = 18446744073709551615;
}

class _SeekingReaderProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _SeekingReaderProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _SeekingReaderProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _SeekingReaderProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _SeekingReaderServiceDescription();

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
      case _seekingReaderMethodReadAtName:
        var r = SeekingReaderReadAtResponseParams.deserialize(
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
    return "_SeekingReaderProxyControl($superString)";
  }
}

class SeekingReaderProxy
    extends bindings.Proxy
    implements SeekingReader {
  SeekingReaderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _SeekingReaderProxyControl.fromEndpoint(endpoint));

  SeekingReaderProxy.fromHandle(core.MojoHandle handle)
      : super(new _SeekingReaderProxyControl.fromHandle(handle));

  SeekingReaderProxy.unbound()
      : super(new _SeekingReaderProxyControl.unbound());

  static SeekingReaderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SeekingReaderProxy"));
    return new SeekingReaderProxy.fromEndpoint(endpoint);
  }

  factory SeekingReaderProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    SeekingReaderProxy p = new SeekingReaderProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic describe([Function responseFactory = null]) {
    var params = new _SeekingReaderDescribeParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _seekingReaderMethodDescribeName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic readAt(int position,[Function responseFactory = null]) {
    var params = new _SeekingReaderReadAtParams();
    params.position = position;
    return ctrl.sendMessageWithRequestId(
        params,
        _seekingReaderMethodReadAtName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
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


  SeekingReaderDescribeResponseParams _seekingReaderDescribeResponseParamsFactory(media_common_mojom.MediaResult result, int size, bool canSeek) {
    var result = new SeekingReaderDescribeResponseParams();
    result.result = result;
    result.size = size;
    result.canSeek = canSeek;
    return result;
  }
  SeekingReaderReadAtResponseParams _seekingReaderReadAtResponseParamsFactory(media_common_mojom.MediaResult result, core.MojoDataPipeConsumer dataPipe) {
    var result = new SeekingReaderReadAtResponseParams();
    result.result = result;
    result.dataPipe = dataPipe;
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
      case _seekingReaderMethodDescribeName:
        var response = _impl.describe(_seekingReaderDescribeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _seekingReaderMethodDescribeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _seekingReaderMethodDescribeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _seekingReaderMethodReadAtName:
        var params = _SeekingReaderReadAtParams.deserialize(
            message.payload);
        var response = _impl.readAt(params.position,_seekingReaderReadAtResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _seekingReaderMethodReadAtName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _seekingReaderMethodReadAtName,
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

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _SeekingReaderServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class SeekingReaderStub
    extends bindings.Stub<SeekingReader>
    implements SeekingReader {
  SeekingReaderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [SeekingReader impl])
      : super(new _SeekingReaderStubControl.fromEndpoint(endpoint, impl));

  SeekingReaderStub.fromHandle(
      core.MojoHandle handle, [SeekingReader impl])
      : super(new _SeekingReaderStubControl.fromHandle(handle, impl));

  SeekingReaderStub.unbound([SeekingReader impl])
      : super(new _SeekingReaderStubControl.unbound(impl));

  static SeekingReaderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For SeekingReaderStub"));
    return new SeekingReaderStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _SeekingReaderStubControl.serviceDescription;


  dynamic describe([Function responseFactory = null]) {
    return impl.describe(responseFactory);
  }
  dynamic readAt(int position,[Function responseFactory = null]) {
    return impl.readAt(position,responseFactory);
  }
}



