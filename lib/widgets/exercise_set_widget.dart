import 'package:flutter/material.dart';

import '../models_client/exercise_set_client.dart';
import 'exercise_type_widget.dart';

class ExerciseSetWidget extends StatelessWidget {
  static const width = 75.0;
  static const borderRadius = Radius.circular(8);
  static const borderSide = BorderSide(color: Colors.black12, width: 1);

  final bool isSingle;
  final bool isLeftmost;
  final bool isRightmost;
  final ExerciseSetClient exerciseSet;

  get _borderTopCell {
    return Border(
      right: isSingle || isRightmost ? BorderSide.none : borderSide,
      bottom: borderSide,
    );
  }

  get _borderBottomCell {
    final rightSide = isSingle || isRightmost ? BorderSide.none : borderSide;

    return Border(right: rightSide);
  }

  const ExerciseSetWidget({
    Key? key,
    this.isSingle = false,
    this.isLeftmost = false,
    this.isRightmost = false,
    required this.exerciseSet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color.fromRGBO(231, 224, 236, 1);

    return SizedBox(
      width: width,
      height: ExerciseTypeWidget.height,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              border: _borderTopCell,
            ),
            height: ExerciseTypeWidget.height / 2,
            child: Center(
              child: Text(
                exerciseSet.reps,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              border: _borderBottomCell,
            ),
            height: ExerciseTypeWidget.height / 2,
            child: Center(
              child: Text(
                exerciseSet.load,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
