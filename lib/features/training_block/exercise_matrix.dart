import 'package:flutter/material.dart';

import 'data/models_client/exercise_day_client.dart';
import 'exercise_day_widget.dart';
import 'exercise_matrix_column.dart';
import 'exercise_type_widget.dart';

class ExerciseMatrix extends StatelessWidget {
  final List<ExerciseDayClient> exerciseDays;

  const ExerciseMatrix({
    Key? key,
    required this.exerciseDays,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: ExerciseTypeWidget.width + 16.0,
        top: ExerciseDayWidget.titleHeight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final exerciseDay in exerciseDays)
            ExerciseMatrixColumn(
              key: Key(exerciseDay.id),
              exerciseTypes: exerciseDay.exerciseTypes,
            ),
        ],
      ),
    );
  }
}
