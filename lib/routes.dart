// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/material.dart';


typedef PathWidgetBuilder = Widget Function(BuildContext, String?);

class Path {
  const Path(this.pattern, this.builder, {this.openInSecondScreen = false});

  /// A RegEx string for route matching.
  final String pattern;

  /// The builder for the associated pattern route. The first argument is the
  /// [BuildContext] and the second argument a RegEx match if that is included
  /// in the pattern.
  ///
  /// ```dart
  /// Path(
  ///   'r'^/demo/([\w-]+)$',
  ///   (context, matches) => Page(argument: match),
  /// )
  /// ```
  final PathWidgetBuilder builder;

  /// If the route should open on the second screen on foldables.
  final bool openInSecondScreen;
}


class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required super.builder,
    super.settings,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

class TwoPanePageRoute<T> extends OverlayRoute<T> {
  TwoPanePageRoute({
    required this.builder,
    super.settings,
  });

  final WidgetBuilder builder;

  @override
  Iterable<OverlayEntry> createOverlayEntries() sync* {
    yield OverlayEntry(builder: (context) {
      final hinge = MediaQuery.of(context).hinge?.bounds;
      if (hinge == null) {
        return builder.call(context);
      } else {
        return Positioned(
            top: 0,
            left: hinge.right,
            right: 0,
            bottom: 0,
            child: builder.call(context));
      }
    });
  }
}
