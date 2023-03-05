import 'package:flutter/material.dart';

import 'fade_gradient.dart';

class VerticalGradient extends StatelessWidget {
  final double? height;
  final Widget? child;

  const VerticalGradient({
    Key? key,
    this.height,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: child,
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: FadeGradient(
              width: 1,
              height: 46.0,
              direction: FadeGradientDirection.toBottom,
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: FadeGradient(
              width: 1,
              height: 46.0,
              direction: FadeGradientDirection.toTop,
            ),
          )
        ],
      ),
    );
  }
}
