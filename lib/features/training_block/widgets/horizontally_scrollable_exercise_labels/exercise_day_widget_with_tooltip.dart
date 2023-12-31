import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../../../settings/edit_mode_switcher.dart';
import '../../../settings/tutorial_settings.dart';
import '../../data/models_client/exercise_day_client.dart';
import '../../data/models_client/training_block_client.dart';
import '../../widget_params.dart';
import 'add_exercise_type_button_with_tooltip.dart';
import 'exercise_day_background.dart';
import 'exercise_types_list.dart';

class ExerciseDayWidgetWithTooltip extends ConsumerWidget {
  final bool isTooltipEnabled;
  final int count;
  final int listIndex;
  final TrainingBlockClient trainingBlock;
  final ExerciseDayClient exerciseDay;

  const ExerciseDayWidgetWithTooltip({
    super.key,
    required this.isTooltipEnabled,
    required this.count,
    required this.listIndex,
    required this.trainingBlock,
    required this.exerciseDay,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final child = _ExerciseDay(
      count: count,
      listIndex: listIndex,
      trainingBlock: trainingBlock,
      exerciseDay: exerciseDay,
    );

    if (!isTooltipEnabled) return child;

    final tutorialSettingsNotifier = ref.watch(
      tutorialSettingsProvider.notifier,
    );

    final isEditMode = ref.watch(editModeSwitcherProvider);
    final isExerciseDaySeen = ref.watch(tutorialSettingsProvider.select(
      (value) => value.isExerciseDaySeen,
    ));

    final showTooltip = !isEditMode && !isExerciseDaySeen;

    return TutorTooltip(
      active: showTooltip,
      order: orderExerciseDay,
      onClose: () => tutorialSettingsNotifier.set(
        (prevState) => prevState.copyWith(isExerciseDaySeen: true),
      ),
      buildTooltip: (_, childSize) => _Tooltip(childSize: childSize),
      buildChild: (_) => child,
    );
  }
}

class _Tooltip extends ConsumerWidget {
  final Size childSize;

  const _Tooltip({
    super.key,
    required this.childSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    return Transform.translate(
      offset: Offset(
        widgetParams.exerciseTypeWidth + 48,
        -childSize.height / 2 - 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              'This is an "exercise day" - a list of all the exercises for a given day',
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: GoogleFonts.indieFlower().fontFamily,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseDay extends ConsumerStatefulWidget {
  final int count;
  final int listIndex;
  final TrainingBlockClient trainingBlock;
  final ExerciseDayClient exerciseDay;

  const _ExerciseDay({
    super.key,
    required this.count,
    required this.listIndex,
    required this.trainingBlock,
    required this.exerciseDay,
  });

  @override
  ConsumerState<_ExerciseDay> createState() => _ExerciseDayState();
}

class _ExerciseDayState extends ConsumerState<_ExerciseDay> {
  double _dismissProgress = 0;

  @override
  Widget build(BuildContext context) {
    ref.listen(editModeSwitcherProvider, (_, isEditMode) {
      if (!isEditMode) setState(() => _dismissProgress = 0);
    });

    final widgetParams = ref.watch(widgetParamsProvider);
    final heightWithButton = widgetParams.getExerciseLabelsHeightWithButton(
      widget.count,
    );

    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: AnimatedContainer(
            duration: WidgetParams.animationDuration,
            curve: WidgetParams.animationCurve,
            width: widgetParams.exerciseLabelsListWidth,
            height: heightWithButton,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ExerciseDayBackground(
                    trainingBlock: widget.trainingBlock,
                    exerciseDay: widget.exerciseDay,
                    count: widget.count,
                    onUpdate: (details) => setState(
                      () => _dismissProgress = details.progress,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AddExerciseTypeButtonWithTooltip(
                    isTooltipEnabled: widget.listIndex == 0,
                    trainingBlock: widget.trainingBlock,
                    exerciseDay: widget.exerciseDay,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Opacity(
            opacity: (1.0 - _dismissProgress).clamp(0, 1),
            child: ExerciseTypesList(
              isTutorialEnabled: widget.listIndex == 0,
              trainingBlock: widget.trainingBlock,
              exerciseDay: widget.exerciseDay,
            ),
          ),
        ),
      ],
    );
  }
}
