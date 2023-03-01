import 'package:flutter/material.dart';

import '../../models_client/exercise_day_client.dart';
import '../../services/normalize_data_service.dart';
import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../widgets/exercise_day_widget.dart';
import '../../widgets/layout.dart';
import '../../widgets/wheel_selector/models/wheel_selector_value.dart';
import '../../widgets/wheel_selector/wheel_selector.dart';

class TrainingBlockScreen extends StatefulWidget {
  final String trainingBlockId;

  const TrainingBlockScreen({
    Key? key,
    required this.trainingBlockId,
  }) : super(key: key);

  @override
  State<TrainingBlockScreen> createState() => _TrainingBlockScreenState();
}

class _TrainingBlockScreenState extends State<TrainingBlockScreen> {
  late final Future<List<ExerciseDayClient>> normalizedData;

  @override
  void initState() {
    super.initState();

    normalizedData = NormalizeDataService()
        .getNormalizedData(trainingBlockId: widget.trainingBlockId);
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

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final exerciseDay in exerciseDays)
                    Container(
                      key: Key(exerciseDay.id),
                      margin: const EdgeInsets.only(bottom: 24.0),
                      child: ExerciseDayWidget(
                        name: exerciseDay.name,
                        exerciseTypes: exerciseDay.exerciseTypes,
                      ),
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
