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
)

type Translator interface {
	TranslateMojomFile(fileName string) *TmplFile
}

type translator struct {
	fileGraph *mojom_files.MojomFileGraph
	// goTypeCache maps type keys to go type strings.
	goTypeCache map[string]string
}

func NewTranslator(fileGraph *mojom_files.MojomFileGraph) (t *translator) {
	t = new(translator)
	t.fileGraph = fileGraph
	t.goTypeCache = map[string]string{}
	return t
}

func (t *translator) TranslateMojomFile(fileName string) (tmplFile *TmplFile) {
	tmplFile = new(TmplFile)
	file := t.fileGraph.Files[fileName]

	tmplFile.PackageName = fileNameToPackageName(fileName)

	tmplFile.Structs = make([]*StructTemplate, len(*file.DeclaredMojomObjects.Structs))
	for i, typeKey := range *file.DeclaredMojomObjects.Structs {
		tmplFile.Structs[i] = t.translateMojomStruct(typeKey)
	}

	tmplFile.Unions = make([]*UnionTemplate, len(*file.DeclaredMojomObjects.Unions))
	for i, typeKey := range *file.DeclaredMojomObjects.Unions {
		tmplFile.Unions[i] = t.translateMojomUnion(typeKey)
	}

	tmplFile.Imports = []Import{
		Import{PackagePath: "mojo/public/go/bindings", PackageName: "bindings"},
		Import{PackagePath: "fmt", PackageName: "fmt"},
		Import{PackagePath: "sort", PackageName: "sort"},
	}
	return tmplFile
}

func (t *translator) GetUserDefinedType(typeKey string) (mojomType mojom_types.UserDefinedType) {
	return t.fileGraph.ResolvedTypes[typeKey]
}

func (t *translator) translateMojomStruct(typeKey string) (m *StructTemplate) {
	m = new(StructTemplate)
	u := t.GetUserDefinedType(typeKey)
	s, ok := u.Interface().(mojom_types.MojomStruct)
	if !ok {
		log.Panicf("%s is not a struct.", userDefinedTypeShortName(u))
	}
	m.Name = t.goTypeName(typeKey)
	m.PrivateName = privateName(m.Name)
	if s.VersionInfo == nil || len(*s.VersionInfo) == 0 {
		log.Fatalln(m.Name, "does not have any version_info!")
	}
	curVersion := (*s.VersionInfo)[len(*s.VersionInfo)-1]
	m.CurVersionSize = curVersion.NumBytes
	m.CurVersionNumber = curVersion.VersionNumber

	sorter := structFieldSerializationSorter(s.Fields)
	sort.Sort(sorter)
	for _, field := range sorter {
		m.Fields = append(m.Fields, t.translateStructField(&field))
	}

	for _, version := range *s.VersionInfo {
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
	return field
}

func (t *translator) encodingInfo(mojomType mojom_types.Type) EncodingInfo {
	return t.encodingInfoNested(mojomType, 0)
}

func (t *translator) encodingInfoNested(mojomType mojom_types.Type, level int) (info EncodingInfo) {
	switch m := mojomType.(type) {
	default:
		panic("This should never happen.")
	case *mojom_types.TypeSimpleType:
		info = t.simpleTypeEncodingInfo(m.Value)
	case *mojom_types.TypeStringType:
		info = t.stringTypeEncodingInfo(m.Value)
	case *mojom_types.TypeHandleType:
		info = t.handleTypeEncodingInfo(m.Value)
	case *mojom_types.TypeArrayType:
		info = t.arrayTypeEncodingInfo(m.Value, level)
	case *mojom_types.TypeMapType:
		info = t.mapTypeEncodingInfo(m.Value, level)
	case *mojom_types.TypeTypeReference:
		info = t.typeRefEncodingInfo(m.Value)
	}
	info.setGoType(t.translateType(mojomType))
	return info
}

func (t *translator) simpleTypeEncodingInfo(mojomType mojom_types.SimpleType) (info *simpleTypeEncodingInfo) {
	info = new(simpleTypeEncodingInfo)
	var typeSuffix string
	var bitSize uint32
	switch mojomType {
	default:
		panic("Not a valid SimpleType.")
	case mojom_types.SimpleType_Bool:
		typeSuffix = "Bool"
		bitSize = 1
	case mojom_types.SimpleType_Double:
		typeSuffix = "Double"
		bitSize = 64
	case mojom_types.SimpleType_Float:
		typeSuffix = "Float"
		bitSize = 32
	case mojom_types.SimpleType_Int8:
		typeSuffix = "Int8"
		bitSize = 8
	case mojom_types.SimpleType_Int16:
		typeSuffix = "Int16"
		bitSize = 16
	case mojom_types.SimpleType_Int32:
		typeSuffix = "Int32"
		bitSize = 32
	case mojom_types.SimpleType_Int64:
		typeSuffix = "Int64"
		bitSize = 64
	case mojom_types.SimpleType_Uint8:
		typeSuffix = "Uint8"
		bitSize = 8
	case mojom_types.SimpleType_Uint16:
		typeSuffix = "Uint16"
		bitSize = 16
	case mojom_types.SimpleType_Uint32:
		typeSuffix = "Uint32"
		bitSize = 32
	case mojom_types.SimpleType_Uint64:
		typeSuffix = "Uint64"
		bitSize = 64
	}
	info.writeFunction = "Write" + typeSuffix
	info.readFunction = "Read" + typeSuffix
	info.bitSize = bitSize
	return info
}

func (t *translator) stringTypeEncodingInfo(mojomType mojom_types.StringType) (info *stringTypeEncodingInfo) {
	info = new(stringTypeEncodingInfo)
	info.nullable = mojomType.Nullable
	return info
}

func (t *translator) handleTypeEncodingInfo(mojomType mojom_types.HandleType) (info *handleTypeEncodingInfo) {
	info = new(handleTypeEncodingInfo)
	info.nullable = mojomType.Nullable
	switch mojomType.Kind {
	case mojom_types.HandleType_Kind_Unspecified:
		info.readFunction = "ReadHandle"
	case mojom_types.HandleType_Kind_MessagePipe:
		info.readFunction = "ReadMessagePipeHandle"
	case mojom_types.HandleType_Kind_DataPipeConsumer:
		info.readFunction = "ReadConsumerHandle"
	case mojom_types.HandleType_Kind_DataPipeProducer:
		info.readFunction = "ReadProducerHandle"
	case mojom_types.HandleType_Kind_SharedBuffer:
		info.readFunction = "ReadSharedBufferHandle"
	}
	return info
}

func (t *translator) arrayTypeEncodingInfo(mojomType mojom_types.ArrayType, level int) (info *arrayTypeEncodingInfo) {
	info = new(arrayTypeEncodingInfo)
	info.nullable = mojomType.Nullable
	info.elementEncodingInfo = t.encodingInfoNested(mojomType.ElementType, level+1)
	info.elementEncodingInfo.setIdentifier(fmt.Sprintf("elem%v", level))
	return info
}

func (t *translator) mapTypeEncodingInfo(mojomType mojom_types.MapType, level int) (info *mapTypeEncodingInfo) {
	info = new(mapTypeEncodingInfo)
	info.nullable = mojomType.Nullable

	keyEncodingInfo := new(arrayTypeEncodingInfo)
	info.keyEncodingInfo = keyEncodingInfo
	keyEncodingInfo.elementEncodingInfo = t.encodingInfoNested(mojomType.KeyType, level+1)
	keyEncodingInfo.setIdentifier(fmt.Sprintf("keys%v", level))
	keyEncodingInfo.setGoType(fmt.Sprintf("[]%v", keyEncodingInfo.elementEncodingInfo.GoType()))
	keyEncodingInfo.elementEncodingInfo.setIdentifier(fmt.Sprintf("key%v", level))

	valueEncodingInfo := new(arrayTypeEncodingInfo)
	info.valueEncodingInfo = valueEncodingInfo
	valueEncodingInfo.elementEncodingInfo = t.encodingInfoNested(mojomType.ValueType, level+1)
	valueEncodingInfo.setIdentifier(fmt.Sprintf("values%v", level))
	valueEncodingInfo.setGoType(fmt.Sprintf("[]%v", valueEncodingInfo.elementEncodingInfo.GoType()))
	valueEncodingInfo.elementEncodingInfo.setIdentifier(fmt.Sprintf("value%v", level))

	return info
}

func (t *translator) typeRefEncodingInfo(typeRef mojom_types.TypeReference) (info EncodingInfo) {
	mojomType := t.GetUserDefinedType(*typeRef.TypeKey)
	switch m := mojomType.(type) {
	case *mojom_types.UserDefinedTypeStructType:
		info = t.structTypeEncodingInfo(m.Value)
	}
	info.setNullable(typeRef.Nullable)
	return info
}

func (t *translator) structTypeEncodingInfo(mojomType mojom_types.MojomStruct) (info *structTypeEncodingInfo) {
	info = new(structTypeEncodingInfo)
	return info
}

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
