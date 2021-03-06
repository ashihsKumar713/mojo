// WARNING: DO NOT EDIT. This file was generated by a program.
// See $MOJO_SDK/tools/bindings/mojom_bindings_generator.py.

library timelines_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
const int kUnspecifiedTime = 9223372036854775807;



class TimelineTransform extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int referenceTime = 0;
  int subjectTime = 0;
  int referenceDelta = 1;
  int subjectDelta = 0;

  TimelineTransform() : super(kVersions.last.size);

  TimelineTransform.init(
    int this.referenceTime, 
    int this.subjectTime, 
    int this.referenceDelta, 
    int this.subjectDelta
  ) : super(kVersions.last.size);

  static TimelineTransform deserialize(bindings.Message message) =>
      bindings.Struct.deserialize(decode, message);

  static TimelineTransform decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TimelineTransform result = new TimelineTransform();
    var mainDataHeader = bindings.Struct.checkVersion(decoder0, kVersions);
    if (mainDataHeader.version >= 0) {
      
      result.referenceTime = decoder0.decodeInt64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.subjectTime = decoder0.decodeInt64(16);
    }
    if (mainDataHeader.version >= 0) {
      
      result.referenceDelta = decoder0.decodeUint32(24);
    }
    if (mainDataHeader.version >= 0) {
      
      result.subjectDelta = decoder0.decodeUint32(28);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    const String structName = "TimelineTransform";
    String fieldName;
    try {
      fieldName = "referenceTime";
      encoder0.encodeInt64(referenceTime, 8);
      fieldName = "subjectTime";
      encoder0.encodeInt64(subjectTime, 16);
      fieldName = "referenceDelta";
      encoder0.encodeUint32(referenceDelta, 24);
      fieldName = "subjectDelta";
      encoder0.encodeUint32(subjectDelta, 28);
    } on bindings.MojoCodecError catch(e) {
      bindings.Struct.fixErrorMessage(e, fieldName, structName);
      rethrow;
    }
  }

  String toString() {
    return "TimelineTransform("
           "referenceTime: $referenceTime" ", "
           "subjectTime: $subjectTime" ", "
           "referenceDelta: $referenceDelta" ", "
           "subjectDelta: $subjectDelta" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["referenceTime"] = referenceTime;
    map["subjectTime"] = subjectTime;
    map["referenceDelta"] = referenceDelta;
    map["subjectDelta"] = subjectDelta;
    return map;
  }
}


class _TimelineConsumerSetTimelineTransformParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  TimelineTransform timelineTransform = null;

  _TimelineConsumerSetTimelineTransformParams() : super(kVersions.last.size);

  _TimelineConsumerSetTimelineTransformParams.init(
    TimelineTransform this.timelineTransform
  ) : super(kVersions.last.size);

  static _TimelineConsumerSetTimelineTransformParams deserialize(bindings.Message message) =>
      bindings.Struct.deserialize(decode, message);

  static _TimelineConsumerSetTimelineTransformParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _TimelineConsumerSetTimelineTransformParams result = new _TimelineConsumerSetTimelineTransformParams();
    var mainDataHeader = bindings.Struct.checkVersion(decoder0, kVersions);
    if (mainDataHeader.version >= 0) {
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.timelineTransform = TimelineTransform.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    const String structName = "_TimelineConsumerSetTimelineTransformParams";
    String fieldName;
    try {
      fieldName = "timelineTransform";
      encoder0.encodeStruct(timelineTransform, 8, false);
    } on bindings.MojoCodecError catch(e) {
      bindings.Struct.fixErrorMessage(e, fieldName, structName);
      rethrow;
    }
  }

  String toString() {
    return "_TimelineConsumerSetTimelineTransformParams("
           "timelineTransform: $timelineTransform" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["timelineTransform"] = timelineTransform;
    return map;
  }
}


class TimelineConsumerSetTimelineTransformResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool completed = false;

  TimelineConsumerSetTimelineTransformResponseParams() : super(kVersions.last.size);

  TimelineConsumerSetTimelineTransformResponseParams.init(
    bool this.completed
  ) : super(kVersions.last.size);

  static TimelineConsumerSetTimelineTransformResponseParams deserialize(bindings.Message message) =>
      bindings.Struct.deserialize(decode, message);

  static TimelineConsumerSetTimelineTransformResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    TimelineConsumerSetTimelineTransformResponseParams result = new TimelineConsumerSetTimelineTransformResponseParams();
    var mainDataHeader = bindings.Struct.checkVersion(decoder0, kVersions);
    if (mainDataHeader.version >= 0) {
      
      result.completed = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    const String structName = "TimelineConsumerSetTimelineTransformResponseParams";
    String fieldName;
    try {
      fieldName = "completed";
      encoder0.encodeBool(completed, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      bindings.Struct.fixErrorMessage(e, fieldName, structName);
      rethrow;
    }
  }

  String toString() {
    return "TimelineConsumerSetTimelineTransformResponseParams("
           "completed: $completed" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["completed"] = completed;
    return map;
  }
}

const int _timelineConsumerMethodSetTimelineTransformName = 0;

class _TimelineConsumerServiceDescription implements service_describer.ServiceDescription {
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

abstract class TimelineConsumer {
  static const String serviceName = null;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _TimelineConsumerServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static TimelineConsumerProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    TimelineConsumerProxy p = new TimelineConsumerProxy.unbound();
    String name = serviceName ?? TimelineConsumer.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void setTimelineTransform(TimelineTransform timelineTransform,void callback(bool completed));
}

abstract class TimelineConsumerInterface
    implements bindings.MojoInterface<TimelineConsumer>,
               TimelineConsumer {
  factory TimelineConsumerInterface([TimelineConsumer impl]) =>
      new TimelineConsumerStub.unbound(impl);

  factory TimelineConsumerInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [TimelineConsumer impl]) =>
      new TimelineConsumerStub.fromEndpoint(endpoint, impl);

  factory TimelineConsumerInterface.fromMock(
      TimelineConsumer mock) =>
      new TimelineConsumerProxy.fromMock(mock);
}

abstract class TimelineConsumerInterfaceRequest
    implements bindings.MojoInterface<TimelineConsumer>,
               TimelineConsumer {
  factory TimelineConsumerInterfaceRequest() =>
      new TimelineConsumerProxy.unbound();
}

class _TimelineConsumerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<TimelineConsumer> {
  TimelineConsumer impl;

  _TimelineConsumerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _TimelineConsumerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _TimelineConsumerProxyControl.unbound() : super.unbound();

  String get serviceName => TimelineConsumer.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _timelineConsumerMethodSetTimelineTransformName:
        Function callback = getCallback(message);
        if (callback != null) {
          var r = TimelineConsumerSetTimelineTransformResponseParams.deserialize(
              message.payload);
          callback(r.completed );
        }
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
    return "_TimelineConsumerProxyControl($superString)";
  }
}

class TimelineConsumerProxy
    extends bindings.Proxy<TimelineConsumer>
    implements TimelineConsumer,
               TimelineConsumerInterface,
               TimelineConsumerInterfaceRequest {
  TimelineConsumerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _TimelineConsumerProxyControl.fromEndpoint(endpoint));

  TimelineConsumerProxy.fromHandle(core.MojoHandle handle)
      : super(new _TimelineConsumerProxyControl.fromHandle(handle));

  TimelineConsumerProxy.unbound()
      : super(new _TimelineConsumerProxyControl.unbound());

  factory TimelineConsumerProxy.fromMock(TimelineConsumer mock) {
    TimelineConsumerProxy newMockedProxy =
        new TimelineConsumerProxy.unbound();
    newMockedProxy.impl = mock;
    return newMockedProxy;
  }

  static TimelineConsumerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TimelineConsumerProxy"));
    return new TimelineConsumerProxy.fromEndpoint(endpoint);
  }


  void setTimelineTransform(TimelineTransform timelineTransform,void callback(bool completed)) {
    if (impl != null) {
      impl.setTimelineTransform(timelineTransform,callback ?? bindings.DoNothingFunction.fn);
      return;
    }
    var params = new _TimelineConsumerSetTimelineTransformParams();
    params.timelineTransform = timelineTransform;
    Function zonedCallback;
    if ((callback == null) || identical(Zone.current, Zone.ROOT)) {
      zonedCallback = callback;
    } else {
      Zone z = Zone.current;
      zonedCallback = ((bool completed) {
        z.bindCallback(() {
          callback(completed);
        })();
      });
    }
    ctrl.sendMessageWithRequestId(
        params,
        _timelineConsumerMethodSetTimelineTransformName,
        -1,
        bindings.MessageHeader.kMessageExpectsResponse,
        zonedCallback);
  }
}

class _TimelineConsumerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<TimelineConsumer> {
  TimelineConsumer _impl;

  _TimelineConsumerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [TimelineConsumer impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _TimelineConsumerStubControl.fromHandle(
      core.MojoHandle handle, [TimelineConsumer impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _TimelineConsumerStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => TimelineConsumer.serviceName;


  Function _timelineConsumerSetTimelineTransformResponseParamsResponder(
      int requestId) {
  return (bool completed) {
      var result = new TimelineConsumerSetTimelineTransformResponseParams();
      result.completed = completed;
      sendResponse(buildResponseWithId(
          result,
          _timelineConsumerMethodSetTimelineTransformName,
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
      case _timelineConsumerMethodSetTimelineTransformName:
        var params = _TimelineConsumerSetTimelineTransformParams.deserialize(
            message.payload);
        _impl.setTimelineTransform(params.timelineTransform, _timelineConsumerSetTimelineTransformResponseParamsResponder(message.header.requestId));
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
  }

  TimelineConsumer get impl => _impl;
  set impl(TimelineConsumer d) {
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
    return "_TimelineConsumerStubControl($superString)";
  }

  int get version => 0;
}

class TimelineConsumerStub
    extends bindings.Stub<TimelineConsumer>
    implements TimelineConsumer,
               TimelineConsumerInterface,
               TimelineConsumerInterfaceRequest {
  TimelineConsumerStub.unbound([TimelineConsumer impl])
      : super(new _TimelineConsumerStubControl.unbound(impl));

  TimelineConsumerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [TimelineConsumer impl])
      : super(new _TimelineConsumerStubControl.fromEndpoint(endpoint, impl));

  TimelineConsumerStub.fromHandle(
      core.MojoHandle handle, [TimelineConsumer impl])
      : super(new _TimelineConsumerStubControl.fromHandle(handle, impl));

  static TimelineConsumerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For TimelineConsumerStub"));
    return new TimelineConsumerStub.fromEndpoint(endpoint);
  }


  void setTimelineTransform(TimelineTransform timelineTransform,void callback(bool completed)) {
    return impl.setTimelineTransform(timelineTransform,callback);
  }
}



