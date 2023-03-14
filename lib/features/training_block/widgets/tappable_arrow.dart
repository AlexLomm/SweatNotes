import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import '../exercise_type_widget.dart';

enum TappableArrowDirection {
  up,
  down,
}

class TappableArrow extends StatelessWidget {
  final TappableArrowDirection direction;
  final bool isDisabled;
  final void Function() onTap;

  const TappableArrow({
    Key? key,
    required this.direction,
    required this.isDisabled,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      // even when disabled, the gesture detector should still prevent
      // the user from interacting with the underlying widget
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 24.0,
        width: ExerciseTypeWidget.dragHandleWidthExpanded,
        color: Colors.white.withOpacity(0.0001),
        child: AnimatedOpacity(
          opacity: isDisabled ? 0.32 : 1.0,
          duration: animationDuration,
          curve: animationCurve,
          child: Icon(
            direction == TappableArrowDirection.up ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
