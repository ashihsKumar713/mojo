// WARNING: DO NOT EDIT. This file was generated by a program.
// See $MOJO_SDK/tools/bindings/mojom_bindings_generator.py.

library media_player_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/media/media_metadata.mojom.dart' as media_metadata_mojom;
import 'package:mojo_services/mojo/timelines.mojom.dart' as timelines_mojom;



class MediaPlayerStatus extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  timelines_mojom.TimelineTransform timelineTransform = null;
  bool endOfStream = false;
  media_metadata_mojom.MediaMetadata metadata = null;

  MediaPlayerStatus() : super(kVersions.last.size);

  MediaPlayerStatus.init(
    timelines_mojom.TimelineTransform this.timelineTransform, 
    bool this.endOfStream, 
    media_metadata_mojom.MediaMetadata this.metadata
  ) : super(kVersions.last.size);

  static MediaPlayerStatus deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaPlayerStatus decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaPlayerStatus result = new MediaPlayerStatus();

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
      result.timelineTransform = timelines_mojom.TimelineTransform.decode(decoder1);
    }
    if (mainDataHeader.version >= 0) {
      
      result.endOfStream = decoder0.decodeBool(16, 0);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(24, true);
      result.metadata = media_metadata_mojom.MediaMetadata.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(timelineTransform, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "timelineTransform of struct MediaPlayerStatus: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(endOfStream, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "endOfStream of struct MediaPlayerStatus: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(metadata, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "metadata of struct MediaPlayerStatus: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaPlayerStatus("
           "timelineTransform: $timelineTransform" ", "
           "endOfStream: $endOfStream" ", "
           "metadata: $metadata" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["timelineTransform"] = timelineTransform;
    map["endOfStream"] = endOfStream;
    map["metadata"] = metadata;
    return map;
  }
}


class _MediaPlayerPlayParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaPlayerPlayParams() : super(kVersions.last.size);

  _MediaPlayerPlayParams.init(
  ) : super(kVersions.last.size);

  static _MediaPlayerPlayParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaPlayerPlayParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaPlayerPlayParams result = new _MediaPlayerPlayParams();

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
    return "_MediaPlayerPlayParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaPlayerPauseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _MediaPlayerPauseParams() : super(kVersions.last.size);

  _MediaPlayerPauseParams.init(
  ) : super(kVersions.last.size);

  static _MediaPlayerPauseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaPlayerPauseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaPlayerPauseParams result = new _MediaPlayerPauseParams();

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
    return "_MediaPlayerPauseParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class _MediaPlayerSeekParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int position = 0;

  _MediaPlayerSeekParams() : super(kVersions.last.size);

  _MediaPlayerSeekParams.init(
    int this.position
  ) : super(kVersions.last.size);

  static _MediaPlayerSeekParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaPlayerSeekParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaPlayerSeekParams result = new _MediaPlayerSeekParams();

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
      
      result.position = decoder0.decodeInt64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInt64(position, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "position of struct _MediaPlayerSeekParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaPlayerSeekParams("
           "position: $position" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["position"] = position;
    return map;
  }
}


class _MediaPlayerGetStatusParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  int versionLastSeen = 0;

  _MediaPlayerGetStatusParams() : super(kVersions.last.size);

  _MediaPlayerGetStatusParams.init(
    int this.versionLastSeen
  ) : super(kVersions.last.size);

  static _MediaPlayerGetStatusParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _MediaPlayerGetStatusParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _MediaPlayerGetStatusParams result = new _MediaPlayerGetStatusParams();

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
      
      result.versionLastSeen = decoder0.decodeUint64(8);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(versionLastSeen, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "versionLastSeen of struct _MediaPlayerGetStatusParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_MediaPlayerGetStatusParams("
           "versionLastSeen: $versionLastSeen" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["versionLastSeen"] = versionLastSeen;
    return map;
  }
}


class MediaPlayerGetStatusResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int version = 0;
  MediaPlayerStatus status = null;

  MediaPlayerGetStatusResponseParams() : super(kVersions.last.size);

  MediaPlayerGetStatusResponseParams.init(
    int this.version, 
    MediaPlayerStatus this.status
  ) : super(kVersions.last.size);

  static MediaPlayerGetStatusResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static MediaPlayerGetStatusResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    MediaPlayerGetStatusResponseParams result = new MediaPlayerGetStatusResponseParams();

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
      
      result.version = decoder0.decodeUint64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(16, false);
      result.status = MediaPlayerStatus.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(version, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "version of struct MediaPlayerGetStatusResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeStruct(status, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "status of struct MediaPlayerGetStatusResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "MediaPlayerGetStatusResponseParams("
           "version: $version" ", "
           "status: $status" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["version"] = version;
    map["status"] = status;
    return map;
  }
}

const int _mediaPlayerMethodPlayName = 0;
const int _mediaPlayerMethodPauseName = 1;
const int _mediaPlayerMethodSeekName = 2;
const int _mediaPlayerMethodGetStatusName = 3;

class _MediaPlayerServiceDescription implements service_describer.ServiceDescription {
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

abstract class MediaPlayer {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _MediaPlayerServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static MediaPlayerProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    MediaPlayerProxy p = new MediaPlayerProxy.unbound();
    String name = serviceName ?? MediaPlayer.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void play();
  void pause();
  void seek(int position);
  void getStatus(int versionLastSeen,void callback(int version, MediaPlayerStatus status));
  static const int kInitialStatus = 0;
}

abstract class MediaPlayerInterface
    implements bindings.MojoInterface<MediaPlayer>,
               MediaPlayer {
  factory MediaPlayerInterface([MediaPlayer impl]) =>
      new MediaPlayerStub.unbound(impl);

  factory MediaPlayerInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [MediaPlayer impl]) =>
      new MediaPlayerStub.fromEndpoint(endpoint, impl);

  factory MediaPlayerInterface.fromMock(
      MediaPlayer mock) =>
      new MediaPlayerProxy.fromMock(mock);
}

abstract class MediaPlayerInterfaceRequest
    implements bindings.MojoInterface<MediaPlayer>,
               MediaPlayer {
  factory MediaPlayerInterfaceRequest() =>
      new MediaPlayerProxy.unbound();
}

class _MediaPlayerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<MediaPlayer> {
  MediaPlayer impl;

  _MediaPlayerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _MediaPlayerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _MediaPlayerProxyControl.unbound() : super.unbound();

  String get serviceName => MediaPlayer.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _mediaPlayerMethodGetStatusName:
        var r = MediaPlayerGetStatusResponseParams.deserialize(
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
        callback(r.version , r.status );
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
    return "_MediaPlayerProxyControl($superString)";
  }
}

class MediaPlayerProxy
    extends bindings.Proxy<MediaPlayer>
    implements MediaPlayer,
               MediaPlayerInterface,
               MediaPlayerInterfaceRequest {
  MediaPlayerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _MediaPlayerProxyControl.fromEndpoint(endpoint));

  MediaPlayerProxy.fromHandle(core.MojoHandle handle)
      : super(new _MediaPlayerProxyControl.fromHandle(handle));

  MediaPlayerProxy.unbound()
      : super(new _MediaPlayerProxyControl.unbound());

  factory MediaPlayerProxy.fromMock(MediaPlayer mock) {
    MediaPlayerProxy newMockedProxy =
        new MediaPlayerProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static MediaPlayerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaPlayerProxy"));
    return new MediaPlayerProxy.fromEndpoint(endpoint);
  }


  void play() {
    if (impl != null) {
      impl.play();
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaPlayerPlayParams();
    ctrl.sendMessage(params,
        _mediaPlayerMethodPlayName);
  }
  void pause() {
    if (impl != null) {
      impl.pause();
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaPlayerPauseParams();
    ctrl.sendMessage(params,
        _mediaPlayerMethodPauseName);
  }
  void seek(int position) {
    if (impl != null) {
      impl.seek(position);
      return;
    }
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _MediaPlayerSeekParams();
    params.position = position;
    ctrl.sendMessage(params,
        _mediaPlayerMethodSeekName);
  }
  void getStatus(int versionLastSeen,void callback(int version, MediaPlayerStatus status)) {
    if (impl != null) {
      impl.getStatus(versionLastSeen,callback);
      return;
    }
    var params = new _MediaPlayerGetStatusParams();
    params.versionLastSeen = versionLastSeen;
    ctrl.sendMessageWithRequestId(
        params,
        _mediaPlayerMethodGetStatusName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse,
        callback);
  }
}

class _MediaPlayerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<MediaPlayer> {
  MediaPlayer _impl;

  _MediaPlayerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaPlayer impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _MediaPlayerStubControl.fromHandle(
      core.MojoHandle handle, [MediaPlayer impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _MediaPlayerStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => MediaPlayer.serviceName;


  Function _mediaPlayerGetStatusResponseParamsResponder(
      int requestId) {
  return (int version, MediaPlayerStatus status) {
      var result = new MediaPlayerGetStatusResponseParams();
      result.version = version;
      result.status = status;
      sendResponse(buildResponseWithId(
          result,
          _mediaPlayerMethodGetStatusName,
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
      case _mediaPlayerMethodPlayName:
        _impl.play();
        break;
      case _mediaPlayerMethodPauseName:
        _impl.pause();
        break;
      case _mediaPlayerMethodSeekName:
        var params = _MediaPlayerSeekParams.deserialize(
            message.payload);
        _impl.seek(params.position);
        break;
      case _mediaPlayerMethodGetStatusName:
        var params = _MediaPlayerGetStatusParams.deserialize(
            message.payload);
        _impl.getStatus(params.versionLastSeen, _mediaPlayerGetStatusResponseParamsResponder(message.header.requestId));
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
  }

  MediaPlayer get impl => _impl;
  set impl(MediaPlayer d) {
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
    return "_MediaPlayerStubControl($superString)";
  }

  int get version => 0;
}

class MediaPlayerStub
    extends bindings.Stub<MediaPlayer>
    implements MediaPlayer,
               MediaPlayerInterface,
               MediaPlayerInterfaceRequest {
  MediaPlayerStub.unbound([MediaPlayer impl])
      : super(new _MediaPlayerStubControl.unbound(impl));

  MediaPlayerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [MediaPlayer impl])
      : super(new _MediaPlayerStubControl.fromEndpoint(endpoint, impl));

  MediaPlayerStub.fromHandle(
      core.MojoHandle handle, [MediaPlayer impl])
      : super(new _MediaPlayerStubControl.fromHandle(handle, impl));

  static MediaPlayerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For MediaPlayerStub"));
    return new MediaPlayerStub.fromEndpoint(endpoint);
  }


  void play() {
    return impl.play();
  }
  void pause() {
    return impl.pause();
  }
  void seek(int position) {
    return impl.seek(position);
  }
  void getStatus(int versionLastSeen,void callback(int version, MediaPlayerStatus status)) {
    return impl.getStatus(versionLastSeen,callback);
  }
}



