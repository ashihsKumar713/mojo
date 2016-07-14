#!/usr/bin/python
# Copyright 2016 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""
This script takes linux Rust binaries which are zipped and
uploads it to Google Cloud Storage at gs://mojo-build/rust. It also produces
the VERSION file with the sha1 code of the uploaded archive.

In order to use it, you need:
- depot_tools in your path
- installed android build deps
- WRITE access to GCS

To update the Rust tool binaries you need to
1) run 'gsutil.py config' to update initialize gsutil's credentials
2) run this script: python upload.py <linux|mac> rust-x.y.z-<arch>-<platform>

This script doesn't check if current version is already up to date, as the
produced tar.gz archive is slightly different every time since it includes
timestamps.
"""

import hashlib
import os
import shutil
import subprocess
import sys
import tarfile
import tempfile

# Path constants. (All of these should be absolute paths.)
THIS_DIR = os.path.abspath(os.path.dirname(__file__))
MOJO_DIR = os.path.abspath(os.path.join(THIS_DIR, '..', '..'))
INSTALL_DIR = os.path.join(MOJO_DIR, 'third_party', 'rust')

sys.path.insert(0, os.path.join(MOJO_DIR, 'tools'))
import find_depot_tools

DEPOT_PATH = find_depot_tools.add_depot_tools_to_path()
GSUTIL_PATH = os.path.join(DEPOT_PATH, 'gsutil.py')

def RunCommand(command, env=None):
  """Run command and return success (True) or failure."""

  print 'Running %s' % (str(command))
  if subprocess.call(command, shell=False, env=env) == 0:
    return True
  print 'Failed.'
  return False

def HashFile(filename):
  """Computes SHA1 hash of a given file by chunking it to avoid loading
     the entire file into memory."""
  sha1 = hashlib.sha1()
  with open(filename, 'rb') as f:
    while True:
      # Read in 1mb chunks, so it doesn't all have to be loaded into memory.
      chunk = f.read(1024*1024)
      if not chunk:
        break
      sha1.update(chunk)
  return sha1.hexdigest()

def DownloadAndRename(version):
  """Downloads the given Rust tarball (by version) from static.rust-lang.org
     and renames it to its SHA1 hash. Returns the hash."""

  extract_path = os.path.join(THIS_DIR, '%s' % version)
  compress_path = os.path.join(THIS_DIR, 'usr')
  archive_path = '%s.tar.gz' % extract_path
  download_cmd = ['wget',
                  '-O', archive_path,
                  'https://static.rust-lang.org/dist/%s.tar.gz' % version]

  print ("Downloading %s.tar.gz." % version)
  if not RunCommand(download_cmd):
    print "Failed to download rust toolchain from rust-lang.org."
    sys.exit(1)

  print ("Extracting archive.")
  with tarfile.open(archive_path) as f:
    f.extractall()
  os.remove(archive_path)

  print ("Installing binaries locally.")
  install_cmd = [os.path.join(extract_path, 'install.sh'),
                 '--destdir=' + THIS_DIR]
  if not RunCommand(install_cmd):
    print ('WARNING: Failed to install Rust tool binaries.')
    return False
  shutil.rmtree(extract_path)

  print ("Compressing archive.")
  with tarfile.open(archive_path, 'w|gz') as f:
    f.add('usr')
  shutil.rmtree(compress_path)

  print ("Calculating SHA1.")
  sha1 = HashFile(archive_path)

  print ("Renaming archive.")
  os.rename(archive_path, os.path.join(THIS_DIR, '%s' % sha1))
  return sha1

def Upload(platform, sha1):
  """Uploads INSTALL_DIR/sha1 to Google Cloud Storage under
     gs://mojo-build/rust and writes sha1 to THIS_DIR/rust-platform.sha1"""

  file_name = sha1
  upload_cmd = ['python', GSUTIL_PATH, 'cp',
                '-n', # Do not upload if the file already exists.
                os.path.join(THIS_DIR, file_name),
                'gs://mojo-build/rust/%s' % file_name]

  print ("Uploading rust toolchain to GCS.")
  if not RunCommand(upload_cmd):
    print ("Failed to upload rust toolchain to GCS.")
    sys.exit(1)
  os.remove(os.path.join(THIS_DIR, file_name))
  # Write versions as the last step.
  stamp_file = os.path.join(INSTALL_DIR, 'rust-%s.sha1' % platform)
  with open(stamp_file, 'w+') as stamp:
    stamp.write('%s\n' % sha1)

def PrintUsage():
  print ("Usage: python %s <linux|mac> <rust-version>" % sys.argv[0])

def main():
  if len(sys.argv) != 3:
    PrintUsage()
    return 1
  platform = sys.argv[1]
  if platform not in ('linux', 'mac'):
    PrintUsage()
    return 1
  sha1 = DownloadAndRename(sys.argv[2])
  Upload(platform, sha1)
  print ("Done.")

if __name__ == '__main__':
  sys.exit(main())
