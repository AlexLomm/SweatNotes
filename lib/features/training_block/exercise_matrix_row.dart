import 'package:flutter/material.dart';

import 'data/models_client/exercise_client.dart';
import 'exercise_widget.dart';

class ExercisesMatrixRow extends StatelessWidget {
  static const marginRight = 16.0;

  final List<ExerciseClient> exercises;

  const ExercisesMatrixRow({Key? key, required this.exercises}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final exercise in exercises)
          Container(
            key: Key(exercise.id),
            margin: const EdgeInsets.only(right: marginRight),
            child: ExerciseWidget(exercise: exercise),
          )
      ],
    );
  }
}
