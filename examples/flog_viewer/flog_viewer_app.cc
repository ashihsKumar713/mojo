// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <iostream>
#include <limits>

#include "base/bind.h"
#include "examples/flog_viewer/channel_handler.h"
#include "examples/flog_viewer/flog_viewer.h"
#include "mojo/environment/scoped_chromium_init.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_impl_base.h"
#include "mojo/public/cpp/application/run_application.h"

namespace mojo {
namespace flog {
namespace examples {

class FlogViewerApp : public ApplicationImplBase {
 public:
  FlogViewerApp() {}

  ~FlogViewerApp() override {}

  // ApplicationImplBase overrides.
  void OnInitialize() override {
    ProcessArgs(args());

    viewer_.Initialize(shell(), [this]() { Terminate(MOJO_RESULT_OK); });

    if (process_last_ || !process_last_label_.empty()) {
      viewer_.ProcessLastLog(process_last_label_);
    } else if (log_id_ == 0) {
      viewer_.ProcessLogs();
    } else {
      viewer_.ProcessLog(log_id_);
    }
  }

 private:
  // Processes arguments.
  void ProcessArgs(const std::vector<std::string>& args) {
    for (size_t i = 1; i < args.size(); ++i) {
      const std::string& arg = args[i];

      std::string string_value;
      uint32_t numeric_value;

      if (MatchOption(arg, "format", &string_value)) {
        viewer_.set_format(string_value);
      } else if (MatchOption(arg, "channel", &numeric_value)) {
        viewer_.set_channel(numeric_value);
      } else if (MatchOption(arg, "last", &string_value)) {
        process_last_label_ = string_value;
      } else if (MatchOption(arg, "last")) {
        process_last_ = true;
      } else if (MatchBareArg(arg, &numeric_value)) {
        log_id_ = numeric_value;
      } else {
        Usage();
      }
    }
  }

  void Usage() {
    std::cout << std::endl;
    std::cout << "mojo/devtools/common/mojo_run "
                 "\"https://core.mojoapps.io/flog_viewer.mojo <args>\""
              << std::endl;
    std::cout << "    <log id>                process specified log"
              << std::endl;
    std::cout
        << "    --last=<label>          process last log with specified label"
        << std::endl;
    std::cout << "    --last                  process last log with any label"
              << std::endl;
    std::cout << std::endl;
    std::cout << std::endl;
    std::cout << "    --format=<format>       terse (default), full, digest"
              << std::endl;
    std::cout << "    --channel=<channel id>  process only one channel"
              << std::endl;
    std::cout << "If no log is specified, a list of logs is printed"
              << std::endl;
    std::cout << std::endl;
    Terminate(MOJO_RESULT_OK);
  }

  bool MatchOption(const std::string& arg, const std::string& option) {
    return arg.compare(0, 2, "--") == 0 &&
           arg.compare(2, std::string::npos, option) == 0;
  }

  bool MatchOption(const std::string& arg,
                   const std::string& option,
                   std::string* string_out) {
    MOJO_DCHECK(string_out);

    if (arg.compare(0, 2, "--") != 0 ||
        arg.compare(2, option.size(), option) != 0 ||
        arg.compare(2 + option.size(), 1, "=") != 0) {
      return false;
    }

    *string_out = arg.substr(2 + option.size() + 1);

    return true;
  }

  bool MatchOption(const std::string& arg,
                   const std::string& option,
                   uint32_t* uint32_out) {
    MOJO_DCHECK(uint32_out);

    if (arg.compare(0, 2, "--") != 0 ||
        arg.compare(2, option.size(), option) != 0 ||
        arg.compare(2 + option.size(), 1, "=") != 0) {
      return false;
    }

    std::istringstream istream(arg.substr(2 + option.size() + 1));
    return static_cast<bool>(istream >> *uint32_out);
  }

  bool MatchBareArg(const std::string& arg, uint32_t* uint32_out) {
    MOJO_DCHECK(uint32_out);

    std::istringstream istream(arg);
    return static_cast<bool>(istream >> *uint32_out);
  }

  FlogViewer viewer_;
  uint32_t log_id_ = 0;
  bool process_last_ = false;
  std::string process_last_label_;
};

}  // namespace examples
}  // namespace flog
}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ScopedChromiumInit init;
  mojo::flog::examples::FlogViewerApp flog_viewer_app;
  return mojo::RunApplication(application_request, &flog_viewer_app);
}
