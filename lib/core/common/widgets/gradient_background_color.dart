// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

/// A Flutter widget that provides a gradient background color for its child.
class GradientBackgroundColor extends StatelessWidget {
  /// Creates a [GradientBackgroundColor] widget.
  ///
  /// The [gradient] parameter specifies the gradient that defines the background color.
  /// The [child] parameter is the widget to be displayed on top of the gradient background.
  ///
  /// The [key] parameter is an optional key that can be used to uniquely identify
  /// this widget in the widget tree.
  const GradientBackgroundColor({
    required this.gradient,
    required this.child,
    super.key,
  });

  /// The gradient that defines the background color of this widget.
  final Gradient gradient;

  /// The widget to be displayed on top of the gradient background.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: SafeArea(child: child),
    );
  }
}
