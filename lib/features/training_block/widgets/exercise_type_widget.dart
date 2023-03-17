import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widgets/button_dropdown_menu.dart';
import '../../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../../widgets/text_editor_single_line_and_wheel.dart';
import '../../settings/edit_mode_switcher.dart';
import '../constants.dart';
import '../data/models_client/exercise_day_client.dart';
import '../data/models_client/exercise_type_client.dart';
import '../data/models_client/training_block_client.dart';
import '../services/exercise_days_service.dart';
import '../services/exercise_types_service.dart';
import 'exercise_day_icon_wrapper.dart';
import 'ignore_pointer_edit_mode.dart';

class ExerciseTypeWidget extends ConsumerWidget {
  final int index;
  final TrainingBlockClient trainingBlock;
  final List<ExerciseDayClient> exerciseDays;
  final ExerciseTypeClient exerciseType;

  const ExerciseTypeWidget({
    Key? key,
    required this.index,
    required this.trainingBlock,
    required this.exerciseDays,
    required this.exerciseType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeSwitcherProvider);
    final exerciseDaysService = ref.watch(exerciseDaysServiceProvider);

    final fromExerciseDay = exerciseDays.firstWhere(
      (exerciseDay) => exerciseDay.exerciseTypes
          //
          .map((e) => e.dbModel.id)
          .contains(exerciseType.dbModel.id),
    );

    final toExerciseDay = exerciseDays.where((e) => e != fromExerciseDay).toList();

    return Material(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: SizedBox(
        // the height is set outside of the AnimatedContainer
        // in order to prevent newly created widgets' heights
        // from being animated
        height: etHeight,
        child: AnimatedContainer(
          duration: animationDuration,
          curve: animationCurve,
          padding: EdgeInsets.only(left: isEditMode ? etPaddingLeftExpanded : etPaddingLeft),
          width: isEditMode ? etWidthExpanded : etWidth,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedOpacity(
                  duration: animationDuration,
                  curve: animationCurve,
                  opacity: isEditMode ? 1 : 0,
                  child: ReorderableDragStartListener(
                    index: index,
                    child: ExerciseDayIconWrapper(
                      icon: Icons.drag_indicator,
                      width: isEditMode ? etDragHandleWidthExpanded : etDragHandleWidth,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: animationDuration,
                  curve: animationCurve,
                  margin: EdgeInsets.only(left: isEditMode ? etDragHandleWidthExpanded : etDragHandleWidth),
                  child: IgnorePointerEditMode(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => CustomBottomSheet(
                      height: CustomBottomSheet.allSpacing + TextEditorSingleLineAndWheel.height,
                      title: 'Edit exercise type',
                      child: _TextEditorSingleLineAndWheelWrapper(exerciseType: exerciseType),
                    ).show(context),
                    child: _ExerciseTypeName(
                      width: isEditMode ? etLabelWidthExpanded : etLabelWidth,
                      name: exerciseType.name,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: AnimatedOpacity(
                  duration: animationDuration,
                  curve: animationCurve,
                  opacity: isEditMode ? 1 : 0,
                  child: IgnorePointerEditMode(
                    child: AnimatedContainer(
                      duration: animationDuration,
                      curve: animationCurve,
                      child: ButtonDropdownMenu(
                        icon: Icons.keyboard_arrow_down,
                        animationDuration: animationDuration,
                        animationCurve: animationCurve,
                        items: toExerciseDay
                            .map(
                              (exerciseDay) => ButtonDropdownMenuItem(
                                onTap: () => exerciseDaysService.moveExerciseTypeIntoAnotherExerciseDay(
                                  trainingBlock: trainingBlock,
                                  fromExerciseDay: fromExerciseDay,
                                  toExerciseDay: exerciseDay,
                                  exerciseTypeId: exerciseType.dbModel.id,
                                ),
                                child: Text(
                                  exerciseDay.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextEditorSingleLineAndWheelWrapper extends ConsumerWidget {
  final ExerciseTypeClient exerciseType;

  const _TextEditorSingleLineAndWheelWrapper({
    Key? key,
    required this.exerciseType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseTypesService = ref.watch(exerciseTypesServiceProvider);

    return TextEditorSingleLineAndWheel(
      value: exerciseType.name,
      unit: exerciseType.unit,
      buttonLabel: 'Update',
      hintText: 'Enter name',
      options: const ['lb', 'kg'],
      onSubmitted: (String name, String unit) {
        exerciseTypesService.update(
          exerciseTypeClient: exerciseType,
          name: name,
          unit: unit,
        );

        Navigator.of(context).pop();
      },
    );
  }
}

class _ExerciseTypeName extends ConsumerWidget {
  final double width;
  final String name;

  const _ExerciseTypeName({
    Key? key,
    required this.width,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeSwitcherProvider);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(right: 8.0),
        width: width,
        height: double.infinity,
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: animationDuration,
            curve: animationCurve,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(isEditMode ? 1.0 : 0.0),
                  width: 1,
                ),
              ),
            ),
            child: AutoSizeText(
              name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              minFontSize: Theme.of(context).textTheme.labelSmall!.fontSize!,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
