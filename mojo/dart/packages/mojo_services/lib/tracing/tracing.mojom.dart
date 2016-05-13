// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library tracing_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _TraceProviderStartTracingParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String categories = null;
  Object recorder = null;

  _TraceProviderStartTracingParams() : super(kVersions.last.size);

  static _TraceProviderStartTracingParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TraceProviderStartTracingParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TraceProviderStartTracingParams result = new _TraceProviderStartTracingParams();

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
      
      result.categories = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.recorder = decoder0.decodeServiceInterface(16, false, TraceRecorderProxy.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(categories, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "categories of struct _TraceProviderStartTracingParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(recorder, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "recorder of struct _TraceProviderStartTracingParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TraceProviderStartTracingParams("
           "categories: $categories" ", "
           "recorder: $recorder" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _TraceProviderStopTracingParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _TraceProviderStopTracingParams() : super(kVersions.last.size);

  static _TraceProviderStopTracingParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TraceProviderStopTracingParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TraceProviderStopTracingParams result = new _TraceProviderStopTracingParams();

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
    return "_TraceProviderStopTracingParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _TraceRecorderRecordParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String json = null;

  _TraceRecorderRecordParams() : super(kVersions.last.size);

  static _TraceRecorderRecordParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TraceRecorderRecordParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TraceRecorderRecordParams result = new _TraceRecorderRecordParams();

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
      
      result.json = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(json, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "json of struct _TraceRecorderRecordParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TraceRecorderRecordParams("
           "json: $json" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["json"] = json;
    return map;
  }
}


class _TraceCollectorStartParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  core.MojoDataPipeProducer stream = null;
  String categories = null;

  _TraceCollectorStartParams() : super(kVersions.last.size);

  static _TraceCollectorStartParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TraceCollectorStartParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TraceCollectorStartParams result = new _TraceCollectorStartParams();

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
      
      result.stream = decoder0.decodeProducerHandle(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      result.categories = decoder0.decodeString(16, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeProducerHandle(stream, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "stream of struct _TraceCollectorStartParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(categories, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "categories of struct _TraceCollectorStartParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TraceCollectorStartParams("
           "stream: $stream" ", "
           "categories: $categories" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _TraceCollectorStopAndFlushParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _TraceCollectorStopAndFlushParams() : super(kVersions.last.size);

  static _TraceCollectorStopAndFlushParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TraceCollectorStopAndFlushParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TraceCollectorStopAndFlushParams result = new _TraceCollectorStopAndFlushParams();

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
    return "_TraceCollectorStopAndFlushParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _traceProviderMethodStartTracingName = 0;
const int _traceProviderMethodStopTracingName = 1;

class _TraceProviderServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class TraceProvider {
  static const String serviceName = "tracing::TraceProvider";
  void startTracing(String categories, Object recorder);
  void stopTracing();
}


class _TraceProviderProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _TraceProviderProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TraceProviderProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _TraceProviderProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _TraceProviderServiceDescription();

  String get serviceName => TraceProvider.serviceName;

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
    return "_TraceProviderProxyControl($superString)";
  }
}


class TraceProviderProxy extends bindings.Proxy
                              implements TraceProvider {
  TraceProviderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _TraceProviderProxyControl.fromEndpoint(endpoint));

  TraceProviderProxy.fromHandle(core.MojoHandle handle)
      : super(new _TraceProviderProxyControl.fromHandle(handle));

  TraceProviderProxy.unbound()
      : super(new _TraceProviderProxyControl.unbound());

  static TraceProviderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceProviderProxy"));
    return new TraceProviderProxy.fromEndpoint(endpoint);
  }

  factory TraceProviderProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TraceProviderProxy p = new TraceProviderProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void startTracing(String categories, Object recorder) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _TraceProviderStartTracingParams();
    params.categories = categories;
    params.recorder = recorder;
    ctrl.sendMessage(params,
        _traceProviderMethodStartTracingName);
  }
  void stopTracing() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _TraceProviderStopTracingParams();
    ctrl.sendMessage(params,
        _traceProviderMethodStopTracingName);
  }
}


class TraceProviderStub extends bindings.Stub {
  TraceProvider _impl;

  TraceProviderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [TraceProvider impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  TraceProviderStub.fromHandle(
      core.MojoHandle handle, [TraceProvider impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  TraceProviderStub.unbound([this._impl]) : super.unbound();

  static TraceProviderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceProviderStub"));
    return new TraceProviderStub.fromEndpoint(endpoint);
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
      case _traceProviderMethodStartTracingName:
        var params = _TraceProviderStartTracingParams.deserialize(
            message.payload);
        _impl.startTracing(params.categories, params.recorder);
        break;
      case _traceProviderMethodStopTracingName:
        _impl.stopTracing();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  TraceProvider get impl => _impl;
  set impl(TraceProvider d) {
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
    return "TraceProviderStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _TraceProviderServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _traceRecorderMethodRecordName = 0;

class _TraceRecorderServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class TraceRecorder {
  static const String serviceName = null;
  void record(String json);
}


class _TraceRecorderProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _TraceRecorderProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TraceRecorderProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _TraceRecorderProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _TraceRecorderServiceDescription();

  String get serviceName => TraceRecorder.serviceName;

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
    return "_TraceRecorderProxyControl($superString)";
  }
}


class TraceRecorderProxy extends bindings.Proxy
                              implements TraceRecorder {
  TraceRecorderProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _TraceRecorderProxyControl.fromEndpoint(endpoint));

  TraceRecorderProxy.fromHandle(core.MojoHandle handle)
      : super(new _TraceRecorderProxyControl.fromHandle(handle));

  TraceRecorderProxy.unbound()
      : super(new _TraceRecorderProxyControl.unbound());

  static TraceRecorderProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceRecorderProxy"));
    return new TraceRecorderProxy.fromEndpoint(endpoint);
  }

  factory TraceRecorderProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TraceRecorderProxy p = new TraceRecorderProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void record(String json) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _TraceRecorderRecordParams();
    params.json = json;
    ctrl.sendMessage(params,
        _traceRecorderMethodRecordName);
  }
}


class TraceRecorderStub extends bindings.Stub {
  TraceRecorder _impl;

  TraceRecorderStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [TraceRecorder impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  TraceRecorderStub.fromHandle(
      core.MojoHandle handle, [TraceRecorder impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  TraceRecorderStub.unbound([this._impl]) : super.unbound();

  static TraceRecorderStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceRecorderStub"));
    return new TraceRecorderStub.fromEndpoint(endpoint);
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
      case _traceRecorderMethodRecordName:
        var params = _TraceRecorderRecordParams.deserialize(
            message.payload);
        _impl.record(params.json);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  TraceRecorder get impl => _impl;
  set impl(TraceRecorder d) {
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
    return "TraceRecorderStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _TraceRecorderServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _traceCollectorMethodStartName = 0;
const int _traceCollectorMethodStopAndFlushName = 1;

class _TraceCollectorServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class TraceCollector {
  static const String serviceName = "tracing::TraceCollector";
  void start(core.MojoDataPipeProducer stream, String categories);
  void stopAndFlush();
}


class _TraceCollectorProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _TraceCollectorProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TraceCollectorProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _TraceCollectorProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _TraceCollectorServiceDescription();

  String get serviceName => TraceCollector.serviceName;

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
    return "_TraceCollectorProxyControl($superString)";
  }
}


class TraceCollectorProxy extends bindings.Proxy
                              implements TraceCollector {
  TraceCollectorProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _TraceCollectorProxyControl.fromEndpoint(endpoint));

  TraceCollectorProxy.fromHandle(core.MojoHandle handle)
      : super(new _TraceCollectorProxyControl.fromHandle(handle));

  TraceCollectorProxy.unbound()
      : super(new _TraceCollectorProxyControl.unbound());

  static TraceCollectorProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceCollectorProxy"));
    return new TraceCollectorProxy.fromEndpoint(endpoint);
  }

  factory TraceCollectorProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TraceCollectorProxy p = new TraceCollectorProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void start(core.MojoDataPipeProducer stream, String categories) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _TraceCollectorStartParams();
    params.stream = stream;
    params.categories = categories;
    ctrl.sendMessage(params,
        _traceCollectorMethodStartName);
  }
  void stopAndFlush() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _TraceCollectorStopAndFlushParams();
    ctrl.sendMessage(params,
        _traceCollectorMethodStopAndFlushName);
  }
}


class TraceCollectorStub extends bindings.Stub {
  TraceCollector _impl;

  TraceCollectorStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [TraceCollector impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  TraceCollectorStub.fromHandle(
      core.MojoHandle handle, [TraceCollector impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  TraceCollectorStub.unbound([this._impl]) : super.unbound();

  static TraceCollectorStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TraceCollectorStub"));
    return new TraceCollectorStub.fromEndpoint(endpoint);
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
      case _traceCollectorMethodStartName:
        var params = _TraceCollectorStartParams.deserialize(
            message.payload);
        _impl.start(params.stream, params.categories);
        break;
      case _traceCollectorMethodStopAndFlushName:
        _impl.stopAndFlush();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  TraceCollector get impl => _impl;
  set impl(TraceCollector d) {
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
    return "TraceCollectorStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _TraceCollectorServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



