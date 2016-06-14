// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package translator

import (
	"sort"
	"testing"

	"mojom/generated/mojom_files"
	"mojom/generated/mojom_types"
)

func TestTranslateMojomStruct(t *testing.T) {
	field1Name := "f_uint32"
	field1 := mojom_types.StructField{
		DeclData:   &mojom_types.DeclarationData{ShortName: &field1Name},
		Type:       &mojom_types.TypeSimpleType{Value: mojom_types.SimpleType_Uint32},
		Offset:     4,
		MinVersion: 10}

	field2Name := "f_uint16"
	field2 := mojom_types.StructField{
		DeclData:   &mojom_types.DeclarationData{ShortName: &field2Name},
		Type:       &mojom_types.TypeSimpleType{Value: mojom_types.SimpleType_Uint16},
		Offset:     5,
		MinVersion: 20}

	structName := "foo"
	s := mojom_types.MojomStruct{
		DeclData: &mojom_types.DeclarationData{ShortName: &structName},
		// field2 must come before field1 to test that sorting happens as expected.
		Fields: []mojom_types.StructField{field2, field1},
		VersionInfo: &[]mojom_types.StructVersion{mojom_types.StructVersion{
			VersionNumber: 10,
			NumBytes:      16,
		}},
	}

	graph := mojom_files.MojomFileGraph{}
	typeKey := "typeKey"
	graph.ResolvedTypes = map[string]mojom_types.UserDefinedType{
		typeKey: &mojom_types.UserDefinedTypeStructType{s},
	}

	translator := NewTranslator(&graph)
	m := translator.translateMojomStruct(typeKey)

	checkEq(t, "Foo", m.Name)
	checkEq(t, uint32(16), m.CurVersionSize)
	checkEq(t, uint32(10), m.CurVersionNumber)
	checkEq(t, "FUint32", m.Fields[0].Name)
	checkEq(t, "uint32", m.Fields[0].Type)
	checkEq(t, uint32(10), m.Fields[0].MinVersion)
	checkEq(t, "FUint16", m.Fields[1].Name)
	checkEq(t, "uint16", m.Fields[1].Type)
	checkEq(t, uint32(20), m.Fields[1].MinVersion)
}

func TestFieldSerializationSorter(t *testing.T) {
	fields := []mojom_types.StructField{
		mojom_types.StructField{Offset: 3, Bit: -1},
		mojom_types.StructField{Offset: 1, Bit: 2},
		mojom_types.StructField{Offset: 2, Bit: -1},
		mojom_types.StructField{Offset: 1, Bit: 1},
		mojom_types.StructField{Offset: 1, Bit: 0},
		mojom_types.StructField{Offset: 0, Bit: -1},
	}

	sorter := structFieldSerializationSorter(fields)
	sort.Sort(sorter)

	checkEq(t, uint32(0), fields[0].Offset)
	checkEq(t, uint32(1), fields[1].Offset)
	checkEq(t, int8(0), fields[1].Bit)
	checkEq(t, uint32(1), fields[2].Offset)
	checkEq(t, int8(1), fields[2].Bit)
	checkEq(t, uint32(1), fields[3].Offset)
	checkEq(t, int8(2), fields[3].Bit)
	checkEq(t, uint32(2), fields[4].Offset)
	checkEq(t, uint32(3), fields[5].Offset)
}

func TestSimpleTypeEncodingInfo(t *testing.T) {
	type expected struct {
		writeFunction string
		bitSize       uint32
	}
	testCases := []struct {
		simpleType mojom_types.SimpleType
		expected   expected
	}{
		{mojom_types.SimpleType_Bool, expected{"WriteBool", 1}},
		{mojom_types.SimpleType_Float, expected{"WriteFloat", 32}},
		{mojom_types.SimpleType_Double, expected{"WriteDouble", 64}},
		{mojom_types.SimpleType_Int8, expected{"WriteInt8", 8}},
		{mojom_types.SimpleType_Int16, expected{"WriteInt16", 16}},
		{mojom_types.SimpleType_Int32, expected{"WriteInt32", 32}},
		{mojom_types.SimpleType_Int64, expected{"WriteInt64", 64}},
		{mojom_types.SimpleType_Uint8, expected{"WriteUint8", 8}},
		{mojom_types.SimpleType_Uint16, expected{"WriteUint16", 16}},
		{mojom_types.SimpleType_Uint32, expected{"WriteUint32", 32}},
		{mojom_types.SimpleType_Uint64, expected{"WriteUint64", 64}},
	}

	translator := translator{}
	for _, testCase := range testCases {
		actual := translator.encodingInfo(&mojom_types.TypeSimpleType{testCase.simpleType})
		checkEq(t, true, actual.IsSimple())
		checkEq(t, testCase.expected.writeFunction, actual.WriteFunction())
		checkEq(t, testCase.expected.bitSize, actual.BitSize())
	}
}

func TestStringTypeEncodingInfo(t *testing.T) {
	mojomType := &mojom_types.TypeStringType{mojom_types.StringType{Nullable: false}}
	translator := translator{}
	info := translator.encodingInfo(mojomType)
	checkEq(t, false, info.IsNullable())
	checkEq(t, true, info.IsSimple())
	checkEq(t, "WriteString", info.WriteFunction())
	checkEq(t, uint32(64), info.BitSize())

	mojomType.Value.Nullable = true
	info = translator.encodingInfo(mojomType)
	checkEq(t, true, info.IsNullable())
}

func TestArrayTypeEncodingInfo(t *testing.T) {
	mojomType := &mojom_types.TypeArrayType{
		mojom_types.ArrayType{
			Nullable: false,
			ElementType: &mojom_types.TypeArrayType{
				mojom_types.ArrayType{
					Nullable:    false,
					ElementType: &mojom_types.TypeSimpleType{mojom_types.SimpleType_Float},
				},
			},
		}}

	translator := translator{}
	info := translator.encodingInfo(mojomType)

	checkEq(t, false, info.IsNullable())
	checkEq(t, true, info.IsPointer())
	checkEq(t, uint32(64), info.BitSize())
	checkEq(t, uint32(64), info.ElementEncodingInfo().BitSize())
	checkEq(t, "elem0", info.ElementEncodingInfo().Identifier())
	checkEq(t, uint32(32), info.ElementEncodingInfo().ElementEncodingInfo().BitSize())
	checkEq(t, "elem1", info.ElementEncodingInfo().ElementEncodingInfo().Identifier())
}

func TestHandleTypeEncodingInfo(t *testing.T) {
	mojomType := &mojom_types.TypeHandleType{
		mojom_types.HandleType{
			Kind:     mojom_types.HandleType_Kind_Unspecified,
			Nullable: false,
		},
	}

	translator := translator{}
	info := translator.encodingInfo(mojomType)

	checkEq(t, false, info.IsNullable())
	checkEq(t, true, info.IsHandle())
	checkEq(t, "ReadHandle", info.ReadFunction())

	mojomType.Value.Nullable = true

	info = translator.encodingInfo(mojomType)
	checkEq(t, true, info.IsNullable())
}

func TestMapTypeEncodingInfo(t *testing.T) {
	mojomType := &mojom_types.TypeMapType{
		mojom_types.MapType{
			Nullable:  true,
			KeyType:   &mojom_types.TypeSimpleType{mojom_types.SimpleType_Uint32},
			ValueType: &mojom_types.TypeSimpleType{mojom_types.SimpleType_Int16},
		},
	}

	translator := translator{}
	info := translator.encodingInfo(mojomType)
	checkEq(t, true, info.IsPointer())
	checkEq(t, true, info.IsMap())
	checkEq(t, true, info.IsNullable())
	checkEq(t, "[]uint32", info.KeyEncodingInfo().GoType())
	checkEq(t, "keys0", info.KeyEncodingInfo().Identifier())
	checkEq(t, "key0", info.KeyEncodingInfo().ElementEncodingInfo().Identifier())
	checkEq(t, "[]int16", info.ValueEncodingInfo().GoType())
	checkEq(t, "values0", info.ValueEncodingInfo().Identifier())
	checkEq(t, "value0", info.ValueEncodingInfo().ElementEncodingInfo().Identifier())
}

func TestStructTypeEncodingInfo(t *testing.T) {
	fileGraph := mojom_files.MojomFileGraph{}
	shortName := "SomeStruct"
	typeKey := "typeKey"

	mojomStruct := mojom_types.MojomStruct{
		DeclData: &mojom_types.DeclarationData{ShortName: &shortName}}
	fileGraph.ResolvedTypes = map[string]mojom_types.UserDefinedType{}
	fileGraph.ResolvedTypes[typeKey] = &mojom_types.UserDefinedTypeStructType{mojomStruct}
	translator := NewTranslator(&fileGraph)

	typeRef := &mojom_types.TypeTypeReference{mojom_types.TypeReference{TypeKey: &typeKey}}

	info := translator.encodingInfo(typeRef)

	checkEq(t, true, info.IsPointer())
	checkEq(t, "SomeStruct", info.GoType())
}

func TestTranslateMojomUnion(t *testing.T) {
	field1Name := "f_uint32"
	field1 := mojom_types.UnionField{
		DeclData: &mojom_types.DeclarationData{ShortName: &field1Name},
		Type:     &mojom_types.TypeSimpleType{Value: mojom_types.SimpleType_Uint32},
		Tag:      5}

	field2Name := "f_uint16"
	field2 := mojom_types.UnionField{
		DeclData: &mojom_types.DeclarationData{ShortName: &field2Name},
		Type:     &mojom_types.TypeSimpleType{Value: mojom_types.SimpleType_Uint16},
		Tag:      6}

	unionName := "foo"
	union := mojom_types.MojomUnion{
		DeclData: &mojom_types.DeclarationData{ShortName: &unionName},
		Fields:   []mojom_types.UnionField{field1, field2},
	}

	graph := mojom_files.MojomFileGraph{}
	typeKey := "typeKey"
	graph.ResolvedTypes = map[string]mojom_types.UserDefinedType{
		typeKey: &mojom_types.UserDefinedTypeUnionType{union},
	}

	translator := NewTranslator(&graph)

	m := translator.translateMojomUnion(typeKey)

	checkEq(t, "Foo", m.Name)
	checkEq(t, "FUint32", m.Fields[0].Name)
	checkEq(t, "uint32", m.Fields[0].Type)
	checkEq(t, uint32(5), m.Fields[0].Tag)
	checkEq(t, m, m.Fields[0].Union)
	checkEq(t, "FUint16", m.Fields[1].Name)
	checkEq(t, "uint16", m.Fields[1].Type)
	checkEq(t, uint32(6), m.Fields[1].Tag)
	checkEq(t, m, m.Fields[1].Union)
}
