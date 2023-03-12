import 'package:flutter/material.dart';

import 'data/models_client/exercise_type_client.dart';
import 'exercise_day_widget.dart';
import 'exercise_type_widget.dart';
import 'exercise_widget.dart';

class HorizontallyScrollableExercises extends StatelessWidget {
  static const double scrollInwardsDepth = 16.0;
  static const double marginTop = ExerciseDayWidget.titleHeight;
  static const double marginLeft = ExerciseTypeWidget.width - scrollInwardsDepth + 8.0;

  static const marginBottomNotLast = ExerciseDayWidget.spacingBetweenItems;
  static const marginBottomLast = marginBottomNotLast +
      ExerciseDayWidget.titleHeight +
      ExerciseDayWidget.additionalBottomSpaceHeight +
      ExerciseDayWidget.spaceForExerciseTypeButton +
      ExerciseDayWidget.marginBottom;

  static const spacingBetweenExercises = 16.0;

  final ScrollController? controller;
  final List<ExerciseTypeClient> exerciseTypes;

  const HorizontallyScrollableExercises({
    Key? key,
    required this.controller,
    required this.exerciseTypes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exerciseTypesCount = exerciseTypes.length;

    final exercisesHeight = ExerciseTypeWidget.height * exerciseTypesCount +
        HorizontallyScrollableExercises.marginBottomNotLast * (exerciseTypesCount - 1);

    final height = exercisesHeight + HorizontallyScrollableExercises.marginBottomLast;

    int numberOfExercisesPerExerciseType = 0;
    if (exerciseTypes.isNotEmpty && exerciseTypes.first.exercises.isNotEmpty) {
      numberOfExercisesPerExerciseType = exerciseTypes.first.exercises.length;
    }

    // int numberOfExerciseSetsPerExercise = 0;
    // if (exerciseTypes.isNotEmpty &&
    //     exerciseTypes.first.exercises.isNotEmpty &&
    //     exerciseTypes.first.exercises.first.exerciseSets.isNotEmpty) {
    //   numberOfExerciseSetsPerExercise = exerciseTypes.first.exercises.first.exerciseSets.length;
    // }

    return Container(
      height: height,
      margin: const EdgeInsets.only(
        left: HorizontallyScrollableExercises.marginLeft,
      ),
      child: ListView.builder(
        padding: const EdgeInsets.only(
          right: HorizontallyScrollableExercises.spacingBetweenExercises,
          left: HorizontallyScrollableExercises.scrollInwardsDepth,
        ),
        // itemExtent: exerciseWithMarginWidth,
        controller: controller,
        itemCount: numberOfExercisesPerExerciseType + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, j) {
          // the alignment is needed to prevent the underlying container
          // from being stretched to the `exerciseWithMargin` width (and
          // thereby losing border radius on the right) instead of being
          // of the `exerciseWithoutMargin` width
          return j == numberOfExercisesPerExerciseType && j > 0
              ? Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: HorizontallyScrollableExercises.marginTop,
                    ),
                    width: 50,
                    height: exercisesHeight,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                )
              : Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: HorizontallyScrollableExercises.marginTop,
                    ),
                    child: Column(
                      children: [
                        for (var verticalIndex = 0; verticalIndex < exerciseTypesCount; verticalIndex++)
                          Container(
                            margin: const EdgeInsets.only(
                              right: HorizontallyScrollableExercises.spacingBetweenExercises,
                              bottom: HorizontallyScrollableExercises.marginBottomNotLast,
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
