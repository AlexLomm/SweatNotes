import 'package:flutter/material.dart';

class WheelSelectorHighlight extends StatelessWidget {
  final double width;
  final double height;

  const WheelSelectorHighlight({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        width: width,
        height: height,
        child: Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
