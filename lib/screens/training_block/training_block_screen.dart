import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal_flutter/services/normalize_data_service.dart';
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
  @override
  void initState() {
    super.initState();

    NormalizeDataService()
        .getNormalizedData(trainingBlockId: widget.trainingBlockId)
        .then((value) {
      for (final exerciseDay in value) {
        printJson(exerciseDay.toJson());
      }
    });
  }

  @override
  void dispose() {
    // trainingBlockState.dispose();
    // normalizeDataState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Center(
        child: Column(
          children: [
            Text('Training Block: ${widget.trainingBlockId}'),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).go('/'),
              child: const Text('Go back'),
            )
          ],
        ),
      ),
      // child: ExerciseDayWidget(name: 'Push 1'),
    );
  }
}
