import 'package:flutter/material.dart';

import '../../../widgets/vertical_gradient.dart';

class VerticalDividerWithGradient extends StatelessWidget {
  final double? height;

  const VerticalDividerWithGradient({
    Key? key,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalGradient(
      height: height,
      child: Container(
        width: 1,
        height: height,
        color: Theme.of(context).colorScheme.outline.withOpacity(0.32),
      ),
    );
  }
}