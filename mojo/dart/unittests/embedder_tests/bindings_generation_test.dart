// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:convert';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart'
    as service_describer;
import 'package:_mojo_for_test_only/expect.dart';
import 'package:_mojo_for_test_only/mojo/test/rect.mojom.dart' as rect;
import 'package:_mojo_for_test_only/mojo/test/serialization_test_structs.mojom.dart'
    as serialization;
import 'package:_mojo_for_test_only/mojo/test/test_structs.mojom.dart'
    as structs;
import 'package:_mojo_for_test_only/mojo/test/test_unions.mojom.dart'
    as unions;
import 'package:_mojo_for_test_only/mojo/test/validation_test_interfaces.mojom.dart'
    as validation;
import 'package:_mojo_for_test_only/regression_tests/regression_tests.mojom.dart'
    as regression;
import 'package:_mojo_for_test_only/sample/sample_interfaces.mojom.dart'
    as sample;

class ProviderImpl implements sample.Provider {
  sample.ProviderStub _stub;

  ProviderImpl(core.MojoMessagePipeEndpoint endpoint) {
    _stub = new sample.ProviderStub.fromEndpoint(endpoint, this);
  }

  echoString(String a, Function responseFactory) =>
      new Future.value(responseFactory(a));

  echoStrings(String a, String b, Function responseFactory) =>
      new Future.value(responseFactory(a, b));

  echoMessagePipeHandle(core.MojoHandle a, Function responseFactory) =>
      new Future.value(responseFactory(a));

  echoEnum(sample.Enum a, Function responseFactory) =>
      new Future.value(responseFactory(a));
}

void providerIsolate(core.MojoMessagePipeEndpoint endpoint) {
  new ProviderImpl(endpoint);
}

Future<bool> testCallResponse() {
  var pipe = new core.MojoMessagePipe();
  var client = new sample.ProviderProxy.fromEndpoint(pipe.endpoints[0]);
  var c = new Completer();
  Isolate.spawn(providerIsolate, pipe.endpoints[1]).then((_) {
    client.ptr.echoString("hello!").then((echoStringResponse) {
      Expect.equals("hello!", echoStringResponse.a);
    }).then((_) {
      client.ptr.echoStrings("hello", "mojo!").then((echoStringsResponse) {
        Expect.equals("hello", echoStringsResponse.a);
        Expect.equals("mojo!", echoStringsResponse.b);
        client.close().then((_) {
          c.complete(true);
        });
      });
    });
  });
  return c.future;
}

Future testAwaitCallResponse() async {
  var pipe = new core.MojoMessagePipe();
  var client = new sample.ProviderProxy.fromEndpoint(pipe.endpoints[0]);
  var isolate = await Isolate.spawn(providerIsolate, pipe.endpoints[1]);

  var echoStringResponse = await client.ptr.echoString("hello!");
  Expect.equals("hello!", echoStringResponse.a);

  var echoStringsResponse = await client.ptr.echoStrings("hello", "mojo!");
  Expect.equals("hello", echoStringsResponse.a);
  Expect.equals("mojo!", echoStringsResponse.b);

  await client.close();
}

bindings.ServiceMessage messageOfStruct(bindings.Struct s) =>
    s.serializeWithHeader(new bindings.MessageHeader(0));

testSerializeNamedRegion() {
  var r = new rect.Rect()
    ..x = 1
    ..y = 2
    ..width = 3
    ..height = 4;
  var namedRegion = new structs.NamedRegion()
    ..name = "name"
    ..rects = [r];
  var message = messageOfStruct(namedRegion);
  var namedRegion2 = structs.NamedRegion.deserialize(message.payload);
  Expect.equals(namedRegion.name, namedRegion2.name);
}

testSerializeArrayValueTypes() {
  var arrayValues = new structs.ArrayValueTypes()
    ..f0 = [0, 1, -1, 0x7f, -0x10]
    ..f1 = [0, 1, -1, 0x7fff, -0x1000]
    ..f2 = [0, 1, -1, 0x7fffffff, -0x10000000]
    ..f3 = [0, 1, -1, 0x7fffffffffffffff, -0x1000000000000000]
    ..f4 = [0.0, 1.0, -1.0, 4.0e9, -4.0e9]
    ..f5 = [0.0, 1.0, -1.0, 4.0e9, -4.0e9];
  var message = messageOfStruct(arrayValues);
  var arrayValues2 = structs.ArrayValueTypes.deserialize(message.payload);
  Expect.listEquals(arrayValues.f0, arrayValues2.f0);
  Expect.listEquals(arrayValues.f1, arrayValues2.f1);
  Expect.listEquals(arrayValues.f2, arrayValues2.f2);
  Expect.listEquals(arrayValues.f3, arrayValues2.f3);
  Expect.listEquals(arrayValues.f4, arrayValues2.f4);
  Expect.listEquals(arrayValues.f5, arrayValues2.f5);
}

testSerializeToJSON() {
  var r = new rect.Rect()
    ..x = 1
    ..y = 2
    ..width = 3
    ..height = 4;

  var encodedRect = JSON.encode(r);
  var goldenEncoding = "{\"x\":1,\"y\":2,\"width\":3,\"height\":4}";
  Expect.equals(goldenEncoding, encodedRect);
}

testSerializeHandleToJSON() {
  var s = new serialization.Struct2();

  Expect.throws(
      () => JSON.encode(s), (e) => e.cause is bindings.MojoCodecError);
}

testSerializeKeywordStruct() {
  var keywordStruct = new structs.DartKeywordStruct()
      ..await_ = structs.DartKeywordStructKeywords.await_
      ..is_ = structs.DartKeywordStructKeywords.is_
      ..rethrow_ = structs.DartKeywordStructKeywords.rethrow_;
  var message = messageOfStruct(keywordStruct);
  var decodedStruct = structs.DartKeywordStruct.deserialize(message.payload);
  Expect.equals(keywordStruct.await_, decodedStruct.await_);
  Expect.equals(keywordStruct.is_, decodedStruct.is_);
  Expect.equals(keywordStruct.rethrow_, decodedStruct.rethrow_);
}

testSerializeStructs() {
  testSerializeNamedRegion();
  testSerializeArrayValueTypes();
  testSerializeToJSON();
  testSerializeHandleToJSON();
  testSerializeKeywordStruct();
}

testSerializePodUnions() {
  var s = new unions.WrapperStruct()..podUnion = new unions.PodUnion();
  s.podUnion.fUint32 = 32;

  Expect.equals(unions.PodUnionTag.fUint32, s.podUnion.tag);
  Expect.equals(32, s.podUnion.fUint32);

  var message = messageOfStruct(s);
  var s2 = unions.WrapperStruct.deserialize(message.payload);

  Expect.equals(s.podUnion.fUint32, s2.podUnion.fUint32);
}

testSerializeStructInUnion() {
  var s = new unions.WrapperStruct()..objectUnion = new unions.ObjectUnion();
  s.objectUnion.fDummy = new unions.DummyStruct()..fInt8 = 8;

  var message = messageOfStruct(s);
  var s2 = unions.WrapperStruct.deserialize(message.payload);

  Expect.equals(s.objectUnion.fDummy.fInt8, s2.objectUnion.fDummy.fInt8);
}

testSerializeArrayInUnion() {
  var s = new unions.WrapperStruct()..objectUnion = new unions.ObjectUnion();
  s.objectUnion.fArrayInt8 = [1, 2, 3];

  var message = messageOfStruct(s);
  var s2 = unions.WrapperStruct.deserialize(message.payload);

  Expect.listEquals(s.objectUnion.fArrayInt8, s2.objectUnion.fArrayInt8);
}

testSerializeMapInUnion() {
  var s = new unions.WrapperStruct()..objectUnion = new unions.ObjectUnion();
  s.objectUnion.fMapInt8 = {"one": 1, "two": 2,};

  var message = messageOfStruct(s);
  var s2 = unions.WrapperStruct.deserialize(message.payload);

  Expect.equals(1, s.objectUnion.fMapInt8["one"]);
  Expect.equals(2, s.objectUnion.fMapInt8["two"]);
}

testSerializeUnionInArray() {
  var s = new unions.SmallStruct()
    ..podUnionArray = [
      new unions.PodUnion()..fUint16 = 16,
      new unions.PodUnion()..fUint32 = 32,
    ];

  var message = messageOfStruct(s);

  var s2 = unions.SmallStruct.deserialize(message.payload);

  Expect.equals(16, s2.podUnionArray[0].fUint16);
  Expect.equals(32, s2.podUnionArray[1].fUint32);
}

testSerializeUnionInMap() {
  var s = new unions.SmallStruct()
    ..podUnionMap = {
      'one': new unions.PodUnion()..fUint16 = 16,
      'two': new unions.PodUnion()..fUint32 = 32,
    };

  var message = messageOfStruct(s);

  var s2 = unions.SmallStruct.deserialize(message.payload);

  Expect.equals(16, s2.podUnionMap['one'].fUint16);
  Expect.equals(32, s2.podUnionMap['two'].fUint32);
}

testSerializeUnionInUnion() {
  var s = new unions.WrapperStruct()..objectUnion = new unions.ObjectUnion();
  s.objectUnion.fPodUnion = new unions.PodUnion()..fUint32 = 32;

  var message = messageOfStruct(s);
  var s2 = unions.WrapperStruct.deserialize(message.payload);

  Expect.equals(32, s2.objectUnion.fPodUnion.fUint32);
}

testUnionsToString() {
  var podUnion = new unions.PodUnion();
  podUnion.fUint32 = 32;
  Expect.equals("PodUnion(fUint32: 32)", podUnion.toString());
}

testUnions() {
  testSerializePodUnions();
  testSerializeStructInUnion();
  testSerializeArrayInUnion();
  testSerializeMapInUnion();
  testSerializeUnionInArray();
  testSerializeUnionInMap();
  testSerializeUnionInUnion();
  testUnionsToString();
}

class CheckEnumCapsImpl implements regression.CheckEnumCaps {
  regression.CheckEnumCapsStub _stub;

  CheckEnumCapsImpl(core.MojoMessagePipeEndpoint endpoint) {
    _stub = new regression.CheckEnumCapsStub.fromEndpoint(endpoint, this);
  }

  setEnumWithInternalAllCaps(regression.EnumWithInternalAllCaps e) {}
}

checkEnumCapsIsolate(core.MojoMessagePipeEndpoint endpoint) {
  new CheckEnumCapsImpl(endpoint);
}

testCheckEnumCapsImpl() {
  var pipe = new core.MojoMessagePipe();
  var client =
      new regression.CheckEnumCapsProxy.fromEndpoint(pipe.endpoints[0]);
  var c = new Completer();
  Isolate.spawn(checkEnumCapsIsolate, pipe.endpoints[1]).then((_) {
    client.ptr.setEnumWithInternalAllCaps(
        regression.EnumWithInternalAllCaps.standard);
    client.close().then((_) {
      c.complete(null);
    });
  });
  return c.future;
}

testSerializeEnum() {
  var constants = new structs.ScopedConstants();
  constants.f4 = structs.ScopedConstantsEType.e0;
  var message = messageOfStruct(constants);
  var constants2 = structs.ScopedConstants.deserialize(message.payload);
  Expect.equals(constants.f4, constants2.f4);
}

testEnums() async {
  testSerializeEnum();
  await testCheckEnumCapsImpl();
}

void closingProviderIsolate(core.MojoMessagePipeEndpoint endpoint) {
  var provider = new ProviderImpl(endpoint);
  provider._stub.close();
}

Future<bool> runOnClosedTest() {
  var testCompleter = new Completer();
  var pipe = new core.MojoMessagePipe();
  var proxy = new sample.ProviderProxy.fromEndpoint(pipe.endpoints[0]);
  proxy.impl.onError = (_) => testCompleter.complete(true);
  Isolate.spawn(closingProviderIsolate, pipe.endpoints[1]);
  return testCompleter.future.then((b) {
    Expect.isTrue(b);
  });
}

class Regression551Impl implements regression.Regression551 {
  regression.Regression551Stub _stub;

  Regression551Impl(core.MojoMessagePipeEndpoint endpoint) {
    _stub = new regression.Regression551Stub.fromEndpoint(endpoint, this);
  }

  dynamic get(List<String> keyPrefixes, Function responseFactory) =>
    responseFactory(0);
}

void regression551Isolate(core.MojoMessagePipeEndpoint endpoint) {
  new Regression551Impl(endpoint);
}

Future<bool> testRegression551() {
  var pipe = new core.MojoMessagePipe();
  var client = new regression.Regression551Proxy.fromEndpoint(pipe.endpoints[0]);
  var c = new Completer();
  Isolate.spawn(regression551Isolate, pipe.endpoints[1]).then((_) {
    client.ptr.get(["hello!"]).then((response) {
      Expect.equals(0, response.result);
      client.close().then((_) {
        c.complete(true);
      });
    });
  });
  return c.future;
}

class ServiceNameImpl implements regression.ServiceName {
  regression.ServiceNameStub _stub;

  ServiceNameImpl(core.MojoMessagePipeEndpoint endpoint) {
    _stub = new regression.ServiceNameStub.fromEndpoint(endpoint, this);
  }

  dynamic serviceName_(Function responseFactory) =>
      responseFactory(ServiceName.serviceName);
}

void serviceNameIsolate(core.MojoMessagePipeEndpoint endpoint) {
  new ServiceNameImpl(endpoint);
}

Future<bool> testServiceName() {
  var pipe = new core.MojoMessagePipe();
  var client = new regression.ServiceNameProxy.fromEndpoint(pipe.endpoints[0]);
  var c = new Completer();
  Isolate.spawn(serviceNameIsolate, pipe.endpoints[1]).then((_) {
    client.ptr.serviceName_().then((response) {
      Expect.equals(ServiceName.serviceName, response.serviceName_);
      client.close().then((_) {
        c.complete(true);
      });
    });
  });
  return c.future;
}


testCamelCase() {
  var e = CamelCaseTestEnum.boolThing;
  e = CamelCaseTestEnum.doubleThing;
  e = CamelCaseTestEnum.floatThing;
  e = CamelCaseTestEnum.int8Thing;
  e = CamelCaseTestEnum.int16Thing;
  e = CamelCaseTestEnum.int32Th1Ng;
  e = CamelCaseTestEnum.int64Th1ng;
  e = CamelCaseTestEnum.uint8TH1ng;
  e = CamelCaseTestEnum.uint16tH1Ng;
  e = CamelCaseTestEnum.uint32Th1ng;
  e = CamelCaseTestEnum.uint64Th1Ng;
}

testValidateMojomTypes() {
  testValidateEnumType();
  testValidateStructType();
  testValidateUnionType();
  testValidateTestStructWithImportType();
  testValidateInterfaceType();
}

// Test that mojom type descriptors were generated correctly for validation's
// BasicEnum.
testValidateEnumType() {
  var testValidationDescriptor = validation.getAllMojomTypeDefinitions();
  String enumID = "validation_test_interfaces_BasicEnum__";
  String shortName = "BasicEnum";
  String fullIdentifier = "mojo.test.BasicEnum";
  Map<String, int> labelMap = <String, int>{
    "A": 0,
    "B": 1,
    "C": 0,
    "D": -3,
    "E": 0xA,
  };

  // Extract the UserDefinedType from the descriptor using enumID.
  mojom_types.UserDefinedType udt = testValidationDescriptor[enumID];
  Expect.isNotNull(udt);

  // The enumType must be present and declared properly.
  mojom_types.MojomEnum me = udt.enumType;
  Expect.isNotNull(me);
  Expect.isNotNull(me.declData);
  Expect.equals(me.declData.shortName, shortName);
  Expect.equals(me.declData.fullIdentifier, fullIdentifier);

  // Now compare the labels to verify that the enum labels match the expected
  // ones.
  Expect.equals(me.values.length, labelMap.length);
  me.values.forEach((mojom_types.EnumValue ev) {
    // Check that the declData is correct...
    Expect.isNotNull(ev.declData);
    Expect.isNotNull(labelMap[ev.declData.shortName]);

    // Check that the enumTypeKey matches the enumID.
    Expect.equals(ev.enumTypeKey, enumID);
    Expect.equals(ev.intValue, labelMap[ev.declData.shortName]);
  });
}

// Test that mojom type descriptors were generated correctly for validation's
// StructE.
testValidateStructType() {
  var testValidationDescriptor = validation.getAllMojomTypeDefinitions();
  String structID = "validation_test_interfaces_StructE__";
  String shortName = "StructE";
  String fullIdentifier = "mojo.test.StructE";
  Map<int, String> expectedFields = <int, String>{
    0: "StructD",
    1: "DataPipeConsumer",
  };

  // Extract the UserDefinedType from the descriptor using structID.
  mojom_types.UserDefinedType udt = testValidationDescriptor[structID];
  Expect.isNotNull(udt);

  // The structType must be present and declared properly.
  mojom_types.MojomStruct ms = udt.structType;
  Expect.isNotNull(ms);
  Expect.isNotNull(ms.declData);
  Expect.equals(ms.declData.shortName, shortName);
  Expect.equals(ms.declData.fullIdentifier, fullIdentifier);

  // Now compare the fields to verify that the struct fields match the expected
  // ones.
  Expect.equals(ms.fields.length, expectedFields.length);
  int i = 0;
  ms.fields.forEach((mojom_types.StructField field) {
    // Check that the declData is correct...
    Expect.isNotNull(field.declData);
    Expect.equals(expectedFields[i], field.declData.shortName);

    // Special case each field since we already know what should be inside.
    switch (i) {
      case 0: // This is a TypeReference to StructD.
        mojom_types.Type t = field.type;
        Expect.isNotNull(t.typeReference);

        // Type key, identifier, and expected reference id should match up.
        mojom_types.TypeReference tr = t.typeReference;
        String expectedRefID = "validation_test_interfaces_StructD__";
        Expect.equals(expectedRefID, tr.identifier);
        Expect.equals(expectedRefID, tr.typeKey);
        break;
      case 1: // This is a non-nullable DataPipeConsumer HandleType.
        mojom_types.Type t = field.type;
        Expect.isNotNull(t.handleType);

        mojom_types.HandleType ht = t.handleType;
        Expect.isFalse(ht.nullable);
        Expect.equals(mojom_types.HandleTypeKind.dataPipeConsumer, ht.kind);
        break;
      default:
        assert(false);
    }

    i++;
  });
}

// Test that mojom type descriptors were generated correctly for validation's
// UnionB.
testValidateUnionType() {
  var testValidationDescriptor = validation.getAllMojomTypeDefinitions();
  String unionID = "validation_test_interfaces_UnionB__";
  String shortName = "UnionB";
  String fullIdentifier = "mojo.test.UnionB";
  Map<int, String> expectedFields = <int, String>{
    0: "A",
    1: "B",
    2: "C",
    3: "D",
  };

  // Extract the UserDefinedType from the descriptor using unionID.
  mojom_types.UserDefinedType udt = testValidationDescriptor[unionID];
  Expect.isNotNull(udt);

  // The unionType must be present and declared properly.
  mojom_types.MojomUnion mu = udt.unionType;
  Expect.isNotNull(mu);
  Expect.isNotNull(mu.declData);
  Expect.equals(mu.declData.shortName, shortName);
  Expect.equals(mu.declData.fullIdentifier, fullIdentifier);

  // Now compare the fields to verify that the union fields match the expected
  // ones.
  Expect.equals(mu.fields.length, expectedFields.length);
  mu.fields.forEach((mojom_types.UnionField field) {
    int ordinal = field.tag;

    // Check that the declData is correct...
    Expect.isNotNull(field.declData);
    Expect.equals(expectedFields[ordinal], field.declData.shortName);

    // Special: It turns out that all types are simple types.
    mojom_types.Type t = field.type;
    Expect.isNotNull(t.simpleType);
    mojom_types.SimpleType st = t.simpleType;

    // Special case each field since we already know what should be inside.
    switch (ordinal) {
      case 0: // Uint16
        Expect.equals(st, mojom_types.SimpleType.uint16);
        break;
      case 1: // Uint32
      case 3:
        Expect.equals(st, mojom_types.SimpleType.uint32);
        break;
      case 2: // Uint64
        Expect.equals(st, mojom_types.SimpleType.uint64);
        break;
      default:
        assert(false);
    }
  });
}

// Test that mojom type descriptors were generated correctly for validation's
// IncludingStruct, which contains a union imported from test_included_unions.
testValidateTestStructWithImportType() {
  var testUnionsDescriptor = unions.getAllMojomTypeDefinitions();
  String structID = "test_unions_IncludingStruct__";
  String shortName = "IncludingStruct";
  String fullIdentifier = "mojo.test.IncludingStruct";
  Map<int, String> expectedFields = <int, String>{0: "A",};

  // Extract the UserDefinedType from the descriptor using structID.
  mojom_types.UserDefinedType udt = testUnionsDescriptor[structID];
  Expect.isNotNull(udt);

  // The structType must be present and declared properly.
  mojom_types.MojomStruct ms = udt.structType;
  Expect.isNotNull(ms);
  Expect.isNotNull(ms.declData);
  Expect.equals(ms.declData.shortName, shortName);
  Expect.equals(ms.declData.fullIdentifier, fullIdentifier);

  // Now compare the fields to verify that the struct fields match the expected
  // ones.
  Expect.equals(ms.fields.length, expectedFields.length);
  int i = 0;
  ms.fields.forEach((mojom_types.StructField field) {
    // Check that the declData is correct...
    Expect.isNotNull(field.declData);
    Expect.equals(expectedFields[i], field.declData.shortName);

    // Special case each field since we already know what should be inside.
    switch (i) {
      case 0: // This is a TypeReference to a Union.
        mojom_types.Type t = field.type;
        Expect.isNotNull(t.typeReference);

        // Type key, identifier, and expected reference id should match up.
        mojom_types.TypeReference tr = t.typeReference;
        String expectedRefID = "test_included_unions_IncludedUnion__";
        Expect.equals(expectedRefID, tr.identifier);
        Expect.equals(expectedRefID, tr.typeKey);
        break;
      default:
        assert(false);
    }

    i++;
  });
}

// Test that mojom type descriptors were generated correctly for validation's
// BoundsCheckTestInterface.
testValidateInterfaceType() {
  // interface BoundsCheckTestInterface {
  //   Method0(uint8 param0) => (uint8 param0);
  //   Method1(uint8 param0);
  // };

  var testValidationDescriptor = validation.getAllMojomTypeDefinitions();
  String interfaceID = "validation_test_interfaces_BoundsCheckTestInterface__";
  String shortName = "BoundsCheckTestInterface";
  String fullIdentifier = "mojo.test.BoundsCheckTestInterface";
  Map<int, String> methodMap = <int, String>{0: "Method0", 1: "Method1",};

  mojom_types.UserDefinedType udt = testValidationDescriptor[interfaceID];
  Expect.isNotNull(udt);

  mojom_types.MojomInterface mi = udt.interfaceType;
  Expect.isNotNull(mi);

  _checkMojomInterface(mi, shortName, fullIdentifier, methodMap);

  // The proxy and stub need to have a valid serviceDescription.
  var bcti_p = new validation.BoundsCheckTestInterfaceProxy.unbound().impl;
  var bcti_s = new validation.BoundsCheckTestInterfaceStub.unbound();

  _checkServiceDescription(
      bcti_p.serviceDescription, interfaceID, shortName, fullIdentifier,
      methodMap);
  _checkServiceDescription(
      bcti_s.serviceDescription, interfaceID, shortName, fullIdentifier,
      methodMap);
}

_checkServiceDescription(service_describer.ServiceDescription sd,
    String interfaceID, String shortName, String fullIdentifier,
    Map<int, String> methodMap) {
  // Check the top level interface, which must pass _checkMojomInterface.
  mojom_types.MojomInterface mi = sd.getTopLevelInterface();
  _checkMojomInterface(mi, shortName, fullIdentifier, methodMap);

  // Try out sd.GetTypeDefinition with the given interfaceID.
  mojom_types.UserDefinedType udt = sd.getTypeDefinition(interfaceID);
  Expect.isNotNull(udt.interfaceType);
  _checkMojomInterface(udt.interfaceType, shortName, fullIdentifier, methodMap);

  // Check all type definitions. Reflect-wise, all data inside should match the
  // imported Descriptor.
  var actualDescriptions = sd.getAllTypeDefinitions();
  var expectedDescriptions = validation.getAllMojomTypeDefinitions();
  Expect.mapEquals(actualDescriptions, expectedDescriptions);
}

_checkMojomInterface(mojom_types.MojomInterface mi, String shortName,
    String fullIdentifier, Map<int, String> methodMap) {
  // check the generated short name.
  Expect.isNotNull(mi.declData);
  Expect.equals(mi.declData.shortName, shortName);
  Expect.equals(mi.declData.fullIdentifier, fullIdentifier);

  // Verify that the number of methods matches the expected ones.
  Expect.equals(mi.methods.length, methodMap.length);

  // Each MojomMethod must be named, typed, and "ordinal"ed correctly.
  mi.methods.forEach((int ordinal, mojom_types.MojomMethod method) {
    Expect.isNotNull(method.declData);
    Expect.equals(methodMap[ordinal], method.declData.shortName);

    // Special case each method since we know what's inside.
    switch (ordinal) {
      case 0: // Has request and response params.
        // Request is a single uint8 input.
        mojom_types.MojomStruct params = method.parameters;
        Expect.equals(params.fields.length, 1);
        Expect.equals(
            params.fields[0].type.simpleType, mojom_types.SimpleType.uint8);

        // Response is a single uint8 output.
        mojom_types.MojomStruct response = method.responseParams;
        Expect.isNotNull(response);
        Expect.equals(response.fields.length, 1);
        Expect.equals(
            response.fields[0].type.simpleType, mojom_types.SimpleType.uint8);
        break;
      case 1: // Only has request params.
        // Request is a single uint8 input.
        mojom_types.MojomStruct params = method.parameters;
        Expect.equals(params.fields.length, 1);
        Expect.equals(
            params.fields[0].type.simpleType, mojom_types.SimpleType.uint8);

        // Response is a single uint8 output.
        mojom_types.MojomStruct response = method.responseParams;
        Expect.isNull(response);
        break;
      default:
        assert(false);
    }
  });
}


main() async {
  testSerializeStructs();
  testUnions();
  testValidateMojomTypes();
  await testEnums();
  await testCallResponse();
  await testAwaitCallResponse();
  await runOnClosedTest();
  await testRegression551();
  await testServiceName();
  testCamelCase();
}
