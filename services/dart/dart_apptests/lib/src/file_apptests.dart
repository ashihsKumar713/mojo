// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library file_apptests;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mojo_apptest/apptest.dart';
import 'package:mojo/application.dart';
import 'package:mojo/bindings.dart';
import 'package:mojo/core.dart';

tests(Application application, String url) {
  group('File Apptests', () {
    test('Absolute path', () async {
      String current = Directory.current.path;
      for (String relative in ['abd', '..', '.', 'efg/hij', 'abc/']) {
        if (current.endsWith('/')) {
          expect(new File(relative).absolute.path, '$current$relative');
        } else {
          expect(new File(relative).absolute.path, '$current/$relative');
        }
        expect(new File(relative).absolute.isAbsolute, isTrue);
        expect(new Directory(relative).absolute.path,
               new Link(relative).absolute.path);
        expect(new File(relative).absolute is File, isTrue);
        expect(new Directory(relative).absolute is Directory, isTrue);
        expect(new Link(relative).absolute is Link, isTrue);
      }
      for (String absolute in ['/abd', '/', '/./..\\', '/efg/hij', '/abc/']) {
        expect(new File(absolute).absolute.path, absolute);
        expect(new File(absolute).absolute.isAbsolute, isTrue);
       }
    });
    test('File Constructor', () async {
      expect(new File('blåbærgrød'), isNotNull);
      expect(new File('foo.txt'), isNotNull);
    });
    test('Directory systemTemp', () async {
      expect(Directory.systemTemp, isNotNull);
    });
    test('Directory create', () async {
      Directory directory =
          await Directory.systemTemp.createTemp('dart_directory_test');
      Directory subDirectory = new Directory("${directory.path}/subdir");
      expect('$directory'.contains(directory.path), isTrue);
      expect(await subDirectory.exists(), isFalse);
      await subDirectory.create();
      expect(await subDirectory.exists(), isTrue);
      File f = new File('${subDirectory.path}/file.txt');
      File fLong = new File('${directory.path}/subdir/../subdir/file.txt');
      expect(await f.exists(), isFalse);
      await fLong.create();
      expect(await f.exists(), isTrue);
    });
    test('Directory sync operation', () async {
      Directory directory = new Directory('/foo');
      bool exceptionCaught = false;
      try {
        directory.statSync();
        // We shouldn't hit here.
        fail("Directory.statSync is expected to throw.");
      } on UnsupportedError catch (e) {
        exceptionCaught = true;
      }
      expect(exceptionCaught, isTrue);
    });
    test('Directory stat', () async {
      Directory directory =
          await Directory.systemTemp.createTemp('stat_test');
      FileStat fs = await directory.stat();
      expect(fs, isNotNull);
      expect(fs.modeString(), "rwx------");
      expect(fs.type, equals(FileSystemEntityType.DIRECTORY));
    });
    test('Directory list', () async {
      // Setup state.
      Directory directory =
        await Directory.systemTemp.createTemp('list_test');
      File f = new File('${directory.path}/child_file.txt');
      await f.create();
      Directory d = new Directory('${directory.path}/child_dir');
      await d.create();
      Directory d2 = new Directory('${d.path}/deeper_child_dir');
      await d2.create();


      // Non-recursive listing.
      List<String> paths = new List<String>();
      await for (FileSystemEntity entity in directory.list()) {
        paths.add(entity.path);
      }
      paths.sort();
      expect(paths.length, 4);
      expect(paths[0].endsWith('/.'), isTrue);
      expect(paths[1].endsWith('/..'), isTrue);
      expect(paths[2].endsWith('/child_dir'), isTrue);
      expect(paths[3].endsWith('/child_file.txt'), isTrue);

      // Recursive listing.
      paths.clear();
      await for (FileSystemEntity entity in directory.list(recursive: true)) {
        paths.add(entity.path);
      }
      paths.sort();
      expect(paths.length, 9);
      expect(paths[0].endsWith('/.'), isTrue);
      expect(paths[1].endsWith('/..'), isTrue);
      expect(paths[2].endsWith('/child_dir'), isTrue);
      expect(paths[3].endsWith('/child_dir/.'), isTrue);
      expect(paths[4].endsWith('/child_dir/..'), isTrue);
      expect(paths[5].endsWith('/child_dir/deeper_child_dir'), isTrue);
      expect(paths[6].endsWith('/child_dir/deeper_child_dir/.'), isTrue);
      expect(paths[7].endsWith('/child_dir/deeper_child_dir/..'), isTrue);
      expect(paths[8].endsWith('/child_file.txt'), isTrue);
    });
  });
}
