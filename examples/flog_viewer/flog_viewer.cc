// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <chrono>
#include <iomanip>
#include <iostream>

#include "base/bind.h"
#include "mojo/environment/scoped_chromium_init.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_impl_base.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/public/cpp/application/run_application.h"
#include "mojo/services/flog/interfaces/flog.mojom.h"

namespace mojo {
namespace flog {
namespace examples {

struct AsNiceDateTime {
  explicit AsNiceDateTime(uint64_t time_us) : time_us_(time_us) {}
  uint64_t time_us_;
};

std::ostream& operator<<(std::ostream& os, AsNiceDateTime value) {
  std::time_t time = std::chrono::system_clock::to_time_t(
      std::chrono::time_point<std::chrono::system_clock>(
          std::chrono::microseconds(value.time_us_)));
  std::tm* tm = localtime(&time);
  return os << std::setw(4) << tm->tm_year + 1900 << "/" << std::setw(2)
            << std::setfill('0') << tm->tm_mon + 1 << "/" << std::setw(2)
            << tm->tm_mday << " " << std::setw(2) << tm->tm_hour << ":"
            << std::setw(2) << tm->tm_min << ":" << std::setw(2) << tm->tm_sec;
}

struct AsMicroseconds {
  explicit AsMicroseconds(uint64_t time_us) : time_us_(time_us) {}
  uint64_t time_us_;
};

std::ostream& operator<<(std::ostream& os, AsMicroseconds value) {
  return os << std::setfill('0') << std::setw(6) << value.time_us_ % 1000000ull;
}

struct AsLogLevel {
  explicit AsLogLevel(uint32_t level) : level_(level) {}
  uint32_t level_;
};

std::ostream& operator<<(std::ostream& os, AsLogLevel value) {
  switch (value.level_) {
    case MOJO_LOG_LEVEL_VERBOSE:
      return os << "VERBOSE";
    case MOJO_LOG_LEVEL_INFO:
      return os << "INFO";
    case MOJO_LOG_LEVEL_WARNING:
      return os << "WARNING";
    case MOJO_LOG_LEVEL_ERROR:
      return os << "ERROR";
    case MOJO_LOG_LEVEL_FATAL:
      return os << "FATAL";
    default:
      return os << "UNKNOWN LEVEL " << value.level_;
  }
}

class FlogViewerApp : public mojo::ApplicationImplBase {
 public:
  FlogViewerApp() {}

  ~FlogViewerApp() override {}

  // ApplicationImplBase overrides.
  void OnInitialize() override {
    ProcessArgs(args());

    if (show_last_) {
      ShowLastLog();
    } else if (log_id_ == 0) {
      ShowLogs();
    } else {
      ShowLog(log_id_);
    }
  }

 private:
  // Processes arguments.
  void ProcessArgs(const std::vector<std::string>& args) {
    for (size_t i = 1; i < args.size(); ++i) {
      const std::string& arg = args[i];

      if (arg == "--last") {
        show_last_ = true;
        continue;
      }

      uint32_t id;
      std::istringstream istream(arg);
      if (!(istream >> id) || id == 0) {
        Usage();
      }
      log_id_ = id;
    }
  }

  void Usage() {
    std::cout << std::endl;
    std::cout << "mojo/devtools/common/mojo_run "
                 "\"https://core.mojoapps.io/flog_viewer.mojo [ id ]\""
              << std::endl;
    std::cout << std::endl;
    Terminate(MOJO_RESULT_OK);
  }

  void EnsureService() {
    if (!service_) {
      ConnectToService(shell(), "mojo:flog", GetProxy(&service_));
    }
  }

  // Shows log descriptions.
  void ShowLogs() {
    EnsureService();

    service_->GetLogDescriptions(
        [this](Array<FlogDescriptionPtr> descriptions) {
          std::cout << std::endl;
          std::cout << "     id  label" << std::endl;
          std::cout << "-------- ---------------------------------------------"
                    << std::endl;

          for (const FlogDescriptionPtr& description : descriptions) {
            std::cout << std::setw(8) << description->log_id << " "
                      << description->label << std::endl;
          }

          std::cout << std::endl;

          Terminate(MOJO_RESULT_OK);
        });
  }

  // Shows entries from a log.
  void ShowLog(uint32_t log_id) {
    MOJO_DCHECK(log_id != 0);

    EnsureService();

    service_->CreateReader(GetProxy(&reader_), log_id);

    std::cout << std::endl;
    ShowEntries(0);
  }

  // Show the log with the highest id.
  void ShowLastLog() {
    EnsureService();

    service_->GetLogDescriptions(
        [this](Array<FlogDescriptionPtr> descriptions) {
          uint32_t last_id = 0;

          for (const FlogDescriptionPtr& description : descriptions) {
            if (last_id < description->log_id) {
              last_id = description->log_id;
            }
          }

          if (last_id == 0) {
            std::cout << std::endl;
            std::cout << "no logs found" << std::endl;
            std::cout << std::endl;
            Terminate(MOJO_RESULT_OK);
            return;
          }

          ShowLog(last_id);
        });
  }

  void ShowEntries(uint32_t start_index) {
    MOJO_DCHECK(reader_);
    reader_->GetEntries(start_index, kGetEntriesMaxCount,
                        [this, start_index](Array<FlogEntryPtr> entries) {
                          for (const FlogEntryPtr& entry : entries) {
                            ShowEntry(entry);
                          }

                          if (entries.size() == kGetEntriesMaxCount) {
                            ShowEntries(start_index + kGetEntriesMaxCount);
                          } else {
                            std::cout << std::endl;
                            Terminate(MOJO_RESULT_OK);
                          }
                        });
  }

  void ShowEntry(const FlogEntryPtr& entry) {
    if (previous_time_us_ / 1000000ull != entry->time_us / 1000000ull) {
      std::cout << AsNiceDateTime(entry->time_us) << std::endl;
    }

    previous_time_us_ = entry->time_us;

    if (entry->details->is_mojo_logger_message()) {
      FlogMojoLoggerMessageEntryDetailsPtr details =
          entry->details->get_mojo_logger_message().Pass();
      std::cout << AsMicroseconds(entry->time_us) << " "
                << AsLogLevel(details->log_level) << ":" << details->source_file
                << "#" << details->source_line << " " << details->message
                << std::endl;
      return;
    }

    std::cout << AsMicroseconds(entry->time_us) << " " << entry->channel_id
              << " ";

    if (entry->details->is_channel_creation()) {
      FlogChannelCreationEntryDetailsPtr details =
          entry->details->get_channel_creation().Pass();
      std::cout << "channel created, type " << details->type_name << std::endl;
    } else if (entry->details->is_channel_message()) {
      FlogChannelMessageEntryDetailsPtr details =
          entry->details->get_channel_message().Pass();
      std::cout << "channel message, size " << details->data.size()
                << std::endl;
    } else if (entry->details->is_channel_deletion()) {
      FlogChannelDeletionEntryDetailsPtr details =
          entry->details->get_channel_deletion().Pass();
      std::cout << "channel deleted" << std::endl;
    } else {
      std::cout << "NO KNOWN DETAILS" << std::endl;
    }
  }

 private:
  static const uint32_t kGetEntriesMaxCount = 1024;

  FlogServicePtr service_;
  FlogReaderPtr reader_;
  uint32_t log_id_ = 0;
  bool show_last_ = false;
  uint64_t previous_time_us_ = 0;
};

}  // namespace examples
}  // namespace flog
}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ScopedChromiumInit init;
  mojo::flog::examples::FlogViewerApp flog_viewer_app;
  return mojo::RunApplication(application_request, &flog_viewer_app);
}
