import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sweatnotes/features/settings/edit_mode_switcher.dart';
import 'package:sweatnotes/features/training_block/data/models_client/training_block_client.dart';
import 'package:tuple/tuple.dart';

import '../../router/router.dart';
import 'widget_params.dart';

class AddExerciseDayButton extends ConsumerWidget {
  final TrainingBlockClient trainingBlock;

  const AddExerciseDayButton({
    super.key,
    required this.trainingBlock,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeSwitcherProvider);

    return AnimatedOpacity(
      opacity: isEditMode ? 0 : 1,
      duration: WidgetParams.animationDuration,
      curve: WidgetParams.animationCurve,
      child: IconButton(
        icon: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        tooltip: 'Add new entry',
        splashRadius: 20,
        onPressed: isEditMode
            ? null
            : () => context.pushNamed(
                  RouteNames.exerciseDayCreateUpdate,
                  extra: Tuple2(trainingBlock.dbModel.id, null),
                ),
      ),
    );
  }
}
