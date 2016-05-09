// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library versioning_test_client_mojom;
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:mojo/mojo/bindings/types/mojom_types.mojom.dart' as mojom_types;
import 'package:mojo/mojo/bindings/types/service_describer.mojom.dart' as service_describer;

class Department extends bindings.MojoEnum {
  static const Department sales = const Department._(0);
  static const Department dev = const Department._(1);

  const Department._(int v) : super(v);

  static const Map<String, Department> valuesMap = const {
    "sales": sales,
    "dev": dev,
  };
  static const List<Department> values = const [
    sales,
    dev,
  ];

  static Department valueOf(String name) => valuesMap[name];

  factory Department(int v) {
    switch (v) {
      case 0:
        return Department.sales;
      case 1:
        return Department.dev;
      default:
        return null;
    }
  }

  static Department decode(bindings.Decoder decoder0, int offset) {
    int v = decoder0.decodeUint32(offset);
    Department result = new Department(v);
    if (result == null) {
      throw new bindings.MojoCodecError(
          'Bad value $v for enum Department.');
    }
    return result;
  }

  String toString() {
    switch(this) {
      case sales:
        return 'Department.sales';
      case dev:
        return 'Department.dev';
      default:
        return null;
    }
  }

  int toJson() => mojoEnumValue;
}



class Employee extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(32, 0)
  ];
  int employeeId = 0;
  String name = null;
  Department department = null;

  Employee() : super(kVersions.last.size);

  static Employee deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static Employee decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    Employee result = new Employee();

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
      
      result.employeeId = decoder0.decodeUint64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.name = decoder0.decodeString(16, false);
    }
    if (mainDataHeader.version >= 0) {
      
        result.department = Department.decode(decoder0, 24);
        if (result.department == null) {
          throw new bindings.MojoCodecError(
            'Trying to decode null union for non-nullable Department.');
        }
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(employeeId, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "employeeId of struct Employee: $e";
      rethrow;
    }
    try {
      encoder0.encodeString(name, 16, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "name of struct Employee: $e";
      rethrow;
    }
    try {
      encoder0.encodeEnum(department, 24);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "department of struct Employee: $e";
      rethrow;
    }
  }

  String toString() {
    return "Employee("
           "employeeId: $employeeId" ", "
           "name: $name" ", "
           "department: $department" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["employeeId"] = employeeId;
    map["name"] = name;
    map["department"] = department;
    return map;
  }
}


class _HumanResourceDatabaseAddEmployeeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  Employee employee = null;

  _HumanResourceDatabaseAddEmployeeParams() : super(kVersions.last.size);

  static _HumanResourceDatabaseAddEmployeeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HumanResourceDatabaseAddEmployeeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HumanResourceDatabaseAddEmployeeParams result = new _HumanResourceDatabaseAddEmployeeParams();

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
      
      var decoder1 = decoder0.decodePointer(8, false);
      result.employee = Employee.decode(decoder1);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(employee, 8, false);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "employee of struct _HumanResourceDatabaseAddEmployeeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HumanResourceDatabaseAddEmployeeParams("
           "employee: $employee" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["employee"] = employee;
    return map;
  }
}


class HumanResourceDatabaseAddEmployeeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  HumanResourceDatabaseAddEmployeeResponseParams() : super(kVersions.last.size);

  static HumanResourceDatabaseAddEmployeeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HumanResourceDatabaseAddEmployeeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HumanResourceDatabaseAddEmployeeResponseParams result = new HumanResourceDatabaseAddEmployeeResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(success, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "success of struct HumanResourceDatabaseAddEmployeeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HumanResourceDatabaseAddEmployeeResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class _HumanResourceDatabaseQueryEmployeeParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1)
  ];
  int id = 0;
  bool retrieveFingerPrint = false;

  _HumanResourceDatabaseQueryEmployeeParams() : super(kVersions.last.size);

  static _HumanResourceDatabaseQueryEmployeeParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HumanResourceDatabaseQueryEmployeeParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HumanResourceDatabaseQueryEmployeeParams result = new _HumanResourceDatabaseQueryEmployeeParams();

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
      
      result.id = decoder0.decodeUint64(8);
    }
    if (mainDataHeader.version >= 1) {
      
      result.retrieveFingerPrint = decoder0.decodeBool(16, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(id, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "id of struct _HumanResourceDatabaseQueryEmployeeParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeBool(retrieveFingerPrint, 16, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "retrieveFingerPrint of struct _HumanResourceDatabaseQueryEmployeeParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HumanResourceDatabaseQueryEmployeeParams("
           "id: $id" ", "
           "retrieveFingerPrint: $retrieveFingerPrint" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    map["retrieveFingerPrint"] = retrieveFingerPrint;
    return map;
  }
}


class HumanResourceDatabaseQueryEmployeeResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0),
    const bindings.StructDataHeader(24, 1)
  ];
  Employee employee = null;
  List<int> fingerPrint = null;

  HumanResourceDatabaseQueryEmployeeResponseParams() : super(kVersions.last.size);

  static HumanResourceDatabaseQueryEmployeeResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HumanResourceDatabaseQueryEmployeeResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HumanResourceDatabaseQueryEmployeeResponseParams result = new HumanResourceDatabaseQueryEmployeeResponseParams();

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
      result.employee = Employee.decode(decoder1);
    }
    if (mainDataHeader.version >= 1) {
      
      result.fingerPrint = decoder0.decodeUint8Array(16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeStruct(employee, 8, true);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "employee of struct HumanResourceDatabaseQueryEmployeeResponseParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(fingerPrint, 16, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fingerPrint of struct HumanResourceDatabaseQueryEmployeeResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HumanResourceDatabaseQueryEmployeeResponseParams("
           "employee: $employee" ", "
           "fingerPrint: $fingerPrint" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["employee"] = employee;
    map["fingerPrint"] = fingerPrint;
    return map;
  }
}


class _HumanResourceDatabaseAttachFingerPrintParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(24, 0)
  ];
  int id = 0;
  List<int> fingerPrint = null;

  _HumanResourceDatabaseAttachFingerPrintParams() : super(kVersions.last.size);

  static _HumanResourceDatabaseAttachFingerPrintParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HumanResourceDatabaseAttachFingerPrintParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HumanResourceDatabaseAttachFingerPrintParams result = new _HumanResourceDatabaseAttachFingerPrintParams();

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
      
      result.id = decoder0.decodeUint64(8);
    }
    if (mainDataHeader.version >= 0) {
      
      result.fingerPrint = decoder0.decodeUint8Array(16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64(id, 8);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "id of struct _HumanResourceDatabaseAttachFingerPrintParams: $e";
      rethrow;
    }
    try {
      encoder0.encodeUint8Array(fingerPrint, 16, bindings.kNothingNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "fingerPrint of struct _HumanResourceDatabaseAttachFingerPrintParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "_HumanResourceDatabaseAttachFingerPrintParams("
           "id: $id" ", "
           "fingerPrint: $fingerPrint" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["id"] = id;
    map["fingerPrint"] = fingerPrint;
    return map;
  }
}


class HumanResourceDatabaseAttachFingerPrintResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  bool success = false;

  HumanResourceDatabaseAttachFingerPrintResponseParams() : super(kVersions.last.size);

  static HumanResourceDatabaseAttachFingerPrintResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HumanResourceDatabaseAttachFingerPrintResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HumanResourceDatabaseAttachFingerPrintResponseParams result = new HumanResourceDatabaseAttachFingerPrintResponseParams();

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
      
      result.success = decoder0.decodeBool(8, 0);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeBool(success, 8, 0);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "success of struct HumanResourceDatabaseAttachFingerPrintResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HumanResourceDatabaseAttachFingerPrintResponseParams("
           "success: $success" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["success"] = success;
    return map;
  }
}


class _HumanResourceDatabaseListEmployeeIdsParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(8, 0)
  ];

  _HumanResourceDatabaseListEmployeeIdsParams() : super(kVersions.last.size);

  static _HumanResourceDatabaseListEmployeeIdsParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static _HumanResourceDatabaseListEmployeeIdsParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    _HumanResourceDatabaseListEmployeeIdsParams result = new _HumanResourceDatabaseListEmployeeIdsParams();

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
    return "_HumanResourceDatabaseListEmployeeIdsParams("")";
  }

  Map toJson() {
    Map map = new Map();
    return map;
  }
}


class HumanResourceDatabaseListEmployeeIdsResponseParams extends bindings.Struct {
  static const List<bindings.StructDataHeader> kVersions = const [
    const bindings.StructDataHeader(16, 0)
  ];
  List<int> ids = null;

  HumanResourceDatabaseListEmployeeIdsResponseParams() : super(kVersions.last.size);

  static HumanResourceDatabaseListEmployeeIdsResponseParams deserialize(bindings.Message message) {
    var decoder = new bindings.Decoder(message);
    var result = decode(decoder);
    if (decoder.excessHandles != null) {
      decoder.excessHandles.forEach((h) => h.close());
    }
    return result;
  }

  static HumanResourceDatabaseListEmployeeIdsResponseParams decode(bindings.Decoder decoder0) {
    if (decoder0 == null) {
      return null;
    }
    HumanResourceDatabaseListEmployeeIdsResponseParams result = new HumanResourceDatabaseListEmployeeIdsResponseParams();

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
      
      result.ids = decoder0.decodeUint64Array(8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    }
    return result;
  }

  void encode(bindings.Encoder encoder) {
    var encoder0 = encoder.getStructEncoderAtOffset(kVersions.last);
    try {
      encoder0.encodeUint64Array(ids, 8, bindings.kArrayNullable, bindings.kUnspecifiedArrayLength);
    } on bindings.MojoCodecError catch(e) {
      e.message = "Error encountered while encoding field "
          "ids of struct HumanResourceDatabaseListEmployeeIdsResponseParams: $e";
      rethrow;
    }
  }

  String toString() {
    return "HumanResourceDatabaseListEmployeeIdsResponseParams("
           "ids: $ids" ")";
  }

  Map toJson() {
    Map map = new Map();
    map["ids"] = ids;
    return map;
  }
}

const int _humanResourceDatabaseMethodAddEmployeeName = 0;
const int _humanResourceDatabaseMethodQueryEmployeeName = 1;
const int _humanResourceDatabaseMethodAttachFingerPrintName = 2;
const int _humanResourceDatabaseMethodListEmployeeIdsName = 3;

class _HumanResourceDatabaseServiceDescription implements service_describer.ServiceDescription {
  dynamic getTopLevelInterface([Function responseFactory]){
    var interfaceTypeKey = getRuntimeTypeInfo().services["mojo::test::versioning::HumanResourceDatabase"];
    var userDefinedType = getAllMojomTypeDefinitions()[interfaceTypeKey];
    return responseFactory(userDefinedType.interfaceType);
  }

  dynamic getTypeDefinition(String typeKey, [Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions()[typeKey]);

  dynamic getAllTypeDefinitions([Function responseFactory]) =>
    responseFactory(getAllMojomTypeDefinitions());
}

abstract class HumanResourceDatabase {
  static const String serviceName = "mojo::test::versioning::HumanResourceDatabase";
  dynamic addEmployee(Employee employee,[Function responseFactory = null]);
  dynamic queryEmployee(int id,bool retrieveFingerPrint,[Function responseFactory = null]);
  dynamic attachFingerPrint(int id,List<int> fingerPrint,[Function responseFactory = null]);
  dynamic listEmployeeIds([Function responseFactory = null]);
}


class _HumanResourceDatabaseProxyImpl extends bindings.Proxy {
  _HumanResourceDatabaseProxyImpl.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) : super.fromEndpoint(endpoint);

  _HumanResourceDatabaseProxyImpl.fromHandle(core.MojoHandle handle) :
      super.fromHandle(handle);

  _HumanResourceDatabaseProxyImpl.unbound() : super.unbound();

  static _HumanResourceDatabaseProxyImpl newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For _HumanResourceDatabaseProxyImpl"));
    return new _HumanResourceDatabaseProxyImpl.fromEndpoint(endpoint);
  }

  service_describer.ServiceDescription get serviceDescription =>
    new _HumanResourceDatabaseServiceDescription();

  void handleResponse(bindings.ServiceMessage message) {
    switch (message.header.type) {
      case _humanResourceDatabaseMethodAddEmployeeName:
        var r = HumanResourceDatabaseAddEmployeeResponseParams.deserialize(
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
      case _humanResourceDatabaseMethodQueryEmployeeName:
        var r = HumanResourceDatabaseQueryEmployeeResponseParams.deserialize(
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
      case _humanResourceDatabaseMethodAttachFingerPrintName:
        var r = HumanResourceDatabaseAttachFingerPrintResponseParams.deserialize(
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
      case _humanResourceDatabaseMethodListEmployeeIdsName:
        var r = HumanResourceDatabaseListEmployeeIdsResponseParams.deserialize(
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

  String toString() {
    var superString = super.toString();
    return "_HumanResourceDatabaseProxyImpl($superString)";
  }
}


class _HumanResourceDatabaseProxyCalls implements HumanResourceDatabase {
  _HumanResourceDatabaseProxyImpl _proxyImpl;

  _HumanResourceDatabaseProxyCalls(this._proxyImpl);
    dynamic addEmployee(Employee employee,[Function responseFactory = null]) {
      var params = new _HumanResourceDatabaseAddEmployeeParams();
      params.employee = employee;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _humanResourceDatabaseMethodAddEmployeeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic queryEmployee(int id,bool retrieveFingerPrint,[Function responseFactory = null]) {
      var params = new _HumanResourceDatabaseQueryEmployeeParams();
      params.id = id;
      params.retrieveFingerPrint = retrieveFingerPrint;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _humanResourceDatabaseMethodQueryEmployeeName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic attachFingerPrint(int id,List<int> fingerPrint,[Function responseFactory = null]) {
      var params = new _HumanResourceDatabaseAttachFingerPrintParams();
      params.id = id;
      params.fingerPrint = fingerPrint;
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _humanResourceDatabaseMethodAttachFingerPrintName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
    dynamic listEmployeeIds([Function responseFactory = null]) {
      var params = new _HumanResourceDatabaseListEmployeeIdsParams();
      return _proxyImpl.sendMessageWithRequestId(
          params,
          _humanResourceDatabaseMethodListEmployeeIdsName,
          -1,
          bindings.MessageHeader.kMessageExpectsResponse);
    }
}


class HumanResourceDatabaseProxy implements bindings.ProxyBase {
  final bindings.Proxy impl;
  HumanResourceDatabase ptr;

  HumanResourceDatabaseProxy(_HumanResourceDatabaseProxyImpl proxyImpl) :
      impl = proxyImpl,
      ptr = new _HumanResourceDatabaseProxyCalls(proxyImpl);

  HumanResourceDatabaseProxy.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) :
      impl = new _HumanResourceDatabaseProxyImpl.fromEndpoint(endpoint) {
    ptr = new _HumanResourceDatabaseProxyCalls(impl);
  }

  HumanResourceDatabaseProxy.fromHandle(core.MojoHandle handle) :
      impl = new _HumanResourceDatabaseProxyImpl.fromHandle(handle) {
    ptr = new _HumanResourceDatabaseProxyCalls(impl);
  }

  HumanResourceDatabaseProxy.unbound() :
      impl = new _HumanResourceDatabaseProxyImpl.unbound() {
    ptr = new _HumanResourceDatabaseProxyCalls(impl);
  }

  factory HumanResourceDatabaseProxy.connectToService(
      bindings.ServiceConnector s, String url, [String serviceName]) {
    HumanResourceDatabaseProxy p = new HumanResourceDatabaseProxy.unbound();
    s.connectToService(url, p, serviceName);
    return p;
  }

  static HumanResourceDatabaseProxy newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HumanResourceDatabaseProxy"));
    return new HumanResourceDatabaseProxy.fromEndpoint(endpoint);
  }

  String get serviceName => HumanResourceDatabase.serviceName;

  Future close({bool immediate: false}) => impl.close(immediate: immediate);

  Future responseOrError(Future f) => impl.responseOrError(f);

  Future get errorFuture => impl.errorFuture;

  int get version => impl.version;

  Future<int> queryVersion() => impl.queryVersion();

  void requireVersion(int requiredVersion) {
    impl.requireVersion(requiredVersion);
  }

  String toString() {
    return "HumanResourceDatabaseProxy($impl)";
  }
}


class HumanResourceDatabaseStub extends bindings.Stub {
  HumanResourceDatabase _impl;

  HumanResourceDatabaseStub.fromEndpoint(
      core.MojoMessagePipeEndpoint endpoint, [HumanResourceDatabase impl])
      : super.fromEndpoint(endpoint, autoBegin: impl != null) {
    _impl = impl;
  }

  HumanResourceDatabaseStub.fromHandle(
      core.MojoHandle handle, [HumanResourceDatabase impl])
      : super.fromHandle(handle, autoBegin: impl != null) {
    _impl = impl;
  }

  HumanResourceDatabaseStub.unbound([this._impl]) : super.unbound();

  static HumanResourceDatabaseStub newFromEndpoint(
      core.MojoMessagePipeEndpoint endpoint) {
    assert(endpoint.setDescription("For HumanResourceDatabaseStub"));
    return new HumanResourceDatabaseStub.fromEndpoint(endpoint);
  }


  HumanResourceDatabaseAddEmployeeResponseParams _humanResourceDatabaseAddEmployeeResponseParamsFactory(bool success) {
    var result = new HumanResourceDatabaseAddEmployeeResponseParams();
    result.success = success;
    return result;
  }
  HumanResourceDatabaseQueryEmployeeResponseParams _humanResourceDatabaseQueryEmployeeResponseParamsFactory(Employee employee, List<int> fingerPrint) {
    var result = new HumanResourceDatabaseQueryEmployeeResponseParams();
    result.employee = employee;
    result.fingerPrint = fingerPrint;
    return result;
  }
  HumanResourceDatabaseAttachFingerPrintResponseParams _humanResourceDatabaseAttachFingerPrintResponseParamsFactory(bool success) {
    var result = new HumanResourceDatabaseAttachFingerPrintResponseParams();
    result.success = success;
    return result;
  }
  HumanResourceDatabaseListEmployeeIdsResponseParams _humanResourceDatabaseListEmployeeIdsResponseParamsFactory(List<int> ids) {
    var result = new HumanResourceDatabaseListEmployeeIdsResponseParams();
    result.ids = ids;
    return result;
  }

  dynamic handleMessage(bindings.ServiceMessage message) {
    if (bindings.ControlMessageHandler.isControlMessage(message)) {
      return bindings.ControlMessageHandler.handleMessage(this,
                                                          2,
                                                          message);
    }
    if (_impl == null) {
      throw new core.MojoApiError("$this has no implementation set");
    }
    switch (message.header.type) {
      case _humanResourceDatabaseMethodAddEmployeeName:
        var params = _HumanResourceDatabaseAddEmployeeParams.deserialize(
            message.payload);
        var response = _impl.addEmployee(params.employee,_humanResourceDatabaseAddEmployeeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _humanResourceDatabaseMethodAddEmployeeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _humanResourceDatabaseMethodAddEmployeeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _humanResourceDatabaseMethodQueryEmployeeName:
        var params = _HumanResourceDatabaseQueryEmployeeParams.deserialize(
            message.payload);
        var response = _impl.queryEmployee(params.id,params.retrieveFingerPrint,_humanResourceDatabaseQueryEmployeeResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _humanResourceDatabaseMethodQueryEmployeeName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _humanResourceDatabaseMethodQueryEmployeeName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _humanResourceDatabaseMethodAttachFingerPrintName:
        var params = _HumanResourceDatabaseAttachFingerPrintParams.deserialize(
            message.payload);
        var response = _impl.attachFingerPrint(params.id,params.fingerPrint,_humanResourceDatabaseAttachFingerPrintResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _humanResourceDatabaseMethodAttachFingerPrintName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _humanResourceDatabaseMethodAttachFingerPrintName,
              message.header.requestId,
              bindings.MessageHeader.kMessageIsResponse);
        }
        break;
      case _humanResourceDatabaseMethodListEmployeeIdsName:
        var response = _impl.listEmployeeIds(_humanResourceDatabaseListEmployeeIdsResponseParamsFactory);
        if (response is Future) {
          return response.then((response) {
            if (response != null) {
              return buildResponseWithId(
                  response,
                  _humanResourceDatabaseMethodListEmployeeIdsName,
                  message.header.requestId,
                  bindings.MessageHeader.kMessageIsResponse);
            }
          });
        } else if (response != null) {
          return buildResponseWithId(
              response,
              _humanResourceDatabaseMethodListEmployeeIdsName,
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

  HumanResourceDatabase get impl => _impl;
  set impl(HumanResourceDatabase d) {
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
    return "HumanResourceDatabaseStub($superString)";
  }

  int get version => 2;

  static service_describer.ServiceDescription _cachedServiceDescription;
  static service_describer.ServiceDescription get serviceDescription {
    if (_cachedServiceDescription == null) {
      _cachedServiceDescription = new _HumanResourceDatabaseServiceDescription();
    }
    return _cachedServiceDescription;
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
  var serializedRuntimeTypeInfo = "H4sIAAAJbogC/+xaT2/jRBS3nUCzXVZb9l8NC10XBEQLG1cgpCh7aUWDilhQoGjFniLXmbZGiR1sp+py2iNHPgZHjvsR+Bh75MixN5hZv1lPxjO2k7ixI+1IT1O7jmfeb977vd9MoitR24D+OfT8/R5zrWJrwPWX2B5gG3m/eJ1OiIKw0zlDfuB4ruOedDoHk5Hl/ogCb+LbaN8KrSMrQIL3PMT2BbafnvS6/W+7TzrkhS3yvlb8upbsbcn5/g29ga3G/H8X+lPod7A1M8fdR2PLD0fIDVv42Y8zn++OxkPvKUKL+9WG+VO/mtw6GPX4mjx3cEW8fhvqtP8K4z97/z9oPyvidgPbOrYYkej+J9juQRykwJeY11Vsb2BzsR1jMyeBbw492xqaJ553MkTmqTdC5m++ZZJXm4FvR3+MJ0dDxzYdN0T+sWWjwDxy3AEeLTDJ8IEZj98nN/r20CHrRz48ivDRmHmM1Wk8KM5NVUltMjzbOfG8Bv4f7j3qHkIufZSNY4s+z+P5Fvi1bDxnzaO8OKsF4XwV8mO/+/jl9afYPsyBM32ex/naiuBs8HwOgF7UZ8O1J8F1AzicMh6J3fdluMa0mOQnbGsl4MnXhx3Ap6dN49Pm5ruu5GsyfBUGX9F92m5C7CKAru8MhPH4NrYrJeAnwkdlE5drjTnwURme4BvhOxLKrjVCIlxulITLhsRPFifC+w1Vnlez4qSlxBGt2wOubvN43QRuKyMPRf4bGbpjVj7kdafOjFljxmty4z+HdfoHek2yrn9x+pPy578p/MnOxxDo7zXmPuWDQ+SfOTb6HsJ+bh1OuPo20Y2S/3+O7b6Mz+WyNRFXm7B+y46reXHRJXGoA99QitMgbppwnz6382bU/3496l/cEcfVBfR/1i6nbuwNBkzVTfqll6Rj+DinOJxr+f0nrS3x/y5gwPj/wEe/TvBMhDjQVkadYPNfVicUtVi90czQc1RviOJls0L1QZfo0Fn36Wl1QZXwABu3ekFx+x62W4m4DcaeG6BVi9tZ2qJxex3qZDCxsS+BkOfuVwAnWVzJ6sKLer59MK+XZXXhNui7HybIf5qyH3u3YnXhj1ox+UX1zpT/TGWoSn7x51OGutz9qCzP1mFesA0Vxs1mRfahaa0hOV+inz+X5NWzBXR8jRmP7me+c9zHkWPT8emj0HfQGeofY4eR3x/7jhtK8DarEJ8Z/KZzmlnPqKeNejH5voXtjiDfaUWtar4/U1dDD94FvVJWnVAvSQ+KcCfr01OL5ZPzS+aTW3BGxtGIIlrHhyWvI8GEzmeN258uyjO8vjqg5zn1+DxHzblu2hLqwDtwprsXhpZ9+vXL1evRxROs31ZF9Bp17HRGvbYrwXMbsEjgMLWbf63bFtVtW8ABVdBtWsq5+LzfH8j2Q3n5keDzWcnnHiJ+TNtfpuksmqeGVkyefgBaVJSn8enF6/OLec8vSPx9tULnF7sQX2Mt/m5Fy1lfawXoIi2jvm4C5o+cIKSq75tBEvftip2DXCjF7IvuAQac/6+qalXytJGD55SUeKB4tQs6nzXg3UncIpZbJX7TlriPpL+/cXCOierANvyGrCr7j/Ucccfy3/8BAAD//9CpxZ1IKQAA";

  // Deserialize RuntimeTypeInfo
  var bytes = BASE64.decode(serializedRuntimeTypeInfo);
  var unzippedBytes = new ZLibDecoder().convert(bytes);
  var bdata = new ByteData.view(unzippedBytes.buffer);
  var message = new bindings.Message(bdata, null, unzippedBytes.length, 0);
  _runtimeTypeInfo = mojom_types.RuntimeTypeInfo.deserialize(message);
  return _runtimeTypeInfo;
}
