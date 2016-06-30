#!/usr/bin/env python
# Copyright 2015 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""Runs Rust tests in the Mojo source tree using Cargo."""


import argparse
import os
import subprocess
import sys


def main():
  parser = argparse.ArgumentParser(description="Runs Rust tests in the "
      "Mojo source tree using Cargo.")
  parser.add_argument('rust_cargo_path', metavar='rust_cargo_path',
      help="the path to the 'cargo' binary")
  parser.add_argument('rustc_path', metavar='rustc_path',
      help="the path to the 'rustc' binary")
  parser.add_argument('rustdoc_path', metavar='rustdoc_path',
      help="the path to the 'rustdoc' binary")
  parser.add_argument('target_out_dir', metavar='target_out_dir',
      help="the path to the output directory")
  parser.add_argument('--release', action='store_true',
      help="specify whether we are building for release")
  args = parser.parse_args()
  cargo_tool = os.path.abspath(args.rust_cargo_path)
  test_command = [cargo_tool, 'test',
                  '--manifest-path', 'mojo/public/rust/Cargo.toml']
  if args.release == True:
    test_command += ['--release']
  os.environ["RUSTC"] = os.path.abspath(args.rustc_path)
  os.environ["RUSTDOC"] = os.path.abspath(args.rustdoc_path)
  os.environ["CARGO_TARGET_DIR"] = os.path.abspath(args.target_out_dir)
  test_result = subprocess.call(test_command)
  return test_result

if __name__ == '__main__':
  sys.exit(main())
