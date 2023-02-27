import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:journal_flutter/services/normalize_data_service.dart';
import 'package:journal_flutter/widgets/layout.dart';

import '../../services/training_block_state.dart';

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
  late TrainingBlockState trainingBlockState;
  late NormalizeDataService normalizeDataState;

  @override
  void initState() {
    super.initState();
    // trainingBlockState = TrainingBlockState(
    //   trainingBlockId: widget.trainingBlockId,
    // );
    // normalizeDataState = NormalizeData(
    //   trainingBlockId: widget.trainingBlockId,
    // )..normalizeData.listen((event) {
    //     print(event);
    //   });

    NormalizeDataService().getNormalizedData(trainingBlockId: widget.trainingBlockId);
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
