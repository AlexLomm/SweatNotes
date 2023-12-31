import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../../../widgets/rounded_icon_button.dart';
import '../../../../widgets/text_editor_single_line_and_wheel.dart';
import '../../../settings/edit_mode_switcher.dart';
import '../../data/models_client/exercise_day_client.dart';
import '../../data/models_client/training_block_client.dart';
import '../../services/exercise_types_service.dart';
import '../../widget_params.dart';

class AddExerciseTypeButton extends ConsumerWidget {
  final TrainingBlockClient trainingBlock;
  final ExerciseDayClient exerciseDay;

  const AddExerciseTypeButton({
    super.key,
    required this.trainingBlock,
    required this.exerciseDay,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);
    final isEditMode = ref.watch(editModeSwitcherProvider);

    return AnimatedOpacity(
      opacity: isEditMode ? 0.0 : 1.0,
      duration: WidgetParams.animationDuration,
      curve: WidgetParams.animationCurve,
      child: RoundedIconButton(
        size: widgetParams.addExerciseButtonSize,
        onPressed: isEditMode
            ? null
            : () => CustomBottomSheet(
                  height: CustomBottomSheet.allSpacing +
                      TextEditorSingleLineAndWheel.height,
                  title: 'Add exercise type',
                  child: _TextEditorSingleLineAndWheelWrapper(
                    trainingBlock: trainingBlock,
                    exerciseDay: exerciseDay,
                  ),
                ).show(context),
      ),
    );
  }
}

class _TextEditorSingleLineAndWheelWrapper extends ConsumerWidget {
  final TrainingBlockClient trainingBlock;
  final ExerciseDayClient exerciseDay;

  const _TextEditorSingleLineAndWheelWrapper({
    required this.trainingBlock,
    required this.exerciseDay,
  });

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
