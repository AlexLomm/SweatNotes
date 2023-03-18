import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models_client/exercise_type_client.dart';
import '../services/exercises_service.dart';
import '../data/models_client/exercise_client.dart';
import '../../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../widget_params.dart';
import 'exercise_set_widget.dart';
import 'exercise_set_editor/exercise_set_editor.dart';

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

    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String trainingBlockId = routeArgs['trainingBlockId'];

    assert(trainingBlockId.isNotEmpty);

    final exercisesService = ref.watch(exercisesServiceProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(widgetParams.borderRadius)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: exercise.sets.asMap().entries.map((entry) {
          final set = entry.value;

          final repsNum = set.reps.isEmpty ? int.parse(set.predictedReps) : int.parse(set.reps);
          final loadNum = set.load.isEmpty ? double.parse(set.predictedLoad) : double.parse(set.load);

          return ExerciseSetWidget(
            key: UniqueKey(),
            onTap: () => CustomBottomSheet(
              title: 'Edit exercise set',
              child: ExerciseSetEditor(
                reps: repsNum,
                load: loadNum,
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
    );
  }
}
