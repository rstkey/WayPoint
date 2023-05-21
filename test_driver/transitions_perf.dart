// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:waypoint/main.dart';

// See transitions_perf_test.dart for how to run this test.

Future<String> _handleMessages(String? message) async {
  switch (message) {
    case 'isTestingCraneOnly':
      return const String.fromEnvironment('onlyCrane', defaultValue: 'false');
    case 'isTestingReplyOnly':
      return const String.fromEnvironment('onlyReply', defaultValue: 'false');
    default:
      throw 'unknown message';
  }
}

void main() {
  enableFlutterDriverExtension(handler: _handleMessages);
  runApp(const App(isTestMode: true));
}
