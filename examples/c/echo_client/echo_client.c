// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Here is an example of the echo client using C bindings. This example avoids
// making any dynamic allocations and uses the stack entirely by wildly
// reserving a stack buffer, and foregoing any size-computation and copying.
// Using it this way essentially requires the programmer to know the mojom
// encoding order and can be error-prone, but fast.

#include <assert.h>
#include <mojo/macros.h>
#include <mojo/result.h>
#include <stdio.h>
#include <string.h>

#include "examples/echo/echo.mojom-c.h"
#include "mojo/public/c/bindings/buffer.h"
#include "mojo/public/c/bindings/message.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/c/system/message_pipe.h"
#include "mojo/public/c/system/wait.h"
#include "mojo/public/interfaces/application/application.mojom-c.h"
#include "mojo/public/interfaces/application/application_connector.mojom-c.h"
#include "mojo/public/interfaces/application/shell.mojom-c.h"

// To avoid dynamic allocations, we reserve this much space as an upper-bound
// for allocating mojo messages on the stack. This space is meant to be consumed
// using a MojomBuffer.
#define MESSAGE_MAX_BYTES 256

// Creates a message pipe; sets |client| to one end of the pipe, and returns
// the other end.
MojoHandle make_message_pipe(MojoHandle* client) {
  MojoHandle server;
  MojoResult r = MojoCreateMessagePipe(NULL, client, &server);
  MOJO_ALLOW_UNUSED_LOCAL(r);
  assert(r == MOJO_RESULT_OK);
  return server;
}

// Given a client handle to mojo.Shell (|shell_h|), sends it a request to hook
// up to an ApplicationConnector. Returns the client-side handle of the
// ApplicationConnector.
MojoHandle create_application_connector(MojoHandle shell_h) {
  MojoHandle app_connector_h = MOJO_HANDLE_INVALID;
  struct {
    struct MojomMessage msg_header;
    struct mojo_Shell_CreateApplicationConnector_Request request;
  } msg = {
      .msg_header =
          {
              .header = {sizeof(struct MojomMessage), 0},
              .ordinal = mojo_Shell_CreateApplicationConnector__Ordinal,
              .flags = 0,
          },
      .request =
          {
              .header_ =
                  {sizeof(struct mojo_Shell_CreateApplicationConnector_Request),
                   0},
              .application_connector_request =
                  make_message_pipe(&app_connector_h),
          },
  };

  MojoHandle handles[1];
  struct MojomHandleBuffer h_buf = {handles, 1, 0};
  mojo_Shell_CreateApplicationConnector_Request_EncodePointersAndHandles(
      &msg.request, sizeof(msg.request), &h_buf);
  assert(h_buf.num_handles_used == 1);

  MojoResult write_res = MojoWriteMessage(shell_h, &msg, sizeof(msg), handles,
                                          1, MOJO_WRITE_MESSAGE_FLAG_NONE);
  MOJO_ALLOW_UNUSED_LOCAL(write_res);
  assert(write_res == MOJO_RESULT_OK);

  return app_connector_h;
}

// Connects to the application (given by |app_url| of length |app_url_len|
// chars) using an ApplicationConnector (given by |app_connector_h|).
// Returns the client-side handle of the application's ServiceProvider.
MojoHandle connect_to_application(MojoHandle app_connector_h,
                                  const char* app_url, size_t app_url_len) {
  MojoHandle services_h = MOJO_HANDLE_INVALID;
  char data[MESSAGE_MAX_BYTES] = {0};
  struct MojomBuffer buf = {data, sizeof(data), 0};

  // 1) Allocate & build the message header.
  struct MojomMessage* msg_header = (struct MojomMessage*)MojomBuffer_Allocate(
      &buf, sizeof(struct MojomMessage));
  assert(msg_header != NULL);
  *msg_header = (struct MojomMessage){
      .header = {sizeof(struct MojomMessage), 0},
      .ordinal = mojo_ApplicationConnector_ConnectToApplication__Ordinal,
      .flags = 0,
  };
  // 2) Allocate the request struct.
  struct mojo_ApplicationConnector_ConnectToApplication_Request* req =
      (struct mojo_ApplicationConnector_ConnectToApplication_Request*)
          MojomBuffer_Allocate(
              &buf,
              sizeof(struct
                     mojo_ApplicationConnector_ConnectToApplication_Request));
  assert(req != NULL);

  // 3) Allocate & build the application url.
  struct MojomStringHeader* mojom_app_url =
      (struct MojomStringHeader*)MojomArray_New(&buf, app_url_len, 1);
  assert(mojom_app_url != NULL);
  *mojom_app_url = (struct MojomStringHeader){
      .chars = {
          .num_bytes = sizeof(struct MojomStringHeader) + app_url_len,
          .num_elements = app_url_len,
      }};
  memcpy((char*)mojom_app_url + sizeof(struct MojomStringHeader), app_url,
         app_url_len);

  // Build the request struct.
  *req = (struct mojo_ApplicationConnector_ConnectToApplication_Request){
      .header_ =
          {sizeof(
               struct mojo_ApplicationConnector_ConnectToApplication_Request),
           0},
      .application_url = {.ptr = mojom_app_url},
      .services = make_message_pipe(&services_h),
  };

  // 4) Encode the request struct.
  MojoHandle handles[1] = {MOJO_HANDLE_INVALID};
  struct MojomHandleBuffer h_buf = {handles, 1, 0};
  mojo_ApplicationConnector_ConnectToApplication_Request_EncodePointersAndHandles(
      req, buf.num_bytes_used - msg_header->header.num_bytes, &h_buf);
  assert(h_buf.num_handles_used == 1);

  MojomValidationResult vresult =
      mojo_ApplicationConnector_ConnectToApplication_Request_Validate(
          req, buf.num_bytes_used - msg_header->header.num_bytes, 1);
  MOJO_ALLOW_UNUSED_LOCAL(vresult);
  assert(vresult == MOJOM_VALIDATION_ERROR_NONE);

  // 5) Write to message pipe.
  MojoResult r = MojoWriteMessage(app_connector_h, buf.buf, buf.num_bytes_used,
                                  handles, 1, MOJO_WRITE_MESSAGE_FLAG_NONE);
  MOJO_ALLOW_UNUSED_LOCAL(r);
  assert(r == MOJO_RESULT_OK);

  return services_h;
}

MojoHandle connect_to_service(MojoHandle service_provider_h,
                              const char* service_name,
                              size_t service_name_len) {
  MojoHandle service_h = MOJO_HANDLE_INVALID;
  char data[MESSAGE_MAX_BYTES] = {0};
  struct MojomBuffer buf = {data, sizeof(data), 0};

  // 1) Allocate & build the message header
  struct MojomMessage* msg_header = (struct MojomMessage*)MojomBuffer_Allocate(
      &buf, sizeof(struct MojomMessage));
  assert(msg_header != NULL);
  *msg_header = (struct MojomMessage){
      .header = {sizeof(struct MojomMessage), 0},
      .ordinal = mojo_ServiceProvider_ConnectToService__Ordinal,
      .flags = 0,
  };

  // 2) Allocate the request struct.
  struct mojo_ServiceProvider_ConnectToService_Request* req =
      (struct mojo_ServiceProvider_ConnectToService_Request*)
          MojomBuffer_Allocate(
              &buf,
              sizeof(struct mojo_ServiceProvider_ConnectToService_Request));
  assert(req != NULL);

  // 3) Allocate & build the application url.
  struct MojomStringHeader* mojom_service_name =
      (struct MojomStringHeader*)MojomArray_New(&buf, service_name_len, 1);
  assert(mojom_service_name != NULL);
  *mojom_service_name = (struct MojomStringHeader){
      .chars = {
          .num_bytes = sizeof(struct MojomStringHeader) + service_name_len,
          .num_elements = service_name_len,
      }};
  memcpy((char*)mojom_service_name + sizeof(struct MojomStringHeader),
         service_name, service_name_len);

  // Build the request struct.
  *req = (struct mojo_ServiceProvider_ConnectToService_Request){
      .header_ = {sizeof(struct mojo_ServiceProvider_ConnectToService_Request),
                  0},
      .interface_name = {mojom_service_name},
      .pipe = make_message_pipe(&service_h),
  };

  // 4) Encode the request struct.
  MojoHandle handles[1] = {MOJO_HANDLE_INVALID};
  struct MojomHandleBuffer h_buf = {handles, 1, 0};
  mojo_ServiceProvider_ConnectToService_Request_EncodePointersAndHandles(
      (struct mojo_ServiceProvider_ConnectToService_Request*)req,
      buf.num_bytes_used - msg_header->header.num_bytes, &h_buf);

  // 5) Write to message pipe.
  MojoResult r =
      MojoWriteMessage(service_provider_h, buf.buf, buf.num_bytes_used, handles,
                       1, MOJO_WRITE_MESSAGE_FLAG_NONE);
  MOJO_ALLOW_UNUSED_LOCAL(r);
  assert(r == MOJO_RESULT_OK);

  return service_h;
}

// This sends the Echo.EchoString message to the Echo service given by the
// |echo_service_h| client handle. It waits, receives the response and prints it
// to stdout.
void call_echo(MojoHandle echo_service_h, const char* echo_str,
               size_t echo_str_len) {
  char data[MESSAGE_MAX_BYTES] = {0};
  struct MojomBuffer buf = {data, sizeof(data), 0};

  // 1) Allocate & build the message header
  struct MojomMessageWithRequestId* msg_header =
      (struct MojomMessageWithRequestId*)MojomBuffer_Allocate(
          &buf, sizeof(struct MojomMessageWithRequestId));
  assert(msg_header != NULL);
  *msg_header = (struct MojomMessageWithRequestId){
      .header = {sizeof(struct MojomMessageWithRequestId), 1},
      .ordinal = mojo_examples_Echo_EchoString__Ordinal,
      .flags = MOJOM_MESSAGE_FLAGS_EXPECTS_RESPONSE,
      // This prevents us from sending more than echo request at a time.
      // To send more than 1 echo request at a time, have the request_id
      // assigned new IDs.
      .request_id = 13,
  };

  // 2) Allocate the request struct.
  struct mojo_examples_Echo_EchoString_Request* req =
      (struct mojo_examples_Echo_EchoString_Request*)MojomBuffer_Allocate(
          &buf, sizeof(struct mojo_examples_Echo_EchoString_Request));
  assert(req != NULL);

  // 3) Allocate & build the application url.
  struct MojomStringHeader* mojom_echo_str =
      (struct MojomStringHeader*)MojomArray_New(&buf, echo_str_len, 1);
  assert(mojom_echo_str != NULL);
  *mojom_echo_str = (struct MojomStringHeader){
      .chars = {
          .num_bytes = sizeof(struct MojomStringHeader) + echo_str_len,
          .num_elements = echo_str_len,
      }};
  memcpy((char*)mojom_echo_str + sizeof(struct MojomStringHeader), echo_str,
         echo_str_len);

  // Build the request struct.
  *req = (struct mojo_examples_Echo_EchoString_Request){
      .header_ = {sizeof(struct mojo_examples_Echo_EchoString_Request), 0},
      .value = {mojom_echo_str},
  };

  // 4) Encode the request struct.
  mojo_examples_Echo_EchoString_Request_EncodePointersAndHandles(
      (struct mojo_examples_Echo_EchoString_Request*)req,
      buf.num_bytes_used - msg_header->header.num_bytes, NULL);

  // 5) Send the echo request.
  MojoResult r = MojoWriteMessage(echo_service_h, buf.buf, buf.num_bytes_used,
                                  NULL, 0, MOJO_WRITE_MESSAGE_FLAG_NONE);
  MOJO_ALLOW_UNUSED_LOCAL(r);
  assert(r == MOJO_RESULT_OK);

  struct MojoHandleSignalsState handle_state = {};
  // We'll wait up to a second for the echo service to start up and receive our
  // message.
  r = MojoWait(echo_service_h,
               MOJO_HANDLE_SIGNAL_READABLE | MOJO_HANDLE_SIGNAL_PEER_CLOSED,
               1000 * 1000, &handle_state);
  assert(r == MOJO_RESULT_OK);

  if (handle_state.satisfied_signals & MOJO_HANDLE_SIGNAL_PEER_CLOSED)
    assert(false);

  // It must be that |echo_service_h| is readable.

  // 6) Now, read back the echo message.
  uint32_t data_numbytes = sizeof(data);
  r = MojoReadMessage(echo_service_h, data, &data_numbytes, NULL, NULL,
                      MOJO_READ_MESSAGE_FLAG_NONE);
  assert(r == MOJO_RESULT_OK);
  assert(data_numbytes <= sizeof(data));

  if (MojomMessage_ValidateHeader(data, data_numbytes) !=
          MOJOM_VALIDATION_ERROR_NONE ||
      MojomMessage_ValidateResponse(data) != MOJOM_VALIDATION_ERROR_NONE) {
    assert(false);
  }

  msg_header = (struct MojomMessageWithRequestId*)data;
  assert(msg_header->ordinal == mojo_examples_Echo_EchoString__Ordinal);

  struct mojo_examples_Echo_EchoString_Response* echo_response =
      (struct mojo_examples_Echo_EchoString_Response*)(data +
                                                       msg_header->header
                                                           .num_bytes);

  if (mojo_examples_Echo_EchoString_Response_Validate(
          echo_response, data_numbytes - msg_header->header.num_bytes, 0) !=
      MOJOM_VALIDATION_ERROR_NONE) {
    assert(false);
  }

  mojo_examples_Echo_EchoString_Response_DecodePointersAndHandles(
      echo_response, data_numbytes - msg_header->header.num_bytes, NULL, 0);

  mojom_echo_str = echo_response->value.ptr;
  char echo_response_str[MESSAGE_MAX_BYTES] = {0};
  assert(mojom_echo_str->chars.num_elements + 1 <= sizeof(echo_response_str));
  strncpy(echo_response_str,
          (char*)&mojom_echo_str->chars + sizeof(struct MojomStringHeader),
          mojom_echo_str->chars.num_elements);
  echo_response_str[mojom_echo_str->chars.num_elements] = '\0';
  printf("Echo response: %s\n", echo_response_str);
}

MojoResult MojoMain(MojoHandle application_request) {
  // 1) First, process the Application.Initialize message. This contains a
  // client-side handle to the Shell, which we can use to connect to other
  // applications.
  char data[MESSAGE_MAX_BYTES] = {0};
  uint32_t data_numbytes = sizeof(data);
  MojoHandle handles[1] = {MOJO_HANDLE_INVALID};
  uint32_t num_handles = 1;
  MojoResult r =
      MojoReadMessage(application_request, data, &data_numbytes, handles,
                      &num_handles, MOJO_READ_MESSAGE_FLAG_NONE);
  MOJO_ALLOW_UNUSED_LOCAL(r);
  assert(r == MOJO_RESULT_OK);
  assert(data_numbytes <= sizeof(data));

  if (MojomMessage_ValidateHeader(data, data_numbytes) !=
          MOJOM_VALIDATION_ERROR_NONE ||
      MojomMessage_ValidateRequestWithoutResponse(data) !=
          MOJOM_VALIDATION_ERROR_NONE) {
    assert(false);
  }

  struct MojomMessage* msg_header = (struct MojomMessage*)data;
  assert(msg_header->ordinal == mojo_Application_Initialize__Ordinal);

  struct mojo_Application_Initialize_Request* init_request =
      (struct mojo_Application_Initialize_Request*)(data +
                                                    msg_header->header
                                                        .num_bytes);
  mojo_Application_Initialize_Request_DecodePointersAndHandles(
      init_request, data_numbytes - msg_header->header.num_bytes, handles,
      num_handles);

  // 2) Use the shell interface to create an application connector (giving it
  // the service-side handle).
  MojoHandle app_conn_h =
      create_application_connector(init_request->shell.handle);

  // 3) Without waiting (this is an example of pipelining), ask the application
  // connector to connect to "echo_service", and give it the service-side handle
  // to a ServiceProvider.
  const char kEchoServiceUrl[] = "mojo:echo_server";
  MojoHandle echo_sp_h = connect_to_application(app_conn_h, kEchoServiceUrl,
                                                strlen(kEchoServiceUrl));

  // 4) Without waiting, ask the service provider for a particular interface
  // (using the ServiceName defined for the interface), and give it a handle
  // (this is again the service-side handle).
  MojoHandle echo_service_h =
      connect_to_service(echo_sp_h, mojo_examples_Echo__ServiceName,
                         strlen(mojo_examples_Echo__ServiceName));

  // 5) Call into the echo service.
  const char kEchoMsg[] = "Hello world!";
  call_echo(echo_service_h, kEchoMsg, strlen(kEchoMsg));

  return MOJO_RESULT_OK;
}
