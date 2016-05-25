// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/public/cpp/application/run_application.h"

#include <memory>

#include "base/at_exit.h"
#include "base/command_line.h"
#include "base/debug/stack_trace.h"
#include "base/message_loop/message_loop.h"
#include "base/threading/thread_local_storage.h"
#include "build/build_config.h"
#include "mojo/message_pump/message_pump_mojo.h"
#include "mojo/public/cpp/application/application_impl_base.h"
#include "mojo/public/cpp/system/message_pipe.h"

namespace mojo {

namespace {

base::ThreadLocalStorage::StaticSlot g_current_result_holder = TLS_INITIALIZER;

// We store a pointer to a |ResultHolder|, which just stores a |MojoResult|, in
// TLS so that |TerminateApplication()| can provide the result that
// |RunApplication()| will return. (The |ResultHolder| is just on
// |RunApplication()|'s stack.)
struct ResultHolder {
#if !defined(NDEBUG) || defined(DCHECK_ALWAYS_ON)
  bool is_set = false;
#endif
  // TODO(vtl): The default result should probably be |MOJO_RESULT_UNKNOWN|, but
  // |ApplicationRunnerChromium| always returned |MOJO_RESULT_OK|.
  MojoResult result = MOJO_RESULT_OK;
};

}  // namespace

MojoResult RunMainApplication(MojoHandle application_request_handle,
                              ApplicationImplBase* application_impl) {
  base::CommandLine::Init(0, nullptr);
  base::AtExitManager at_exit;

  g_current_result_holder.Initialize(nullptr);

#if !defined(NDEBUG) && !defined(OS_NACL)
  base::debug::EnableInProcessStackDumping();
#endif

  return RunApplication(application_request_handle, application_impl);
}

MojoResult RunApplication(MojoHandle application_request_handle,
                          ApplicationImplBase* application_impl) {
  DCHECK(!g_current_result_holder.Get());

  ResultHolder result_holder;
  g_current_result_holder.Set(&result_holder);

  std::unique_ptr<base::MessageLoop> loop;
  // TODO(vtl): Support other types of message loops. (That's why I'm leaving
  // |loop| as a unique_ptr.)
  loop.reset(new base::MessageLoop(common::MessagePumpMojo::Create()));
  application_impl->Bind(InterfaceRequest<Application>(
      MakeScopedHandle(MessagePipeHandle(application_request_handle))));
  loop->Run();

  g_current_result_holder.Set(nullptr);

  // TODO(vtl): We'd like to enable the following assertion, but we quit the
  // current message loop directly in various places.
  // DCHECK(result_holder.is_set);

  return result_holder.result;
}

void TerminateMainApplication(MojoResult result) {
  TerminateApplication(result);
}

void TerminateApplication(MojoResult result) {
  DCHECK(base::MessageLoop::current()->is_running());
  base::MessageLoop::current()->Quit();

  ResultHolder* result_holder =
      static_cast<ResultHolder*>(g_current_result_holder.Get());
  DCHECK(result_holder);
  DCHECK(!result_holder->is_set);
  result_holder->result = result;
#if !defined(NDEBUG) || defined(DCHECK_ALWAYS_ON)
  result_holder->is_set = true;
#endif
}

}  // namespace mojo
