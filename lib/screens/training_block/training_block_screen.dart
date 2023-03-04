import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_flutter/screens/training_block/exercise_set_editor/exercise_set_editor.dart';

import '../../services/training_block_store_service.dart';
import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../widgets/layout.dart';
import 'exercise_matrix.dart';
import 'exercise_matrix_labels.dart';

class TrainingBlockScreen extends ConsumerWidget {
  final String trainingBlockId;

  const TrainingBlockScreen({
    Key? key,
    required this.trainingBlockId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingBlockStoreService = trainingBlockStoreServiceProvider(
      trainingBlockId,
    );

    final exerciseDaysAsyncValue = ref.watch(trainingBlockStoreService);

    return Layout(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => ref.read(trainingBlockStoreService.notifier).clear(),
      //   child: const Icon(Icons.abc),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => CustomBottomSheet(
          height: 322.0,
          child: ExerciseSetEditor(
            reps: 10,
            load: 102.25,
            onChange: ({required reps, required load}) {
              print('-------------------------------------');
              print('reps: $reps, load: $load');
            },
          ),
        ).show(context),
        child: const Icon(Icons.abc),
      ),
      child: exerciseDaysAsyncValue.when(
        data: (data) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ExerciseMatrix(exerciseDays: data),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: ExerciseMatrixLabels(exerciseDays: data),
              ),
            ],
          );
        },
        error: (e, _) => Center(child: Text('Uh oh! Something went wrong: $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
