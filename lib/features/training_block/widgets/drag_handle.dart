import 'package:flutter/material.dart';

import '../constants.dart';

class DragHandle extends StatelessWidget {
  final double width;

  const DragHandle({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      curve: animationCurve,
      height: double.infinity,
      width: width,
      // this color is needed in order for the entire Container to
      // be tappable. Otherwise, the tap area is only the icon
      color: Colors.white.withOpacity(0.0001),
      child: Icon(
        Icons.drag_indicator,
        color: Theme.of(context).colorScheme.outline,
      ),
    );
  }
}
