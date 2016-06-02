// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package templates

const structDeclTmplText = `
{{- define "StructDecl" -}}
{{$struct := . -}}
type {{$struct.Name}} struct {
{{- range $field := $struct.Fields}}
	{{$field.Name}} {{$field.Type}}
{{- end}}
}
{{- end -}}
`
