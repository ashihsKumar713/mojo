// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package templates

const GenerateStruct = `
{{- /* . (dot) refers to the Go type |rustgen.StructTemplate| */ -}}
{{- define "GenerateStruct" -}}
{{- $struct := . -}}

// -- {{$struct.Name}} --

// Constants
{{range $const := $struct.Constants -}}
pub const {{$const.Name}}: {{$const.Type}} = {{$const.Value}};
{{end -}}

// Enums
{{range $enum := $struct.Enums -}}
{{template "GenerateEnum" $enum}}
{{end -}}

// Struct version information
{{$versions := len $struct.Versions -}}
const {{$struct.Name}}Versions: [(u32, u32); {{$versions}}] = [
{{range $version := $struct.Versions}}    ({{$version.Version}}, {{$version.Size}}),
{{end -}}
];

// Struct definition
pub struct {{$struct.Name}} {
{{range $field := $struct.Fields}}    pub {{$field.Name}}: {{$field.Type}},
{{end -}}
}

impl MojomPointer for {{$struct.Name}} {
    fn header_data(&self) -> DataHeaderValue { DataHeaderValue::Version({{$struct.Version}}) }
    fn serialized_size(&self, _context: &Context) -> usize { {{$struct.Size}} }
    fn encode_value(self, encoder: &mut Encoder, context: Context) {
{{range $field := $struct.Fields}}        MojomEncodable::encode(self.{{$field.Name}}, encoder, context.clone());
{{end}}
    }
    fn decode_value(decoder: &mut Decoder, context: Context) -> Self {
        // TODO(mknyszek): Validate bytes and version
        let (_bytes, version) = {
            let mut state = decoder.get_mut(&context);
            let bytes = state.decode::<u32>();
            let version = state.decode::<u32>();
            (bytes, version)
        };
{{range $field := $struct.Fields}}        let {{$field.Name}} = {{if ne $field.MinVersion 0 -}}
	if version >= {{$field.MinVersion}} {
            <{{$field.Type}}>::decode(decoder, context.clone())
        } else {
            Default::default()
        };
	{{- else -}}
	<{{$field.Type}}>::decode(decoder, context.clone());
	{{- end}}
{{end}}        {{$struct.Name}} {
{{range $field := $struct.Fields}}            {{$field.Name}}: {{$field.Name}},
{{end}}        }
    }
}

impl MojomEncodable for {{$struct.Name}} {
    impl_encodable_for_pointer!();
    fn compute_size(&self, context: Context) -> usize {
        encoding::align_default(self.serialized_size(&context))
{{range $field := $struct.Fields}}        + self.{{$field.Name}}.compute_size(context.clone())
{{end}}    }
}

impl MojomStruct for {{$struct.Name}} {}
{{- end}}
`
