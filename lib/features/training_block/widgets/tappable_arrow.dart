import 'dart:math';

import 'package:flutter/material.dart';

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
      child: Container(
        width: ExerciseTypeWidget.dragHandleWidth,
        height: ExerciseTypeWidget.dragHandleWidth,
        color: Colors.white.withOpacity(0.0001),
        child: Transform.rotate(
          angle: pi / 2,
          child: AnimatedOpacity(
            opacity: isDisabled ? 0.32 : 1.0,
            duration: animationDuration,
            curve: animationCurve,
            child: Icon(direction == TappableArrowDirection.up ? Icons.chevron_left : Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}
