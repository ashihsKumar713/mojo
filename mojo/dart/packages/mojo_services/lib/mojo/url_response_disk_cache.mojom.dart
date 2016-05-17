// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library url_response_disk_cache_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo/mojo/url_response.mojom.dart' as url_response_mojom;



class _UrlResponseDiskCacheGetParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String url = null;

  _UrlResponseDiskCacheGetParams() : super(kVersions.last.size);

  static _UrlResponseDiskCacheGetParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlResponseDiskCacheGetParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlResponseDiskCacheGetParams result = new _UrlResponseDiskCacheGetParams();

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
      
      result.url = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(url, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "url of struct _UrlResponseDiskCacheGetParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UrlResponseDiskCacheGetParams("
           "url: $url" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["url"] = url;
    return map;
  }
}


class UrlResponseDiskCacheGetResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  url_response_mojom.UrlResponse response = null;
  List<int> filePath = null;
  List<int> cacheDirPath = null;

  UrlResponseDiskCacheGetResponseParams() : super(kVersions.last.size);

  static UrlResponseDiskCacheGetResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlResponseDiskCacheGetResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlResponseDiskCacheGetResponseParams result = new UrlResponseDiskCacheGetResponseParams();

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
      
      var decoder1 = decoder0.decodePointer(8, true);
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.filePath = decoder0.decodeUint8Array(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.cacheDirPath = decoder0.decodeUint8Array(24, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct UrlResponseDiskCacheGetResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(filePath, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "filePath of struct UrlResponseDiskCacheGetResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(cacheDirPath, 24, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "cacheDirPath of struct UrlResponseDiskCacheGetResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlResponseDiskCacheGetResponseParams("
           "response: $response" ", "
           "filePath: $filePath" ", "
           "cacheDirPath: $cacheDirPath" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _UrlResponseDiskCacheValidateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String url = null;

  _UrlResponseDiskCacheValidateParams() : super(kVersions.last.size);

  static _UrlResponseDiskCacheValidateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlResponseDiskCacheValidateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlResponseDiskCacheValidateParams result = new _UrlResponseDiskCacheValidateParams();

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
      
      result.url = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(url, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "url of struct _UrlResponseDiskCacheValidateParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UrlResponseDiskCacheValidateParams("
           "url: $url" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["url"] = url;
    return map;
  }
}


class _UrlResponseDiskCacheUpdateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_response_mojom.UrlResponse response = null;

  _UrlResponseDiskCacheUpdateParams() : super(kVersions.last.size);

  static _UrlResponseDiskCacheUpdateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlResponseDiskCacheUpdateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlResponseDiskCacheUpdateParams result = new _UrlResponseDiskCacheUpdateParams();

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
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct _UrlResponseDiskCacheUpdateParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UrlResponseDiskCacheUpdateParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _UrlResponseDiskCacheUpdateAndGetParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_response_mojom.UrlResponse response = null;

  _UrlResponseDiskCacheUpdateAndGetParams() : super(kVersions.last.size);

  static _UrlResponseDiskCacheUpdateAndGetParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlResponseDiskCacheUpdateAndGetParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlResponseDiskCacheUpdateAndGetParams result = new _UrlResponseDiskCacheUpdateAndGetParams();

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
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct _UrlResponseDiskCacheUpdateAndGetParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UrlResponseDiskCacheUpdateAndGetParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class UrlResponseDiskCacheUpdateAndGetResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  List<int> filePath = null;
  List<int> cacheDirPath = null;

  UrlResponseDiskCacheUpdateAndGetResponseParams() : super(kVersions.last.size);

  static UrlResponseDiskCacheUpdateAndGetResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlResponseDiskCacheUpdateAndGetResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlResponseDiskCacheUpdateAndGetResponseParams result = new UrlResponseDiskCacheUpdateAndGetResponseParams();

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
      
      result.filePath = decoder0.decodeUint8Array(8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.cacheDirPath = decoder0.decodeUint8Array(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8Array(filePath, 8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "filePath of struct UrlResponseDiskCacheUpdateAndGetResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(cacheDirPath, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "cacheDirPath of struct UrlResponseDiskCacheUpdateAndGetResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlResponseDiskCacheUpdateAndGetResponseParams("
           "filePath: $filePath" ", "
           "cacheDirPath: $cacheDirPath" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["filePath"] = filePath;
    map["cacheDirPath"] = cacheDirPath;
    return map;
  }
}


class _UrlResponseDiskCacheUpdateAndGetExtractedParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  url_response_mojom.UrlResponse response = null;

  _UrlResponseDiskCacheUpdateAndGetExtractedParams() : super(kVersions.last.size);

  static _UrlResponseDiskCacheUpdateAndGetExtractedParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _UrlResponseDiskCacheUpdateAndGetExtractedParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _UrlResponseDiskCacheUpdateAndGetExtractedParams result = new _UrlResponseDiskCacheUpdateAndGetExtractedParams();

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
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.response = url_response_mojom.UrlResponse.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(response, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "response of struct _UrlResponseDiskCacheUpdateAndGetExtractedParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_UrlResponseDiskCacheUpdateAndGetExtractedParams("
           "response: $response" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class UrlResponseDiskCacheUpdateAndGetExtractedResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  List<int> extractedDirPath = null;
  List<int> cacheDirPath = null;

  UrlResponseDiskCacheUpdateAndGetExtractedResponseParams() : super(kVersions.last.size);

  static UrlResponseDiskCacheUpdateAndGetExtractedResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static UrlResponseDiskCacheUpdateAndGetExtractedResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    UrlResponseDiskCacheUpdateAndGetExtractedResponseParams result = new UrlResponseDiskCacheUpdateAndGetExtractedResponseParams();

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
      
      result.extractedDirPath = decoder0.decodeUint8Array(8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    if (mainDataHeader.version >= 0) {
      
      result.cacheDirPath = decoder0.decodeUint8Array(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint8Array(extractedDirPath, 8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "extractedDirPath of struct UrlResponseDiskCacheUpdateAndGetExtractedResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(cacheDirPath, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "cacheDirPath of struct UrlResponseDiskCacheUpdateAndGetExtractedResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "UrlResponseDiskCacheUpdateAndGetExtractedResponseParams("
           "extractedDirPath: $extractedDirPath" ", "
           "cacheDirPath: $cacheDirPath" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["extractedDirPath"] = extractedDirPath;
    map["cacheDirPath"] = cacheDirPath;
    return map;
  }
}

const int _urlResponseDiskCacheMethodGetName = 0;
const int _urlResponseDiskCacheMethodValidateName = 1;
const int _urlResponseDiskCacheMethodUpdateName = 2;
const int _urlResponseDiskCacheMethodUpdateAndGetName = 3;
const int _urlResponseDiskCacheMethodUpdateAndGetExtractedName = 4;

class _UrlResponseDiskCacheServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class UrlResponseDiskCache {
  static const String serviceName = "mojo::URLResponseDiskCache";
  dynamic get(String url,[Function responseFactory = null]);
  void validate(String url);
  void update(url_response_mojom.UrlResponse response);
  dynamic updateAndGet(url_response_mojom.UrlResponse response,[Function responseFactory = null]);
  dynamic updateAndGetExtracted(url_response_mojom.UrlResponse response,[Function responseFactory = null]);
}

class _UrlResponseDiskCacheProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _UrlResponseDiskCacheProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _UrlResponseDiskCacheProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _UrlResponseDiskCacheProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _UrlResponseDiskCacheServiceDescription();

  String get serviceName => UrlResponseDiskCache.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _urlResponseDiskCacheMethodGetName:
        var r = UrlResponseDiskCacheGetResponseParams.deserialize(
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
      case _urlResponseDiskCacheMethodUpdateAndGetName:
        var r = UrlResponseDiskCacheUpdateAndGetResponseParams.deserialize(
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
      case _urlResponseDiskCacheMethodUpdateAndGetExtractedName:
        var r = UrlResponseDiskCacheUpdateAndGetExtractedResponseParams.deserialize(
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
    return "_UrlResponseDiskCacheProxyControl($superString)";
  }
}

class UrlResponseDiskCacheProxy
    extends bindings.Proxy
    implements UrlResponseDiskCache {
  UrlResponseDiskCacheProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _UrlResponseDiskCacheProxyControl.fromEndpoint(endpoint));

  UrlResponseDiskCacheProxy.fromHandle(core.MojoHandle handle)
      : super(new _UrlResponseDiskCacheProxyControl.fromHandle(handle));

  UrlResponseDiskCacheProxy.unbound()
      : super(new _UrlResponseDiskCacheProxyControl.unbound());

  static UrlResponseDiskCacheProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlResponseDiskCacheProxy"));
    return new UrlResponseDiskCacheProxy.fromEndpoint(endpoint);
  }

  factory UrlResponseDiskCacheProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    UrlResponseDiskCacheProxy p = new UrlResponseDiskCacheProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic get(String url,[Function responseFactory = null]) {
    var params = new _UrlResponseDiskCacheGetParams();
    params.url = url;
    return ctrl.sendMessageWithRequestId(
        params,
        _urlResponseDiskCacheMethodGetName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void validate(String url) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _UrlResponseDiskCacheValidateParams();
    params.url = url;
    ctrl.sendMessage(params,
        _urlResponseDiskCacheMethodValidateName);
  }
  void update(url_response_mojom.UrlResponse response) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _UrlResponseDiskCacheUpdateParams();
    params.response = response;
    ctrl.sendMessage(params,
        _urlResponseDiskCacheMethodUpdateName);
  }
  dynamic updateAndGet(url_response_mojom.UrlResponse response,[Function responseFactory = null]) {
    var params = new _UrlResponseDiskCacheUpdateAndGetParams();
    params.response = response;
    return ctrl.sendMessageWithRequestId(
        params,
        _urlResponseDiskCacheMethodUpdateAndGetName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic updateAndGetExtracted(url_response_mojom.UrlResponse response,[Function responseFactory = null]) {
    var params = new _UrlResponseDiskCacheUpdateAndGetExtractedParams();
    params.response = response;
    return ctrl.sendMessageWithRequestId(
        params,
        _urlResponseDiskCacheMethodUpdateAndGetExtractedName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _UrlResponseDiskCacheStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<UrlResponseDiskCache> {
  UrlResponseDiskCache _impl;

  _UrlResponseDiskCacheStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [UrlResponseDiskCache impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _UrlResponseDiskCacheStubControl.fromHandle(
      core.MojoHandle handle, [UrlResponseDiskCache impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _UrlResponseDiskCacheStubControl.unbound([this._impl]) : super.unbound();


  UrlResponseDiskCacheGetResponseParams _urlResponseDiskCacheGetResponseParamsFactory(url_response_mojom.UrlResponse response, List<int> filePath, List<int> cacheDirPath) {
    var result = new UrlResponseDiskCacheGetResponseParams();
    result.response = response;
    result.filePath = filePath;
    result.cacheDirPath = cacheDirPath;
    return result;
  }
  UrlResponseDiskCacheUpdateAndGetResponseParams _urlResponseDiskCacheUpdateAndGetResponseParamsFactory(List<int> filePath, List<int> cacheDirPath) {
    var result = new UrlResponseDiskCacheUpdateAndGetResponseParams();
    result.filePath = filePath;
    result.cacheDirPath = cacheDirPath;
    return result;
  }
  UrlResponseDiskCacheUpdateAndGetExtractedResponseParams _urlResponseDiskCacheUpdateAndGetExtractedResponseParamsFactory(List<int> extractedDirPath, List<int> cacheDirPath) {
    var result = new UrlResponseDiskCacheUpdateAndGetExtractedResponseParams();
    result.extractedDirPath = extractedDirPath;
    result.cacheDirPath = cacheDirPath;
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
      case _urlResponseDiskCacheMethodGetName:
        var params = _UrlResponseDiskCacheGetParams.deserialize(
            message.payload);
        var response = _impl.get(params.url,_urlResponseDiskCacheGetResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _urlResponseDiskCacheMethodGetName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _urlResponseDiskCacheMethodGetName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _urlResponseDiskCacheMethodValidateName:
        var params = _UrlResponseDiskCacheValidateParams.deserialize(
            message.payload);
        _impl.validate(params.url);
        break;
      case _urlResponseDiskCacheMethodUpdateName:
        var params = _UrlResponseDiskCacheUpdateParams.deserialize(
            message.payload);
        _impl.update(params.response);
        break;
      case _urlResponseDiskCacheMethodUpdateAndGetName:
        var params = _UrlResponseDiskCacheUpdateAndGetParams.deserialize(
            message.payload);
        var response = _impl.updateAndGet(params.response,_urlResponseDiskCacheUpdateAndGetResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _urlResponseDiskCacheMethodUpdateAndGetName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _urlResponseDiskCacheMethodUpdateAndGetName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _urlResponseDiskCacheMethodUpdateAndGetExtractedName:
        var params = _UrlResponseDiskCacheUpdateAndGetExtractedParams.deserialize(
            message.payload);
        var response = _impl.updateAndGetExtracted(params.response,_urlResponseDiskCacheUpdateAndGetExtractedResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _urlResponseDiskCacheMethodUpdateAndGetExtractedName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _urlResponseDiskCacheMethodUpdateAndGetExtractedName,
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

  UrlResponseDiskCache get impl => _impl;
  set impl(UrlResponseDiskCache d) {
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
    return "_UrlResponseDiskCacheStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _UrlResponseDiskCacheServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class UrlResponseDiskCacheStub
    extends bindings.Stub<UrlResponseDiskCache>
    implements UrlResponseDiskCache {
  UrlResponseDiskCacheStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [UrlResponseDiskCache impl])
      : super(new _UrlResponseDiskCacheStubControl.fromEndpoint(endpoint, impl));

  UrlResponseDiskCacheStub.fromHandle(
      core.MojoHandle handle, [UrlResponseDiskCache impl])
      : super(new _UrlResponseDiskCacheStubControl.fromHandle(handle, impl));

  UrlResponseDiskCacheStub.unbound([UrlResponseDiskCache impl])
      : super(new _UrlResponseDiskCacheStubControl.unbound(impl));

  static UrlResponseDiskCacheStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlResponseDiskCacheStub"));
    return new UrlResponseDiskCacheStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _UrlResponseDiskCacheStubControl.serviceDescription;


  dynamic get(String url,[Function responseFactory = null]) {
    return impl.get(url,responseFactory);
  }
  void validate(String url) {
    return impl.validate(url);
  }
  void update(url_response_mojom.UrlResponse response) {
    return impl.update(response);
  }
  dynamic updateAndGet(url_response_mojom.UrlResponse response,[Function responseFactory = null]) {
    return impl.updateAndGet(response,responseFactory);
  }
  dynamic updateAndGetExtracted(url_response_mojom.UrlResponse response,[Function responseFactory = null]) {
    return impl.updateAndGetExtracted(response,responseFactory);
  }
}



