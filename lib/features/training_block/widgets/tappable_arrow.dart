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
          child: Center(
            // using SVGs instead of icons because the icons are
            // shifted to the bottom when used with `Transform.rotate`
            // and when their container's size becomes smaller
            child: SvgPicture.asset(
              direction == TappableArrowDirection.up ? 'assets/chevron-up.svg' : 'assets/chevron-down.svg',
              width: 24.0,
              height: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
