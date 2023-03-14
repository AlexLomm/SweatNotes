import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../widgets/text_editor_single_line_and_wheel.dart';
import '../settings/edit_mode_switcher.dart';
import '../training_block/services/exercise_types_service.dart';
import 'constants.dart';
import 'data/models_client/exercise_type_client.dart';
import 'widgets/drag_handle.dart';

class ExerciseTypeWidget extends ConsumerWidget {
  static const height = 80.0;

  static const width = 128.0;
  static const dragHandleWidth = 0.0;
  static const paddingLeft = 8.0;
  static const labelWidth = width - dragHandleWidth - paddingLeft;

  static const widthExpanded = 168.0;
  static const dragHandleWidthExpanded = 48.0;
  static const paddingLeftExpanded = 0.0;
  static const labelWidthExpanded = widthExpanded - dragHandleWidthExpanded - paddingLeftExpanded;

  final int index;
  final ExerciseTypeClient exerciseType;

  const ExerciseTypeWidget({
    Key? key,
    required this.index,
    required this.exerciseType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeSwitcherProvider);

    return Material(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: AnimatedContainer(
        duration: animationDuration,
        curve: animationCurve,
        padding: EdgeInsets.only(left: isEditMode ? paddingLeftExpanded : paddingLeft),
        width: isEditMode ? widthExpanded : width,
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: animationDuration,
              curve: animationCurve,
              opacity: isEditMode ? 1 : 0,
              child: ReorderableDragStartListener(
                index: index,
                child: DragHandle(
                  width: isEditMode ? dragHandleWidthExpanded : dragHandleWidth,
                ),
              ),
            ),
            IgnorePointer(
              ignoring: !isEditMode,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => CustomBottomSheet(
                  height: CustomBottomSheet.allSpacing + TextEditorSingleLineAndWheel.height,
                  title: 'Edit exercise type',
                  child: _TextEditorSingleLineAndWheelWrapper(exerciseType: exerciseType),
                ).show(context),
                child: _ExerciseTypeName(
                  width: isEditMode ? labelWidthExpanded : labelWidth,
                  name: exerciseType.name,
                ),
              ),
            ),
          ],
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
