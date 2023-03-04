import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models_client/exercise_client.dart';
import '../../services/training_block_store_service.dart';
import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import 'exercise_set_editor/exercise_set_editor.dart';
import 'exercise_set_widget.dart';

class ExerciseWidget extends ConsumerWidget {
  static const borderRadius = Radius.circular(8);

  final ExerciseClient exercise;

  const ExerciseWidget({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String trainingBlockId = routeArgs['trainingBlockId'];

    assert(trainingBlockId.isNotEmpty);

    final trainingBlockStore = ref.watch(
      trainingBlockStoreServiceProvider(trainingBlockId).notifier,
    );

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(borderRadius),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: exercise.exerciseSets.asMap().entries.map((entry) {
          final repsNum =
              entry.value.reps.isEmpty ? 0 : int.parse(entry.value.reps);

          final loadNum =
              entry.value.load.isEmpty ? 0.0 : double.parse(entry.value.load);

          return ExerciseSetWidget(
            key: UniqueKey(),
            onTap: () => CustomBottomSheet(
              height: 322.0,
              child: SingleChildScrollView(
                child: ExerciseSetEditor(
                  reps: repsNum,
                  load: loadNum,
                  onChange: ({required reps, required load}) {
                    trainingBlockStore.setExerciseSet(
                      exercise: exercise,
                      reps: reps,
                      load: load,
                      index: entry.key,
                    );

                    Navigator.of(context).pop();
                  },
                ),
              ),
            ).show(context),
            exerciseSet: entry.value,
            isSingle: exercise.exerciseSets.length == 1,
            isLeftmost: entry.key == 0,
            isRightmost: entry.key == exercise.exerciseSets.length - 1,
          );
        }).toList(),
      ),
    );
  }
}
