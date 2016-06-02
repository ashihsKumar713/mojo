// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library terminal_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/files/file.mojom.dart' as file_mojom;
import 'package:mojo_services/mojo/files/types.mojom.dart' as types_mojom;
import 'package:mojo_services/mojo/terminal/terminal_client.mojom.dart' as terminal_client_mojom;



class _TerminalConnectParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  file_mojom.FileInterfaceRequest terminalFile = null;
  bool force = false;

  _TerminalConnectParams() : super(kVersions.last.size);

  static _TerminalConnectParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TerminalConnectParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TerminalConnectParams result = new _TerminalConnectParams();

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
      
      result.terminalFile = decoder0.decodeInterfaceRequest(8, false, file_mojom.FileStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.force = decoder0.decodeBool(12, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(terminalFile, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "terminalFile of struct _TerminalConnectParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(force, 12, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "force of struct _TerminalConnectParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TerminalConnectParams("
           "terminalFile: $terminalFile" ", "
           "force: $force" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class TerminalConnectResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  TerminalConnectResponseParams() : super(kVersions.last.size);

  static TerminalConnectResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalConnectResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalConnectResponseParams result = new TerminalConnectResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct TerminalConnectResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "TerminalConnectResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _TerminalConnectToClientParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  terminal_client_mojom.TerminalClientInterface terminalClient = null;
  bool force = false;

  _TerminalConnectToClientParams() : super(kVersions.last.size);

  static _TerminalConnectToClientParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TerminalConnectToClientParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TerminalConnectToClientParams result = new _TerminalConnectToClientParams();

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
      
      result.terminalClient = decoder0.decodeServiceInterface(8, false, terminal_client_mojom.TerminalClientProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.force = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(terminalClient, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "terminalClient of struct _TerminalConnectToClientParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(force, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "force of struct _TerminalConnectToClientParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TerminalConnectToClientParams("
           "terminalClient: $terminalClient" ", "
           "force: $force" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class TerminalConnectToClientResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  TerminalConnectToClientResponseParams() : super(kVersions.last.size);

  static TerminalConnectToClientResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalConnectToClientResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalConnectToClientResponseParams result = new TerminalConnectToClientResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct TerminalConnectToClientResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "TerminalConnectToClientResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _TerminalGetSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _TerminalGetSizeParams() : super(kVersions.last.size);

  static _TerminalGetSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TerminalGetSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TerminalGetSizeParams result = new _TerminalGetSizeParams();

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
    return "_TerminalGetSizeParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class TerminalGetSizeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  int rows = 0;
  int columns = 0;

  TerminalGetSizeResponseParams() : super(kVersions.last.size);

  static TerminalGetSizeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalGetSizeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalGetSizeResponseParams result = new TerminalGetSizeResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.rows = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.columns = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct TerminalGetSizeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(rows, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rows of struct TerminalGetSizeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(columns, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "columns of struct TerminalGetSizeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "TerminalGetSizeResponseParams("
           "error: $error" ", "
           "rows: $rows" ", "
           "columns: $columns" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["rows"] = rows;
    map["columns"] = columns;
    return map;
  }
}


class _TerminalSetSizeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int rows = 0;
  int columns = 0;
  bool reset = false;

  _TerminalSetSizeParams() : super(kVersions.last.size);

  static _TerminalSetSizeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _TerminalSetSizeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TerminalSetSizeParams result = new _TerminalSetSizeParams();

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
      
      result.rows = decoder0.decodeUint32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.columns = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.reset = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint32(rows, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rows of struct _TerminalSetSizeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(columns, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "columns of struct _TerminalSetSizeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(reset, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "reset of struct _TerminalSetSizeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_TerminalSetSizeParams("
           "rows: $rows" ", "
           "columns: $columns" ", "
           "reset: $reset" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["rows"] = rows;
    map["columns"] = columns;
    map["reset"] = reset;
    return map;
  }
}


class TerminalSetSizeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  types_mojom.Error error = null;
  int rows = 0;
  int columns = 0;

  TerminalSetSizeResponseParams() : super(kVersions.last.size);

  static TerminalSetSizeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static TerminalSetSizeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TerminalSetSizeResponseParams result = new TerminalSetSizeResponseParams();

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
      
        result.error = types_mojom.Error.decode(decoder0, 8);
        if (result.error == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable types_mojom.Error.');
        }
    }
    if (mainDataHeader.version >= 0) {
      
      result.rows = decoder0.decodeUint32(12);
    }
    if (mainDataHeader.version >= 0) {
      
      result.columns = decoder0.decodeUint32(16);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct TerminalSetSizeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(rows, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "rows of struct TerminalSetSizeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint32(columns, 16);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "columns of struct TerminalSetSizeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "TerminalSetSizeResponseParams("
           "error: $error" ", "
           "rows: $rows" ", "
           "columns: $columns" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["rows"] = rows;
    map["columns"] = columns;
    return map;
  }
}

const int _terminalMethodConnectName = 0;
const int _terminalMethodConnectToClientName = 1;
const int _terminalMethodGetSizeName = 2;
const int _terminalMethodSetSizeName = 3;

class _TerminalServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Terminal {
  static const String serviceName = "mojo::terminal::Terminal";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _TerminalServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static TerminalProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TerminalProxy p = new TerminalProxy.unbound();
    String name = serviceName ?? Terminal.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic connect(file_mojom.FileInterfaceRequest terminalFile,bool force,[Function responseFactory = null]);
  dynamic connectToClient(terminal_client_mojom.TerminalClientInterface terminalClient,bool force,[Function responseFactory = null]);
  dynamic getSize([Function responseFactory = null]);
  dynamic setSize(int rows,int columns,bool reset,[Function responseFactory = null]);
}

abstract class TerminalInterface
    implements bindings.MojoInterface<Terminal>,
               Terminal {
  factory TerminalInterface([Terminal impl]) =>
      new TerminalStub.unbound(impl);

  factory TerminalInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [Terminal impl]) =>
      new TerminalStub.fromEndpoint(endpoint, impl);

  factory TerminalInterface.fromMock(
      Terminal mock) =>
      new TerminalProxy.fromMock(mock);
}

abstract class TerminalInterfaceRequest
    implements bindings.MojoInterface<Terminal>,
               Terminal {
  factory TerminalInterfaceRequest() =>
      new TerminalProxy.unbound();
}

class _TerminalProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<Terminal> {
  Terminal impl;

  _TerminalProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TerminalProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _TerminalProxyControl.unbound() : super.unbound();

  String get serviceName => Terminal.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _terminalMethodConnectName:
        var r = TerminalConnectResponseParams.deserialize(
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
      case _terminalMethodConnectToClientName:
        var r = TerminalConnectToClientResponseParams.deserialize(
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
      case _terminalMethodGetSizeName:
        var r = TerminalGetSizeResponseParams.deserialize(
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
      case _terminalMethodSetSizeName:
        var r = TerminalSetSizeResponseParams.deserialize(
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
    return "_TerminalProxyControl($superString)";
  }
}

class TerminalProxy
    extends bindings.Proxy<Terminal>
    implements Terminal,
               TerminalInterface,
               TerminalInterfaceRequest {
  TerminalProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _TerminalProxyControl.fromEndpoint(endpoint));

  TerminalProxy.fromHandle(core.MojoHandle handle)
      : super(new _TerminalProxyControl.fromHandle(handle));

  TerminalProxy.unbound()
      : super(new _TerminalProxyControl.unbound());

  factory TerminalProxy.fromMock(Terminal mock) {
    TerminalProxy newMockedProxy =
        new TerminalProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static TerminalProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TerminalProxy"));
    return new TerminalProxy.fromEndpoint(endpoint);
  }


  dynamic connect(file_mojom.FileInterfaceRequest terminalFile,bool force,[Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.connect(terminalFile,force,_TerminalStubControl._terminalConnectResponseParamsFactory));
    }
    var params = new _TerminalConnectParams();
    params.terminalFile = terminalFile;
    params.force = force;
    return ctrl.sendMessageWithRequestId(
        params,
        _terminalMethodConnectName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic connectToClient(terminal_client_mojom.TerminalClientInterface terminalClient,bool force,[Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.connectToClient(terminalClient,force,_TerminalStubControl._terminalConnectToClientResponseParamsFactory));
    }
    var params = new _TerminalConnectToClientParams();
    params.terminalClient = terminalClient;
    params.force = force;
    return ctrl.sendMessageWithRequestId(
        params,
        _terminalMethodConnectToClientName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic getSize([Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.getSize(_TerminalStubControl._terminalGetSizeResponseParamsFactory));
    }
    var params = new _TerminalGetSizeParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _terminalMethodGetSizeName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic setSize(int rows,int columns,bool reset,[Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.setSize(rows,columns,reset,_TerminalStubControl._terminalSetSizeResponseParamsFactory));
    }
    var params = new _TerminalSetSizeParams();
    params.rows = rows;
    params.columns = columns;
    params.reset = reset;
    return ctrl.sendMessageWithRequestId(
        params,
        _terminalMethodSetSizeName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _TerminalStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<Terminal> {
  Terminal _impl;

  _TerminalStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Terminal impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _TerminalStubControl.fromHandle(
      core.MojoHandle handle, [Terminal impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _TerminalStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => Terminal.serviceName;


  static TerminalConnectResponseParams _terminalConnectResponseParamsFactory(types_mojom.Error error) {
    var result = new TerminalConnectResponseParams();
    result.error = error;
    return result;
  }
  static TerminalConnectToClientResponseParams _terminalConnectToClientResponseParamsFactory(types_mojom.Error error) {
    var result = new TerminalConnectToClientResponseParams();
    result.error = error;
    return result;
  }
  static TerminalGetSizeResponseParams _terminalGetSizeResponseParamsFactory(types_mojom.Error error, int rows, int columns) {
    var result = new TerminalGetSizeResponseParams();
    result.error = error;
    result.rows = rows;
    result.columns = columns;
    return result;
  }
  static TerminalSetSizeResponseParams _terminalSetSizeResponseParamsFactory(types_mojom.Error error, int rows, int columns) {
    var result = new TerminalSetSizeResponseParams();
    result.error = error;
    result.rows = rows;
    result.columns = columns;
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
      case _terminalMethodConnectName:
        var params = _TerminalConnectParams.deserialize(
            message.payload);
        var response = _impl.connect(params.terminalFile,params.force,_terminalConnectResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _terminalMethodConnectName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _terminalMethodConnectName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _terminalMethodConnectToClientName:
        var params = _TerminalConnectToClientParams.deserialize(
            message.payload);
        var response = _impl.connectToClient(params.terminalClient,params.force,_terminalConnectToClientResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _terminalMethodConnectToClientName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _terminalMethodConnectToClientName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _terminalMethodGetSizeName:
        var response = _impl.getSize(_terminalGetSizeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _terminalMethodGetSizeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _terminalMethodGetSizeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _terminalMethodSetSizeName:
        var params = _TerminalSetSizeParams.deserialize(
            message.payload);
        var response = _impl.setSize(params.rows,params.columns,params.reset,_terminalSetSizeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _terminalMethodSetSizeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _terminalMethodSetSizeName,
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

  Terminal get impl => _impl;
  set impl(Terminal d) {
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
    return "_TerminalStubControl($superString)";
  }

  int get version => 0;
}

class TerminalStub
    extends bindings.Stub<Terminal>
    implements Terminal,
               TerminalInterface,
               TerminalInterfaceRequest {
  TerminalStub.unbound([Terminal impl])
      : super(new _TerminalStubControl.unbound(impl));

  TerminalStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Terminal impl])
      : super(new _TerminalStubControl.fromEndpoint(endpoint, impl));

  TerminalStub.fromHandle(
      core.MojoHandle handle, [Terminal impl])
      : super(new _TerminalStubControl.fromHandle(handle, impl));

  static TerminalStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TerminalStub"));
    return new TerminalStub.fromEndpoint(endpoint);
  }


  dynamic connect(file_mojom.FileInterfaceRequest terminalFile,bool force,[Function responseFactory = null]) {
    return impl.connect(terminalFile,force,responseFactory);
  }
  dynamic connectToClient(terminal_client_mojom.TerminalClientInterface terminalClient,bool force,[Function responseFactory = null]) {
    return impl.connectToClient(terminalClient,force,responseFactory);
  }
  dynamic getSize([Function responseFactory = null]) {
    return impl.getSize(responseFactory);
  }
  dynamic setSize(int rows,int columns,bool reset,[Function responseFactory = null]) {
    return impl.setSize(rows,columns,reset,responseFactory);
  }
}



