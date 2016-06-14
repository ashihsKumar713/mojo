// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package templates

const GenerateTypeTableDeclarations = `
{{define "GenerateTypeTableDeclarations"}}
{{range $union := .PublicUnionNames -}}
extern struct MojomPointerTableUnionEntry {{$union}}[];
{{end}}

{{range $struct := .PublicStructNames -}}
extern struct MojomPointerTableStructEntry {{$struct}}[];
{{end -}}
{{end}}
`

const GenerateTypeTableDefinitions = `
{{define "GenerateTypeTableDefinitions"}}
{{range $array := .Arrays -}}
static struct MojomPointerTableArrayEntry {{$array.Name}} = {
  {{$array.ElemTable}}, {{$array.NumElements}}, {{$array.Nullable}},
  {{$array.ElemType}},
};
{{end -}}

{{range $union := .Unions -}}
struct MojomPointerTableUnionEntry {{$union.Name}}[] = {
{{- range $entry := $union.Entries}}
  {
    {{$entry.ElemTable}}, {{$entry.Tag}},
    {{$entry.Nullable}}, {{$entry.ElemType}}, {{$entry.KeepGoing}},
  },
{{end -}}
};
{{end}}

{{range $struct := .Structs -}}
struct MojomPointerTableStructEntry {{$struct.Name}}[] = {
{{- range $entry := $struct.Entries}}
  {
    {{$entry.ElemTable}}, {{$entry.Offset}},
    {{$entry.Nullable}}, {{$entry.ElemType}}, {{$entry.KeepGoing}},
  },
{{end -}}
};
{{end -}}

{{end}}
`
