// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library pingpong_apptests;

import 'dart:async';

import 'package:mojo_apptest/apptest.dart';
import 'package:mojo/application.dart';
import 'package:mojo/bindings.dart';
import 'package:mojo/core.dart';
import 'package:_mojo_for_test_only/test/pingpong_service.mojom.dart';

class _TestingPingPongClient extends PingPongClient {
  final PingPongClientStub stub;
  Completer _completer;

  _TestingPingPongClient.unbound() : stub = new PingPongClientStub.unbound() {
    stub.impl = this;
  }

  waitForPong() async {
    _completer = new Completer();
    return _completer.future;
  }

  void pong(int pongValue) {
    _completer.complete(pongValue);
    _completer = null;
  }
}

pingpongApptests(Application application, String url) {
  group('Ping-Pong Service Apptests', () {
    // Verify that "pingpong.dart" implements the PingPongService interface
    // and sends responses to our client.
    test('Ping Service To Pong Client', () async {
      var pingPongServiceProxy = new PingPongServiceProxy.unbound();
      pingPongServiceProxy.ctrl.errorFuture.then((e) => fail('$e'));
      application.connectToService(
          "mojo:dart_pingpong", pingPongServiceProxy);

      var pingPongClient = new _TestingPingPongClient.unbound();
      pingPongServiceProxy.setClient(pingPongClient.stub);

      pingPongServiceProxy.ping(1);
      var pongValue = await pingPongClient.waitForPong();
      expect(pongValue, equals(2));

      pingPongServiceProxy.ping(100);
      pongValue = await pingPongClient.waitForPong();
      expect(pongValue, equals(101));

      await pingPongClient.stub.close();
      await pingPongServiceProxy.close();
    });

    // Verify that "pingpong.dart" can connect to "pingpong_target.dart", act as
    // its client, and return a Future that only resolves after the
    // target.ping() => client.pong() methods have executed 9 times.
    test('Ping Target URL', () async {
      var pingPongServiceProxy = new PingPongServiceProxy.unbound();
      pingPongServiceProxy.ctrl.errorFuture.then((e) => fail('$e'));
      application.connectToService(
          "mojo:dart_pingpong", pingPongServiceProxy);

      var r = await pingPongServiceProxy.pingTargetUrl(
          "mojo:dart_pingpong_target", 9);
      expect(r.ok, equals(true));

      await pingPongServiceProxy.close();
    });

    // Same as the previous test except that instead of providing the
    // pingpong_target.dart URL, we provide a connection to its PingPongService.
    test('Ping Target Service', () async {
      var pingPongServiceProxy = new PingPongServiceProxy.unbound();
      pingPongServiceProxy.ctrl.errorFuture.then((e) => fail('$e'));
      application.connectToService(
          "mojo:dart_pingpong", pingPongServiceProxy);

      var targetServiceProxy = new PingPongServiceProxy.unbound();
      targetServiceProxy.ctrl.errorFuture.then((e) => fail('$e'));
      application.connectToService(
          "mojo:dart_pingpong_target", targetServiceProxy);

      var r = await pingPongServiceProxy.pingTargetService(
          targetServiceProxy, 9);
      expect(r.ok, equals(true));
      // This side no longer has access to the pipe.
      expect(targetServiceProxy.ctrl.isOpen, equals(false));
      expect(targetServiceProxy.ctrl.isBound, equals(false));

      await pingPongServiceProxy.close();
    });

    // Verify that Dart can implement an interface "request" parameter.
    test('Get Target Service', () async {
      var pingPongServiceProxy = new PingPongServiceProxy.unbound();
      pingPongServiceProxy.ctrl.errorFuture.then((e) => fail('$e'));
      application.connectToService(
          "mojo:dart_pingpong", pingPongServiceProxy);

      var targetServiceProxy = new PingPongServiceProxy.unbound();
      targetServiceProxy.ctrl.errorFuture.then((e) => fail('$e'));
      pingPongServiceProxy.getPingPongService(targetServiceProxy);

      var pingPongClient = new _TestingPingPongClient.unbound();
      targetServiceProxy.setClient(pingPongClient.stub);

      targetServiceProxy.ping(1);
      var pongValue = await pingPongClient.waitForPong();
      expect(pongValue, equals(2));

      targetServiceProxy.ping(100);
      pongValue = await pingPongClient.waitForPong();
      expect(pongValue, equals(101));

      await pingPongClient.stub.close();
      await targetServiceProxy.close();
      await pingPongServiceProxy.close();
    });

    // Verify that Dart can implement an interface "request" parameter that
    // isn't hooked up to an actual service implementation until after some
    // delay.
    test('Get Target Service Delayed', () async {
      var pingPongServiceProxy = new PingPongServiceProxy.unbound();
      pingPongServiceProxy.ctrl.errorFuture.then((e) => fail('$e'));
      application.connectToService(
          "mojo:dart_pingpong", pingPongServiceProxy);

      var targetServiceProxy = new PingPongServiceProxy.unbound();
      targetServiceProxy.ctrl.errorFuture.then((e) => fail('$e'));
      pingPongServiceProxy.getPingPongServiceDelayed(targetServiceProxy);

      var pingPongClient = new _TestingPingPongClient.unbound();
      targetServiceProxy.setClient(pingPongClient.stub);

      targetServiceProxy.ping(1);
      var pongValue = await pingPongClient.waitForPong();
      expect(pongValue, equals(2));

      targetServiceProxy.ping(100);
      pongValue = await pingPongClient.waitForPong();
      expect(pongValue, equals(101));

      await pingPongClient.stub.close();
      await targetServiceProxy.close();
      await pingPongServiceProxy.close();
    });
  });
}
