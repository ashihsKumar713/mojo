// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library echo_apptests;

import 'dart:async';

import 'package:mojo_apptest/apptest.dart';
import 'package:mojo/application.dart';
import 'package:mojo/bindings.dart';
import 'package:mojo/core.dart';
import 'package:_mojo_for_test_only/test/echo_service.mojom.dart';

class EchoServiceMock implements EchoService {
  dynamic echoString(String value, [Function responseFactory])
      => responseFactory(value);

  dynamic delayedEchoString(String value,int millis, [Function responseFactory])
      => new Future.delayed(new Duration(milliseconds : millis),
                            () => responseFactory(value));
  void swap() {}
  void quit() {}
}

echoApptests(Application application, String url) {
  group('Echo Service Apptests', () {
    test('String', () async {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      var v = await echo.echoString("foo");
      expect(v.value, equals("foo"));

      var q = await echo.echoString("quit");
      expect(q.value, equals("quit"));

      await echo.close();
    });

    test('Empty String', () async {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      var v = await echo.echoString("");
      expect(v.value, equals(""));

      var q = await echo.echoString("quit");
      expect(q.value, equals("quit"));

      await echo.close();
    });

    test('Null String', () async {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      var v = await echo.echoString(null);
      expect(v.value, equals(null));

      var q = await echo.echoString("quit");
      expect(q.value, equals("quit"));

      await echo.close();
    });

    test('Delayed Success', () async {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      var milliseconds = 100;
      var watch = new Stopwatch()..start();
      var v = await echo.delayedEchoString("foo", milliseconds);
      var elapsed = watch.elapsedMilliseconds;
      expect(v.value, equals("foo"));
      expect(elapsed, greaterThanOrEqualTo(milliseconds));

      var q = await echo.echoString("quit");
      expect(q.value, equals("quit"));

      await echo.close();
    });

    test('Delayed Close', () {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      var milliseconds = 100;
      echo.responseOrError(echo.delayedEchoString(
          "quit", milliseconds)).then((result) {
        fail('This future should not complete.');
      }, onError: (e) {
        expect(e is ProxyError, isTrue);
      });

      return new Future.delayed(
          new Duration(milliseconds: 10), () => echo.close());
    });

    test('Swap', () async {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      for (int i = 0; i < 10; i++) {
        var v = await echo.responseOrError(echo.echoString("foo"));
        expect(v.value, equals("foo"));
      }

      echo.ctrl.errorFuture.then((e) {
        fail("echo: $e");
      });

      // Trigger an implementation swap in the echo server.
      echo.swap();

      expect(echo.ctrl.isBound, isTrue);

      for (int i = 0; i < 10; i++) {
        var v = await echo.responseOrError(echo.echoString("foo"));
        expect(v.value, equals("foo"));
      }

      var q = await echo.responseOrError(echo.echoString("quit"));
      expect(q.value, equals("quit"));

      await echo.close();
    });

    test('Multiple Error Checks Success', () {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      List<Future> futures = [];
      for (int i = 0; i < 100; i++) {
        var f = echo.responseOrError(echo.echoString("foo")).then((r) {
          expect(r.value, equals("foo"));
        }, onError: (e) {
          fail('There should be no errors');
        });
        futures.add(f);
      }
      return Future.wait(futures).whenComplete(() => echo.close());
    });

    test('Multiple Error Checks Fail', () {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      List<Future> futures = [];
      var milliseconds = 100;
      for (int i = 0; i < 100; i++) {
        var f = echo.responseOrError(
            echo.delayedEchoString("foo", milliseconds)).then((_) {
          fail('This call should fail');
        }, onError: (e) {
          expect(e is ProxyError, isTrue);
        });
        futures.add(f);
      }
      return echo.close().then((_) => Future.wait(futures));
    });

    test('Uncaught Call Closed', () async {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      // Do a normal call.
      var v = await echo.echoString("foo");
      expect(v.value, equals("foo"));

      // Close the proxy.
      await echo.close();

      // Try to do another call, which should not return.
      echo.echoString("foo").then((_) {
        fail('This should be unreachable');
      });
    });

    test('Catch Call Closed', () async {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      // Do a normal call.
      var v = await echo.echoString("foo");
      expect(v.value, equals("foo"));

      // Close the proxy.
      await echo.close();

      // Try to do another call, which should fail.
      bool caughtException = false;
      try {
        v = await echo.responseOrError(echo.echoString("foo"));
        fail('This should be unreachable');
      } on ProxyError catch (e) {
        caughtException = true;
      }
      expect(caughtException, isTrue);
    });

    test('Catch Call Sequence Closed Twice', () async {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      // Do a normal call.
      var v = await echo.echoString("foo");
      expect(v.value, equals("foo"));

      // Close the proxy.
      await echo.close();

      // Try to do another call, which should fail.
      bool caughtException = false;
      try {
        v = await echo.responseOrError(echo.echoString("foo"));
        fail('This should be unreachable');
      } on ProxyError catch (e) {
        caughtException = true;
      }
      expect(caughtException, isTrue);

      // Make sure we can catch an error more than once.
      caughtException = false;
      try {
        v = await echo.responseOrError(echo.echoString("foo"));
        fail('This should be unreachable');
      } on ProxyError catch (e) {
        caughtException = true;
      }
      expect(caughtException, isTrue);
    });

    test('Catch Call Parallel Closed Twice', () async {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      // Do a normal call.
      var v = await echo.echoString("foo");
      expect(v.value, equals("foo"));

      // Close the proxy.
      await echo.close();

      // Queue up two calls after the close, and make sure they both fail.
      var f1 = echo.responseOrError(echo.echoString("foo")).then((_) {
        fail('This should be unreachable');
      }, onError: (e) {
        expect(e is ProxyError, isTrue);
      });

      var f2 = echo.responseOrError(echo.echoString("foo")).then((_) {
        fail('This should be unreachable');
      }, onError: (e) {
        expect(e is ProxyError, isTrue);
      });

      return Future.wait([f1, f2]);
    });

    test('Unbind, close', () async {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      var r = await echo.responseOrError(echo.echoString("foo"));
      expect(r.value, equals("foo"));

      var endpoint = echo.ctrl.unbind();
      await echo.close();
      endpoint.close();
    });

    test('Unbind, rebind to same', () async {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      var r = await echo.responseOrError(echo.echoString("foo"));
      expect(r.value, equals("foo"));

      var endpoint = echo.ctrl.unbind();
      echo.ctrl.bind(endpoint);

      r = await echo.responseOrError(echo.echoString("foo"));
      expect(r.value, equals("foo"));

      await echo.close();
    });

    test('Unbind, rebind to different', () async {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      var r = await echo.responseOrError(echo.echoString("foo"));
      expect(r.value, equals("foo"));

      var endpoint = echo.ctrl.unbind();
      var differentEchoProxy = new EchoServiceProxy.fromEndpoint(endpoint);

      r = await differentEchoProxy.responseOrError(
          differentEchoProxy.echoString("foo"));
      expect(r.value, equals("foo"));

      await differentEchoProxy.close();
    });

    test('Unbind, rebind to different, close original', () async {
      var echo = EchoService.connectToService(application, "mojo:dart_echo");

      var r = await echo.responseOrError(echo.echoString("foo"));
      expect(r.value, equals("foo"));

      var endpoint = echo.ctrl.unbind();
      var differentEchoProxy = new EchoServiceProxy.fromEndpoint(endpoint);
      await echo.close();

      r = await differentEchoProxy.responseOrError(
          differentEchoProxy.echoString("foo"));
      expect(r.value, equals("foo"));

      await differentEchoProxy.close();
    });

    test('Mock', () async {
      var echo = new EchoServiceInterface.fromMock(new EchoServiceMock());

      var r = await echo.echoString("foo");
      expect(r.value, equals("foo"));

      await echo.close();
    });
  });
}
