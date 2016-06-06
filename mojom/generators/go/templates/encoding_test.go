// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package templates

import (
	"testing"
)

type mockEncodingInfo struct {
	IsSimple            bool
	IsPointer           bool
	IsHandle            bool
	IsArray             bool
	IsMap               bool
	IsNullable          bool
	IsStruct            bool
	ElementEncodingInfo *mockEncodingInfo
	KeyEncodingInfo     *mockEncodingInfo
	ValueEncodingInfo   *mockEncodingInfo
	BitSize             uint32
	WriteFunction       string
	ReadFunction        string
	Identifier          string
	GoType              string
}

func TestEncodingSimpleFieldEncoding(t *testing.T) {
	expected := `if err := encoder.WriteUint8(s.Fuint8); err != nil {
	return err
}`

	encodingInfo := mockEncodingInfo{
		IsSimple:      true,
		Identifier:    "s.Fuint8",
		WriteFunction: "WriteUint8",
	}

	check(t, expected, "FieldEncodingTmpl", encodingInfo)
}

func TestEncodingHandleFieldEncoding(t *testing.T) {
	expected := `if err := encoder.WriteHandle(s.SomeHandle); err != nil {
	return err
}`

	encodingInfo := mockEncodingInfo{
		IsHandle:   true,
		Identifier: "s.SomeHandle",
	}

	check(t, expected, "FieldEncodingTmpl", encodingInfo)
}

func TestEncodingNullableHandleFieldEncoding(t *testing.T) {
	expected := `if s.SomeHandle == nil {
	encoder.WriteInvalidHandle()
} else {
	if err := encoder.WriteHandle(*(s.SomeHandle)); err != nil {
		return err
	}
}`

	encodingInfo := mockEncodingInfo{
		IsHandle:   true,
		Identifier: "s.SomeHandle",
		IsNullable: true,
	}

	check(t, expected, "FieldEncodingTmpl", encodingInfo)
}

func TestEncodingStringFieldEncoding(t *testing.T) {
	expected := `if err := encoder.WritePointer(); err != nil {
	return err
}
if err := encoder.WriteString(s.FString); err != nil {
	return err
}`

	encodingInfo := mockEncodingInfo{
		IsSimple:      true,
		Identifier:    "s.FString",
		WriteFunction: "WriteString",
		IsPointer:     true,
	}

	check(t, expected, "FieldEncodingTmpl", encodingInfo)
}

func TestEncodingNullableStringFieldEncoding(t *testing.T) {
	expected := `if s.FString == nil {
	encoder.WriteNullPointer()
} else {
	if err := encoder.WritePointer(); err != nil {
		return err
	}
	if err := encoder.WriteString(s.FString); err != nil {
		return err
	}
}`

	encodingInfo := mockEncodingInfo{
		IsSimple:      true,
		Identifier:    "s.FString",
		WriteFunction: "WriteString",
		IsPointer:     true,
		IsNullable:    true,
	}

	check(t, expected, "FieldEncodingTmpl", encodingInfo)
}

func TestEncodingArrayOfArrayOfUint16(t *testing.T) {
	expected := `if err := encoder.WritePointer(); err != nil {
	return err
}
encoder.StartArray(uint32(len(s.ArrayOfArrayOfInt)), 64)
for _, elem0 := range s.ArrayOfArrayOfInt {
	if err := encoder.WritePointer(); err != nil {
		return err
	}
	encoder.StartArray(uint32(len(elem0)), 16)
	for _, elem1 := range elem0 {
		if err := encoder.WriteUint16(elem1); err != nil {
			return err
		}
	}
	if err := encoder.Finish(); err != nil {
		return err
	}
}
if err := encoder.Finish(); err != nil {
	return err
}`

	encodingInfo := mockEncodingInfo{
		IsPointer:  true,
		IsArray:    true,
		Identifier: "s.ArrayOfArrayOfInt",
		ElementEncodingInfo: &mockEncodingInfo{
			IsPointer:  true,
			IsArray:    true,
			BitSize:    64,
			Identifier: "elem0",
			ElementEncodingInfo: &mockEncodingInfo{
				IsSimple:      true,
				BitSize:       16,
				WriteFunction: "WriteUint16",
				Identifier:    "elem1",
			},
		},
	}

	check(t, expected, "FieldEncodingTmpl", encodingInfo)
}

func TestEncodingMapUint16ToInt32(t *testing.T) {
	expected := `if err := encoder.WritePointer(); err != nil {
	return err
}
encoder.StartMap()
{
	var keys0 []uint16
	var values0 []int32
	for key0 := range s.MapUint16ToInt32 {
		keys0 = append(keys0, key0)
	}
	if encoder.Deterministic() {
		bindings.SortMapKeys(&keys0)
	}
	for key0 := range keys0 {
		values0 = append(values0, s.MapUint16ToInt32[key0])
	}
	if err := encoder.WritePointer(); err != nil {
		return err
	}
	encoder.StartArray(uint32(len(keys0)), 16)
	for _, key0 := range keys0 {
		if err := encoder.WriteUint16(key0); err != nil {
			return err
		}
	}
	if err := encoder.Finish(); err != nil {
		return err
	}
	if err := encoder.WritePointer(); err != nil {
		return err
	}
	encoder.StartArray(uint32(len(values0)), 32)
	for _, value0 := range values0 {
		if err := encoder.WriteInt32(value0); err != nil {
			return err
		}
	}
	if err := encoder.Finish(); err != nil {
		return err
	}
}
if err := encoder.Finish(); err != nil {
	return err
}`

	encodingInfo := mockEncodingInfo{
		IsPointer:  true,
		IsMap:      true,
		Identifier: "s.MapUint16ToInt32",
		KeyEncodingInfo: &mockEncodingInfo{
			IsPointer:  true,
			IsArray:    true,
			BitSize:    64,
			Identifier: "keys0",
			GoType:     "[]uint16",
			ElementEncodingInfo: &mockEncodingInfo{
				IsSimple:      true,
				BitSize:       16,
				WriteFunction: "WriteUint16",
				Identifier:    "key0",
			},
		},
		ValueEncodingInfo: &mockEncodingInfo{
			IsPointer:  true,
			IsArray:    true,
			BitSize:    64,
			Identifier: "values0",
			GoType:     "[]int32",
			ElementEncodingInfo: &mockEncodingInfo{
				IsSimple:      true,
				BitSize:       32,
				WriteFunction: "WriteInt32",
				Identifier:    "value0",
			},
		},
	}

	check(t, expected, "FieldEncodingTmpl", encodingInfo)
}

func TestEncodingStructFieldEncoding(t *testing.T) {
	expected := `if err := encoder.WritePointer(); err != nil {
	return err
}
if err := s.FStruct.Encode(encoder); err != nil {
	return err
}`

	encodingInfo := mockEncodingInfo{
		IsPointer:  true,
		IsStruct:   true,
		Identifier: "s.FStruct",
	}

	check(t, expected, "FieldEncodingTmpl", encodingInfo)
}

func TestEncodingNullableStructFieldEncoding(t *testing.T) {
	expected := `if s.FNullableStruct == nil {
	encoder.WriteNullPointer()
} else {
	if err := encoder.WritePointer(); err != nil {
		return err
	}
	if err := s.FNullableStruct.Encode(encoder); err != nil {
		return err
	}
}`

	encodingInfo := mockEncodingInfo{
		IsPointer:  true,
		IsStruct:   true,
		IsNullable: true,
		Identifier: "s.FNullableStruct",
	}

	check(t, expected, "FieldEncodingTmpl", encodingInfo)
}
