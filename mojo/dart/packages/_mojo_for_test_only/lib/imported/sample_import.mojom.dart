// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library sample_import_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;

class Shape extends bindings.MojoEnum {
  static const Shape rectangle = const Shape._(1);
  static const Shape circle = const Shape._(2);
  static const Shape triangle = const Shape._(3);
  static const Shape last = const Shape._(3);

  const Shape._(int v) : super(v);

  static const Map<String, Shape> valuesMap = const {
    "rectangle": rectangle,
    "circle": circle,
    "triangle": triangle,
    "last": last,
  };
  static const List<Shape> values = const [
    rectangle,
    circle,
    triangle,
    last,
  ];

  static Shape valueOf(String name) => valuesMap[name];

  factory Shape(int v) {
    switch (v) {
      case 1:
        return Shape.rectangle;
      case 2:
        return Shape.circle;
      case 3:
        return Shape.triangle;
      case 3:
        return Shape.last;
      default:
        return null;
    }
  }

  static Shape decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Shape result = new Shape(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Shape.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case rectangle:
        return 'Shape.rectangle';
      case circle:
        return 'Shape.circle';
      case triangle:
        return 'Shape.triangle';
      case last:
        return 'Shape.last';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class AnotherShape extends bindings.MojoEnum {
  static const AnotherShape rectangle = const AnotherShape._(10);
  static const AnotherShape circle = const AnotherShape._(11);
  static const AnotherShape triangle = const AnotherShape._(12);

  const AnotherShape._(int v) : super(v);

  static const Map<String, AnotherShape> valuesMap = const {
    "rectangle": rectangle,
    "circle": circle,
    "triangle": triangle,
  };
  static const List<AnotherShape> values = const [
    rectangle,
    circle,
    triangle,
  ];

  static AnotherShape valueOf(String name) => valuesMap[name];

  factory AnotherShape(int v) {
    switch (v) {
      case 10:
        return AnotherShape.rectangle;
      case 11:
        return AnotherShape.circle;
      case 12:
        return AnotherShape.triangle;
      default:
        return null;
    }
  }

  static AnotherShape decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    AnotherShape result = new AnotherShape(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum AnotherShape.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case rectangle:
        return 'AnotherShape.rectangle';
      case circle:
        return 'AnotherShape.circle';
      case triangle:
        return 'AnotherShape.triangle';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}

class YetAnotherShape extends bindings.MojoEnum {
  static const YetAnotherShape rectangle = const YetAnotherShape._(20);
  static const YetAnotherShape circle = const YetAnotherShape._(21);
  static const YetAnotherShape triangle = const YetAnotherShape._(22);

  const YetAnotherShape._(int v) : super(v);

  static const Map<String, YetAnotherShape> valuesMap = const {
    "rectangle": rectangle,
    "circle": circle,
    "triangle": triangle,
  };
  static const List<YetAnotherShape> values = const [
    rectangle,
    circle,
    triangle,
  ];

  static YetAnotherShape valueOf(String name) => valuesMap[name];

  factory YetAnotherShape(int v) {
    switch (v) {
      case 20:
        return YetAnotherShape.rectangle;
      case 21:
        return YetAnotherShape.circle;
      case 22:
        return YetAnotherShape.triangle;
      default:
        return null;
    }
  }

  static YetAnotherShape decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    YetAnotherShape result = new YetAnotherShape(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum YetAnotherShape.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case rectangle:
        return 'YetAnotherShape.rectangle';
      case circle:
        return 'YetAnotherShape.circle';
      case triangle:
        return 'YetAnotherShape.triangle';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class Point extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int x = 0;
  int y = 0;

  Point() : super(kVersions.last.size);

  static Point deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Point decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Point result = new Point();

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
      
      result.x = decoder0.decodeInt32(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.y = decoder0.decodeInt32(12);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt32(x, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "x of struct Point: $e";
      rethrow;
    }
    try {
      encoder0.encodeInt32(y, 12);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "y of struct Point: $e";
      rethrow;
    }
  }

  String toString() {
    return "Point("
           "x: $x" ", "
           "y: $y" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["x"] = x;
    map["y"] = y;
    return map;
  }
}


class _ImportedInterfaceDoSomethingParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ImportedInterfaceDoSomethingParams() : super(kVersions.last.size);

  static _ImportedInterfaceDoSomethingParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ImportedInterfaceDoSomethingParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ImportedInterfaceDoSomethingParams result = new _ImportedInterfaceDoSomethingParams();

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
    return "_ImportedInterfaceDoSomethingParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _importedInterfaceMethodDoSomethingName = 0;

class _ImportedInterfaceServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ImportedInterface {
  static const String serviceName = null;
  void doSomething();
}

class _ImportedInterfaceProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl {
  _ImportedInterfaceProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ImportedInterfaceProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ImportedInterfaceProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _ImportedInterfaceServiceDescription();

  String get serviceName => ImportedInterface.serviceName;

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
    return "_ImportedInterfaceProxyControl($superString)";
  }
}

class ImportedInterfaceProxy
    extends bindings.Proxy
    implements ImportedInterface {
  ImportedInterfaceProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _ImportedInterfaceProxyControl.fromEndpoint(endpoint));

  ImportedInterfaceProxy.fromHandle(core.MojoHandle handle)
      : super(new _ImportedInterfaceProxyControl.fromHandle(handle));

  ImportedInterfaceProxy.unbound()
      : super(new _ImportedInterfaceProxyControl.unbound());

  static ImportedInterfaceProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ImportedInterfaceProxy"));
    return new ImportedInterfaceProxy.fromEndpoint(endpoint);
  }

  factory ImportedInterfaceProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ImportedInterfaceProxy p = new ImportedInterfaceProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void doSomething() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ImportedInterfaceDoSomethingParams();
    ctrl.sendMessage(params,
        _importedInterfaceMethodDoSomethingName);
  }
}

class _ImportedInterfaceStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<ImportedInterface> {
  ImportedInterface _impl;

  _ImportedInterfaceStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ImportedInterface impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _ImportedInterfaceStubControl.fromHandle(
      core.MojoHandle handle, [ImportedInterface impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _ImportedInterfaceStubControl.unbound([this._impl]) : super.unbound();



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
      case _importedInterfaceMethodDoSomethingName:
        _impl.doSomething();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ImportedInterface get impl => _impl;
  set impl(ImportedInterface d) {
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
    return "_ImportedInterfaceStubControl($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ImportedInterfaceServiceDescription();
    }
    return _cachedServiceDescription;
  }
}

class ImportedInterfaceStub
    extends bindings.Stub<ImportedInterface>
    implements ImportedInterface {
  ImportedInterfaceStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ImportedInterface impl])
      : super(new _ImportedInterfaceStubControl.fromEndpoint(endpoint, impl));

  ImportedInterfaceStub.fromHandle(
      core.MojoHandle handle, [ImportedInterface impl])
      : super(new _ImportedInterfaceStubControl.fromHandle(handle, impl));

  ImportedInterfaceStub.unbound([ImportedInterface impl])
      : super(new _ImportedInterfaceStubControl.unbound(impl));

  static ImportedInterfaceStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ImportedInterfaceStub"));
    return new ImportedInterfaceStub.fromEndpoint(endpoint);
  }

  static service_describer.ServiceDescription get serviceDescription =>
      _ImportedInterfaceStubControl.serviceDescription;


  void doSomething() {
    return impl.doSomething();
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/8yYX3PSQBDAL9AqtbTi2D/0j5pq1aoj8bHjUzuVEcaOwwAP8OAUSiOJAwSTMKN+Aj9GP4ofxY/QR9/0QvYk2dxBojRwMztHckty+7vdvc1lidsy0L+CHt9nfQr1WI9Io+csUjmA2wXo+9B/h/4S+idU7lOp1kv5s3f5+mu92zdMW73IHfcMW1PNitbsq4S8oDqPuHpF+FHs2ar5sdlSh899QGWTq18y9J49Ztx94TM6tscdr6u2f2rDVgO7M8hu5zpJ5efC6NpBpaX8/H4s+68v74znfET8ja0fu/8bWonw2xqVNBVsyj0q61QEyxCYz12w2xn7QEUZWKbSMVrNjtI2jHZHVTSjqyrfzKbSNT4ZimW23B/9wXlHbyk6WzVLOdd7F3qvbSm2atmWYjW7/Y565k4k5/ynS58vA082jwLwaCTcnvmdjP0Y9G6RaPxqAn7O8ixRKedPqsfv357m4f5T8D0uv9xIG3N01iMRI0fml4wH5obb8gRuhyH9bpXKDSonxfKJA22f/t4V8mJaQb9bj5nXJD7pKfHJQI6tlotDR2H5kc+HaQX5bMwJn6zkvxbxKSA+DQGfLYg9ftYn5CGVbS8vgSLmtQ+xEBcv/P6sx48k5A+SZ9/FnK8EnESciYcz7z7x5HUn5t8YFWq3rVGDuNwex+xnMuJ1hfowdjvtUGD3DtjusfulqX4e0Cnx92NocdmfEvhFFs0nhfyEjf9ifpSMlq+OBLxWYP93qyo376x64w8GMDdnj7wZc7wlvPGG6qhDNL9FEq6FjbMDwf+XYB2/COpqGdYyLk5ReSz8Aw8pBI+vAh57MfMYF2cJTv7OhMxHUeOL1d+B+IIB/P7lmOvyA/AFGdXlNajLteT4+jwl+T5v/vv7RlSfy7BWfn6jwhxzTM+oLpdC1uWJiH5WCFmXB74DUUGOOa3MWT2enBIXXI+zcwPE5W8hjrmszphLhvmINF0uaYj30+NK1Vs3IS5sOMDl9ozrRhnFj2idRedD13Uuswls8ClTIG8hBTyfrRmfy5SAhzbhXIbVYWsR834jYt5/Dt+GIn459AfMc3tG+8BayH1g/ZrOZwLnWZgbKGJeO3O2H2xE5FMLuR+wc2Ihn9ERDdevdmPm9CcAAP//jmet5PgXAAA=";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
