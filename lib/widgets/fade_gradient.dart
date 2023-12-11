import 'package:flutter/material.dart';

enum FadeGradientDirection { toTop, toBottom }

class FadeGradient extends StatelessWidget {
  final double width;
  final double height;
  final FadeGradientDirection direction;

  const FadeGradient({
    super.key,
    required this.width,
    required this.height,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    final begin = direction == FadeGradientDirection.toTop
        ? Alignment.bottomCenter
        : Alignment.topCenter;

    final end = direction == FadeGradientDirection.toTop
        ? Alignment.topCenter
        : Alignment.bottomCenter;

    return IgnorePointer(
      child: SizedBox(
        width: width,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.surface.withOpacity(0.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
