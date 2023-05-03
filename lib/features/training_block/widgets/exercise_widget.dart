import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweatnotes/widgets/reaction_menu.dart';

import '../../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../settings/exercise_reactions_switcher.dart';
import '../data/models_client/exercise_client.dart';
import '../data/models_client/exercise_type_client.dart';
import '../services/exercises_service.dart';
import '../widget_params.dart';
import 'exercise_set_editor/exercise_set_editor.dart';
import 'exercise_set_widget.dart';

class ExerciseWidget extends ConsumerWidget {
  final ExerciseTypeClient exerciseType;
  final ExerciseClient exercise;

  const ExerciseWidget({
    Key? key,
    required this.exerciseType,
    required this.exercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);
    final isExerciseReactionsEnabled = ref.watch(exerciseReactionsSwitcherProvider);

    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String trainingBlockId = routeArgs['trainingBlockId'];

    assert(trainingBlockId.isNotEmpty);

    final exercisesService = ref.watch(exercisesServiceProvider);

    final allExerciseSetsWidth = widgetParams.exerciseSetWidth * exercise.sets.length;

    return AnimatedContainer(
      duration: WidgetParams.animationDuration,
      width: isExerciseReactionsEnabled
          ? allExerciseSetsWidth + widgetParams.reactionCircleSize / 2
          : allExerciseSetsWidth,
      height: widgetParams.exerciseTypeHeight,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: allExerciseSetsWidth,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(widgetParams.borderRadius)),
              ),
              child: Row(
                children: exercise.sets.asMap().entries.map((entry) {
                  final set = entry.value;

                  final repsInitial = set.reps == 0 ? set.predictedReps : set.reps;
                  final loadInitial = set.load == 0 ? set.predictedLoad : set.load;

                  return ExerciseSetWidget(
                    key: UniqueKey(),
                    onTap: () => CustomBottomSheet(
                      title: 'Edit exercise set',
                      child: ExerciseSetEditor(
                        reps: repsInitial,
                        load: loadInitial,
                        onChange: ({required reps, required load}) {
                          exercisesService.setExerciseSet(
                            exerciseType: exerciseType,
                            exercise: exercise,
                            exerciseSetIndex: entry.key,
                            reps: reps,
                            load: load,
                          );

                          Navigator.of(context).pop();
                        },
                      ),
                    ).show(context),
                    exerciseSet: set,
                    isSingle: exercise.sets.length == 1,
                    isRightmost: entry.key == exercise.sets.length - 1,
                  );
                }).toList(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IgnorePointer(
              ignoring: !isExerciseReactionsEnabled,
              child: AnimatedOpacity(
                opacity: isExerciseReactionsEnabled ? 1 : 0,
                duration: WidgetParams.animationDuration,
                curve: WidgetParams.animationCurve,
                child: ReactionMenu(
                  selectedReaction: exercise.reactionScore,
                  onSelect: (int? reactionScore) {
                    exercisesService.setExerciseReaction(
                      exerciseType: exerciseType,
                      exercise: exercise,
                      reactionScore: reactionScore,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
