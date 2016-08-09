// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <mojo/system/main.h>

#include <memory>

#include "examples/audio_play_test/play_audio.h"
#include "mojo/public/cpp/application/connect.h"
#include "mojo/public/cpp/application/run_application.h"
#include "mojo/public/cpp/system/data_pipe.h"
#include "mojo/public/cpp/system/wait.h"
#include "mojo/services/network/interfaces/network_service.mojom.h"
#include "mojo/services/network/interfaces/url_loader.mojom.h"

#define PACKED __attribute__((packed))

static inline constexpr uint32_t make_fourcc(uint8_t a,
                                             uint8_t b,
                                             uint8_t c,
                                             uint8_t d) {
  return (static_cast<uint32_t>(a) << 24) | (static_cast<uint32_t>(b) << 16) |
         (static_cast<uint32_t>(c) << 8) | static_cast<uint32_t>(d);
}

static inline constexpr uint32_t fetch_fourcc(const void* source) {
  return (static_cast<uint32_t>(static_cast<const uint8_t*>(source)[0]) << 24) |
         (static_cast<uint32_t>(static_cast<const uint8_t*>(source)[1]) << 16) |
         (static_cast<uint32_t>(static_cast<const uint8_t*>(source)[2]) << 8) |
         static_cast<uint32_t>(static_cast<const uint8_t*>(source)[3]);
}

namespace mojo {
namespace media {
namespace audio {
namespace examples {

static constexpr const char* kOriginUrl =
    "http://www.kozco.com/tech/piano2.wav";

class PlayWavApp : public PlayAudioApp {
 public:
  // ApplicationImplBase overrides:
  void OnInitialize() override;
  void OnQuit() override;

 protected:
  bool FillPayloadBuffer(void* payload, uint32_t frames_per_packet) override;

 private:
  // TODO(johngro): endianness!
  struct PACKED RIFFChunkHeader {
    uint32_t four_cc;
    uint32_t length;
  };

  struct PACKED WAVHeader {
    uint32_t wave_four_cc;
    uint32_t fmt_four_cc;
    uint32_t fmt_chunk_len;
    uint16_t format;
    uint16_t channel_count;
    uint32_t frame_rate;
    uint32_t average_byte_rate;
    uint16_t frame_size;
    uint16_t bits_per_sample;
  };

  // TODO(johngro): as mentioned before... endianness!
  static constexpr uint32_t RIFF_FOUR_CC = make_fourcc('R', 'I', 'F', 'F');
  static constexpr uint32_t WAVE_FOUR_CC = make_fourcc('W', 'A', 'V', 'E');
  static constexpr uint32_t FMT_FOUR_CC = make_fourcc('f', 'm', 't', ' ');
  static constexpr uint32_t DATA_FOUR_CC = make_fourcc('d', 'a', 't', 'a');

  static constexpr uint16_t FORMAT_LPCM = 0x0001;
  static constexpr uint16_t FORMAT_MULAW = 0x0101;
  static constexpr uint16_t FORMAT_ALAW = 0x0102;
  static constexpr uint16_t FORMAT_ADPCM = 0x0103;

  static const std::set<std::string> VALID_MIME_TYPES;
  static const std::set<uint16_t> VALID_FRAME_RATES;
  static const std::set<uint16_t> VALID_BITS_PER_SAMPLES;

  bool BlockingRead(void* buffer,
                    uint32_t bytes_to_read,
                    uint32_t* bytes_read_out = nullptr);
  void ProcessHTTPResponse(URLResponsePtr resp);

  bool ReadAndValidateRIFFHeader();
  bool ReadAndValidateWAVHeader();
  bool ReadAndValidateDATAHeader();

  NetworkServicePtr network_service_;
  URLLoaderPtr url_loader_;
  ScopedDataPipeConsumerHandle data_pipe_consumer_handle_;
  RIFFChunkHeader riff_hdr_;
  WAVHeader wav_info_;
  RIFFChunkHeader data_hdr_;
};

const std::set<std::string> PlayWavApp::VALID_MIME_TYPES({
    "audio/x-wav", "audio/wav",
});

const std::set<uint16_t> PlayWavApp::VALID_FRAME_RATES({
    8000, 16000, 24000, 32000, 48000, 11025, 22050, 44100,
});

const std::set<uint16_t> PlayWavApp::VALID_BITS_PER_SAMPLES({
    8, 16,
});

void PlayWavApp::OnInitialize() {
  ConnectToService(shell(), "mojo:network_service",
                   GetProxy(&network_service_));
  network_service_->CreateURLLoader(GetProxy(&url_loader_));
  url_loader_.set_connection_error_handler(
      [this]() { OnConnectionError("url_loader"); });

  URLRequestPtr req(URLRequest::New());
  req->url = kOriginUrl;
  req->method = "GET";

  auto cbk = [this](URLResponsePtr resp) { ProcessHTTPResponse(resp.Pass()); };
  url_loader_->Start(req.Pass(), URLLoader::StartCallback(cbk));
}

void PlayWavApp::OnQuit() {
  data_pipe_consumer_handle_.reset();
  url_loader_.reset();
  network_service_.reset();
  PlayAudioApp::OnQuit();
}

bool PlayWavApp::BlockingRead(void* buffer,
                              uint32_t bytes_to_read,
                              uint32_t* bytes_read_out) {
  uint8_t* buffer_bytes = reinterpret_cast<uint8_t*>(buffer);
  uint32_t bytes_to_read_remaining = bytes_to_read;

  while (true) {
    uint32_t byte_count = bytes_to_read_remaining;
    MojoResult result =
        ReadDataRaw(data_pipe_consumer_handle_.get(), buffer_bytes, &byte_count,
                    MOJO_READ_DATA_FLAG_NONE);

    if (result == MOJO_RESULT_SHOULD_WAIT) {
      byte_count = 0;
    } else if (result == MOJO_ERROR_CODE_FAILED_PRECONDITION) {
      // TODO(dalesat): Why MOJO_ERROR_CODE_FAILED_PRECONDITION? See
      // https://github.com/domokit/mojo/issues/497.
      if (bytes_read_out != nullptr) {
        *bytes_read_out = bytes_to_read - bytes_to_read_remaining;
        return true;
      }
      return false;
    } else if (result != MOJO_RESULT_OK) {
      MOJO_DLOG(ERROR) << "ReadDataRaw failed " << result;
      return false;
    }

    buffer_bytes += byte_count;
    bytes_to_read_remaining -= byte_count;

    if (bytes_to_read_remaining == 0) {
      if (bytes_read_out != nullptr) {
        *bytes_read_out = bytes_to_read;
      }
      return true;
    }

    Wait(data_pipe_consumer_handle_.get(), MOJO_HANDLE_SIGNAL_READABLE,
         MOJO_DEADLINE_INDEFINITE, nullptr);
  }
}

void PlayWavApp::ProcessHTTPResponse(URLResponsePtr resp) {
  if (resp->mime_type.is_null() ||
      (VALID_MIME_TYPES.find(resp->mime_type) == VALID_MIME_TYPES.end())) {
    MOJO_LOG(ERROR) << "Bad MimeType \""
                    << (resp->mime_type.is_null() ? "<null>" : resp->mime_type)
                    << "\"";
    Shutdown();
    return;
  }

  data_pipe_consumer_handle_ = resp->body.Pass();

  if (!ReadAndValidateRIFFHeader() || !ReadAndValidateWAVHeader() ||
      !ReadAndValidateDATAHeader()) {
    Shutdown();
    return;
  }

  MOJO_LOG(INFO) << "Preparing to play...";
  MOJO_LOG(INFO) << "File : " << kOriginUrl;
  MOJO_LOG(INFO) << "Rate : " << wav_info_.frame_rate;
  MOJO_LOG(INFO) << "Chan : " << wav_info_.channel_count;
  MOJO_LOG(INFO) << "BPS  : " << wav_info_.bits_per_sample;

  Start((wav_info_.bits_per_sample == 8) ? AudioSampleFormat::UNSIGNED_8
                                         : AudioSampleFormat::SIGNED_16,
        wav_info_.channel_count, wav_info_.frame_rate);
}

bool PlayWavApp::FillPayloadBuffer(void* payload, uint32_t frames_per_packet) {
  uint32_t bytes_read;
  if (!BlockingRead(payload, frames_per_packet * bytes_per_frame(),
                    &bytes_read)) {
    MOJO_LOG(ERROR) << "Failed to read source, shutting down...";
    PostShutdown();
    return false;
  }

  if (bytes_read == frames_per_packet * bytes_per_frame()) {
    return true;
  }

  uint8_t* payload_as_bytes = reinterpret_cast<uint8_t*>(payload);
  memset(payload_as_bytes + bytes_read, 0,
         frames_per_packet * bytes_per_frame() - bytes_read);
  return false;
}

bool PlayWavApp::ReadAndValidateRIFFHeader() {
  // Read and sanity check the top level RIFF header
  if (!BlockingRead(&riff_hdr_, sizeof(riff_hdr_))) {
    MOJO_LOG(ERROR) << "Failed to read top level RIFF header!";
    return false;
  }

  if (fetch_fourcc(&riff_hdr_.four_cc) != RIFF_FOUR_CC) {
    MOJO_LOG(ERROR) << "Missing expected 'RIFF' 4CC "
                    << "(expected 0x " << std::hex << RIFF_FOUR_CC << " got 0x"
                    << std::hex << fetch_fourcc(&riff_hdr_.four_cc) << ")";
    return false;
  }

  return true;
}

bool PlayWavApp::ReadAndValidateWAVHeader() {
  // Read the WAVE header along with its required format chunk.
  if (!BlockingRead(&wav_info_, sizeof(wav_info_))) {
    MOJO_LOG(ERROR) << "Failed to read top level WAVE header!";
    return false;
  }

  if (fetch_fourcc(&wav_info_.wave_four_cc) != WAVE_FOUR_CC) {
    MOJO_LOG(ERROR) << "Missing expected 'WAVE' 4CC "
                    << "(expected 0x " << std::hex << WAVE_FOUR_CC << " got 0x"
                    << std::hex << fetch_fourcc(&wav_info_.wave_four_cc) << ")";
    return false;
  }

  if (fetch_fourcc(&wav_info_.fmt_four_cc) != FMT_FOUR_CC) {
    MOJO_LOG(ERROR) << "Missing expected 'fmt ' 4CC "
                    << "(expected 0x " << std::hex << FMT_FOUR_CC << " got 0x"
                    << std::hex << fetch_fourcc(&wav_info_.fmt_four_cc) << ")";
    return false;
  }

  // Sanity check the format of the wave file.  This demo only support a limited
  // subset of the possible formats.
  if (wav_info_.format != FORMAT_LPCM) {
    MOJO_LOG(ERROR) << "Unsupported format (0x" << std::hex << wav_info_.format
                    << ") must be LPCM (0x" << std::hex << FORMAT_LPCM << ")";
    return false;
  }

  if ((wav_info_.channel_count != 1) && (wav_info_.channel_count != 2)) {
    MOJO_LOG(ERROR) << "Unsupported channel count (" << wav_info_.channel_count
                    << ") must be either mono or stereo";
    return false;
  }

  if (VALID_FRAME_RATES.find(wav_info_.frame_rate) == VALID_FRAME_RATES.end()) {
    MOJO_LOG(ERROR) << "Unsupported frame_rate (" << wav_info_.frame_rate
                    << ")";
    return false;
  }

  if (VALID_BITS_PER_SAMPLES.find(wav_info_.bits_per_sample) ==
      VALID_BITS_PER_SAMPLES.end()) {
    MOJO_LOG(ERROR) << "Unsupported bits per sample ("
                    << wav_info_.bits_per_sample << ")";
    return false;
  }

  uint16_t expected_frame_size =
      (wav_info_.channel_count * wav_info_.bits_per_sample) >> 3;
  if (wav_info_.frame_size != expected_frame_size) {
    MOJO_LOG(ERROR) << "Frame size sanity check failed.  (expected "
                    << expected_frame_size << " got " << wav_info_.frame_size
                    << ")";
    return false;
  }

  return true;
}

bool PlayWavApp::ReadAndValidateDATAHeader() {
  // Technically, there could be format specific member of the wave format
  // chunk, or other riff chunks which could come after this, but for this demo,
  // we only handle getting the 'data' chunk at this point.
  if (!BlockingRead(&data_hdr_, sizeof(data_hdr_))) {
    MOJO_LOG(ERROR) << "Failed to read data header!";
    return false;
  }

  if (fetch_fourcc(&data_hdr_.four_cc) != DATA_FOUR_CC) {
    MOJO_LOG(ERROR) << "Missing expected 'data' 4CC "
                    << "(expected 0x " << std::hex << DATA_FOUR_CC << " got 0x"
                    << std::hex << fetch_fourcc(&data_hdr_.four_cc) << ")";
    return false;
  }

  if ((data_hdr_.length + sizeof(WAVHeader) + sizeof(RIFFChunkHeader)) !=
      riff_hdr_.length) {
    MOJO_LOG(ERROR) << "Header length sanity check failure ("
                    << data_hdr_.length << " + "
                    << sizeof(WAVHeader) + sizeof(RIFFChunkHeader)
                    << " != " << riff_hdr_.length << ")";
    return false;
  }

  // If the length of the data chunk is not a multiple of the frame size, log a
  // warning and truncate the length.
  uint16_t leftover;
  uint32_t payload_len = data_hdr_.length;
  leftover = payload_len % wav_info_.frame_size;
  if (leftover) {
    MOJO_LOG(WARNING) << "Data chunk length (" << payload_len
                      << ") not a multiple of frame size ("
                      << wav_info_.frame_size << ")";
    payload_len -= leftover;
  }

  return true;
}

}  // namespace examples
}  // namespace audio
}  // namespace media
}  // namespace mojo

MojoResult MojoMain(MojoHandle app_request) {
  mojo::media::audio::examples::PlayWavApp play_wav_app;
  return mojo::RunApplication(app_request, &play_wav_app);
}
