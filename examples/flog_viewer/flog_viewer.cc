// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "examples/flog_viewer/flog_viewer.h"

#include <chrono>
#include <iomanip>
#include <iostream>

#include "mojo/public/cpp/application/connect.h"
#include "mojo/public/cpp/bindings/message.h"

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

// static
const std::string FlogViewer::kFormatTerse = "terse";
// static
const std::string FlogViewer::kFormatFull = "full";
// static
const std::string FlogViewer::kFormatDigest = "digest";

FlogViewer::FlogViewer() {}

FlogViewer::~FlogViewer() {}

void FlogViewer::Initialize(Shell* shell,
                            const std::function<void()>& terminate_callback) {
  terminate_callback_ = terminate_callback;
  ConnectToService(shell, "mojo:flog", GetProxy(&service_));
}

void FlogViewer::ProcessLogs() {
  MOJO_DCHECK(service_);

  service_->GetLogDescriptions([this](Array<FlogDescriptionPtr> descriptions) {
    std::cout << std::endl;
    std::cout << "     id  label" << std::endl;
    std::cout << "-------- ---------------------------------------------"
              << std::endl;

    for (const FlogDescriptionPtr& description : descriptions) {
      std::cout << std::setw(8) << description->log_id << " "
                << description->label << std::endl;
    }

    std::cout << std::endl;

    terminate_callback_();
  });
}

void FlogViewer::ProcessLog(uint32_t log_id) {
  MOJO_DCHECK(log_id != 0);
  MOJO_DCHECK(service_);

  service_->CreateReader(GetProxy(&reader_), log_id);

  std::cout << std::endl;
  ProcessEntries(0);
}

void FlogViewer::ProcessLastLog(const std::string& label) {
  MOJO_DCHECK(service_);

  service_->GetLogDescriptions(
      [this, label](Array<FlogDescriptionPtr> descriptions) {
        uint32_t last_id = 0;

        for (const FlogDescriptionPtr& description : descriptions) {
          if ((label.empty() || description->label == label) &&
              last_id < description->log_id) {
            last_id = description->log_id;
          }
        }

        if (last_id == 0) {
          std::cout << std::endl;
          std::cout << "no logs found" << std::endl;
          std::cout << std::endl;
          terminate_callback_();
          return;
        }

        ProcessLog(last_id);
      });
}

void FlogViewer::DeleteLog(uint32_t log_id) {
  MOJO_DCHECK(service_);
  service_->DeleteLog(log_id);
}

void FlogViewer::DeleteAllLogs() {
  MOJO_DCHECK(service_);
  service_->DeleteAllLogs();
}

void FlogViewer::ProcessEntries(uint32_t start_index) {
  MOJO_DCHECK(reader_);
  reader_->GetEntries(start_index, kGetEntriesMaxCount,
                      [this, start_index](Array<FlogEntryPtr> entries) {
                        uint32_t entry_index = start_index;
                        for (const FlogEntryPtr& entry : entries) {
                          ProcessEntry(entry_index, entry);
                          entry_index++;
                        }

                        if (entries.size() == kGetEntriesMaxCount) {
                          ProcessEntries(start_index + kGetEntriesMaxCount);
                        } else {
                          std::cout << std::endl;
                          PrintRemainingAccumulators();
                          terminate_callback_();
                        }
                      });
}

void FlogViewer::ProcessEntry(uint32_t entry_index, const FlogEntryPtr& entry) {
  if (!channels_.empty() && channels_.count(entry->channel_id) == 0) {
    return;
  }

  if (entry->details->is_mojo_logger_message()) {
    OnMojoLoggerMessage(entry_index, entry,
                        entry->details->get_mojo_logger_message());
    return;
  }

  if (entry->details->is_channel_creation()) {
    OnChannelCreated(entry_index, entry,
                     entry->details->get_channel_creation());
  } else if (entry->details->is_channel_message()) {
    OnChannelMessage(entry_index, entry, entry->details->get_channel_message());
  } else if (entry->details->is_channel_deletion()) {
    OnChannelDeleted(entry_index, entry,
                     entry->details->get_channel_deletion());
  } else {
    PrintEntryProlog(entry);
    std::cout << "NO KNOWN DETAILS" << std::endl;
  }
}

void FlogViewer::PrintEntryProlog(const FlogEntryPtr& entry) {
  if (previous_time_us_ / 1000000ull != entry->time_us / 1000000ull) {
    std::cout << AsNiceDateTime(entry->time_us) << std::endl;
  }

  previous_time_us_ = entry->time_us;

  std::cout << AsMicroseconds(entry->time_us) << " ";

  std::cout << entry->channel_id << " ";
}

void FlogViewer::PrintAccumulator(
    uint32_t channel_id,
    std::shared_ptr<ChannelHandler> channel_handler) {
  std::shared_ptr<Accumulator> accumulator = channel_handler->GetAccumulator();
  if (accumulator) {
    std::cout << "CHANNEL " << channel_id << ": ";
    accumulator->Print();
    std::cout << std::endl;
  }
}

void FlogViewer::PrintRemainingAccumulators() {
  for (std::pair<uint32_t, std::shared_ptr<ChannelHandler>> pair :
       channel_handlers_by_channel_id_) {
    PrintAccumulator(pair.first, pair.second);
  }
}

void FlogViewer::OnMojoLoggerMessage(
    uint32_t entry_index,
    const FlogEntryPtr& entry,
    const FlogMojoLoggerMessageEntryDetailsPtr& details) {
  if (format_ != kFormatTerse && format_ != kFormatFull) {
    return;
  }

  PrintEntryProlog(entry);
  std::cout << AsLogLevel(details->log_level) << ":" << details->source_file
            << "#" << details->source_line << " " << details->message
            << std::endl;
}

void FlogViewer::OnChannelCreated(
    uint32_t entry_index,
    const FlogEntryPtr& entry,
    const FlogChannelCreationEntryDetailsPtr& details) {
  if (format_ == kFormatTerse || format_ == kFormatFull) {
    PrintEntryProlog(entry);
    std::cout << "channel created, type " << details->type_name << std::endl;
  }

  auto iter = channel_handlers_by_channel_id_.find(entry->channel_id);
  if (iter != channel_handlers_by_channel_id_.end()) {
    PrintEntryProlog(entry);
    std::cout << "    ERROR: CHANNEL ALREADY EXISTS" << std::endl;
  }

  std::shared_ptr<ChannelHandler> handler = ChannelHandler::CreateHandler(
      details->type_name, format_,
      [this](const FlogEntryPtr& entry) { PrintEntryProlog(entry); });
  MOJO_DCHECK(handler);
  channel_handlers_by_channel_id_.insert(
      std::make_pair(entry->channel_id, handler));
}

void FlogViewer::OnChannelMessage(
    uint32_t entry_index,
    const FlogEntryPtr& entry,
    const FlogChannelMessageEntryDetailsPtr& details) {
  Message message;
  message.AllocUninitializedData(details->data.size());
  memcpy(message.mutable_data(), details->data.data(), details->data.size());

  auto iter = channel_handlers_by_channel_id_.find(entry->channel_id);
  if (iter == channel_handlers_by_channel_id_.end()) {
    std::cout << "channel message, size " << details->data.size() << " name "
              << message.name() << std::endl;
  } else {
    iter->second->HandleMessage(entry_index, entry, &message);
  }
}

void FlogViewer::OnChannelDeleted(
    uint32_t entry_index,
    const FlogEntryPtr& entry,
    const FlogChannelDeletionEntryDetailsPtr& details) {
  if (format_ == kFormatTerse || format_ == kFormatFull) {
    PrintEntryProlog(entry);
    std::cout << "channel deleted" << std::endl;
  }

  auto iter = channel_handlers_by_channel_id_.find(entry->channel_id);
  if (iter == channel_handlers_by_channel_id_.end()) {
    PrintEntryProlog(entry);
    std::cout << "    ERROR: CHANNEL DOESN'T EXIST" << std::endl;
  } else {
    PrintAccumulator(entry->channel_id, iter->second);
    channel_handlers_by_channel_id_.erase(iter);
  }
}

}  // namespace examples
}  // namespace flog
}  // namespace mojo
