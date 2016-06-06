// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package templates

import (
	"testing"
)

func TestDecodingStructVersions(t *testing.T) {
	expected := `var someStruct_Versions []bindings.DataHeader = []bindings.DataHeader{
	bindings.DataHeader{80, 0},
	bindings.DataHeader{100, 1},
	bindings.DataHeader{120, 2},
}`

	type structVersion struct {
		NumBytes uint32
		Version  uint32
	}

	s := struct {
		PrivateName string
		Versions    []structVersion
	}{
		PrivateName: "someStruct",
		Versions: []structVersion{
			{80, 0},
			{100, 1},
			{120, 2},
		},
	}

	check(t, expected, "StructVersions", s)
}

func TestDecodingSimpleFieldDecoding(t *testing.T) {
	expected := `value, err := decoder.ReadUint8()
if err != nil {
	return err
}
s.Fuint8 = value`

	encodingInfo := mockEncodingInfo{
		IsSimple:     true,
		Identifier:   "s.Fuint8",
		ReadFunction: "ReadUint8",
	}

	check(t, expected, "FieldDecodingTmpl", encodingInfo)
}

func TestDecodingHandleFieldDecoding(t *testing.T) {
	expected := `handle, err := decoder.ReadHandle()
if err != nil {
	return err
}
if handle.IsValid() {
	s.SomeHandle = handle
} else {
	return &bindings.ValidationError{bindings.UnexpectedInvalidHandle, "unexpected invalid handle"}
}`

	encodingInfo := mockEncodingInfo{
		IsHandle:     true,
		Identifier:   "s.SomeHandle",
		ReadFunction: "ReadHandle",
	}

	check(t, expected, "FieldDecodingTmpl", encodingInfo)
}

func TestDecodingNullableHandleFieldDecoding(t *testing.T) {
	expected := `handle, err := decoder.ReadHandle()
if err != nil {
	return err
}
if handle.IsValid() {
	s.SomeNullableHandle = &handle
} else {
	s.SomeNullableHandle = nil
}`

	encodingInfo := mockEncodingInfo{
		IsHandle:     true,
		Identifier:   "s.SomeNullableHandle",
		ReadFunction: "ReadHandle",
		IsNullable:   true,
	}

	check(t, expected, "FieldDecodingTmpl", encodingInfo)
}

func TestDecodingStringFieldDecoding(t *testing.T) {
	expected := `pointer, err := decoder.ReadPointer()
if err != nil {
	return err
}
if pointer == 0 {
	return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
} else {
	value, err := decoder.ReadString()
	if err != nil {
		return err
	}
	s.FString = value
}`

	encodingInfo := mockEncodingInfo{
		IsSimple:     true,
		Identifier:   "s.FString",
		ReadFunction: "ReadString",
		IsPointer:    true,
	}

	check(t, expected, "FieldDecodingTmpl", encodingInfo)
}

func TestDecodingNullableStringFieldDecoding(t *testing.T) {
	expected := `pointer, err := decoder.ReadPointer()
if err != nil {
	return err
}
if pointer == 0 {
	s.FString = nil
} else {
	value, err := decoder.ReadString()
	if err != nil {
		return err
	}
	s.FString = value
}`

	encodingInfo := mockEncodingInfo{
		IsSimple:     true,
		Identifier:   "s.FString",
		ReadFunction: "ReadString",
		IsPointer:    true,
		IsNullable:   true,
	}

	check(t, expected, "FieldDecodingTmpl", encodingInfo)
}

func TestDecodingStructFieldDecoding(t *testing.T) {
	expected := `pointer, err := decoder.ReadPointer()
if err != nil {
	return err
}
if pointer == 0 {
	return &bindings.ValidationError{bindings.UnexpectedNullPointer, "unexpected null pointer"}
} else {
	if err := s.FStruct.Decode(decoder); err != nil {
		return err
	}
}`

	encodingInfo := mockEncodingInfo{
		IsPointer:  true,
		IsStruct:   true,
		Identifier: "s.FStruct",
	}

	check(t, expected, "FieldDecodingTmpl", encodingInfo)
}

func TestDecodingNullableStructFieldDecoding(t *testing.T) {
	expected := `pointer, err := decoder.ReadPointer()
if err != nil {
	return err
}
if pointer == 0 {
	s.FStruct = nil
} else {
	s.FStruct = new(SomeStruct)
	if err := s.FStruct.Decode(decoder); err != nil {
		return err
	}
}`

	encodingInfo := mockEncodingInfo{
		IsNullable: true,
		IsPointer:  true,
		IsStruct:   true,
		Identifier: "s.FStruct",
		GoType:     "SomeStruct",
	}

	check(t, expected, "FieldDecodingTmpl", encodingInfo)
}
