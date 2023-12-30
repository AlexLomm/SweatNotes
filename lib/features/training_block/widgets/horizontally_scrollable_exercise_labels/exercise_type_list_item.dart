import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweatnotes/features/training_block/data/models_client/training_block_client.dart';

import '../../data/models_client/exercise_type_client.dart';
import '../../widget_params.dart';
import '../exercise_type_widget.dart';

class ExerciseTypeListItem extends ConsumerWidget {
  final int index;
  final TrainingBlockClient trainingBlock;
  final ExerciseTypeClient exerciseType;

  const ExerciseTypeListItem({
    super.key,
    required this.index,
    required this.trainingBlock,
    required this.exerciseType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    return Container(
      margin: EdgeInsets.only(
        bottom: widgetParams.exerciseTypesVerticalSpacing,
      ),
      child: ExerciseTypeWidget(
        index: index,
        trainingBlock: trainingBlock,
        exerciseDays: trainingBlock.exerciseDays,
        exerciseType: exerciseType,
      ),
    );
  }
}
