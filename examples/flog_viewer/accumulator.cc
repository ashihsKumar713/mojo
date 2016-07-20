// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "examples/flog_viewer/accumulator.h"

#include <iostream>

namespace mojo {
namespace flog {
namespace examples {

Accumulator::Accumulator() {}

Accumulator::~Accumulator() {}

void Accumulator::ReportProblem(const std::string& description) {
  problems_.push_back(description);
}

void Accumulator::PrintProblems() {
  for (const std::string& problem : problems_) {
    std::cout << "PROBLEM: " << problem << std::endl;
  }
}

void Accumulator::Print() {
  PrintProblems();
}

}  // namespace examples
}  // namespace flog
}  // namespace mojo
