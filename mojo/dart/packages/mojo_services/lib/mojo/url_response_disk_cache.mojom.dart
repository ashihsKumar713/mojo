// WARNING: DO NOT EDIT. This file was generated by a program.
// See $MOJO_SDK/tools/bindings/mojom_bindings_generator.py.

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

  _UrlResponseDiskCacheGetParams.init(
    String this.url
  ) : super(kVersions.last.size);

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

  UrlResponseDiskCacheGetResponseParams.init(
    url_response_mojom.UrlResponse this.response, 
    List<int> this.filePath, 
    List<int> this.cacheDirPath
  ) : super(kVersions.last.size);

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

  _UrlResponseDiskCacheValidateParams.init(
    String this.url
  ) : super(kVersions.last.size);

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

  _UrlResponseDiskCacheUpdateParams.init(
    url_response_mojom.UrlResponse this.response
  ) : super(kVersions.last.size);

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

  _UrlResponseDiskCacheUpdateAndGetParams.init(
    url_response_mojom.UrlResponse this.response
  ) : super(kVersions.last.size);

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

  UrlResponseDiskCacheUpdateAndGetResponseParams.init(
    List<int> this.filePath, 
    List<int> this.cacheDirPath
  ) : super(kVersions.last.size);

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

  _UrlResponseDiskCacheUpdateAndGetExtractedParams.init(
    url_response_mojom.UrlResponse this.response
  ) : super(kVersions.last.size);

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

  UrlResponseDiskCacheUpdateAndGetExtractedResponseParams.init(
    List<int> this.extractedDirPath, 
    List<int> this.cacheDirPath
  ) : super(kVersions.last.size);

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

abstract class UrlResponseDiskCache {
  static const String serviceName = "mojo::URLResponseDiskCache";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _UrlResponseDiskCacheServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static UrlResponseDiskCacheProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    UrlResponseDiskCacheProxy p = new UrlResponseDiskCacheProxy.unbound();
    String name = serviceName ?? UrlResponseDiskCache.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void get(String url,void callback(url_response_mojom.UrlResponse response, List<int> filePath, List<int> cacheDirPath));
  void validate(String url);
  void update(url_response_mojom.UrlResponse response);
  void updateAndGet(url_response_mojom.UrlResponse response,void callback(List<int> filePath, List<int> cacheDirPath));
  void updateAndGetExtracted(url_response_mojom.UrlResponse response,void callback(List<int> extractedDirPath, List<int> cacheDirPath));
}

abstract class UrlResponseDiskCacheInterface
    implements bindings.MojoInterface<UrlResponseDiskCache>,
               UrlResponseDiskCache {
  factory UrlResponseDiskCacheInterface([UrlResponseDiskCache impl]) =>
      new UrlResponseDiskCacheStub.unbound(impl);

  factory UrlResponseDiskCacheInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [UrlResponseDiskCache impl]) =>
      new UrlResponseDiskCacheStub.fromEndpoint(endpoint, impl);

  factory UrlResponseDiskCacheInterface.fromMock(
      UrlResponseDiskCache mock) =>
      new UrlResponseDiskCacheProxy.fromMock(mock);
}

abstract class UrlResponseDiskCacheInterfaceRequest
    implements bindings.MojoInterface<UrlResponseDiskCache>,
               UrlResponseDiskCache {
  factory UrlResponseDiskCacheInterfaceRequest() =>
      new UrlResponseDiskCacheProxy.unbound();
}

class _UrlResponseDiskCacheProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<UrlResponseDiskCache> {
  UrlResponseDiskCache impl;

  _UrlResponseDiskCacheProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _UrlResponseDiskCacheProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _UrlResponseDiskCacheProxyControl.unbound() : super.unbound();

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
        Function callback = callbackMap[message.header.requestId];
        if (callback == null) {
          proxyError(
              "Message had unknown request Id: ${message.header.requestId}");
          return;
        }
        callbackMap.remove(message.header.requestId);
        callback(r.response , r.filePath , r.cacheDirPath );
        break;
      case _urlResponseDiskCacheMethodUpdateAndGetName:
        var r = UrlResponseDiskCacheUpdateAndGetResponseParams.deserialize(
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
        callback(r.filePath , r.cacheDirPath );
        break;
      case _urlResponseDiskCacheMethodUpdateAndGetExtractedName:
        var r = UrlResponseDiskCacheUpdateAndGetExtractedResponseParams.deserialize(
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
        callback(r.extractedDirPath , r.cacheDirPath );
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
    extends bindings.Proxy<UrlResponseDiskCache>
    implements UrlResponseDiskCache,
               UrlResponseDiskCacheInterface,
               UrlResponseDiskCacheInterfaceRequest {
  UrlResponseDiskCacheProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _UrlResponseDiskCacheProxyControl.fromEndpoint(endpoint));

  UrlResponseDiskCacheProxy.fromHandle(core.MojoHandle handle)
      : super(new _UrlResponseDiskCacheProxyControl.fromHandle(handle));

  UrlResponseDiskCacheProxy.unbound()
      : super(new _UrlResponseDiskCacheProxyControl.unbound());

  factory UrlResponseDiskCacheProxy.fromMock(UrlResponseDiskCache mock) {
    UrlResponseDiskCacheProxy newMockedProxy =
        new UrlResponseDiskCacheProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static UrlResponseDiskCacheProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlResponseDiskCacheProxy"));
    return new UrlResponseDiskCacheProxy.fromEndpoint(endpoint);
  }


  void get(String url,void callback(url_response_mojom.UrlResponse response, List<int> filePath, List<int> cacheDirPath)) {
    if (impl != null) {
      impl.get(url,callback);
      return;
    }
    var params = new _UrlResponseDiskCacheGetParams();
    params.url = url;
    ctrl.sendMessageWithRequestId(
        params,
        _urlResponseDiskCacheMethodGetName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse,
        callback);
  }
  void validate(String url) {
    if (impl != null) {
      impl.validate(url);
      return;
    }
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
    if (impl != null) {
      impl.update(response);
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _UrlResponseDiskCacheUpdateParams();
    params.response = response;
    ctrl.sendMessage(params,
        _urlResponseDiskCacheMethodUpdateName);
  }
  void updateAndGet(url_response_mojom.UrlResponse response,void callback(List<int> filePath, List<int> cacheDirPath)) {
    if (impl != null) {
      impl.updateAndGet(response,callback);
      return;
    }
    var params = new _UrlResponseDiskCacheUpdateAndGetParams();
    params.response = response;
    ctrl.sendMessageWithRequestId(
        params,
        _urlResponseDiskCacheMethodUpdateAndGetName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse,
        callback);
  }
  void updateAndGetExtracted(url_response_mojom.UrlResponse response,void callback(List<int> extractedDirPath, List<int> cacheDirPath)) {
    if (impl != null) {
      impl.updateAndGetExtracted(response,callback);
      return;
    }
    var params = new _UrlResponseDiskCacheUpdateAndGetExtractedParams();
    params.response = response;
    ctrl.sendMessageWithRequestId(
        params,
        _urlResponseDiskCacheMethodUpdateAndGetExtractedName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse,
        callback);
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

  String get serviceName => UrlResponseDiskCache.serviceName;


  Function _urlResponseDiskCacheGetResponseParamsResponder(
      int requestId) {
  return (url_response_mojom.UrlResponse response, List<int> filePath, List<int> cacheDirPath) {
      var result = new UrlResponseDiskCacheGetResponseParams();
      result.response = response;
      result.filePath = filePath;
      result.cacheDirPath = cacheDirPath;
      sendResponse(buildResponseWithId(
          result,
          _urlResponseDiskCacheMethodGetName,
          requestId,
          bindings.MessageHeader.kMessageIsResponse));
    };
  }
  Function _urlResponseDiskCacheUpdateAndGetResponseParamsResponder(
      int requestId) {
  return (List<int> filePath, List<int> cacheDirPath) {
      var result = new UrlResponseDiskCacheUpdateAndGetResponseParams();
      result.filePath = filePath;
      result.cacheDirPath = cacheDirPath;
      sendResponse(buildResponseWithId(
          result,
          _urlResponseDiskCacheMethodUpdateAndGetName,
          requestId,
          bindings.MessageHeader.kMessageIsResponse));
    };
  }
  Function _urlResponseDiskCacheUpdateAndGetExtractedResponseParamsResponder(
      int requestId) {
  return (List<int> extractedDirPath, List<int> cacheDirPath) {
      var result = new UrlResponseDiskCacheUpdateAndGetExtractedResponseParams();
      result.extractedDirPath = extractedDirPath;
      result.cacheDirPath = cacheDirPath;
      sendResponse(buildResponseWithId(
          result,
          _urlResponseDiskCacheMethodUpdateAndGetExtractedName,
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
      case _urlResponseDiskCacheMethodGetName:
        var params = _UrlResponseDiskCacheGetParams.deserialize(
            message.payload);
        _impl.get(params.url, _urlResponseDiskCacheGetResponseParamsResponder(message.header.requestId));
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
        _impl.updateAndGet(params.response, _urlResponseDiskCacheUpdateAndGetResponseParamsResponder(message.header.requestId));
        break;
      case _urlResponseDiskCacheMethodUpdateAndGetExtractedName:
        var params = _UrlResponseDiskCacheUpdateAndGetExtractedParams.deserialize(
            message.payload);
        _impl.updateAndGetExtracted(params.response, _urlResponseDiskCacheUpdateAndGetExtractedResponseParamsResponder(message.header.requestId));
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
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
}

class UrlResponseDiskCacheStub
    extends bindings.Stub<UrlResponseDiskCache>
    implements UrlResponseDiskCache,
               UrlResponseDiskCacheInterface,
               UrlResponseDiskCacheInterfaceRequest {
  UrlResponseDiskCacheStub.unbound([UrlResponseDiskCache impl])
      : super(new _UrlResponseDiskCacheStubControl.unbound(impl));

  UrlResponseDiskCacheStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [UrlResponseDiskCache impl])
      : super(new _UrlResponseDiskCacheStubControl.fromEndpoint(endpoint, impl));

  UrlResponseDiskCacheStub.fromHandle(
      core.MojoHandle handle, [UrlResponseDiskCache impl])
      : super(new _UrlResponseDiskCacheStubControl.fromHandle(handle, impl));

  static UrlResponseDiskCacheStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For UrlResponseDiskCacheStub"));
    return new UrlResponseDiskCacheStub.fromEndpoint(endpoint);
  }


  void get(String url,void callback(url_response_mojom.UrlResponse response, List<int> filePath, List<int> cacheDirPath)) {
    return impl.get(url,callback);
  }
  void validate(String url) {
    return impl.validate(url);
  }
  void update(url_response_mojom.UrlResponse response) {
    return impl.update(response);
  }
  void updateAndGet(url_response_mojom.UrlResponse response,void callback(List<int> filePath, List<int> cacheDirPath)) {
    return impl.updateAndGet(response,callback);
  }
  void updateAndGetExtracted(url_response_mojom.UrlResponse response,void callback(List<int> extractedDirPath, List<int> cacheDirPath)) {
    return impl.updateAndGetExtracted(response,callback);
  }
}



