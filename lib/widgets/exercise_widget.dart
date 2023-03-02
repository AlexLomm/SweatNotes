import 'package:flutter/material.dart';

import '../models_client/exercise_client.dart';
import '../widgets/exercise_set_widget.dart';

class ExerciseWidget extends StatelessWidget {
  static const borderRadius = Radius.circular(8);

  final ExerciseClient exercise;

  const ExerciseWidget({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(borderRadius),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(children: [
        for (final entry in exercise.exerciseSets.asMap().entries)
          ExerciseSetWidget(
            key: UniqueKey(),
            exerciseSet: entry.value,
            isSingle: exercise.exerciseSets.length == 1,
            isLeftmost: entry.key == 0,
            isRightmost: entry.key == exercise.exerciseSets.length - 1,
          ),
      ]),
    );
  }
}
