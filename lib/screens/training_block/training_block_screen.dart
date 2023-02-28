import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal_flutter/models_client/exercise_day_client.dart';
import 'package:journal_flutter/services/normalize_data_service.dart';
import 'package:journal_flutter/widgets/exercise_day_widget.dart';
import 'package:journal_flutter/widgets/layout.dart';

import '../../utils/print_json.dart';

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
        .getNormalizedData(trainingBlockId: widget.trainingBlockId)
        .then((value) {
      for (final exerciseDay in value) {
        printJson(exerciseDay.toJson());
      }

      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Training Block: ${widget.trainingBlockId}'),
          ElevatedButton(
            onPressed: () => GoRouter.of(context).go('/'),
            child: const Text('Go back'),
          ),
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
