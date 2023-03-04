import 'package:flutter/material.dart';

import '../../../widgets/vertical_gradient.dart';

class VerticalDivider extends StatelessWidget {
  static const height = 128.0;

  const VerticalDivider({Key? key}) : super(key: key);

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
