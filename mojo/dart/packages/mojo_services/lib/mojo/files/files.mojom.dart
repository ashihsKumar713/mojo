// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library files_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/files/directory.mojom.dart' as directory_mojom;
import 'package:mojo_services/mojo/files/types.mojom.dart' as types_mojom;



class _FilesOpenFileSystemParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  String fileSystem = null;
  directory_mojom.DirectoryInterfaceRequest directory = null;

  _FilesOpenFileSystemParams() : super(kVersions.last.size);

  static _FilesOpenFileSystemParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _FilesOpenFileSystemParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _FilesOpenFileSystemParams result = new _FilesOpenFileSystemParams();

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
      
      result.fileSystem = decoder0.decodeString(8, true);
    }
    if (mainDataHeader.version >= 0) {
      
      result.directory = decoder0.decodeInterfaceRequest(16, false, directory_mojom.DirectoryStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeString(fileSystem, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fileSystem of struct _FilesOpenFileSystemParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(directory, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "directory of struct _FilesOpenFileSystemParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_FilesOpenFileSystemParams("
           "fileSystem: $fileSystem" ", "
           "directory: $directory" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class FilesOpenFileSystemResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  types_mojom.Error error = null;

  FilesOpenFileSystemResponseParams() : super(kVersions.last.size);

  static FilesOpenFileSystemResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static FilesOpenFileSystemResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    FilesOpenFileSystemResponseParams result = new FilesOpenFileSystemResponseParams();

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
          "error of struct FilesOpenFileSystemResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "FilesOpenFileSystemResponseParams("
           "error: $error" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["error"] = error;
    return map;
  }
}

const int _filesMethodOpenFileSystemName = 0;

class _FilesServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class Files {
  static const String serviceName = "mojo::files::Files";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _FilesServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static FilesProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    FilesProxy p = new FilesProxy.unbound();
    String name = serviceName ?? Files.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  dynamic openFileSystem(String fileSystem,directory_mojom.DirectoryInterfaceRequest directory,[Function responseFactory = null]);
}

abstract class FilesInterface
    implements bindings.MojoInterface<Files>,
               Files {
  factory FilesInterface([Files impl]) =>
      new FilesStub.unbound(impl);

  factory FilesInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [Files impl]) =>
      new FilesStub.fromEndpoint(endpoint, impl);

  factory FilesInterface.fromMock(
      Files mock) =>
      new FilesProxy.fromMock(mock);
}

abstract class FilesInterfaceRequest
    implements bindings.MojoInterface<Files>,
               Files {
  factory FilesInterfaceRequest() =>
      new FilesProxy.unbound();
}

class _FilesProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<Files> {
  Files impl;

  _FilesProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _FilesProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _FilesProxyControl.unbound() : super.unbound();

  String get serviceName => Files.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _filesMethodOpenFileSystemName:
        var r = FilesOpenFileSystemResponseParams.deserialize(
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
    return "_FilesProxyControl($superString)";
  }
}

class FilesProxy
    extends bindings.Proxy<Files>
    implements Files,
               FilesInterface,
               FilesInterfaceRequest {
  FilesProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _FilesProxyControl.fromEndpoint(endpoint));

  FilesProxy.fromHandle(core.MojoHandle handle)
      : super(new _FilesProxyControl.fromHandle(handle));

  FilesProxy.unbound()
      : super(new _FilesProxyControl.unbound());

  factory FilesProxy.fromMock(Files mock) {
    FilesProxy newMockedProxy =
        new FilesProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static FilesProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FilesProxy"));
    return new FilesProxy.fromEndpoint(endpoint);
  }


  dynamic openFileSystem(String fileSystem,directory_mojom.DirectoryInterfaceRequest directory,[Function responseFactory = null]) {
    if (impl != null) {
      return new Future(() => impl.openFileSystem(fileSystem,directory,_FilesStubControl._filesOpenFileSystemResponseParamsFactory));
    }
    var params = new _FilesOpenFileSystemParams();
    params.fileSystem = fileSystem;
    params.directory = directory;
    return ctrl.sendMessageWithRequestId(
        params,
        _filesMethodOpenFileSystemName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse);
  }
}

class _FilesStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<Files> {
  Files _impl;

  _FilesStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Files impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _FilesStubControl.fromHandle(
      core.MojoHandle handle, [Files impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _FilesStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => Files.serviceName;


  static FilesOpenFileSystemResponseParams _filesOpenFileSystemResponseParamsFactory(types_mojom.Error error) {
    var result = new FilesOpenFileSystemResponseParams();
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
      case _filesMethodOpenFileSystemName:
        var params = _FilesOpenFileSystemParams.deserialize(
            message.payload);
        var response = _impl.openFileSystem(params.fileSystem,params.directory,_filesOpenFileSystemResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _filesMethodOpenFileSystemName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _filesMethodOpenFileSystemName,
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

  Files get impl => _impl;
  set impl(Files d) {
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
    return "_FilesStubControl($superString)";
  }

  int get version => 0;
}

class FilesStub
    extends bindings.Stub<Files>
    implements Files,
               FilesInterface,
               FilesInterfaceRequest {
  FilesStub.unbound([Files impl])
      : super(new _FilesStubControl.unbound(impl));

  FilesStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [Files impl])
      : super(new _FilesStubControl.fromEndpoint(endpoint, impl));

  FilesStub.fromHandle(
      core.MojoHandle handle, [Files impl])
      : super(new _FilesStubControl.fromHandle(handle, impl));

  static FilesStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For FilesStub"));
    return new FilesStub.fromEndpoint(endpoint);
  }


  dynamic openFileSystem(String fileSystem,directory_mojom.DirectoryInterfaceRequest directory,[Function responseFactory = null]) {
    return impl.openFileSystem(fileSystem,directory,responseFactory);
  }
}



