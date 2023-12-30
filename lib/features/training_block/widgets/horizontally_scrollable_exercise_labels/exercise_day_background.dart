import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tuple/tuple.dart';

import '../../../../app.dart';
import '../../../../router/router.dart';
import '../../../../widgets/custom_dismissible.dart';
import '../../data/models_client/exercise_day_client.dart';
import '../../data/models_client/training_block_client.dart';
import '../../services/training_blocks_service.dart';
import '../../widget_params.dart';
import '../ignore_pointer_edit_mode.dart';
import 'exercise_day_widget.dart';

class ExerciseDayBackground extends ConsumerWidget {
  final TrainingBlockClient trainingBlock;
  final ExerciseDayClient exerciseDay;
  final int count;
  final Function(DismissUpdateDetails details) onUpdate;

  const ExerciseDayBackground({
    super.key,
    required this.trainingBlock,
    required this.exerciseDay,
    required this.count,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context, ref) {
    final widgetParams = ref.watch(widgetParamsProvider);
    final trainingBlocksService = ref.watch(trainingBlocksServiceProvider);
    final messenger = ref.watch(messengerProvider);

    final heightWithoutButton = widgetParams.getExerciseLabelsHeight(count);

    return Align(
      alignment: Alignment.topLeft,
      child: _Background(
        id: exerciseDay.dbModel.pseudoId,
        width: widgetParams.exerciseLabelsListWidth,
        height: heightWithoutButton,
        borderRadius: widgetParams.borderRadius,
        onUpdate: onUpdate,
        onDismissed: (_) {
          trainingBlocksService.archiveExerciseDay(
            trainingBlock: trainingBlock,
            exerciseDay: exerciseDay,
            archive: true,
          );

          messenger?.clearSnackBars();
          messenger?.showSnackBar(
            SnackBar(
              content: Text(
                'Exercise day "${exerciseDay.name}" archived',
              ),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () => trainingBlocksService.archiveExerciseDay(
                  trainingBlock: trainingBlock,
                  exerciseDay: exerciseDay,
                  archive: false,
                ),
              ),
            ),
          );
        },
        child: IgnorePointerInEditMode(
          onTap: () => context.pushNamed(
            RouteNames.exerciseDayCreateUpdate,
            extra: Tuple2(
              trainingBlock.dbModel.id,
              exerciseDay,
            ),
          ),
          child: ExerciseDayWidget(
            exerciseDay: exerciseDay,
            trainingBlock: trainingBlock,
          ),
        ),
      ),
    );
  }
}

class _Background extends ConsumerWidget {
  final String id;
  final double height;
  final double width;
  final Widget child;
  final double borderRadius;
  final DismissUpdateCallback onUpdate;
  final DismissDirectionCallback onDismissed;

  const _Background({
    super.key,
    required this.id,
    required this.height,
    required this.width,
    required this.child,
    required this.borderRadius,
    required this.onUpdate,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedContainer(
      duration: WidgetParams.animationDuration,
      curve: WidgetParams.animationCurve,
      height: height,
      width: width,
      child: Material(
        elevation: 2,
        surfaceTintColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
          ),
        ),
        child: CustomDismissible(
          id: id,
          isEnabled: false,
          onUpdate: onUpdate,
          onDismissed: onDismissed,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }
}
