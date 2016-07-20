// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_FLOG_VIEWER_ACCUMULATOR_H_
#define EXAMPLES_FLOG_VIEWER_ACCUMULATOR_H_

#include "mojo/public/cpp/bindings/message.h"
#include "mojo/services/flog/interfaces/flog.mojom.h"

namespace mojo {
namespace flog {
namespace examples {

// Base class for accumulators produced by handlers that analyze message
// streams.
//
// Some channel handlers (particularly the ones for the 'digest' format) will
// produce an accumulator, which reflects the handler's understanding of the
// messages that have been handled.
class Accumulator {
 public:
  virtual ~Accumulator();

  // Report a problem.
  void ReportProblem(const std::string& description);

  // Prints reported problems.
  void PrintProblems();

  // Prints the contents of the accumulator to cout. The default implementation
  // calls PrintProblems.
  virtual void Print();

 protected:
  Accumulator();

 private:
  std::vector<std::string> problems_;
};

}  // namespace examples
}  // namespace flog
}  // namespace mojo

#endif  // EXAMPLES_FLOG_VIEWER_ACCUMULATOR_H_
