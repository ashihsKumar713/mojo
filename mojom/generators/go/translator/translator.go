// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package translator

import (
	"fmt"
	"log"
	"sort"

	"mojom/generated/mojom_files"
	"mojom/generated/mojom_types"
	"mojom/generators/common"
)

type Translator interface {
	TranslateMojomFile(fileName string) *TmplFile
}

type translator struct {
	fileGraph *mojom_files.MojomFileGraph
	// goTypeCache maps type keys to go type strings.
	goTypeCache     map[string]string
	imports         map[string]string
	currentFileName string
	Config          common.GeneratorConfig
}

func NewTranslator(fileGraph *mojom_files.MojomFileGraph) (t *translator) {
	t = new(translator)
	t.fileGraph = fileGraph
	t.goTypeCache = map[string]string{}
	return t
}

func (t *translator) TranslateMojomFile(fileName string) (tmplFile *TmplFile) {
	t.currentFileName = fileName
	t.imports = map[string]string{}

	tmplFile = new(TmplFile)
	file := t.fileGraph.Files[fileName]

	tmplFile.PackageName = fileNameToPackageName(fileName)

	if file.DeclaredMojomObjects.Structs == nil {
		file.DeclaredMojomObjects.Structs = &[]string{}
	}
	tmplFile.Structs = make([]*StructTemplate, len(*file.DeclaredMojomObjects.Structs))
	for i, typeKey := range *file.DeclaredMojomObjects.Structs {
		tmplFile.Structs[i] = t.translateMojomStruct(typeKey)
	}

	if file.DeclaredMojomObjects.Unions == nil {
		file.DeclaredMojomObjects.Unions = &[]string{}
	}
	tmplFile.Unions = make([]*UnionTemplate, len(*file.DeclaredMojomObjects.Unions))
	for i, typeKey := range *file.DeclaredMojomObjects.Unions {
		tmplFile.Unions[i] = t.translateMojomUnion(typeKey)
	}

	if file.DeclaredMojomObjects.TopLevelEnums == nil {
		file.DeclaredMojomObjects.TopLevelEnums = &[]string{}
	}
	if file.DeclaredMojomObjects.EmbeddedEnums == nil {
		file.DeclaredMojomObjects.EmbeddedEnums = &[]string{}
	}
	topLevelEnumsNum := len(*file.DeclaredMojomObjects.TopLevelEnums)
	embeddedEnumsNum := len(*file.DeclaredMojomObjects.EmbeddedEnums)
	enumNum := embeddedEnumsNum + topLevelEnumsNum
	tmplFile.Enums = make([]*EnumTemplate, enumNum)
	for i, typeKey := range *file.DeclaredMojomObjects.TopLevelEnums {
		tmplFile.Enums[i] = t.translateMojomEnum(typeKey)
	}
	for i, typeKey := range *file.DeclaredMojomObjects.EmbeddedEnums {
		tmplFile.Enums[i+topLevelEnumsNum] = t.translateMojomEnum(typeKey)
	}

	if file.DeclaredMojomObjects.Interfaces == nil {
		file.DeclaredMojomObjects.Interfaces = &[]string{}
	}
	tmplFile.Interfaces = make([]*InterfaceTemplate, len(*file.DeclaredMojomObjects.Interfaces))
	for i, typeKey := range *file.DeclaredMojomObjects.Interfaces {
		tmplFile.Interfaces[i] = t.translateMojomInterface(typeKey)
	}

	tmplFile.Imports = []Import{
		Import{PackagePath: "mojo/public/go/bindings", PackageName: "bindings"},
		Import{PackagePath: "fmt", PackageName: "fmt"},
		Import{PackagePath: "sort", PackageName: "sort"},
	}

	for pkgName, pkgPath := range t.imports {
		tmplFile.Imports = append(
			tmplFile.Imports,
			Import{PackagePath: pkgPath, PackageName: pkgName},
		)
	}
	return tmplFile
}

func (t *translator) GetUserDefinedType(typeKey string) (mojomType mojom_types.UserDefinedType) {
	return t.fileGraph.ResolvedTypes[typeKey]
}

func (t *translator) translateMojomStruct(typeKey string) (m *StructTemplate) {
	m = new(StructTemplate)
	u := t.GetUserDefinedType(typeKey)
	mojomStruct, ok := u.Interface().(mojom_types.MojomStruct)
	if !ok {
		log.Panicf("%s is not a struct.", userDefinedTypeShortName(u))
	}
	m = t.translateMojomStructObject(mojomStruct)
	m.Name = t.goTypeName(typeKey)
	m.PrivateName = privateName(m.Name)

	return m
}

func (t *translator) translateMojomStructObject(mojomStruct mojom_types.MojomStruct) (m *StructTemplate) {
	m = new(StructTemplate)
	if mojomStruct.VersionInfo == nil || len(*mojomStruct.VersionInfo) == 0 {
		log.Fatalln(m.Name, "does not have any version_info!")
	}
	curVersion := (*mojomStruct.VersionInfo)[len(*mojomStruct.VersionInfo)-1]
	m.CurVersionSize = curVersion.NumBytes
	m.CurVersionNumber = curVersion.VersionNumber

	sorter := structFieldSerializationSorter(mojomStruct.Fields)
	sort.Sort(sorter)
	for _, field := range sorter {
		m.Fields = append(m.Fields, t.translateStructField(&field))
	}

	for _, version := range *mojomStruct.VersionInfo {
		m.Versions = append(m.Versions, structVersion{
			NumBytes: version.NumBytes,
			Version:  version.VersionNumber,
		})
	}
	return m
}

func (t *translator) translateStructField(mojomField *mojom_types.StructField) (field StructFieldTemplate) {
	field.Name = formatName(*mojomField.DeclData.ShortName)
	field.Type = t.translateType(mojomField.Type)
	field.MinVersion = mojomField.MinVersion
	field.EncodingInfo = t.encodingInfo(mojomField.Type)
	field.EncodingInfo.setIdentifier("s." + field.Name)
	return
}

func (t *translator) translateMojomUnion(typeKey string) (m *UnionTemplate) {
	m = new(UnionTemplate)
	u := t.GetUserDefinedType(typeKey)
	union, ok := u.Interface().(mojom_types.MojomUnion)
	if !ok {
		log.Panicf("%s is not a union.\n", userDefinedTypeShortName(u))
	}
	m.Name = t.goTypeName(typeKey)

	for _, field := range union.Fields {
		m.Fields = append(m.Fields, t.translateUnionField(&field))
		m.Fields[len(m.Fields)-1].Union = m
	}

	return m
}

func (t *translator) translateUnionField(mojomField *mojom_types.UnionField) (field UnionFieldTemplate) {
	field.Name = formatName(*mojomField.DeclData.ShortName)
	field.Type = t.translateType(mojomField.Type)
	field.Tag = mojomField.Tag
	field.EncodingInfo = t.encodingInfo(mojomField.Type)
	field.EncodingInfo.setIdentifier("u.Value")
	if info, ok := field.EncodingInfo.(*unionTypeEncodingInfo); ok {
		info.nestedUnion = true
	}
	return field
}

func (t *translator) translateMojomEnum(typeKey string) (m *EnumTemplate) {
	m = new(EnumTemplate)
	e := t.GetUserDefinedType(typeKey)
	enum, ok := e.Interface().(mojom_types.MojomEnum)
	if !ok {
		log.Panicf("%s is not an enum.\n", userDefinedTypeShortName(e))
	}

	m.Name = t.goTypeName(typeKey)

	for _, mojomValue := range enum.Values {
		name := fmt.Sprintf("%s_%s", m.Name, formatName(*mojomValue.DeclData.ShortName))
		m.Values = append(m.Values,
			EnumValueTemplate{Name: name, Value: mojomValue.IntValue})
	}
	return m
}

func (t *translator) translateMojomInterface(typeKey string) (m *InterfaceTemplate) {
	m = new(InterfaceTemplate)
	i := t.GetUserDefinedType(typeKey)
	mojomInterface, ok := i.Interface().(mojom_types.MojomInterface)
	if !ok {
		log.Panicf("%s is not an interface.", userDefinedTypeShortName(i))
	}

	m.Name = t.goTypeName(typeKey)
	m.PrivateName = privateName(m.Name)
	m.ServiceName = mojomInterface.ServiceName

	for _, mojomMethod := range mojomInterface.Methods {
		m.Methods = append(m.Methods, *t.translateMojomMethod(mojomMethod, m))
	}

	return m
}

func (t *translator) translateMojomMethod(mojomMethod mojom_types.MojomMethod, interfaceTemplate *InterfaceTemplate) (m *MethodTemplate) {
	m = new(MethodTemplate)
	m.Interface = interfaceTemplate
	m.MethodName = formatName(*mojomMethod.DeclData.ShortName)
	m.FullName = fmt.Sprintf("%s_%s", interfaceTemplate.PrivateName, m.MethodName)
	m.Params = *t.translateMojomStructObject(mojomMethod.Parameters)
	m.Params.Name = fmt.Sprintf("%s_Params", m.FullName)
	m.Params.PrivateName = privateName(m.Params.Name)
	if mojomMethod.ResponseParams != nil {
		m.ResponseParams = t.translateMojomStructObject(*mojomMethod.ResponseParams)
		m.ResponseParams.Name = fmt.Sprintf("%s_ResponseParams", m.FullName)
		m.ResponseParams.PrivateName = privateName(m.ResponseParams.Name)
	}
	return m
}

////////////////////////////////////////////////////////////////////////////////

// Implements sort.Interface.
type structFieldSerializationSorter []mojom_types.StructField

func (s structFieldSerializationSorter) Len() int {
	return len(s)
}

func (s structFieldSerializationSorter) Less(i, j int) bool {
	if s[i].Offset < s[j].Offset {
		return true
	}

	if s[i].Offset == s[j].Offset && s[i].Bit < s[j].Bit {
		return true
	}

	return false
}

func (s structFieldSerializationSorter) Swap(i, j int) {
	s[i], s[j] = s[j], s[i]
}
