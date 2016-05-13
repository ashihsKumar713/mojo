// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:mojo/application.dart';
import 'package:mojo/bindings.dart';
import 'package:mojo/core.dart';

import 'package:_mojo_for_test_only/test/pingpong_service.mojom.dart';

class PingPongClientImpl implements PingPongClient {
  final PingPongClientStub stub;
  Completer _completer;
  int _count;

  PingPongClientImpl.unbound(this._count, this._completer)
      : stub = new PingPongClientStub.unbound() {
    stub.impl = this;
  }

  void pong(int pongValue) {
    if (pongValue == _count) {
      _completer.complete(null);
      stub.close();
    }
  }
}

class PingPongServiceImpl implements PingPongService {
  PingPongServiceStub _stub;
  Application _application;
  PingPongClientProxy _pingPongClient;

  PingPongServiceImpl(this._application, MojoMessagePipeEndpoint endpoint) {
    _stub = new PingPongServiceStub.fromEndpoint(endpoint, this);
  }

  PingPongServiceImpl.fromStub(this._stub) {
    _stub.impl = this;
  }

  void setClient(Proxy proxy) {
    assert(_pingPongClient == null);
    _pingPongClient = proxy;
  }

  void ping(int pingValue) {
    if (_pingPongClient != null) {
      _pingPongClient.pong(pingValue + 1);
    }
  }

  Future pingTargetUrl(String url, int count,
      [Function responseFactory]) async {
    if (_application == null) {
      return responseFactory(false);
    }
    var completer = new Completer();
    var pingPongService = new PingPongServiceProxy.unbound();
    _application.connectToService(url, pingPongService);

    var pingPongClient = new PingPongClientImpl.unbound(count, completer);
    pingPongService.setClient(pingPongClient.stub);

    for (var i = 0; i < count; i++) {
      pingPongService.ping(i);
    }
    await completer.future;
    await pingPongService.close();

    return responseFactory(true);
  }

  Future pingTargetService(Proxy proxy, int count,
      [Function responseFactory]) async {
    var pingPongService = proxy;
    var completer = new Completer();
    var client = new PingPongClientImpl.unbound(count, completer);
    pingPongService.setClient(client.stub);

    for (var i = 0; i < count; i++) {
      pingPongService.ping(i);
    }
    await completer.future;
    await pingPongService.close();

    return responseFactory(true);
  }

  getPingPongService(PingPongServiceStub serviceStub) {
    var targetServiceProxy = new PingPongServiceProxy.unbound();
    _application.connectToService(
        "mojo:dart_pingpong_target", targetServiceProxy);

    // Pass along the interface request to another implementation of the
    // service.
    targetServiceProxy.getPingPongService(serviceStub);
    targetServiceProxy.close();
  }

  getPingPongServiceDelayed(PingPongServiceStub serviceStub) {
    Timer.run(() {
      var endpoint = serviceStub.unbind();
      new Timer(const Duration(milliseconds: 10), () {
        var targetServiceProxy = new PingPongServiceProxy.unbound();
        _application.connectToService(
            "mojo:dart_pingpong_target", targetServiceProxy);

        // Pass along the interface request to another implementation of the
        // service.
        serviceStub.bind(endpoint);
        targetServiceProxy.getPingPongService(serviceStub);
        targetServiceProxy.close();
      });
    });
  }

  void quit() {}
}

class PingPongApplication extends Application {
  PingPongApplication.fromHandle(MojoHandle handle) : super.fromHandle(handle);

  @override
  void acceptConnection(String requestorUrl, String resolvedUrl,
      ApplicationConnection connection) {
    connection.provideService(PingPongService.serviceName,
        (endpoint) => new PingPongServiceImpl(this, endpoint),
        description: PingPongServiceStub.serviceDescription);
  }
}

main(List args, Object handleToken) {
  MojoHandle appHandle = new MojoHandle(handleToken);
  new PingPongApplication.fromHandle(appHandle)
    ..onError = ((_) {
      MojoHandle.reportLeakedHandles();
    });
}
