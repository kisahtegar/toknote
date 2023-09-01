import 'package:flutter/material.dart';

class GradientBackgroundColor extends StatelessWidget {
  const GradientBackgroundColor({
    required this.gradient,
    required this.child,
    super.key,
  });

  final Gradient gradient;
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
