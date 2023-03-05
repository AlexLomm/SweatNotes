import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/normalize_data_service/normalize_data_service.dart';
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
    final normalizeDataService = ref.watch(normalizeDataServiceProvider(
      trainingBlockId,
    ));

    return Layout(
      child: StreamBuilder(
        stream: normalizeDataService.exerciseDays,
        builder: (context, snapshot) {
          final exerciseDays = snapshot.data;

          if (exerciseDays == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                // TODO: replace with ListView.builder https://www.youtube.com/watch?v=YY-_yrZdjGc&t=6s
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ExerciseMatrix(exerciseDays: exerciseDays),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: ExerciseMatrixLabels(exerciseDays: exerciseDays),
              ),
            ],
          );
        },
      ),
    );
  }
}
