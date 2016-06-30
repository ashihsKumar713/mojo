#!/usr/bin/env python
# Copyright 2016 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""
This script invokes cargo for building only. If tests are slated to be built,
they will not be run.
Must be called as follows:
python cargo.py [--release] [--no_embed] rust_cargo_tool action rustc_tool
                rustdoc_tool root_out_dir target_out_dir
"""

import argparse
import os
import sys
from subprocess import call

def main():
  parser = argparse.ArgumentParser()
  parser.add_argument('--release', action='store_true')
  parser.add_argument('--no_embed', action='store_true')
  parser.add_argument('rust_cargo_tool')
  parser.add_argument('action')
  parser.add_argument('rustc_tool')
  parser.add_argument('rustdoc_tool')
  parser.add_argument('manifest_path')
  parser.add_argument('root_out_dir')
  parser.add_argument('target_out_dir')
  args = parser.parse_args()
  cargo = os.path.abspath(args.rust_cargo_tool)
  action = args.action
  manifest = os.path.abspath(args.manifest_path)
  os.environ['RUSTC'] = os.path.abspath(args.rustc_tool)
  os.environ['RUSTDOC'] = os.path.abspath(args.rustdoc_tool)
  os.environ['MOJO_OUT_DIR'] = os.path.abspath(args.root_out_dir)
  os.environ['CARGO_TARGET_DIR'] = os.path.abspath(args.target_out_dir)
  if args.no_embed == True:
    os.environ['MOJO_RUST_NO_EMBED'] = '1'
  command = [cargo, action, '--manifest-path', manifest, '--quiet']
  if args.release == True:
    command += ['--release']
  if action == 'test':
    command += ['--no-run']
  return call(command)

if __name__ == '__main__':
  sys.exit(main())
