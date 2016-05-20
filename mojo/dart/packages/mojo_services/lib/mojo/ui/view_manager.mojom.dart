// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library view_manager_mojom;
import 'dart:async';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;
import 'package:mojo_services/mojo/ui/view_associates.mojom.dart' as view_associates_mojom;
import 'package:mojo_services/mojo/ui/view_token.mojom.dart' as view_token_mojom;
import 'package:mojo_services/mojo/ui/view_trees.mojom.dart' as view_trees_mojom;
import 'package:mojo_services/mojo/ui/views.mojom.dart' as views_mojom;
const int kLabelMaxLength = 32;



class _ViewManagerCreateViewParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  views_mojom.ViewInterfaceRequest view = null;
  view_token_mojom.ViewOwnerInterfaceRequest viewOwner = null;
  views_mojom.ViewListenerInterface viewListener = null;
  String label = null;

  _ViewManagerCreateViewParams() : super(kVersions.last.size);

  static _ViewManagerCreateViewParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewManagerCreateViewParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewManagerCreateViewParams result = new _ViewManagerCreateViewParams();

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
      
      result.view = decoder0.decodeInterfaceRequest(8, false, views_mojom.ViewStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.viewOwner = decoder0.decodeInterfaceRequest(12, false, view_token_mojom.ViewOwnerStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.viewListener = decoder0.decodeServiceInterface(16, false, views_mojom.ViewListenerProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.label = decoder0.decodeString(24, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(view, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "view of struct _ViewManagerCreateViewParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(viewOwner, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewOwner of struct _ViewManagerCreateViewParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(viewListener, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewListener of struct _ViewManagerCreateViewParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(label, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "label of struct _ViewManagerCreateViewParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewManagerCreateViewParams("
           "view: $view" ", "
           "viewOwner: $viewOwner" ", "
           "viewListener: $viewListener" ", "
           "label: $label" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewManagerCreateViewTreeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  view_trees_mojom.ViewTreeInterfaceRequest viewTree = null;
  view_trees_mojom.ViewTreeListenerInterface viewTreeListener = null;
  String label = null;

  _ViewManagerCreateViewTreeParams() : super(kVersions.last.size);

  static _ViewManagerCreateViewTreeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewManagerCreateViewTreeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewManagerCreateViewTreeParams result = new _ViewManagerCreateViewTreeParams();

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
      
      result.viewTree = decoder0.decodeInterfaceRequest(8, false, view_trees_mojom.ViewTreeStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.viewTreeListener = decoder0.decodeServiceInterface(12, false, view_trees_mojom.ViewTreeListenerProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.label = decoder0.decodeString(24, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterfaceRequest(viewTree, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewTree of struct _ViewManagerCreateViewTreeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterface(viewTreeListener, 12, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewTreeListener of struct _ViewManagerCreateViewTreeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(label, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "label of struct _ViewManagerCreateViewTreeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewManagerCreateViewTreeParams("
           "viewTree: $viewTree" ", "
           "viewTreeListener: $viewTreeListener" ", "
           "label: $label" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewManagerRegisterViewAssociateParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  view_associates_mojom.ViewAssociateInterface viewAssociate = null;
  view_associates_mojom.ViewAssociateOwnerInterfaceRequest viewAssociateOwner = null;
  String label = null;

  _ViewManagerRegisterViewAssociateParams() : super(kVersions.last.size);

  static _ViewManagerRegisterViewAssociateParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewManagerRegisterViewAssociateParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewManagerRegisterViewAssociateParams result = new _ViewManagerRegisterViewAssociateParams();

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
      
      result.viewAssociate = decoder0.decodeServiceInterface(8, false, view_associates_mojom.ViewAssociateProxy.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.viewAssociateOwner = decoder0.decodeInterfaceRequest(16, false, view_associates_mojom.ViewAssociateOwnerStub.newFromEndpoint);
    }
    if (mainDataHeader.version >= 0) {
      
      result.label = decoder0.decodeString(24, true);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeInterface(viewAssociate, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewAssociate of struct _ViewManagerRegisterViewAssociateParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeInterfaceRequest(viewAssociateOwner, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "viewAssociateOwner of struct _ViewManagerRegisterViewAssociateParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(label, 24, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "label of struct _ViewManagerRegisterViewAssociateParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_ViewManagerRegisterViewAssociateParams("
           "viewAssociate: $viewAssociate" ", "
           "viewAssociateOwner: $viewAssociateOwner" ", "
           "label: $label" ")";
  }

  Map toJson() {
    throw new bindings.MojoCodecError(
        'Object containing handles cannot be encoded to JSON.');
  }
}


class _ViewManagerFinishedRegisteringViewAssociatesParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _ViewManagerFinishedRegisteringViewAssociatesParams() : super(kVersions.last.size);

  static _ViewManagerFinishedRegisteringViewAssociatesParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _ViewManagerFinishedRegisteringViewAssociatesParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _ViewManagerFinishedRegisteringViewAssociatesParams result = new _ViewManagerFinishedRegisteringViewAssociatesParams();

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
    return "_ViewManagerFinishedRegisteringViewAssociatesParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}

const int _viewManagerMethodCreateViewName = 0;
const int _viewManagerMethodCreateViewTreeName = 1;
const int _viewManagerMethodRegisterViewAssociateName = 2;
const int _viewManagerMethodFinishedRegisteringViewAssociatesName = 3;

class _ViewManagerServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]) =>
      responseFactory(null);

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
      responseFactory(null);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
      responseFactory(null);
}

abstract class ViewManager {
  static const String serviceName = "mojo::ui::ViewManager";

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _ViewManagerServiceDescription();
    }
    return _cachedServiceDescription;
  }

  static ViewManagerProxy connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    ViewManagerProxy p = new ViewManagerProxy.unbound();
    String name = serviceName ?? ViewManager.serviceName;
    if ((name == null) || name.isEmpty) {
      throw new core.MojoApiError(
          "If an interface has no ServiceName, then one must be provided.");
    }
    s.connectToService(url, p, name);
    return p;
  }
  void createView(views_mojom.ViewInterfaceRequest view, view_token_mojom.ViewOwnerInterfaceRequest viewOwner, views_mojom.ViewListenerInterface viewListener, String label);
  void createViewTree(view_trees_mojom.ViewTreeInterfaceRequest viewTree, view_trees_mojom.ViewTreeListenerInterface viewTreeListener, String label);
  void registerViewAssociate(view_associates_mojom.ViewAssociateInterface viewAssociate, view_associates_mojom.ViewAssociateOwnerInterfaceRequest viewAssociateOwner, String label);
  void finishedRegisteringViewAssociates();
}

abstract class ViewManagerInterface
    implements bindings.MojoInterface<ViewManager>,
               ViewManager {
  factory ViewManagerInterface([ViewManager impl]) =>
      new ViewManagerStub.unbound(impl);
  factory ViewManagerInterface.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint,
      [ViewManager impl]) =>
      new ViewManagerStub.fromEndpoint(endpoint, impl);
}

abstract class ViewManagerInterfaceRequest
    implements bindings.MojoInterface<ViewManager>,
               ViewManager {
  factory ViewManagerInterfaceRequest() =>
      new ViewManagerProxy.unbound();
}

class _ViewManagerProxyControl
    extends bindings.ProxyMessageHandler
    implements bindings.ProxyControl<ViewManager> {
  _ViewManagerProxyControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _ViewManagerProxyControl.fromHandle(
      core.MojoHandle handle) : super.fromHandle(handle);

  _ViewManagerProxyControl.unbound() : super.unbound();

  String get serviceName => ViewManager.serviceName;

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      default:
        proxyError("Unexpected message type: ${message.header.type}");
        close(immediate: true);
        break;
    }
  }

  ViewManager get impl => null;
  set impl(ViewManager _) {
    throw new core.MojoApiError("The impl of a Proxy cannot be set.");
  }

  @override
  String toString() {
    var superString = super.toString();
    return "_ViewManagerProxyControl($superString)";
  }
}

class ViewManagerProxy
    extends bindings.Proxy<ViewManager>
    implements ViewManager,
               ViewManagerInterface,
               ViewManagerInterfaceRequest {
  ViewManagerProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint)
      : super(new _ViewManagerProxyControl.fromEndpoint(endpoint));

  ViewManagerProxy.fromHandle(core.MojoHandle handle)
      : super(new _ViewManagerProxyControl.fromHandle(handle));

  ViewManagerProxy.unbound()
      : super(new _ViewManagerProxyControl.unbound());

  static ViewManagerProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewManagerProxy"));
    return new ViewManagerProxy.fromEndpoint(endpoint);
  }


  void createView(views_mojom.ViewInterfaceRequest view, view_token_mojom.ViewOwnerInterfaceRequest viewOwner, views_mojom.ViewListenerInterface viewListener, String label) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ViewManagerCreateViewParams();
    params.view = view;
    params.viewOwner = viewOwner;
    params.viewListener = viewListener;
    params.label = label;
    ctrl.sendMessage(params,
        _viewManagerMethodCreateViewName);
  }
  void createViewTree(view_trees_mojom.ViewTreeInterfaceRequest viewTree, view_trees_mojom.ViewTreeListenerInterface viewTreeListener, String label) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ViewManagerCreateViewTreeParams();
    params.viewTree = viewTree;
    params.viewTreeListener = viewTreeListener;
    params.label = label;
    ctrl.sendMessage(params,
        _viewManagerMethodCreateViewTreeName);
  }
  void registerViewAssociate(view_associates_mojom.ViewAssociateInterface viewAssociate, view_associates_mojom.ViewAssociateOwnerInterfaceRequest viewAssociateOwner, String label) {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ViewManagerRegisterViewAssociateParams();
    params.viewAssociate = viewAssociate;
    params.viewAssociateOwner = viewAssociateOwner;
    params.label = label;
    ctrl.sendMessage(params,
        _viewManagerMethodRegisterViewAssociateName);
  }
  void finishedRegisteringViewAssociates() {
    if (!ctrl.isBound) {
      ctrl.proxyError("The Proxy is closed.");
      return;
    }
    var params = new _ViewManagerFinishedRegisteringViewAssociatesParams();
    ctrl.sendMessage(params,
        _viewManagerMethodFinishedRegisteringViewAssociatesName);
  }
}

class _ViewManagerStubControl
    extends bindings.StubMessageHandler
    implements bindings.StubControl<ViewManager> {
  ViewManager _impl;

  _ViewManagerStubControl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ViewManager impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  _ViewManagerStubControl.fromHandle(
      core.MojoHandle handle, [ViewManager impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  _ViewManagerStubControl.unbound([this._impl]) : super.unbound();

  String get serviceName => ViewManager.serviceName;



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
      case _viewManagerMethodCreateViewName:
        var params = _ViewManagerCreateViewParams.deserialize(
            message.payload);
        _impl.createView(params.view, params.viewOwner, params.viewListener, params.label);
        break;
      case _viewManagerMethodCreateViewTreeName:
        var params = _ViewManagerCreateViewTreeParams.deserialize(
            message.payload);
        _impl.createViewTree(params.viewTree, params.viewTreeListener, params.label);
        break;
      case _viewManagerMethodRegisterViewAssociateName:
        var params = _ViewManagerRegisterViewAssociateParams.deserialize(
            message.payload);
        _impl.registerViewAssociate(params.viewAssociate, params.viewAssociateOwner, params.label);
        break;
      case _viewManagerMethodFinishedRegisteringViewAssociatesName:
        _impl.finishedRegisteringViewAssociates();
        break;
      default:
        throw new bindings.MojoCodecError("Unexpected message name");
        break;
    }
    return null;
  }

  ViewManager get impl => _impl;
  set impl(ViewManager d) {
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
    return "_ViewManagerStubControl($superString)";
  }

  int get version => 0;
}

class ViewManagerStub
    extends bindings.Stub<ViewManager>
    implements ViewManager,
               ViewManagerInterface,
               ViewManagerInterfaceRequest {
  ViewManagerStub.unbound([ViewManager impl])
      : super(new _ViewManagerStubControl.unbound(impl));

  ViewManagerStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [ViewManager impl])
      : super(new _ViewManagerStubControl.fromEndpoint(endpoint, impl));

  ViewManagerStub.fromHandle(
      core.MojoHandle handle, [ViewManager impl])
      : super(new _ViewManagerStubControl.fromHandle(handle, impl));

  static ViewManagerStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For ViewManagerStub"));
    return new ViewManagerStub.fromEndpoint(endpoint);
  }


  void createView(views_mojom.ViewInterfaceRequest view, view_token_mojom.ViewOwnerInterfaceRequest viewOwner, views_mojom.ViewListenerInterface viewListener, String label) {
    return impl.createView(view, viewOwner, viewListener, label);
  }
  void createViewTree(view_trees_mojom.ViewTreeInterfaceRequest viewTree, view_trees_mojom.ViewTreeListenerInterface viewTreeListener, String label) {
    return impl.createViewTree(viewTree, viewTreeListener, label);
  }
  void registerViewAssociate(view_associates_mojom.ViewAssociateInterface viewAssociate, view_associates_mojom.ViewAssociateOwnerInterfaceRequest viewAssociateOwner, String label) {
    return impl.registerViewAssociate(viewAssociate, viewAssociateOwner, label);
  }
  void finishedRegisteringViewAssociates() {
    return impl.finishedRegisteringViewAssociates();
  }
}



