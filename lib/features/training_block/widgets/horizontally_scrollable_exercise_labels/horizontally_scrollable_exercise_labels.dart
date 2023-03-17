import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../../../widgets/rounded_icon_button.dart';
import '../../../../widgets/text_editor_single_line.dart';
import '../../../../widgets/text_editor_single_line_and_wheel.dart';
import '../../../settings/edit_mode_switcher.dart';
import '../../constants.dart';
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

  get height {
    final exerciseDaysCount = max(1, exerciseDay.exerciseTypes.length);

    return elscTitleHeight + exerciseDaysCount * (etHeight + elscSpacingBetweenItems) + elscAdditionalBottomSpaceHeight;
  }

  const HorizontallyScrollableExerciseLabels({
    Key? key,
    required this.exerciseDay,
    // TODO: provide via riverpod?
    required this.trainingBlock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeSwitcherProvider);

    return Container(
      margin: const EdgeInsets.only(
        bottom: elscMarginBottom,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: AnimatedContainer(
              duration: animationDuration,
              curve: animationCurve,
              width: isEditMode ? elscWidthExpanded : elscWidth,
              // add enough space for the add exercise type button's half size to fit
              height: height + elscSpaceForExerciseTypeButton,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: _Background(
                      width: isEditMode ? elscWidthExpanded : elscWidth,
                      height: height,
                      borderRadius: borderRadius,
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
                      opacity: isEditMode ? 0.0 : 1.0,
                      duration: animationDuration,
                      curve: animationCurve,
                      child: RoundedIconButton(
                        size: elscAddExerciseTypeButtonSize,
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
      duration: animationDuration,
      curve: animationCurve,
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
