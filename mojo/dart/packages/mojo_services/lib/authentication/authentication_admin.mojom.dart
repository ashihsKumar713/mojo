// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library authentication_admin_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;



class _AuthenticationAdminServiceGetOAuth2DeviceCodeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<String> scopes = null;

  _AuthenticationAdminServiceGetOAuth2DeviceCodeParams() : super(kVersions.last.size);

  static _AuthenticationAdminServiceGetOAuth2DeviceCodeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AuthenticationAdminServiceGetOAuth2DeviceCodeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AuthenticationAdminServiceGetOAuth2DeviceCodeParams result = new _AuthenticationAdminServiceGetOAuth2DeviceCodeParams();

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
          "scopes of struct _AuthenticationAdminServiceGetOAuth2DeviceCodeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_AuthenticationAdminServiceGetOAuth2DeviceCodeParams("
           "scopes: $scopes" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["scopes"] = scopes;
    return map;
  }
}


class AuthenticationAdminServiceGetOAuth2DeviceCodeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(40, 0)
  ];
  String verificationUrl = null;
  String deviceCode = null;
  String userCode = null;
  String error = null;

  AuthenticationAdminServiceGetOAuth2DeviceCodeResponseParams() : super(kVersions.last.size);

  static AuthenticationAdminServiceGetOAuth2DeviceCodeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AuthenticationAdminServiceGetOAuth2DeviceCodeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AuthenticationAdminServiceGetOAuth2DeviceCodeResponseParams result = new AuthenticationAdminServiceGetOAuth2DeviceCodeResponseParams();

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
          "verificationUrl of struct AuthenticationAdminServiceGetOAuth2DeviceCodeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(deviceCode, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "deviceCode of struct AuthenticationAdminServiceGetOAuth2DeviceCodeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(userCode, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "userCode of struct AuthenticationAdminServiceGetOAuth2DeviceCodeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(error, 32, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct AuthenticationAdminServiceGetOAuth2DeviceCodeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "AuthenticationAdminServiceGetOAuth2DeviceCodeResponseParams("
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


class _AuthenticationAdminServiceAddAccountParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  String deviceCode = null;

  _AuthenticationAdminServiceAddAccountParams() : super(kVersions.last.size);

  static _AuthenticationAdminServiceAddAccountParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AuthenticationAdminServiceAddAccountParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AuthenticationAdminServiceAddAccountParams result = new _AuthenticationAdminServiceAddAccountParams();

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
          "deviceCode of struct _AuthenticationAdminServiceAddAccountParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_AuthenticationAdminServiceAddAccountParams("
           "deviceCode: $deviceCode" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["deviceCode"] = deviceCode;
    return map;
  }
}


class AuthenticationAdminServiceAddAccountResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String username = null;
  String error = null;

  AuthenticationAdminServiceAddAccountResponseParams() : super(kVersions.last.size);

  static AuthenticationAdminServiceAddAccountResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AuthenticationAdminServiceAddAccountResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AuthenticationAdminServiceAddAccountResponseParams result = new AuthenticationAdminServiceAddAccountResponseParams();

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
          "username of struct AuthenticationAdminServiceAddAccountResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(error, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct AuthenticationAdminServiceAddAccountResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "AuthenticationAdminServiceAddAccountResponseParams("
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


class _AuthenticationAdminServiceGetAllUsersParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _AuthenticationAdminServiceGetAllUsersParams() : super(kVersions.last.size);

  static _AuthenticationAdminServiceGetAllUsersParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AuthenticationAdminServiceGetAllUsersParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AuthenticationAdminServiceGetAllUsersParams result = new _AuthenticationAdminServiceGetAllUsersParams();

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
    return "_AuthenticationAdminServiceGetAllUsersParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class AuthenticationAdminServiceGetAllUsersResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  List<String> usernames = null;
  String error = null;

  AuthenticationAdminServiceGetAllUsersResponseParams() : super(kVersions.last.size);

  static AuthenticationAdminServiceGetAllUsersResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static AuthenticationAdminServiceGetAllUsersResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    AuthenticationAdminServiceGetAllUsersResponseParams result = new AuthenticationAdminServiceGetAllUsersResponseParams();

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
        result.usernames = new List<String>(si1.numElements);
        for (int i1 = 0; i1 < si1.numElements; ++i1) {
          
          result.usernames[i1] = decoder1.decodeString(bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i1, false);
        }
      }
    }
    if (mainDataHeader.version >= 0) {
      
      result.error = decoder0.decodeString(16, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      if (usernames == null) {
        encoder0.encodeNullPointer(8, false);
      } else {
        var encoder1 = encoder0.encodePointerArray(usernames.length, 8, bindings.kUnspecifiedArrayLength);
        for (int i0 = 0; i0 < usernames.length; ++i0) {
          encoder1.encodeString(usernames[i0], bindings.ArrayDataHeader.kHeaderSize + bindings.kPointerSize * i0, false);
        }
      }
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "usernames of struct AuthenticationAdminServiceGetAllUsersResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(error, 16, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "error of struct AuthenticationAdminServiceGetAllUsersResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "AuthenticationAdminServiceGetAllUsersResponseParams("
           "usernames: $usernames" ", "
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["usernames"] = usernames;
    map["error"] = error;
    return map;
  }
}

const int _authenticationAdminServiceMethodGetOAuth2DeviceCodeName = 0;
const int _authenticationAdminServiceMethodAddAccountName = 1;
const int _authenticationAdminServiceMethodGetAllUsersName = 2;

class _AuthenticationAdminServiceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class AuthenticationAdminService {
  static const String serviceName = "authentication::AuthenticationAdminService";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _AuthenticationAdminServiceServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static AuthenticationAdminServiceProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    AuthenticationAdminServiceProxy p = new AuthenticationAdminServiceProxy.unbound();
    String name = serviceName ?? AuthenticationAdminService.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic getOAuth2DeviceCode(List<String> scopes,[Function responseFactory = null]);
  dynamic addAccount(String deviceCode,[Function responseFactory = null]);
  dynamic getAllUsers([Function responseFactory = null]);
}

abstract class AuthenticationAdminServiceInterface
    implements bindings.MojoInterface<AuthenticationAdminService>,
               AuthenticationAdminService {
  factory AuthenticationAdminServiceInterface([AuthenticationAdminService impl]) =>
      new AuthenticationAdminServiceStub.unbound(impl);
  factory AuthenticationAdminServiceInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [AuthenticationAdminService impl]) =>
      new AuthenticationAdminServiceStub.fromEndpoint(endpoint, impl);
}

abstract class AuthenticationAdminServiceInterfaceRequest
    implements bindings.MojoInterface<AuthenticationAdminService>,
               AuthenticationAdminService {
  factory AuthenticationAdminServiceInterfaceRequest() =>
      new AuthenticationAdminServiceProxy.unbound();
}

class _AuthenticationAdminServiceProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<AuthenticationAdminService> {
  _AuthenticationAdminServiceProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _AuthenticationAdminServiceProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _AuthenticationAdminServiceProxyControl.unbound() : super.unbound();

  String get serviceName => AuthenticationAdminService.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _authenticationAdminServiceMethodGetOAuth2DeviceCodeName:
        var r = AuthenticationAdminServiceGetOAuth2DeviceCodeResponseParams.deserialize(
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
      case _authenticationAdminServiceMethodAddAccountName:
        var r = AuthenticationAdminServiceAddAccountResponseParams.deserialize(
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
      case _authenticationAdminServiceMethodGetAllUsersName:
        var r = AuthenticationAdminServiceGetAllUsersResponseParams.deserialize(
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

  AuthenticationAdminService get impl => null;
  set impl(AuthenticationAdminService _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_AuthenticationAdminServiceProxyControl($superString)";
  }
}

class AuthenticationAdminServiceProxy
    extends bindings.Proxy<AuthenticationAdminService>
    implements AuthenticationAdminService,
               AuthenticationAdminServiceInterface,
               AuthenticationAdminServiceInterfaceRequest {
  AuthenticationAdminServiceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _AuthenticationAdminServiceProxyControl.fromEndpoint(endpoint));

  AuthenticationAdminServiceProxy.fromHandle(core.MojoHandle handle)
      : super(new _AuthenticationAdminServiceProxyControl.fromHandle(handle));

  AuthenticationAdminServiceProxy.unbound()
      : super(new _AuthenticationAdminServiceProxyControl.unbound());

  static AuthenticationAdminServiceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AuthenticationAdminServiceProxy"));
    return new AuthenticationAdminServiceProxy.fromEndpoint(endpoint);
  }


  dynamic getOAuth2DeviceCode(List<String> scopes,[Function responseFactory = null]) {
    var params = new _AuthenticationAdminServiceGetOAuth2DeviceCodeParams();
    params.scopes = scopes;
    return ctrl.sendMessageWithRequestId(
        params,
        _authenticationAdminServiceMethodGetOAuth2DeviceCodeName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic addAccount(String deviceCode,[Function responseFactory = null]) {
    var params = new _AuthenticationAdminServiceAddAccountParams();
    params.deviceCode = deviceCode;
    return ctrl.sendMessageWithRequestId(
        params,
        _authenticationAdminServiceMethodAddAccountName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
  dynamic getAllUsers([Function responseFactory = null]) {
    var params = new _AuthenticationAdminServiceGetAllUsersParams();
    return ctrl.sendMessageWithRequestId(
        params,
        _authenticationAdminServiceMethodGetAllUsersName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _AuthenticationAdminServiceStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<AuthenticationAdminService> {
  AuthenticationAdminService _impl;

  _AuthenticationAdminServiceStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [AuthenticationAdminService impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _AuthenticationAdminServiceStubControl.fromHandle(
      core.MojoHandle handle, [AuthenticationAdminService impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _AuthenticationAdminServiceStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => AuthenticationAdminService.serviceName;


  AuthenticationAdminServiceGetOAuth2DeviceCodeResponseParams _authenticationAdminServiceGetOAuth2DeviceCodeResponseParamsFactory(String verificationUrl, String deviceCode, String userCode, String error) {
    var result = new AuthenticationAdminServiceGetOAuth2DeviceCodeResponseParams();
    result.verificationUrl = verificationUrl;
    result.deviceCode = deviceCode;
    result.userCode = userCode;
    result.error = error;
    return result;
  }
  AuthenticationAdminServiceAddAccountResponseParams _authenticationAdminServiceAddAccountResponseParamsFactory(String username, String error) {
    var result = new AuthenticationAdminServiceAddAccountResponseParams();
    result.username = username;
    result.error = error;
    return result;
  }
  AuthenticationAdminServiceGetAllUsersResponseParams _authenticationAdminServiceGetAllUsersResponseParamsFactory(List<String> usernames, String error) {
    var result = new AuthenticationAdminServiceGetAllUsersResponseParams();
    result.usernames = usernames;
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
      case _authenticationAdminServiceMethodGetOAuth2DeviceCodeName:
        var params = _AuthenticationAdminServiceGetOAuth2DeviceCodeParams.deserialize(
            message.payload);
        var response = _impl.getOAuth2DeviceCode(params.scopes,_authenticationAdminServiceGetOAuth2DeviceCodeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _authenticationAdminServiceMethodGetOAuth2DeviceCodeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _authenticationAdminServiceMethodGetOAuth2DeviceCodeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _authenticationAdminServiceMethodAddAccountName:
        var params = _AuthenticationAdminServiceAddAccountParams.deserialize(
            message.payload);
        var response = _impl.addAccount(params.deviceCode,_authenticationAdminServiceAddAccountResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _authenticationAdminServiceMethodAddAccountName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _authenticationAdminServiceMethodAddAccountName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _authenticationAdminServiceMethodGetAllUsersName:
        var response = _impl.getAllUsers(_authenticationAdminServiceGetAllUsersResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _authenticationAdminServiceMethodGetAllUsersName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _authenticationAdminServiceMethodGetAllUsersName,
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

  AuthenticationAdminService get impl => _impl;
  set impl(AuthenticationAdminService d) {
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
    return "_AuthenticationAdminServiceStubControl($superString)";
  }

  int get version => 0;
}

class AuthenticationAdminServiceStub
    extends bindings.Stub<AuthenticationAdminService>
    implements AuthenticationAdminService,
               AuthenticationAdminServiceInterface,
               AuthenticationAdminServiceInterfaceRequest {
  AuthenticationAdminServiceStub.unbound([AuthenticationAdminService impl])
      : super(new _AuthenticationAdminServiceStubControl.unbound(impl));

  AuthenticationAdminServiceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [AuthenticationAdminService impl])
      : super(new _AuthenticationAdminServiceStubControl.fromEndpoint(endpoint, impl));

  AuthenticationAdminServiceStub.fromHandle(
      core.MojoHandle handle, [AuthenticationAdminService impl])
      : super(new _AuthenticationAdminServiceStubControl.fromHandle(handle, impl));

  static AuthenticationAdminServiceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AuthenticationAdminServiceStub"));
    return new AuthenticationAdminServiceStub.fromEndpoint(endpoint);
  }


  dynamic getOAuth2DeviceCode(List<String> scopes,[Function responseFactory = null]) {
    return impl.getOAuth2DeviceCode(scopes,responseFactory);
  }
  dynamic addAccount(String deviceCode,[Function responseFactory = null]) {
    return impl.addAccount(deviceCode,responseFactory);
  }
  dynamic getAllUsers([Function responseFactory = null]) {
    return impl.getAllUsers(responseFactory);
  }
}



