import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app.dart';
import '../../../widgets/button_dropdown_menu.dart';
import '../../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../../widgets/custom_dismissible.dart';
import '../../../widgets/text_editor_multi_line.dart';
import '../../../widgets/text_editor_single_line_and_wheel.dart';
import '../../settings/edit_mode_switcher.dart';
import '../widget_params.dart';
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
    final messenger = ref.watch(messengerProvider);
    final exerciseTypeService = ref.watch(exerciseTypesServiceProvider);
    final exerciseDaysService = ref.watch(exerciseDaysServiceProvider);

    final isEditMode = ref.watch(editModeSwitcherProvider);
    final widgetParams = ref.watch(widgetParamsProvider);

    final fromExerciseDay = exerciseDays.firstWhere(
      (exerciseDay) => exerciseDay.exerciseTypes
          //
          .map((e) => e.dbModel.id)
          .contains(exerciseType.dbModel.id),
    );

    final toExerciseDay = exerciseDays.where((e) => e != fromExerciseDay).toList();

    return CustomDismissible(
      id: exerciseType.dbModel.id,
      isEnabled: isEditMode,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(widgetParams.borderRadius),
        bottomRight: Radius.circular(widgetParams.borderRadius),
      ),
      onDismissed: (direction) {
        exerciseTypeService.archive(exerciseType, true);

        messenger?.showSnackBar(
          SnackBar(
            content: Text('Exercise type "${exerciseType.name}" archived'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () => exerciseTypeService.archive(exerciseType, false),
            ),
          ),
        );
      },
      child: Material(
        elevation: 2,
        shape: const RoundedRectangleBorder(),
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: SizedBox(
          // the height is set outside of the AnimatedContainer
          // in order to prevent newly created widgets' heights
          // from being animated
          height: widgetParams.exerciseTypeHeight,
          child: AnimatedContainer(
            duration: WidgetParams.animationDuration,
            curve: WidgetParams.animationCurve,
            padding: EdgeInsets.only(left: widgetParams.exerciseTypePaddingLeft),
            width: widgetParams.exerciseTypeWidth,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedOpacity(
                    duration: WidgetParams.animationDuration,
                    curve: WidgetParams.animationCurve,
                    opacity: isEditMode ? 1 : 0,
                    child: ReorderableDragStartListener(
                      index: index,
                      child: ExerciseDayIconWrapper(
                        icon: Icons.drag_indicator,
                        width: widgetParams.exerciseTypeDragHandleWidth,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: WidgetParams.animationDuration,
                    curve: WidgetParams.animationCurve,
                    margin: EdgeInsets.only(left: widgetParams.exerciseTypeDragHandleWidth),
                    child: IgnorePointerEditMode(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => CustomBottomSheet(
                        height: CustomBottomSheet.allSpacing + TextEditorSingleLineAndWheel.height,
                        title: 'Edit exercise type',
                        child: _TextEditorSingleLineAndWheelWrapper(exerciseType: exerciseType),
                      ).show(context),
                      child: _ExerciseTypeName(
                        width: widgetParams.exerciseTypeLabelWidth,
                        name: exerciseType.name,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedOpacity(
                    duration: WidgetParams.animationDuration,
                    curve: WidgetParams.animationCurve,
                    opacity: isEditMode ? 1 : 0,
                    child: IgnorePointerEditMode(
                      child: AnimatedContainer(
                        duration: WidgetParams.animationDuration,
                        curve: WidgetParams.animationCurve,
                        child: ButtonDropdownMenu(
                          icon: Icons.keyboard_arrow_down,
                          animationDuration: WidgetParams.animationDuration,
                          animationCurve: WidgetParams.animationCurve,
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
                Align(
                  alignment: Alignment.bottomLeft,
                  child: AnimatedOpacity(
                    duration: WidgetParams.animationDuration,
                    curve: WidgetParams.animationCurve,
                    opacity: isEditMode ? 0 : 1,
                    child: IgnorePointerEditMode(
                      ignoreWhenEditMode: true,
                      child: AnimatedContainer(
                        duration: WidgetParams.animationDuration,
                        curve: WidgetParams.animationCurve,
                        height: 22,
                        width: widgetParams.exerciseTypeWidth,
                        padding: const EdgeInsets.only(bottom: 4, right: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                exerciseType.notes,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.48)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => CustomBottomSheet(
                                height: 324,
                                title: 'Add notes',
                                child: _TextEditorMultiLineWrapper(exerciseType: exerciseType),
                              ).show(context),
                              child: Icon(
                                Icons.edit_note,
                                color: exerciseType.notes.isEmpty
                                    ? Theme.of(context).colorScheme.outline.withOpacity(0.72)
                                    : Theme.of(context).colorScheme.tertiary,
                                size: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TextEditorMultiLineWrapper extends ConsumerWidget {
  final ExerciseTypeClient exerciseType;

  const _TextEditorMultiLineWrapper({
    Key? key,
    required this.exerciseType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseTypesService = ref.watch(exerciseTypesServiceProvider);

    return TextEditorMultiLine(
      value: exerciseType.notes,
      hintText: 'Add notes',
      onSubmitted: (String notes) {
        exerciseTypesService.updateNotes(exerciseType, notes);

        Navigator.of(context).pop();
      },
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
      child: AnimatedContainer(
        duration: WidgetParams.animationDuration,
        curve: WidgetParams.animationCurve,
        padding: EdgeInsets.only(right: 8.0, bottom: isEditMode ? 0 : 16.0),
        width: width,
        height: double.infinity,
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: WidgetParams.animationDuration,
            curve: WidgetParams.animationCurve,
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
              maxLines: 2,
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
