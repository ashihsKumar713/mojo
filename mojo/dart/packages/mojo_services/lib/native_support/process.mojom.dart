// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library process_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/files/file.mojom.dart' as file_mojom;
import 'package:mojo_services/mojo/files/types.mojom.dart' as types_mojom;



class _ProcessSpawnParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(64, 0)
  ];
  List<int> path = null;
  List<List<int>> argv = null;
  List<List<int>> envp = null;
  Object stdinFile = null;
  Object stdoutFile = null;
  Object stderrFile = null;
  Object processController = null;

  _ProcessSpawnParams() : super(kVersions.last.size);

  static _ProcessSpawnParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProcessSpawnParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProcessSpawnParams result = new _ProcessSpawnParams();

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
      
      result.path = decoder0.decodeUint8Array(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.argv = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.argv = new List<List<int>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.argv[i1] = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, true);
      if (decoder1 == null) {
        result.envp = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.envp = new List<List<int>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.envp[i1] = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.stdinFile = decoder0.decodeServiceInterface(32, true, file_mojom.FileProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.stdoutFile = decoder0.decodeServiceInterface(40, true, file_mojom.FileProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.stderrFile = decoder0.decodeServiceInterface(48, true, file_mojom.FileProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.processController = decoder0.decodeInterfaceRequest(56, false, ProcessControllerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8Array(path, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _ProcessSpawnParams: $e";
      rethrow;
    }
    try {
      if (argv == null) {
        encoder0.encodeNullPointer(16, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(argv.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < argv.length; ++i0) {
          encoder1.encodeUint8Array(argv[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "argv of struct _ProcessSpawnParams: $e";
      rethrow;
    }
    try {
      if (envp == null) {
        encoder0.encodeNullPointer(24, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(envp.length, 24, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < envp.length; ++i0) {
          encoder1.encodeUint8Array(envp[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "envp of struct _ProcessSpawnParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(stdinFile, 32, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "stdinFile of struct _ProcessSpawnParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(stdoutFile, 40, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "stdoutFile of struct _ProcessSpawnParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(stderrFile, 48, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "stderrFile of struct _ProcessSpawnParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(processController, 56, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "processController of struct _ProcessSpawnParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProcessSpawnParams("
           "path: $path" ", "
           "argv: $argv" ", "
           "envp: $envp" ", "
           "stdinFile: $stdinFile" ", "
           "stdoutFile: $stdoutFile" ", "
           "stderrFile: $stderrFile" ", "
           "processController: $processController" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ProcessSpawnResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  ProcessSpawnResponseParams() : super(kVersions.last.size);

  static ProcessSpawnResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProcessSpawnResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProcessSpawnResponseParams result = new ProcessSpawnResponseParams();

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
          "error of struct ProcessSpawnResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProcessSpawnResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _ProcessSpawnWithTerminalParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(48, 0)
  ];
  List<int> path = null;
  List<List<int>> argv = null;
  List<List<int>> envp = null;
  Object terminalFile = null;
  Object processController = null;

  _ProcessSpawnWithTerminalParams() : super(kVersions.last.size);

  static _ProcessSpawnWithTerminalParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProcessSpawnWithTerminalParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProcessSpawnWithTerminalParams result = new _ProcessSpawnWithTerminalParams();

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
      
      result.path = decoder0.decodeUint8Array(8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, true);
      if (decoder1 == null) {
        result.argv = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.argv = new List<List<int>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.argv[i1] = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, true);
      if (decoder1 == null) {
        result.envp = null;
      } else {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.envp = new List<List<int>>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.envp[i1] = decoder1.decodeUint8Array(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.terminalFile = decoder0.decodeServiceInterface(32, false, file_mojom.FileProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.processController = decoder0.decodeInterfaceRequest(40, false, ProcessControllerStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8Array(path, 8, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "path of struct _ProcessSpawnWithTerminalParams: $e";
      rethrow;
    }
    try {
      if (argv == null) {
        encoder0.encodeNullPointer(16, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(argv.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < argv.length; ++i0) {
          encoder1.encodeUint8Array(argv[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "argv of struct _ProcessSpawnWithTerminalParams: $e";
      rethrow;
    }
    try {
      if (envp == null) {
        encoder0.encodeNullPointer(24, true);
      } else {
        var encoder1 = encoder0.encodePointerArray(envp.length, 24, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < envp.length; ++i0) {
          encoder1.encodeUint8Array(envp[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "envp of struct _ProcessSpawnWithTerminalParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(terminalFile, 32, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "terminalFile of struct _ProcessSpawnWithTerminalParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(processController, 40, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "processController of struct _ProcessSpawnWithTerminalParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProcessSpawnWithTerminalParams("
           "path: $path" ", "
           "argv: $argv" ", "
           "envp: $envp" ", "
           "terminalFile: $terminalFile" ", "
           "processController: $processController" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class ProcessSpawnWithTerminalResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  ProcessSpawnWithTerminalResponseParams() : super(kVersions.last.size);

  static ProcessSpawnWithTerminalResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProcessSpawnWithTerminalResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProcessSpawnWithTerminalResponseParams result = new ProcessSpawnWithTerminalResponseParams();

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
          "error of struct ProcessSpawnWithTerminalResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProcessSpawnWithTerminalResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}


class _ProcessControllerWaitParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ProcessControllerWaitParams() : super(kVersions.last.size);

  static _ProcessControllerWaitParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProcessControllerWaitParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProcessControllerWaitParams result = new _ProcessControllerWaitParams();

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
    return "_ProcessControllerWaitParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class ProcessControllerWaitResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;
  int exitStatus = 0;

  ProcessControllerWaitResponseParams() : super(kVersions.last.size);

  static ProcessControllerWaitResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProcessControllerWaitResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProcessControllerWaitResponseParams result = new ProcessControllerWaitResponseParams();

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
      
      result.exitStatus = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeEnum(error, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct ProcessControllerWaitResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(exitStatus, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "exitStatus of struct ProcessControllerWaitResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProcessControllerWaitResponseParams("
           "error: $error" ", "
           "exitStatus: $exitStatus" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    map["exitStatus"] = exitStatus;
    return map;
  }
}


class _ProcessControllerKillParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int signal = 0;

  _ProcessControllerKillParams() : super(kVersions.last.size);

  static _ProcessControllerKillParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ProcessControllerKillParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ProcessControllerKillParams result = new _ProcessControllerKillParams();

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
      
      result.signal = decoder0.decodeInt32(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(signal, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "signal of struct _ProcessControllerKillParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ProcessControllerKillParams("
           "signal: $signal" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["signal"] = signal;
    return map;
  }
}


class ProcessControllerKillResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  ProcessControllerKillResponseParams() : super(kVersions.last.size);

  static ProcessControllerKillResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static ProcessControllerKillResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    ProcessControllerKillResponseParams result = new ProcessControllerKillResponseParams();

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
          "error of struct ProcessControllerKillResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "ProcessControllerKillResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}

const int _processMethodSpawnName = 0;
const int _processMethodSpawnWithTerminalName = 1;

class _ProcessServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Process {
  static const String serviceName = "native_support::Process";
  dynamic spawn(List<int> path,List<List<int>> argv,List<List<int>> envp,Object stdinFile,Object stdoutFile,Object stderrFile,Object processController,[Function responseFactory = null]);
  dynamic spawnWithTerminal(List<int> path,List<List<int>> argv,List<List<int>> envp,Object terminalFile,Object processController,[Function responseFactory = null]);
}


class _ProcessProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _ProcessProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ProcessProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ProcessProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _ProcessServiceDescription();

  String get serviceName => Process.serviceName;

  @override
  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _processMethodSpawnName:
        var r = ProcessSpawnResponseParams.deserialize(
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
      case _processMethodSpawnWithTerminalName:
        var r = ProcessSpawnWithTerminalResponseParams.deserialize(
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
    return "_ProcessProxyControl($superString)";
  }
}


class ProcessProxy extends bindings.Proxy
                              implements Process {
  ProcessProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _ProcessProxyControl.fromEndpoint(endpoint));

  ProcessProxy.fromHandle(core.MojoHandle handle)
      : super(new _ProcessProxyControl.fromHandle(handle));

  ProcessProxy.unbound()
      : super(new _ProcessProxyControl.unbound());

  static ProcessProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProcessProxy"));
    return new ProcessProxy.fromEndpoint(endpoint);
  }

  factory ProcessProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ProcessProxy p = new ProcessProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic spawn(List<int> path,List<List<int>> argv,List<List<int>> envp,Object stdinFile,Object stdoutFile,Object stderrFile,Object processController,[Function responseFactory = null]) {
    var params = new _ProcessSpawnParams();
    params.path = path;
    params.argv = argv;
    params.envp = envp;
    params.stdinFile = stdinFile;
    params.stdoutFile = stdoutFile;
    params.stderrFile = stderrFile;
    params.processController = processController;
    return ctrl.sendMessageWithRequestId(
        params,
        _processMethodSpawnName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic spawnWithTerminal(List<int> path,List<List<int>> argv,List<List<int>> envp,Object terminalFile,Object processController,[Function responseFactory = null]) {
    var params = new _ProcessSpawnWithTerminalParams();
    params.path = path;
    params.argv = argv;
    params.envp = envp;
    params.terminalFile = terminalFile;
    params.processController = processController;
    return ctrl.sendMessageWithRequestId(
        params,
        _processMethodSpawnWithTerminalName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}


class ProcessStub extends bindings.Stub {
  Process _impl;

  ProcessStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Process impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  ProcessStub.fromHandle(
      core.MojoHandle handle, [Process impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  ProcessStub.unbound([this._impl]) : super.unbound();

  static ProcessStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProcessStub"));
    return new ProcessStub.fromEndpoint(endpoint);
  }


  ProcessSpawnResponseParams _processSpawnResponseParamsFactory(types_mojom.Error error) {
    var result = new ProcessSpawnResponseParams();
    result.error = error;
    return result;
  }
  ProcessSpawnWithTerminalResponseParams _processSpawnWithTerminalResponseParamsFactory(types_mojom.Error error) {
    var result = new ProcessSpawnWithTerminalResponseParams();
    result.error = error;
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
      case _processMethodSpawnName:
        var params = _ProcessSpawnParams.deserialize(
            message.payload);
        var response = _impl.spawn(params.path,params.argv,params.envp,params.stdinFile,params.stdoutFile,params.stderrFile,params.processController,_processSpawnResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _processMethodSpawnName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _processMethodSpawnName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _processMethodSpawnWithTerminalName:
        var params = _ProcessSpawnWithTerminalParams.deserialize(
            message.payload);
        var response = _impl.spawnWithTerminal(params.path,params.argv,params.envp,params.terminalFile,params.processController,_processSpawnWithTerminalResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _processMethodSpawnWithTerminalName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _processMethodSpawnWithTerminalName,
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

  Process get impl => _impl;
  set impl(Process d) {
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
    return "ProcessStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ProcessServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

const int _processControllerMethodWaitName = 0;
const int _processControllerMethodKillName = 1;

class _ProcessControllerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ProcessController {
  static const String serviceName = null;
  dynamic wait([Function responseFactory = null]);
  dynamic kill(int signal,[Function responseFactory = null]);
}


class _ProcessControllerProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _ProcessControllerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ProcessControllerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ProcessControllerProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _ProcessControllerServiceDescription();

  String get serviceName => ProcessController.serviceName;

  @override
  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _processControllerMethodWaitName:
        var r = ProcessControllerWaitResponseParams.deserialize(
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
      case _processControllerMethodKillName:
        var r = ProcessControllerKillResponseParams.deserialize(
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
    return "_ProcessControllerProxyControl($superString)";
  }
}


class ProcessControllerProxy extends bindings.Proxy
                              implements ProcessController {
  ProcessControllerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _ProcessControllerProxyControl.fromEndpoint(endpoint));

  ProcessControllerProxy.fromHandle(core.MojoHandle handle)
      : super(new _ProcessControllerProxyControl.fromHandle(handle));

  ProcessControllerProxy.unbound()
      : super(new _ProcessControllerProxyControl.unbound());

  static ProcessControllerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProcessControllerProxy"));
    return new ProcessControllerProxy.fromEndpoint(endpoint);
  }

  factory ProcessControllerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ProcessControllerProxy p = new ProcessControllerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic wait([Function responseFactory = null]) {
    var params = new _ProcessControllerWaitParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _processControllerMethodWaitName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic kill(int signal,[Function responseFactory = null]) {
    var params = new _ProcessControllerKillParams();
    params.signal = signal;
    return ctrl.sendMessageWithRequestId(
        params,
        _processControllerMethodKillName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}


class ProcessControllerStub extends bindings.Stub {
  ProcessController _impl;

  ProcessControllerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ProcessController impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  ProcessControllerStub.fromHandle(
      core.MojoHandle handle, [ProcessController impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  ProcessControllerStub.unbound([this._impl]) : super.unbound();

  static ProcessControllerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ProcessControllerStub"));
    return new ProcessControllerStub.fromEndpoint(endpoint);
  }


  ProcessControllerWaitResponseParams _processControllerWaitResponseParamsFactory(types_mojom.Error error, int exitStatus) {
    var result = new ProcessControllerWaitResponseParams();
    result.error = error;
    result.exitStatus = exitStatus;
    return result;
  }
  ProcessControllerKillResponseParams _processControllerKillResponseParamsFactory(types_mojom.Error error) {
    var result = new ProcessControllerKillResponseParams();
    result.error = error;
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
      case _processControllerMethodWaitName:
        var response = _impl.wait(_processControllerWaitResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _processControllerMethodWaitName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _processControllerMethodWaitName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _processControllerMethodKillName:
        var params = _ProcessControllerKillParams.deserialize(
            message.payload);
        var response = _impl.kill(params.signal,_processControllerKillResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _processControllerMethodKillName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _processControllerMethodKillName,
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

  ProcessController get impl => _impl;
  set impl(ProcessController d) {
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
    return "ProcessControllerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ProcessControllerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



