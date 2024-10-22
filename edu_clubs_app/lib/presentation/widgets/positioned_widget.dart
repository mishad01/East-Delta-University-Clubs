import 'package:flutter/material.dart';

class PositionedWidget extends StatelessWidget {
  const PositionedWidget({
    super.key,
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.child,
  });
  final double? top, left, right, bottom;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left ?? 0,
      right: right ?? 0,
      bottom: bottom,
      child: child,
    );
  }
}
