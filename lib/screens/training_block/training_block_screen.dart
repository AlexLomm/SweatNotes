import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models_client/exercise_day_client.dart';
import '../../services/normalize_data_service/normalize_data_service.dart';
import '../../services/training_block_store_service.dart';
import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../widgets/layout.dart';
import '../../widgets/wheel_selector/models/wheel_selector_value.dart';
import '../../widgets/wheel_selector/wheel_selector.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(trainingBlockStoreService.notifier).clear(),
        child: const Icon(Icons.abc),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => CustomBottomSheet(
      //     height: 322.0,
      //     child: WheelSelector(
      //       convertIndexToValue: (index) {
      //         final value = index / 4;
      //
      //         return WheelSelectorValue(label: '$value lb', value: value);
      //       },
      //       onValueChanged: (value) => print(value),
      //       childCount: 16,
      //     ),
      //   ).show(context),
      //   child: const Icon(Icons.abc),
      // ),
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
        error: (err, stack) {
          print('ERROR');
          print(err);

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        loading: () {
          print('LOADING');

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
