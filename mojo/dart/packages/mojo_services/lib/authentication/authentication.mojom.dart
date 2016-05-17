// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library authentication_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _AuthenticationServiceSelectAccountParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool returnLastSelected = false;

  _AuthenticationServiceSelectAccountParams() : super(kVersions.last.size);

  static _AuthenticationServiceSelectAccountParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AuthenticationServiceSelectAccountParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AuthenticationServiceSelectAccountParams result = new _AuthenticationServiceSelectAccountParams();

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
      
      result.returnLastSelected = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(returnLastSelected, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "returnLastSelected of struct _AuthenticationServiceSelectAccountParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_AuthenticationServiceSelectAccountParams("
           "returnLastSelected: $returnLastSelected" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["returnLastSelected"] = returnLastSelected;
    return map;
  }
}


class AuthenticationServiceSelectAccountResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String username = null;
  String error = null;

  AuthenticationServiceSelectAccountResponseParams() : super(kVersions.last.size);

  static AuthenticationServiceSelectAccountResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AuthenticationServiceSelectAccountResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AuthenticationServiceSelectAccountResponseParams result = new AuthenticationServiceSelectAccountResponseParams();

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
      
      result.username = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.error = decoder0.decodeString(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(username, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "username of struct AuthenticationServiceSelectAccountResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(error, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct AuthenticationServiceSelectAccountResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "AuthenticationServiceSelectAccountResponseParams("
           "username: $username" ", "
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["username"] = username;
    map["error"] = error;
    return map;
  }
}


class _AuthenticationServiceGetOAuth2TokenParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String username = null;
  List<String> scopes = null;

  _AuthenticationServiceGetOAuth2TokenParams() : super(kVersions.last.size);

  static _AuthenticationServiceGetOAuth2TokenParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AuthenticationServiceGetOAuth2TokenParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AuthenticationServiceGetOAuth2TokenParams result = new _AuthenticationServiceGetOAuth2TokenParams();

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
      
      result.username = decoder0.decodeString(8, false);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.scopes = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.scopes[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(username, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "username of struct _AuthenticationServiceGetOAuth2TokenParams: $e";
      rethrow;
    }
    try {
      if (scopes == null) {
        encoder0.encodeNullPointer(16, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(scopes.length, 16, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < scopes.length; ++i0) {
          encoder1.encodeString(scopes[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "scopes of struct _AuthenticationServiceGetOAuth2TokenParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_AuthenticationServiceGetOAuth2TokenParams("
           "username: $username" ", "
           "scopes: $scopes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["username"] = username;
    map["scopes"] = scopes;
    return map;
  }
}


class AuthenticationServiceGetOAuth2TokenResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String token = null;
  String error = null;

  AuthenticationServiceGetOAuth2TokenResponseParams() : super(kVersions.last.size);

  static AuthenticationServiceGetOAuth2TokenResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AuthenticationServiceGetOAuth2TokenResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AuthenticationServiceGetOAuth2TokenResponseParams result = new AuthenticationServiceGetOAuth2TokenResponseParams();

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
      
      result.token = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.error = decoder0.decodeString(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(token, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "token of struct AuthenticationServiceGetOAuth2TokenResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(error, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct AuthenticationServiceGetOAuth2TokenResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "AuthenticationServiceGetOAuth2TokenResponseParams("
           "token: $token" ", "
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["token"] = token;
    map["error"] = error;
    return map;
  }
}


class _AuthenticationServiceClearOAuth2TokenParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String token = null;

  _AuthenticationServiceClearOAuth2TokenParams() : super(kVersions.last.size);

  static _AuthenticationServiceClearOAuth2TokenParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AuthenticationServiceClearOAuth2TokenParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AuthenticationServiceClearOAuth2TokenParams result = new _AuthenticationServiceClearOAuth2TokenParams();

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
      
      result.token = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(token, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "token of struct _AuthenticationServiceClearOAuth2TokenParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_AuthenticationServiceClearOAuth2TokenParams("
           "token: $token" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["token"] = token;
    return map;
  }
}


class _AuthenticationServiceGetOAuth2DeviceCodeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<String> scopes = null;

  _AuthenticationServiceGetOAuth2DeviceCodeParams() : super(kVersions.last.size);

  static _AuthenticationServiceGetOAuth2DeviceCodeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AuthenticationServiceGetOAuth2DeviceCodeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AuthenticationServiceGetOAuth2DeviceCodeParams result = new _AuthenticationServiceGetOAuth2DeviceCodeParams();

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
      {
        var si1 = decoder1.decodeDataHeaderForPointerArray(bindings.kUnspecifiedArrayLength);
        result.scopes = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.scopes[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (scopes == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(scopes.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < scopes.length; ++i0) {
          encoder1.encodeString(scopes[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "scopes of struct _AuthenticationServiceGetOAuth2DeviceCodeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_AuthenticationServiceGetOAuth2DeviceCodeParams("
           "scopes: $scopes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["scopes"] = scopes;
    return map;
  }
}


class AuthenticationServiceGetOAuth2DeviceCodeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  String verificationUrl = null;
  String deviceCode = null;
  String userCode = null;
  String error = null;

  AuthenticationServiceGetOAuth2DeviceCodeResponseParams() : super(kVersions.last.size);

  static AuthenticationServiceGetOAuth2DeviceCodeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AuthenticationServiceGetOAuth2DeviceCodeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AuthenticationServiceGetOAuth2DeviceCodeResponseParams result = new AuthenticationServiceGetOAuth2DeviceCodeResponseParams();

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
      
      result.verificationUrl = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.deviceCode = decoder0.decodeString(16, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.userCode = decoder0.decodeString(24, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.error = decoder0.decodeString(32, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(verificationUrl, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "verificationUrl of struct AuthenticationServiceGetOAuth2DeviceCodeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(deviceCode, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "deviceCode of struct AuthenticationServiceGetOAuth2DeviceCodeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(userCode, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "userCode of struct AuthenticationServiceGetOAuth2DeviceCodeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(error, 32, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct AuthenticationServiceGetOAuth2DeviceCodeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "AuthenticationServiceGetOAuth2DeviceCodeResponseParams("
           "verificationUrl: $verificationUrl" ", "
           "deviceCode: $deviceCode" ", "
           "userCode: $userCode" ", "
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["verificationUrl"] = verificationUrl;
    map["deviceCode"] = deviceCode;
    map["userCode"] = userCode;
    map["error"] = error;
    return map;
  }
}


class _AuthenticationServiceAddAccountParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String deviceCode = null;

  _AuthenticationServiceAddAccountParams() : super(kVersions.last.size);

  static _AuthenticationServiceAddAccountParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AuthenticationServiceAddAccountParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AuthenticationServiceAddAccountParams result = new _AuthenticationServiceAddAccountParams();

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
      
      result.deviceCode = decoder0.decodeString(8, false);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(deviceCode, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "deviceCode of struct _AuthenticationServiceAddAccountParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_AuthenticationServiceAddAccountParams("
           "deviceCode: $deviceCode" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["deviceCode"] = deviceCode;
    return map;
  }
}


class AuthenticationServiceAddAccountResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String username = null;
  String error = null;

  AuthenticationServiceAddAccountResponseParams() : super(kVersions.last.size);

  static AuthenticationServiceAddAccountResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AuthenticationServiceAddAccountResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AuthenticationServiceAddAccountResponseParams result = new AuthenticationServiceAddAccountResponseParams();

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
      
      result.username = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.error = decoder0.decodeString(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(username, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "username of struct AuthenticationServiceAddAccountResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(error, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct AuthenticationServiceAddAccountResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "AuthenticationServiceAddAccountResponseParams("
           "username: $username" ", "
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["username"] = username;
    map["error"] = error;
    return map;
  }
}

const int _authenticationServiceMethodSelectAccountName = 0;
const int _authenticationServiceMethodGetOAuth2TokenName = 1;
const int _authenticationServiceMethodClearOAuth2TokenName = 2;
const int _authenticationServiceMethodGetOAuth2DeviceCodeName = 3;
const int _authenticationServiceMethodAddAccountName = 4;

class _AuthenticationServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class AuthenticationService {
  static const String serviceName = "authentication::AuthenticationService";
  dynamic selectAccount(bool returnLastSelected,[Function responseFactory = null]);
  dynamic getOAuth2Token(String username,List<String> scopes,[Function responseFactory = null]);
  void clearOAuth2Token(String token);
  dynamic getOAuth2DeviceCode(List<String> scopes,[Function responseFactory = null]);
  dynamic addAccount(String deviceCode,[Function responseFactory = null]);
}

class _AuthenticationServiceProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _AuthenticationServiceProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _AuthenticationServiceProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _AuthenticationServiceProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _AuthenticationServiceServiceDescription();

  String get serviceName => AuthenticationService.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _authenticationServiceMethodSelectAccountName:
        var r = AuthenticationServiceSelectAccountResponseParams.deserialize(
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
      case _authenticationServiceMethodGetOAuth2TokenName:
        var r = AuthenticationServiceGetOAuth2TokenResponseParams.deserialize(
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
      case _authenticationServiceMethodGetOAuth2DeviceCodeName:
        var r = AuthenticationServiceGetOAuth2DeviceCodeResponseParams.deserialize(
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
      case _authenticationServiceMethodAddAccountName:
        var r = AuthenticationServiceAddAccountResponseParams.deserialize(
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
    return "_AuthenticationServiceProxyControl($superString)";
  }
}

class AuthenticationServiceProxy
    extends bindings.Proxy
    implements AuthenticationService {
  AuthenticationServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _AuthenticationServiceProxyControl.fromEndpoint(endpoint));

  AuthenticationServiceProxy.fromHandle(core.MojoHandle handle)
      : super(new _AuthenticationServiceProxyControl.fromHandle(handle));

  AuthenticationServiceProxy.unbound()
      : super(new _AuthenticationServiceProxyControl.unbound());

  static AuthenticationServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AuthenticationServiceProxy"));
    return new AuthenticationServiceProxy.fromEndpoint(endpoint);
  }

  factory AuthenticationServiceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    AuthenticationServiceProxy p = new AuthenticationServiceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  dynamic selectAccount(bool returnLastSelected,[Function responseFactory = null]) {
    var params = new _AuthenticationServiceSelectAccountParams();
    params.returnLastSelected = returnLastSelected;
    return ctrl.sendMessageWithRequestId(
        params,
        _authenticationServiceMethodSelectAccountName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic getOAuth2Token(String username,List<String> scopes,[Function responseFactory = null]) {
    var params = new _AuthenticationServiceGetOAuth2TokenParams();
    params.username = username;
    params.scopes = scopes;
    return ctrl.sendMessageWithRequestId(
        params,
        _authenticationServiceMethodGetOAuth2TokenName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  void clearOAuth2Token(String token) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _AuthenticationServiceClearOAuth2TokenParams();
    params.token = token;
    ctrl.sendMessage(params,
        _authenticationServiceMethodClearOAuth2TokenName);
  }
  dynamic getOAuth2DeviceCode(List<String> scopes,[Function responseFactory = null]) {
    var params = new _AuthenticationServiceGetOAuth2DeviceCodeParams();
    params.scopes = scopes;
    return ctrl.sendMessageWithRequestId(
        params,
        _authenticationServiceMethodGetOAuth2DeviceCodeName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic addAccount(String deviceCode,[Function responseFactory = null]) {
    var params = new _AuthenticationServiceAddAccountParams();
    params.deviceCode = deviceCode;
    return ctrl.sendMessageWithRequestId(
        params,
        _authenticationServiceMethodAddAccountName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _AuthenticationServiceStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<AuthenticationService> {
  AuthenticationService _impl;

  _AuthenticationServiceStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [AuthenticationService impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _AuthenticationServiceStubControl.fromHandle(
      core.MojoHandle handle, [AuthenticationService impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _AuthenticationServiceStubControl.unbound([this._impl]) : super.unbound();


  AuthenticationServiceSelectAccountResponseParams _authenticationServiceSelectAccountResponseParamsFactory(String username, String error) {
    var result = new AuthenticationServiceSelectAccountResponseParams();
    result.username = username;
    result.error = error;
    return result;
  }
  AuthenticationServiceGetOAuth2TokenResponseParams _authenticationServiceGetOAuth2TokenResponseParamsFactory(String token, String error) {
    var result = new AuthenticationServiceGetOAuth2TokenResponseParams();
    result.token = token;
    result.error = error;
    return result;
  }
  AuthenticationServiceGetOAuth2DeviceCodeResponseParams _authenticationServiceGetOAuth2DeviceCodeResponseParamsFactory(String verificationUrl, String deviceCode, String userCode, String error) {
    var result = new AuthenticationServiceGetOAuth2DeviceCodeResponseParams();
    result.verificationUrl = verificationUrl;
    result.deviceCode = deviceCode;
    result.userCode = userCode;
    result.error = error;
    return result;
  }
  AuthenticationServiceAddAccountResponseParams _authenticationServiceAddAccountResponseParamsFactory(String username, String error) {
    var result = new AuthenticationServiceAddAccountResponseParams();
    result.username = username;
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
      case _authenticationServiceMethodSelectAccountName:
        var params = _AuthenticationServiceSelectAccountParams.deserialize(
            message.payload);
        var response = _impl.selectAccount(params.returnLastSelected,_authenticationServiceSelectAccountResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _authenticationServiceMethodSelectAccountName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _authenticationServiceMethodSelectAccountName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _authenticationServiceMethodGetOAuth2TokenName:
        var params = _AuthenticationServiceGetOAuth2TokenParams.deserialize(
            message.payload);
        var response = _impl.getOAuth2Token(params.username,params.scopes,_authenticationServiceGetOAuth2TokenResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _authenticationServiceMethodGetOAuth2TokenName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _authenticationServiceMethodGetOAuth2TokenName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _authenticationServiceMethodClearOAuth2TokenName:
        var params = _AuthenticationServiceClearOAuth2TokenParams.deserialize(
            message.payload);
        _impl.clearOAuth2Token(params.token);
        break;
      case _authenticationServiceMethodGetOAuth2DeviceCodeName:
        var params = _AuthenticationServiceGetOAuth2DeviceCodeParams.deserialize(
            message.payload);
        var response = _impl.getOAuth2DeviceCode(params.scopes,_authenticationServiceGetOAuth2DeviceCodeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _authenticationServiceMethodGetOAuth2DeviceCodeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _authenticationServiceMethodGetOAuth2DeviceCodeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _authenticationServiceMethodAddAccountName:
        var params = _AuthenticationServiceAddAccountParams.deserialize(
            message.payload);
        var response = _impl.addAccount(params.deviceCode,_authenticationServiceAddAccountResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _authenticationServiceMethodAddAccountName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _authenticationServiceMethodAddAccountName,
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

  AuthenticationService get impl => _impl;
  set impl(AuthenticationService d) {
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
    return "_AuthenticationServiceStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _AuthenticationServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class AuthenticationServiceStub
    extends bindings.Stub<AuthenticationService>
    implements AuthenticationService {
  AuthenticationServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [AuthenticationService impl])
      : super(new _AuthenticationServiceStubControl.fromEndpoint(endpoint, impl));

  AuthenticationServiceStub.fromHandle(
      core.MojoHandle handle, [AuthenticationService impl])
      : super(new _AuthenticationServiceStubControl.fromHandle(handle, impl));

  AuthenticationServiceStub.unbound([AuthenticationService impl])
      : super(new _AuthenticationServiceStubControl.unbound(impl));

  static AuthenticationServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AuthenticationServiceStub"));
    return new AuthenticationServiceStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _AuthenticationServiceStubControl.serviceDescription;


  dynamic selectAccount(bool returnLastSelected,[Function responseFactory = null]) {
    return impl.selectAccount(returnLastSelected,responseFactory);
  }
  dynamic getOAuth2Token(String username,List<String> scopes,[Function responseFactory = null]) {
    return impl.getOAuth2Token(username,scopes,responseFactory);
  }
  void clearOAuth2Token(String token) {
    return impl.clearOAuth2Token(token);
  }
  dynamic getOAuth2DeviceCode(List<String> scopes,[Function responseFactory = null]) {
    return impl.getOAuth2DeviceCode(scopes,responseFactory);
  }
  dynamic addAccount(String deviceCode,[Function responseFactory = null]) {
    return impl.addAccount(deviceCode,responseFactory);
  }
}



