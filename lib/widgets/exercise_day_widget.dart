import 'package:flutter/material.dart';
import 'package:journal_flutter/models_client/exercise_type_client.dart';

import 'exercise_type_widget.dart';
import 'exercise_widget.dart';

class ExerciseDayWidget extends StatelessWidget {
  static const titleHeight = 56.0;
  static const spacingBetweenExerciseTypes = 8.0;

  final String name;
  final List<ExerciseTypeClient> exerciseTypes;

  const ExerciseDayWidget({
    Key? key,
    required this.name,
    required this.exerciseTypes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: const EdgeInsets.only(top: 18, right: 16, left: 16),
            width: ExerciseTypeWidget.width - 24,
            height: exerciseTypes.length *
                    (ExerciseTypeWidget.height + spacingBetweenExerciseTypes) +
                titleHeight,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(103, 80, 164, 0.08),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 16,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(
              top: titleHeight,
              bottom: spacingBetweenExerciseTypes,
            ),
            child: Column(
              children: [
                for (final exerciseType in exerciseTypes)
                  Container(
                    key: Key(exerciseType.id),
                    margin: const EdgeInsets.only(right: 16),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ExerciseTypeWidget(exerciseType: exerciseType),
                    ),
                  )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(
              left: ExerciseTypeWidget.width + 16.0,
              top: titleHeight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final exerciseType in exerciseTypes)
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: spacingBetweenExerciseTypes,
                    ),
                    child: Row(
                      children: [
                        for (final exercise in exerciseType.exercises)
                          Container(
                            key: Key(exercise.id),
                            margin: const EdgeInsets.only(right: 16),
                            child: ExerciseWidget(exercise: exercise),
                          )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
