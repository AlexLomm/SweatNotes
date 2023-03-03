import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models_client/exercise_day_client.dart';
import '../../services/normalize_data_service/normalize_data_service.dart';
import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../widgets/layout.dart';
import '../../widgets/wheel_selector/models/wheel_selector_value.dart';
import '../../widgets/wheel_selector/wheel_selector.dart';
import 'exercise_matrix.dart';
import 'exercise_matrix_labels.dart';

class TrainingBlockScreen extends ConsumerStatefulWidget {
  final String trainingBlockId;

  const TrainingBlockScreen({
    Key? key,
    required this.trainingBlockId,
  }) : super(key: key);

  @override
  TrainingBlockScreenState createState() => TrainingBlockScreenState();
}

class TrainingBlockScreenState extends ConsumerState<TrainingBlockScreen> {
  late final Future<List<ExerciseDayClient>> normalizedData;

  @override
  void initState() {
    super.initState();

    final normalizeDataService = ref.read(normalizeDataServiceProvider);

    normalizedData = normalizeDataService.getNormalizedData(
      trainingBlockId: widget.trainingBlockId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      floatingActionButton: FloatingActionButton(
        onPressed: () => CustomBottomSheet(
          height: 322.0,
          child: WheelSelector(
            convertIndexToValue: (index) {
              final value = index / 4;

              return WheelSelectorValue(label: '$value lb', value: value);
            },
            onValueChanged: (value) => print(value),
            childCount: 16,
          ),
        ).show(context),
        child: const Icon(Icons.abc),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: normalizedData,
            builder: (context, snapshot) {
              final exerciseDays = snapshot.data;

              if (exerciseDays == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
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
        ],
      ),
    );
  }
}
