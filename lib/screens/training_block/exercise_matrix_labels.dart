import 'package:flutter/material.dart';

import '../../models_client/exercise_day_client.dart';
import '../../widgets/exercise_day_widget.dart';

class ExerciseMatrixLabels extends StatelessWidget {
  static const spacingBetweenItems = 24.0;

  final List<ExerciseDayClient> exerciseDays;

  const ExerciseMatrixLabels({
    Key? key,
    required this.exerciseDays,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final exerciseDay in exerciseDays)
          Container(
            key: Key(exerciseDay.id),
            margin: const EdgeInsets.only(bottom: spacingBetweenItems),
            child: ExerciseDayWidget(
              name: exerciseDay.name,
              exerciseTypes: exerciseDay.exerciseTypes,
            ),
          ),
      ],
    );
  }
}
