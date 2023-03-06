import 'package:flutter/material.dart';

import 'data/models_client/exercise_type_client.dart';
import 'exercise_day_widget.dart';
import 'exercise_matrix_labels.dart';
import 'exercise_matrix_row.dart';

class ExerciseMatrixColumn extends StatelessWidget {
  final List<ExerciseTypeClient> exerciseTypes;

  const ExerciseMatrixColumn({
    Key? key,
    required this.exerciseTypes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const marginBottomRegular = ExerciseDayWidget.spacingBetweenItems;

    const marginBottomLast = marginBottomRegular +
        ExerciseDayWidget.titleHeight +
        ExerciseDayWidget.additionalBottomSpaceHeight +
        ExerciseMatrixLabels.spacingBetweenItems;

    return Column(
      children: [
        for (final entry in exerciseTypes.asMap().entries)
          Container(
            key: Key(entry.value.id),
            margin: EdgeInsets.only(
              bottom: entry.key == exerciseTypes.length - 1
                  ? marginBottomLast
                  : marginBottomRegular,
            ),
            child: ExercisesMatrixRow(exercises: entry.value.exercises),
          )
      ],
    );
  }
}
