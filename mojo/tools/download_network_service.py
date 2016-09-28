#!/usr/bin/env python
# Copyright 2015 The Chromium Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

import argparse
import os
import sys
import tempfile
import zipfile

_PLATFORMS = ["linux-x64", "android-arm"]
_APPS = ["network_service", "network_service_apptests"]
_ROOT_PATH = os.path.dirname(
    os.path.dirname(os.path.dirname(os.path.realpath(__file__))))
_PREBUILT_PATH = os.path.join(_ROOT_PATH, "mojo", "prebuilt")
_MOJO_PUBLIC_ROOT = os.path.join(_ROOT_PATH, "mojo", "public")
sys.path.insert(0, os.path.join(_MOJO_PUBLIC_ROOT, "tools", "pylib"))
import gs

find_depot_tools_path = os.path.join(_ROOT_PATH, "tools")
sys.path.insert(0, find_depot_tools_path)
# pylint: disable=F0401
import find_depot_tools
depot_tools_path = find_depot_tools.add_depot_tools_to_path()


def download_app(app, version):
  stamp_path = os.path.join(_PREBUILT_PATH, app, "VERSION")

  try:
    with open(stamp_path) as stamp_file:
      current_version = stamp_file.read().strip()
      if current_version == version:
        return  # Already have the right version.
  except IOError:
    pass  # If the stamp file does not exist we need to download a new binary.

  for platform in _PLATFORMS:
    download_app_for_platform(app, version, platform)

  with open(stamp_path, 'w') as stamp_file:
    stamp_file.write(version)


def download_app_for_platform(app, version, platform):
  binary_name = app + ".mojo"
  gs_path = "gs://mojo/%s/%s/%s/%s.zip" % (app, version, platform, binary_name)
  output_directory = os.path.join(_PREBUILT_PATH, app, platform)

  with tempfile.NamedTemporaryFile() as temp_zip_file:
    gs.download_from_public_bucket(gs_path, temp_zip_file.name,
                                   depot_tools_path)
    with zipfile.ZipFile(temp_zip_file.name) as z:
      zi = z.getinfo(binary_name)
      mode = zi.external_attr >> 16
      z.extract(zi, output_directory)
      os.chmod(os.path.join(output_directory, binary_name), mode)


def main():
  parser = argparse.ArgumentParser(
      description="Download prebuilt network service binaries from google " +
                  "storage")
  parser.parse_args()

  version_path = os.path.join(_MOJO_PUBLIC_ROOT,
                              "tools",
                              "NETWORK_SERVICE_VERSION")
  with open(version_path) as version_file:
    version = version_file.read().strip()

  for app in _APPS:
    download_app(app, version)

  return 0


if __name__ == "__main__":
  sys.exit(main())
