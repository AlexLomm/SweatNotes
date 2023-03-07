import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/layout.dart';
import 'data/models_client/exercise_day_client.dart';
import 'exercise_matrix.dart';
import 'exercise_matrix_labels.dart';
import 'services/normalize_data_service/normalize_data_service.dart';

class TrainingBlockScreen extends ConsumerStatefulWidget {
  final String trainingBlockId;

  const TrainingBlockScreen({
    Key? key,
    required this.trainingBlockId,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TrainingBlockScreenState();
}

class _TrainingBlockScreenState extends ConsumerState<TrainingBlockScreen> {
  late final Stream<List<ExerciseDayClient>> exerciseDaysStream;

  @override
  void initState() {
    super.initState();

    final normalizeDataService = ref.read(normalizeDataServiceProvider(
      widget.trainingBlockId,
    ));

    exerciseDaysStream = normalizeDataService.exerciseDays;
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      isGoBackButtonVisible: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          tooltip: 'Add new entry',
          splashRadius: 20,
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.edit_outlined,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          tooltip: 'Turn on edit mode',
          splashRadius: 20,
          onPressed: () {},
        ),
      ],
      child: StreamBuilder(
        stream: exerciseDaysStream,
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
