// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library audio_server_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/media/audio_track.mojom.dart' as audio_track_mojom;



class _AudioServerCreateTrackParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Object track = null;

  _AudioServerCreateTrackParams() : super(kVersions.last.size);

  static _AudioServerCreateTrackParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _AudioServerCreateTrackParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _AudioServerCreateTrackParams result = new _AudioServerCreateTrackParams();

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
      
      result.track = decoder0.decodeInterfaceRequest(8, false, audio_track_mojom.AudioTrackStub.newFromEndpoint);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(track, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "track of struct _AudioServerCreateTrackParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_AudioServerCreateTrackParams("
           "track: $track" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}

const int _audioServerMethodCreateTrackName = 0;

class _AudioServerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class AudioServer {
  static const String serviceName = "mojo::media::AudioServer";
  void createTrack(Object track);
}


class _AudioServerProxyControl extends bindings.ProxyMessageHandler
                                      implements bindings.ProxyControl {
  _AudioServerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _AudioServerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _AudioServerProxyControl.unbound() : super.unbound();

  service_describer.ServiceDescription get serviceDescription =>
      new _AudioServerServiceDescription();

  String get serviceName => AudioServer.serviceName;

  @override
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
    return "_AudioServerProxyControl($superString)";
  }
}


class AudioServerProxy extends bindings.Proxy
                              implements AudioServer {
  AudioServerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _AudioServerProxyControl.fromEndpoint(endpoint));

  AudioServerProxy.fromHandle(core.MojoHandle handle)
      : super(new _AudioServerProxyControl.fromHandle(handle));

  AudioServerProxy.unbound()
      : super(new _AudioServerProxyControl.unbound());

  static AudioServerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AudioServerProxy"));
    return new AudioServerProxy.fromEndpoint(endpoint);
  }

  factory AudioServerProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    AudioServerProxy p = new AudioServerProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }


  void createTrack(Object track) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _AudioServerCreateTrackParams();
    params.track = track;
    ctrl.sendMessage(params,
        _audioServerMethodCreateTrackName);
  }
}


class AudioServerStub extends bindings.Stub {
  AudioServer _impl;

  AudioServerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [AudioServer impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  AudioServerStub.fromHandle(
      core.MojoHandle handle, [AudioServer impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  AudioServerStub.unbound([this._impl]) : super.unbound();

  static AudioServerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For AudioServerStub"));
    return new AudioServerStub.fromEndpoint(endpoint);
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
      case _audioServerMethodCreateTrackName:
        var params = _AudioServerCreateTrackParams.deserialize(
            message.payload);
        _impl.createTrack(params.track);
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  AudioServer get impl => _impl;
  set impl(AudioServer d) {
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
    return "AudioServerStub($superString)";
  }

  int get version => 0;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _AudioServerServiceDescription();
    }
    return _cachedServiceDescription;
  }
}



