#!/usr/bin/python
# Copyright 2016 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""
Downloads Rust binaries from Google Cloud Storage and extracts them to
INSTALL_DIR, updating INSTALL_DIR/VERSION stamp file with current version.
Does nothing if INSTALL_DIR/VERSION is already up to date.
"""

import os
import shutil
import subprocess
import sys
import tarfile

# Path constants. (All of these should be absolute paths.)
THIS_DIR = os.path.abspath(os.path.dirname(__file__))
MOJO_DIR = os.path.abspath(os.path.join(THIS_DIR, '..', '..'))
# Should be the same as in upload.py.
INSTALL_DIR = os.path.join(MOJO_DIR, 'third_party', 'rust')

sys.path.insert(0, os.path.join(MOJO_DIR, 'tools'))
import find_depot_tools

DEPOT_PATH = find_depot_tools.add_depot_tools_to_path()
GSUTIL_PATH = os.path.join(DEPOT_PATH, 'gsutil.py')

def RunCommand(command):
  """Run command and return success (True) or failure."""

  print 'Running %s' % (str(command))
  if subprocess.call(command, shell=False) == 0:
    return True
  print 'Failed.'
  return False

def VersionFileName():
  if sys.platform.startswith('linux'):
    platform_suffix = 'LINUX'
  else:
    raise Exception('unsupported platform: ' + sys.platform)
  return 'VERSION_' + platform_suffix

def GetInstalledVersion():
  version_file = os.path.join(INSTALL_DIR, VersionFileName())
  if not os.path.exists(version_file):
    return None
  with open(version_file) as f:
    return f.read().strip()

def InstallRustBinaries(version):
  """Downloads gzip'd rust binaries from rust-lang and extracts them,
     stamping current version. Returns True on success, False on failure."""

  # Remove current installation.
  if os.path.exists(INSTALL_DIR):
    shutil.rmtree(INSTALL_DIR)
  os.makedirs(INSTALL_DIR)
  # Download rust tool binaries.
  archive_path = os.path.join(INSTALL_DIR, 'rust.tar.gz')
  rust_toolchain = 'rust-%s-x86_64-unknown-linux-gnu' % version
  download_cmd = ['python', GSUTIL_PATH, 'cp',
                  'gs://mojo-build/rust/%s.tar.gz' % rust_toolchain,
                  archive_path]
  if not RunCommand(download_cmd):
    print ('WARNING: Failed to download Rust tool binaries.')
    return False

  print "Extracting Rust binaries."
  with tarfile.open(archive_path) as arch:
    arch.extractall(INSTALL_DIR)

  os.remove(archive_path)
  install_cmd = [os.path.join(INSTALL_DIR, rust_toolchain, 'install.sh'),
                 '--destdir=' + INSTALL_DIR]
  if not RunCommand(install_cmd):
    print ('WARNING: Failed to install Rust tool binaries.')
    return False

  shutil.rmtree(os.path.join(INSTALL_DIR, rust_toolchain))
  # Write version as the last step.
  with open(os.path.join(INSTALL_DIR, VersionFileName()), 'w+') as f:
    f.write('%s\n' % version)
  return True

def main():
  # Read latest version.
  version = ''
  with open(os.path.join(THIS_DIR, VersionFileName())) as f:
    version = f.read().strip()
  # Return success if installed binaries are up to date.
  if version == GetInstalledVersion():
    return 0
  # Return failure if binaries fail to install.
  if not InstallRustBinaries(version):
    return 1
  return 0

if __name__ == '__main__':
  sys.exit(main())
