// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package templates

// These declarations go in the header file so that we can avoid some
// circular-dependencies. We call these "public" to say that other types can
// refer to them.
const GenerateTypeTableDeclarations = `
{{define "GenerateTypeTableDeclarations"}}
// Union type table declarations.
{{range $union := .PublicUnionNames -}}
extern struct MojomTypeDescriptorUnion {{$union}};
{{end -}}

// Struct type table declarations.
{{range $struct := .PublicStructNames -}}
extern struct MojomTypeDescriptorStruct {{$struct}};
{{end -}}
{{end}}
`

const GenerateTypeTableDefinitions = `
{{define "GenerateTypeTableDefinitions"}}
// Declarations for array type entries.
{{range $array := .Arrays -}}
static struct MojomTypeDescriptorArray {{$array.Name}};
{{end -}}

// Declarations for struct type tables.
{{range $struct := .Structs -}}
struct MojomTypeDescriptorStruct {{$struct.Name}};
{{end -}}

// Declarations for union type tables.
{{range $union := .Unions -}}
struct MojomTypeDescriptorUnion {{$union.Name}};
{{end -}}

// Array type entry definitions.
{{range $array := .Arrays -}}
static struct MojomTypeDescriptorArray {{$array.Name}} = {
  {{$array.ElemType}}, {{$array.ElemTable}},
  {{$array.NumElements}}, {{$array.Nullable}},
};
{{end -}}

// Struct type table definitions.
{{range $struct := .Structs -}}
struct MojomTypeDescriptorStructEntry {{$struct.Name}}_Entries[] = {
{{- range $entry := $struct.Entries}}
  {
    {{$entry.ElemType}}, {{$entry.ElemTable}},
    {{$entry.Offset}}, {{$entry.MinVersion}},
    {{$entry.Nullable}},
  },
{{end -}}
};
struct MojomTypeDescriptorStruct {{$struct.Name}} = {
  {{len $struct.Entries}}ul, {{$struct.Name}}_Entries, 
};
{{end -}}

// Union type table definitions.
{{range $union := .Unions -}}
struct MojomTypeDescriptorUnionEntry {{$union.Name}}_Entries[] = {
{{- range $entry := $union.Entries}}
  {
    {{$entry.ElemType}}, {{$entry.ElemTable}},
    {{$entry.Tag}}, {{$entry.Nullable}},
  },
{{end -}}
};
struct MojomTypeDescriptorUnion {{$union.Name}} = {
  {{len $union.Entries}}ul, {{$union.Name}}_Entries, 
};
{{end}}

{{end}}
`
