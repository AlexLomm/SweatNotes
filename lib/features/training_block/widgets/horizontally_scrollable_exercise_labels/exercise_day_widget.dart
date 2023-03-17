import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings/edit_mode_switcher.dart';
import '../../widget_params.dart';
import '../../data/models_client/exercise_day_client.dart';
import '../../data/models_client/training_block_client.dart';
import '../../services/training_blocks_service.dart';
import '../tappable_arrow.dart';

class ExerciseDayWidget extends ConsumerStatefulWidget {
  final TrainingBlockClient trainingBlock;
  final ExerciseDayClient exerciseDay;

  const ExerciseDayWidget({
    Key? key,
    required this.trainingBlock,
    required this.exerciseDay,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ExerciseDayState();
}

class _ExerciseDayState extends ConsumerState<ExerciseDayWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final widgetParams = ref.watch(widgetParamsProvider);
    final isEditMode = ref.watch(editModeSwitcherProvider);

    final indexOfExerciseDay = widget.trainingBlock.indexOfExerciseDay(widget.exerciseDay);
    final isFirst = indexOfExerciseDay == 0;
    final isLast = indexOfExerciseDay == widget.trainingBlock.exerciseDays.length - 1;

    return Align(
      alignment: Alignment.topLeft,
      child: AnimatedContainer(
        height: 56.0,
        duration: WidgetParams.animationDuration,
        curve: WidgetParams.animationCurve,
        padding: EdgeInsets.only(
          left: widgetParams.exercisesTitlePaddingLeft,
          right: widgetParams.exercisesTitlePaddingRight,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: WidgetParams.animationDuration,
              curve: WidgetParams.animationCurve,
              // TODO: ??
              opacity: isEditMode ? 1.0 : 0.0,
              child: AnimatedContainer(
                duration: WidgetParams.animationDuration,
                curve: WidgetParams.animationCurve,
                padding: const EdgeInsets.only(top: 4.0),
                width: widgetParams.exerciseTypeDragHandleWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TappableArrow(
                      direction: TappableArrowDirection.up,
                      isDisabled: isLoading || isFirst,
                      onTap: () => _moveExerciseDayBy(-1),
                    ),
                    TappableArrow(
                      direction: TappableArrowDirection.down,
                      isDisabled: isLoading || isLast,
                      onTap: () => _moveExerciseDayBy(1),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              duration: WidgetParams.animationDuration,
              curve: WidgetParams.animationCurve,
              width: widgetParams.exerciseLabelsTitleWidth,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(isEditMode ? 1.0 : 0.0),
                    width: 1.0,
                  ),
                ),
              ),
              child: AutoSizeText(
                widget.exerciseDay.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                minFontSize: Theme.of(context).textTheme.titleSmall!.fontSize!,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _moveExerciseDayBy(int moveBy) async {
    setState(() => isLoading = true);

    final trainingBlocksService = ref.read(trainingBlocksServiceProvider);

    try {
      await trainingBlocksService.moveExerciseDay(
        trainingBlock: widget.trainingBlock,
        exerciseDay: widget.exerciseDay,
        moveBy: moveBy,
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    setState(() => isLoading = false);
  }
}
