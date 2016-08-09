// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <mojo/system/main.h>

#include "examples/audio_play_test/play_audio.h"
#include "mojo/public/cpp/application/run_application.h"

namespace mojo {
namespace media {
namespace audio {
namespace examples {

class PlayToneApp : public PlayAudioApp {
 public:
  // ApplicationImplBase overrides:
  void OnInitialize() override;

 protected:
  // PlayAudioApp overrides.
  bool FillPayloadBuffer(void* payload, uint32_t frames_per_packet) override;

 private:
  static constexpr uint32_t kFramesPerSecond = 48000;
  static constexpr float kFrequency = 440.0f;
  static constexpr float kRotator =
      2.0f * 3.14159f * kFrequency / kFramesPerSecond;
  static constexpr int16_t kSampleConversionMultiplier = 30000;

  float real_sample_ = 0.0f;
  float imaginary_sample_ = 1.0f;
};

void PlayToneApp::OnInitialize() {
  Start(AudioSampleFormat::SIGNED_16, 1, kFramesPerSecond);
}

bool PlayToneApp::FillPayloadBuffer(void* payload, uint32_t frames_per_packet) {
  float real_sample = real_sample_;
  float imaginary_sample = imaginary_sample_;

  int16_t* dest = reinterpret_cast<int16_t*>(payload);

  // Generate a sine wave using what amounts to a 2D rotation transform. We're
  // rotating a unit vector around the origin and using the value of the 'real'
  // coordinate to generate the output.
  for (size_t i = 0; i < frames_per_packet; ++i) {
    *dest = static_cast<int16_t>(real_sample * kSampleConversionMultiplier);
    ++dest;

    real_sample -= imaginary_sample * kRotator;
    imaginary_sample += real_sample * kRotator;
  }

  real_sample_ = real_sample;
  imaginary_sample_ = imaginary_sample;

  return true;
}

}  // namespace examples
}  // namespace audio
}  // namespace media
}  // namespace mojo

MojoResult MojoMain(MojoHandle app_request) {
  mojo::media::audio::examples::PlayToneApp play_tone_app;
  return mojo::RunApplication(app_request, &play_tone_app);
}
