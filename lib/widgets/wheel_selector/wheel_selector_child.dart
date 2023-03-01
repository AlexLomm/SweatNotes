import 'package:flutter/material.dart';

class WheelSelectorChild extends StatelessWidget {
  static double height = 36.0;

  final double width;
  final String value;

  const WheelSelectorChild({
    super.key,
    required this.width,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Text(
          value,
          softWrap: false,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}
