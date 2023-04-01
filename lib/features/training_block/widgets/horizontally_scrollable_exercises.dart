import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/edit_mode_switcher.dart';
import '../widget_params.dart';
import '../data/models_client/exercise_day_client.dart';
import 'exercise_widget.dart';
import '../services/exercises_service.dart';
import 'ignore_pointer_edit_mode.dart';

class HorizontallyScrollableExercises extends ConsumerWidget {
  final ExerciseDayClient exerciseDay;

  const HorizontallyScrollableExercises({
    Key? key,
    required this.exerciseDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);
    final exercisesService = ref.watch(exercisesServiceProvider);
    final isEditMode = ref.watch(editModeSwitcherProvider);

    final exerciseTypes = exerciseDay.exerciseTypes.isEmpty ? [] : exerciseDay.exerciseTypes;

    final exerciseTypesCount = exerciseTypes.length;

    int numberOfExercisesPerExerciseType = 0;
    if (exerciseTypes.isNotEmpty && exerciseTypes.first.exercises.isNotEmpty) {
      numberOfExercisesPerExerciseType = exerciseTypes.first.exercises.length;
    }

    return AnimatedOpacity(
      opacity: isEditMode ? 0.32 : 1.0,
      duration: WidgetParams.animationDuration,
      curve: WidgetParams.animationCurve,
      child: IgnorePointerEditMode(
        ignoreWhenEditMode: true,
        child: AnimatedContainer(
          duration: WidgetParams.animationDuration,
          curve: WidgetParams.animationCurve,
          height: widgetParams.getExercisesHeight(exerciseTypesCount),
          margin: EdgeInsets.only(
            left: widgetParams.exercisesMarginLeft,
          ),
          child: ListView.builder(
            padding: EdgeInsets.only(
              right: widgetParams.exercisesSideSpacing,
              left: widgetParams.exercisesScrollInwardsDepth,
            ),
            // +1 is needed for the "add button" to be shown
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
                          height: widgetParams.getExerciseTypesListHeight(exerciseTypesCount),
                          margin: EdgeInsets.only(
                            top: widgetParams.exercisesTitleHeight,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.all(Radius.circular(widgetParams.borderRadius)),
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
                        margin: EdgeInsets.only(
                          top: widgetParams.exercisesTitleHeight,
                        ),
                        child: Column(
                          children: [
                            for (var verticalIndex = 0; verticalIndex < exerciseTypesCount; verticalIndex++)
                              Container(
                                margin: EdgeInsets.only(
                                  right: widgetParams.exercisesSideSpacing,
                                  bottom: widgetParams.exercisesMarginBottomNotLast,
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
