// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library math_calculator_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _CalculatorClearParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _CalculatorClearParams() : super(kVersions.last.size);

  static _CalculatorClearParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CalculatorClearParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CalculatorClearParams result = new _CalculatorClearParams();

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
    return "_CalculatorClearParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class CalculatorClearResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double value = 0.0;

  CalculatorClearResponseParams() : super(kVersions.last.size);

  static CalculatorClearResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CalculatorClearResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CalculatorClearResponseParams result = new CalculatorClearResponseParams();

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
      
      result.value = decoder0.decodeDouble(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeDouble(value, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct CalculatorClearResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "CalculatorClearResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class _CalculatorAddParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double value = 0.0;

  _CalculatorAddParams() : super(kVersions.last.size);

  static _CalculatorAddParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CalculatorAddParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CalculatorAddParams result = new _CalculatorAddParams();

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
      
      result.value = decoder0.decodeDouble(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeDouble(value, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct _CalculatorAddParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_CalculatorAddParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class CalculatorAddResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double value = 0.0;

  CalculatorAddResponseParams() : super(kVersions.last.size);

  static CalculatorAddResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CalculatorAddResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CalculatorAddResponseParams result = new CalculatorAddResponseParams();

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
      
      result.value = decoder0.decodeDouble(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeDouble(value, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct CalculatorAddResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "CalculatorAddResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class _CalculatorMultiplyParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double value = 0.0;

  _CalculatorMultiplyParams() : super(kVersions.last.size);

  static _CalculatorMultiplyParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _CalculatorMultiplyParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _CalculatorMultiplyParams result = new _CalculatorMultiplyParams();

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
      
      result.value = decoder0.decodeDouble(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeDouble(value, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct _CalculatorMultiplyParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_CalculatorMultiplyParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}


class CalculatorMultiplyResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  double value = 0.0;

  CalculatorMultiplyResponseParams() : super(kVersions.last.size);

  static CalculatorMultiplyResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static CalculatorMultiplyResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    CalculatorMultiplyResponseParams result = new CalculatorMultiplyResponseParams();

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
      
      result.value = decoder0.decodeDouble(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeDouble(value, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "value of struct CalculatorMultiplyResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "CalculatorMultiplyResponseParams("
           "value: $value" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["value"] = value;
    return map;
  }
}

const int _calculatorMethodClearName = 0;
const int _calculatorMethodAddName = 1;
const int _calculatorMethodMultiplyName = 2;

class _CalculatorServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Calculator {
  static const String serviceName = null;
  dynamic clear([Function responseFactory = null]);
  dynamic add(double value,[Function responseFactory = null]);
  dynamic multiply(double value,[Function responseFactory = null]);
}


class _CalculatorProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _CalculatorProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _CalculatorProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _CalculatorProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _CalculatorServiceDescription();

  String get serviceName => Calculator.serviceName;

  @override
  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _calculatorMethodClearName:
        var r = CalculatorClearResponseParams.deserialize(
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
      case _calculatorMethodAddName:
        var r = CalculatorAddResponseParams.deserialize(
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
      case _calculatorMethodMultiplyName:
        var r = CalculatorMultiplyResponseParams.deserialize(
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
    return "_CalculatorProxyControl($superString)";
  }
}


class CalculatorProxy extends bindings.Proxy
                              implements Calculator {
  CalculatorProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _CalculatorProxyControl.fromEndpoint(endpoint));

  CalculatorProxy.fromHandle(core.MojoHandle handle)
      : super(new _CalculatorProxyControl.fromHandle(handle));

  CalculatorProxy.unbound()
      : super(new _CalculatorProxyControl.unbound());

  static CalculatorProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CalculatorProxy"));
    return new CalculatorProxy.fromEndpoint(endpoint);
  }

  factory CalculatorProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    CalculatorProxy p = new CalculatorProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic clear([Function responseFactory = null]) {
    var params = new _CalculatorClearParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _calculatorMethodClearName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic add(double value,[Function responseFactory = null]) {
    var params = new _CalculatorAddParams();
    params.value = value;
    return ctrl.sendMessageWithRequestId(
        params,
        _calculatorMethodAddName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic multiply(double value,[Function responseFactory = null]) {
    var params = new _CalculatorMultiplyParams();
    params.value = value;
    return ctrl.sendMessageWithRequestId(
        params,
        _calculatorMethodMultiplyName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}


class CalculatorStub extends bindings.Stub {
  Calculator _impl;

  CalculatorStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Calculator impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  CalculatorStub.fromHandle(
      core.MojoHandle handle, [Calculator impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  CalculatorStub.unbound([this._impl]) : super.unbound();

  static CalculatorStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For CalculatorStub"));
    return new CalculatorStub.fromEndpoint(endpoint);
  }


  CalculatorClearResponseParams _calculatorClearResponseParamsFactory(double value) {
    var result = new CalculatorClearResponseParams();
    result.value = value;
    return result;
  }
  CalculatorAddResponseParams _calculatorAddResponseParamsFactory(double value) {
    var result = new CalculatorAddResponseParams();
    result.value = value;
    return result;
  }
  CalculatorMultiplyResponseParams _calculatorMultiplyResponseParamsFactory(double value) {
    var result = new CalculatorMultiplyResponseParams();
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
      case _calculatorMethodClearName:
        var response = _impl.clear(_calculatorClearResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _calculatorMethodClearName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _calculatorMethodClearName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _calculatorMethodAddName:
        var params = _CalculatorAddParams.deserialize(
            message.payload);
        var response = _impl.add(params.value,_calculatorAddResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _calculatorMethodAddName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _calculatorMethodAddName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _calculatorMethodMultiplyName:
        var params = _CalculatorMultiplyParams.deserialize(
            message.payload);
        var response = _impl.multiply(params.value,_calculatorMultiplyResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _calculatorMethodMultiplyName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _calculatorMethodMultiplyName,
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

  Calculator get impl => _impl;
  set impl(Calculator d) {
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
    return "CalculatorStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _CalculatorServiceDescription();
    }
    return _cachedServiceDescription;
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+xXTY/TMBBtU5CyLR/lc8OtEpdeWO9xxWkRWgkJIXHgsqfKm5pskBOHOEGCX8uxR/4BOGTcOtOYflDasMpIo2kcW5n3+ual9TplDKGeQsXrurqo4n1nxnXX2DeCvR8u319M3l5cvoxodn3ymnI/5zQTqQf7i3M949zYOF+JbvXyHN0+Res/Id506uOhyr7KRUfl+rHK+ypRu0u4XTgfqJyoJLlMCRc+5SQQIuCMXIuIkW8pJZH4JIhM/fJDkl/x0CdhnLH0I/WZJFdhPA3jQJKMyUyS4skTf/7kk+JUtPR8zc9j4E9T5Bj3e8b3ldwq6/ejep5nGpezHs84xpb1uypvFzxzRtMa/RxBz/vicYR0PEN1FV6tKxsPTwDzb7wvUvY5V83U4NaxL9yuZU491I+LdIF50gL7W56eqrxn8CQTEUt2eJ4wP+c1PldjR9bY1fx8oTxnlvk5PiA/HrLoYefP/jLqVflbxU8X0sbPAHzu1XRa+37qN8RfdjU3jwCzwmu4Szs3m85NH97zTZubf62f4vfCnbl+tOu2+tlGP8//Q9911uTHgbTxM4Re3uU8CxP+FfMzuGG+6wE2jVebbzs3m83NADyo6b77A/0fWlc/ZxZenql8UNXPwnxb/91KR+MG6uhXAAAA//+Vb42mYBEAAA==";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
