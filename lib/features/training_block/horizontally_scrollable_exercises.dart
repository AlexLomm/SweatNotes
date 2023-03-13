import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_flutter/features/settings/edit_mode_switcher.dart';

import 'data/models_client/exercise_day_client.dart';
import 'horizontally_scrollable_exercise_labels.dart';
import 'exercise_type_widget.dart';
import 'exercise_widget.dart';
import 'services/exercises_service.dart';

class HorizontallyScrollableExercises extends ConsumerWidget {
  static const double scrollInwardsDepth = 16.0;
  static const double marginTop = HorizontallyScrollableExerciseLabels.titleHeight;
  static const double marginLeft = ExerciseTypeWidget.width - scrollInwardsDepth + 8.0;

  static const marginBottomNotLast = HorizontallyScrollableExerciseLabels.spacingBetweenItems;
  static const marginBottomLast = marginBottomNotLast +
      HorizontallyScrollableExerciseLabels.titleHeight +
      HorizontallyScrollableExerciseLabels.additionalBottomSpaceHeight +
      HorizontallyScrollableExerciseLabels.spaceForExerciseTypeButton +
      HorizontallyScrollableExerciseLabels.marginBottom;

  static const spacingBetweenExercises = 16.0;

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

    final exercisesHeight = ExerciseTypeWidget.height * exerciseTypesCount +
        HorizontallyScrollableExercises.marginBottomNotLast * (exerciseTypesCount - 1);

    final height = exercisesHeight + HorizontallyScrollableExercises.marginBottomLast;

    int numberOfExercisesPerExerciseType = 0;
    if (exerciseTypes.isNotEmpty && exerciseTypes.first.exercises.isNotEmpty) {
      numberOfExercisesPerExerciseType = exerciseTypes.first.exercises.length;
    }

    return AnimatedOpacity(
      opacity: isEditMode ? 0.32 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: isEditMode,
        child: Container(
          height: height,
          margin: const EdgeInsets.only(
            left: HorizontallyScrollableExercises.marginLeft,
          ),
          child: ListView.builder(
            padding: const EdgeInsets.only(
              right: HorizontallyScrollableExercises.spacingBetweenExercises,
              left: HorizontallyScrollableExercises.scrollInwardsDepth,
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
                        onTap: () => exercisesService.addEmptyExercise(exerciseDay: exerciseDay),
                        child: Container(
                          width: 48,
                          height: exercisesHeight,
                          margin: const EdgeInsets.only(
                            top: HorizontallyScrollableExercises.marginTop,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
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
        ),
      ),
    );
  }
}
