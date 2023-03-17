import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_flutter/features/settings/edit_mode_switcher.dart';

import '../constants.dart';
import '../data/models_client/exercise_day_client.dart';
import 'exercise_widget.dart';
import '../services/exercises_service.dart';
import 'ignore_pointer_edit_mode.dart';

class HorizontallyScrollableExercises extends ConsumerWidget {
  static const exercisesScrollContainerSpacingBetweenExercises = 16.0;

  final ExerciseDayClient exerciseDay;

  const HorizontallyScrollableExercises({
    Key? key,
    required this.exerciseDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesService = ref.watch(exercisesServiceProvider);
    final isEditMode = ref.watch(editModeSwitcherProvider);

    final exerciseTypes = exerciseDay.exerciseTypes.isEmpty ? [] : exerciseDay.exerciseTypes;

    final exerciseTypesCount = exerciseTypes.length;

    final exercisesHeight = etHeight * exerciseTypesCount + escMarginBottomNotLast * (exerciseTypesCount - 1);

    final height = exercisesHeight + escMarginBottomLast;

    int numberOfExercisesPerExerciseType = 0;
    if (exerciseTypes.isNotEmpty && exerciseTypes.first.exercises.isNotEmpty) {
      numberOfExercisesPerExerciseType = exerciseTypes.first.exercises.length;
    }

    return AnimatedOpacity(
      opacity: isEditMode ? 0.32 : 1.0,
      duration: animationDuration,
      curve: animationCurve,
      child: IgnorePointerEditMode(
        ignoreWhenEditMode: true,
        child: Container(
          height: height,
          margin: const EdgeInsets.only(
            left: escMarginLeft,
          ),
          child: ListView.builder(
            padding: const EdgeInsets.only(
              right: exercisesScrollContainerSpacingBetweenExercises,
              left: escInwardsDepth,
            ),
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
                      child: GestureDetector(
                        onTap: () => exercisesService.addEmptyExercise(exerciseType: exerciseTypes.first),
                        child: Container(
                          width: 48,
                          height: exercisesHeight,
                          margin: const EdgeInsets.only(
                            top: escMarginTop,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: escMarginTop,
                        ),
                        child: Column(
                          children: [
                            for (var verticalIndex = 0; verticalIndex < exerciseTypesCount; verticalIndex++)
                              Container(
                                margin: const EdgeInsets.only(
                                  right: exercisesScrollContainerSpacingBetweenExercises,
                                  bottom: escMarginBottomNotLast,
                                ),
                                child: ExerciseWidget(
                                  exerciseType: exerciseTypes[verticalIndex],
                                  exercise: exerciseTypes[verticalIndex].exercises[j],
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
