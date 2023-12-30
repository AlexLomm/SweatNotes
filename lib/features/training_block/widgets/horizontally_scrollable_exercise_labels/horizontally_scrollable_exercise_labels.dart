import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings/show_archived_exercise_types_switcher.dart';
import '../../data/models_client/exercise_day_client.dart';
import '../../data/models_client/training_block_client.dart';
import '../../widget_params.dart';
import 'exercise_day_widget_with_tooltip.dart';

class HorizontallyScrollableExerciseLabels extends ConsumerWidget {
  final int listIndex;
  final ExerciseDayClient exerciseDay;
  final TrainingBlockClient trainingBlock;

  const HorizontallyScrollableExerciseLabels({
    super.key,
    required this.listIndex,
    required this.exerciseDay,
    // TODO: provide via riverpod?
    required this.trainingBlock,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);
    final showArchived = ref.watch(showArchivedExerciseTypesSwitcherProvider);

    final count = exerciseDay.exerciseTypes
        .where((et) => showArchived ? true : et.archivedAt == null)
        .length;

    return Container(
      margin: EdgeInsets.only(
        bottom: widgetParams.exercisesMarginBottom,
      ),
      child: ExerciseDayWidgetWithTooltip(
        isTooltipEnabled: listIndex == 0,
        count: count,
        listIndex: listIndex,
        trainingBlock: trainingBlock,
        exerciseDay: exerciseDay,
      ),
    );
  }
}
