import 'package:flutter/material.dart';

import 'data/models_client/exercise_type_client.dart';
import 'exercise_day_widget.dart';
import 'exercise_set_widget.dart';
import 'exercise_type_widget.dart';
import 'exercise_widget.dart';

class HorizontallyScrollableExercises extends StatelessWidget {
  static const double marginTop = ExerciseDayWidget.titleHeight;
  static const double marginLeft = ExerciseTypeWidget.width + 16.0;

  static const marginBottomNotLast = ExerciseDayWidget.spacingBetweenItems;
  static const marginBottomLast = marginBottomNotLast +
      ExerciseDayWidget.titleHeight +
      ExerciseDayWidget.additionalBottomSpaceHeight +
      ExerciseDayWidget.spaceForExerciseTypeButton +
      ExerciseDayWidget.marginBottom;

  static const spacingBetweenExercises = 16.0;

  final List<ExerciseTypeClient> exerciseTypes;

  const HorizontallyScrollableExercises({
    Key? key,
    required this.exerciseTypes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exerciseTypesCount = exerciseTypes.length;

    final height = ExerciseTypeWidget.height * exerciseTypesCount +
        marginBottomNotLast * (exerciseTypesCount - 1) +
        marginBottomLast;

    int numberOfExercisesPerExerciseType = 0;
    if (exerciseTypes.isNotEmpty && exerciseTypes.first.exercises.isNotEmpty) {
      numberOfExercisesPerExerciseType = exerciseTypes.first.exercises.length;
    }

    int numberOfExerciseSetsPerExercise = 0;
    if (exerciseTypes.isNotEmpty &&
        exerciseTypes.first.exercises.isNotEmpty &&
        exerciseTypes.first.exercises.first.exerciseSets.isNotEmpty) {
      numberOfExerciseSetsPerExercise = exerciseTypes.first.exercises.first.exerciseSets.length;
    }

    final exerciseWithoutMargin = ExerciseSetWidget.width * numberOfExerciseSetsPerExercise;
    final exerciseWithMargin = exerciseWithoutMargin + spacingBetweenExercises;

    return Container(
      height: height,
      margin: const EdgeInsets.only(
        left: marginLeft,
      ),
      child: ListView.builder(
        itemExtent: exerciseWithMargin,
        itemCount: numberOfExercisesPerExerciseType,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, j) {
          // the alignment is needed to prevent the underlying container
          // from being stretched to the `exerciseWithMargin` width (and
          // thereby losing border radius on the right) instead of being
          // of the `exerciseWithoutMargin` width
          return Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: exerciseWithoutMargin,
              margin: const EdgeInsets.only(
                top: marginTop,
              ),
              child: Column(
                children: [
                  for (var verticalIndex = 0; verticalIndex < exerciseTypesCount; verticalIndex++)
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: marginBottomNotLast,
                      ),
                      child: ExerciseWidget(
                        exercise: exerciseTypes[verticalIndex].exercises[j],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
