import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../../../widgets/rounded_icon_button.dart';
import '../../../../widgets/text_editor_single_line.dart';
import '../../../../widgets/text_editor_single_line_and_wheel.dart';
import '../../../settings/edit_mode_switcher.dart';
import '../../widget_params.dart';
import '../../data/models_client/exercise_day_client.dart';
import '../../data/models_client/training_block_client.dart';
import '../../services/exercise_days_service.dart';
import '../../services/exercise_types_service.dart';
import '../ignore_pointer_edit_mode.dart';
import 'exercise_day_widget.dart';
import 'exercise_types_list.dart';

class HorizontallyScrollableExerciseLabels extends ConsumerWidget {
  final ExerciseDayClient exerciseDay;
  final TrainingBlockClient trainingBlock;

  get isEmpty => exerciseDay.exerciseTypes.isEmpty;

  const HorizontallyScrollableExerciseLabels({
    Key? key,
    required this.exerciseDay,
    // TODO: provide via riverpod?
    required this.trainingBlock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);
    final isEditMode = ref.watch(editModeSwitcherProvider);

    final heightWithButton = widgetParams.getExerciseLabelsHeightWithButton(
      exerciseDay.exerciseTypes.length,
    );

    final heightWithoutButton = widgetParams.getExerciseLabelsHeight(
      exerciseDay.exerciseTypes.length,
    );

    return Container(
      margin: EdgeInsets.only(
        bottom: widgetParams.exercisesMarginBottom,
      ),
      child: Stack(
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
                    alignment: Alignment.topLeft,
                    child: _Background(
                      width: widgetParams.exerciseLabelsListWidth,
                      height: heightWithoutButton,
                      borderRadius: WidgetParams.borderRadius,
                      child: IgnorePointerEditMode(
                        onTap: () => CustomBottomSheet(
                          height: CustomBottomSheet.allSpacing + TextEditorSingleLine.height,
                          title: 'Edit exercise day',
                          child: _TextEditorSingleLineWrapper(
                            trainingBlock: trainingBlock,
                            exerciseDay: exerciseDay,
                          ),
                        ).show(context),
                        child: ExerciseDayWidget(
                          exerciseDay: exerciseDay,
                          trainingBlock: trainingBlock,
                        ),
                      ),
                    ),
                  ),
                  // using Align instead of Positioned or transform, because the
                  // rounded button can't be Transform.translate()'d, as the
                  // button won't be registering taps in that case
                  // @see https://stackoverflow.com/a/62500610/4241959
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedOpacity(
                      // TODO: extract?
                      opacity: isEditMode ? 0.0 : 1.0,
                      duration: WidgetParams.animationDuration,
                      curve: WidgetParams.animationCurve,
                      child: RoundedIconButton(
                        size: widgetParams.addExerciseButtonSize,
                        onPressed: isEditMode
                            ? null
                            : () => CustomBottomSheet(
                                  height: CustomBottomSheet.allSpacing + TextEditorSingleLineAndWheel.height,
                                  title: 'Add exercise type',
                                  child: _TextEditorSingleLineAndWheelWrapper(
                                    trainingBlock: trainingBlock,
                                    exerciseDay: exerciseDay,
                                  ),
                                ).show(context),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: ExerciseTypesList(
              trainingBlock: trainingBlock,
              exerciseDay: exerciseDay,
            ),
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final double borderRadius;

  const _Background({
    Key? key,
    required this.height,
    required this.width,
    required this.child,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: child,
      ),
    );
  }
}

class _TextEditorSingleLineWrapper extends ConsumerWidget {
  final TrainingBlockClient trainingBlock;
  final ExerciseDayClient exerciseDay;

  const _TextEditorSingleLineWrapper({
    Key? key,
    required this.trainingBlock,
    required this.exerciseDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseDaysService = ref.watch(exerciseDaysServiceProvider);

    return TextEditorSingleLine(
      value: exerciseDay.name,
      onSubmitted: (String text) {
        exerciseDaysService.updateName(
          trainingBlock: trainingBlock,
          exerciseDay: exerciseDay,
          name: text,
        );

        Navigator.of(context).pop();
      },
    );
  }
}

class _TextEditorSingleLineAndWheelWrapper extends ConsumerWidget {
  final TrainingBlockClient trainingBlock;
  final ExerciseDayClient exerciseDay;

  const _TextEditorSingleLineAndWheelWrapper({
    Key? key,
    required this.trainingBlock,
    required this.exerciseDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseTypesService = ref.watch(exerciseTypesServiceProvider);

    return TextEditorSingleLineAndWheel(
      value: '',
      // TODO: replace with user preferred value
      unit: 'lb',
      buttonLabel: 'Add',
      hintText: 'Enter name',
      options: const ['lb', 'kg'],
      onSubmitted: (String name, String unit) {
        exerciseTypesService.create(
          trainingBlock: trainingBlock,
          exerciseDay: exerciseDay,
          name: name,
          unit: unit,
        );

        Navigator.of(context).pop();
      },
    );
  }
}
