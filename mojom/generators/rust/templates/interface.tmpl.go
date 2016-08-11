// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package templates

const GenerateEndpoint = `
{{- /* . (dot) refers to a string which is the endpoint's name */ -}}
{{- define "GenerateEndpoint" -}}
{{- $endpoint := . -}}

pub struct {{$endpoint}} {
    pipe: message_pipe::MessageEndpoint,
}

impl {{$endpoint}} {
    pub fn new(pipe: message_pipe::MessageEndpoint) -> {{$endpoint}} {
        {{$endpoint}} { pipe: pipe }
    }
}

impl CastHandle for {{$endpoint}} {
    unsafe fn from_untyped(handle: system::UntypedHandle) -> {{$endpoint}} {
        {{$endpoint}} {
            pipe: message_pipe::MessageEndpoint::from_untyped(handle),
        }
    }
    fn as_untyped(self) -> system::UntypedHandle {
        self.pipe.as_untyped()
    }
}

impl MojomEncodable for {{$endpoint}} {
    impl_encodable_for_interface!();
}

{{- end -}}
`

const GenerateInterface = `
{{- /* . (dot) refers to the Go type |rustgen.InterfaceTemplate| */ -}}
{{- define "GenerateInterface" -}}
{{- $interface := . -}}
// --- {{$interface.Name}} ---

pub mod {{$interface.Name}} {
    pub const SERVICE_NAME: &'static str = "{{$interface.ServiceName}}";
    pub const VERSION: u32 = {{$interface.Version}};
}

{{- $client := printf "%s%s" $interface.Name "Client" -}}
{{template "GenerateEndpoint" $client}}

impl MojomInterface for {{$client}} {
    fn service_name() -> &'static str { {{$interface.Name}}::SERVICE_NAME }
    fn version() -> u32 { {{$interface.Name}}::VERSION }
    fn pipe(&self) -> &message_pipe::MessageEndpoint { &self.pipe }
    fn unwrap(self) -> message_pipe::MessageEndpoint { self.pipe }
}

impl<R: {{$interface.Name}}Request> MojomInterfaceSend<R> for {{$client}} {}

{{- $server := printf "%s%s" $interface.Name "Server" -}}
{{template "GenerateEndpoint" $server}}

impl MojomInterface for {{$server}} {
    fn service_name() -> &'static str { {{$interface.Name}}::SERVICE_NAME }
    fn version() -> u32 { {{$interface.Name}}::VERSION }
    fn pipe(&self) -> &message_pipe::MessageEndpoint { &self.pipe }
    fn unwrap(self) -> message_pipe::MessageEndpoint { self.pipe }
}

impl<R: {{$interface.Name}}Response> MojomInterfaceSend<R> for {{$server}} {}

// Enums
{{range $enum := $interface.Enums -}}
{{template "GenerateEnum" $enum}}
{{end}}

// Constants
{{range $const := $interface.Constants -}}
pub const {{$const.Name}}: {{$const.Type}} = {{$const.Value}};
{{end}}

pub trait {{$interface.Name}}Request: MojomMessage {}
pub trait {{$interface.Name}}Response: MojomMessage {}

{{range $message := $interface.Messages -}}
/// Message: {{$message.Name}}
pub mod {{$message.Name}} {
    pub const ORDINAL: u32 = {{$message.MessageOrdinal}};
    pub const MIN_VERSION: u32 = {{$message.MinVersion}};
}
{{template "GenerateStruct" $message.RequestStruct}}
impl MojomMessage for {{$message.RequestStruct.Name}} {
    fn create_header() -> MessageHeader {
        MessageHeader::new({{$interface.Name}}::VERSION,
	                   {{$message.Name}}::ORDINAL,
{{- if eq $message.ResponseStruct.Name "" -}}
                           message::MESSAGE_HEADER_NO_FLAG)
{{else}}
                           message::MESSAGE_HEADER_EXPECT_RESPONSE)
{{end}}
    }
}
impl {{$interface.Name}}Request for {{$message.RequestStruct.Name}} {}

{{if ne $message.ResponseStruct.Name "" -}}
{{template "GenerateStruct" $message.ResponseStruct}}

impl MojomMessage for {{$message.ResponseStruct.Name}} {
    fn create_header() -> MessageHeader {
        MessageHeader::new({{$interface.Name}}::VERSION,
	                   {{$message.Name}}::ORDINAL,
			   message::MESSAGE_HEADER_IS_RESPONSE)
    }
}
impl {{$interface.Name}}Response for {{$message.RequestStruct.Name}} {}

{{- end}}
{{- end -}}
{{- end -}}
`
