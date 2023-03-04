import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/training_block_store_service.dart';
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
      child: exerciseDaysAsyncValue.when(
        data: (data) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                // TODO: replace with ListView.builder https://www.youtube.com/watch?v=YY-_yrZdjGc&t=6s
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
