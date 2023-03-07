import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../training_block/data/models_client/exercise_day_client.dart';
import '../../features/training_block/services/exercise_types_service.dart';
import '../../widgets/text_editor_single_line.dart';
import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../widgets/rounded_icon_button.dart';
import '../../widgets/text_editor_single_line_and_wheel.dart';
import 'exercise_type_widget.dart';
import 'services/exercise_days_service.dart';

class ExerciseDayWidget extends StatelessWidget {
  static const borderRadius = 8.0;
  static const rightInsetSize = 24.0;
  static const width = ExerciseTypeWidget.width - rightInsetSize;
  static const titleHeight = 56.0;
  static const spacingBetweenItems = 8.0;
  static const additionalBottomSpaceHeight = 28.0 - spacingBetweenItems;
  static const addExerciseTypeButtonSize = 40.0;

  final ExerciseDayClient exerciseDay;

  get isEmpty => exerciseDay.exerciseTypes.isEmpty;

  get height {
    final exerciseDaysCount = max(1, exerciseDay.exerciseTypes.length);

    return titleHeight +
        exerciseDaysCount * (ExerciseTypeWidget.height + spacingBetweenItems) +
        additionalBottomSpaceHeight;
  }

  const ExerciseDayWidget({
    Key? key,
    required this.exerciseDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: width,
            // add enough space for the add exercise type button's half size to fit
            height: height + addExerciseTypeButtonSize / 2,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: _Background(
                    width: width,
                    height: height,
                    borderRadius: borderRadius,
                    child: GestureDetector(
                      onTap: () => CustomBottomSheet(
                        height: CustomBottomSheet.allSpacing +
                            TextEditorSingleLine.height,
                        title: 'Edit exercise day',
                        child: _TextEditorSingleLineWrapper(
                          exerciseDay: exerciseDay,
                        ),
                      ).show(context),
                      child: _ExerciseDayName(
                        name: exerciseDay.name,
                      ),
                    ),
                  ),
                ),
                // the rounded button can't be Transform.translate()'d,
                // because the button won't register taps
                // @see https://stackoverflow.com/a/62500610/4241959
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RoundedIconButton(
                    size: addExerciseTypeButtonSize,
                    onPressed: () => CustomBottomSheet(
                      height: CustomBottomSheet.allSpacing +
                          TextEditorSingleLineAndWheel.height,
                      title: 'Add exercise type',
                      child: _TextEditorSingleLineAndWheelWrapper(
                        exerciseDay: exerciseDay,
                      ),
                    ).show(context),
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: _ExerciseTypesList(exerciseDay: exerciseDay),
        ),
      ],
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
    return SizedBox(
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
        child: Padding(
          padding: const EdgeInsets.only(
            top: 18,
            right: 16,
            left: 16,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _ExerciseDayName extends StatelessWidget {
  final String name;

  const _ExerciseDayName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      minFontSize: Theme.of(context).textTheme.titleSmall!.fontSize!,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }
}

class _TextEditorSingleLineWrapper extends ConsumerWidget {
  final ExerciseDayClient exerciseDay;

  const _TextEditorSingleLineWrapper({
    Key? key,
    required this.exerciseDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseDaysService = ref.watch(exerciseDaysServiceProvider);

    return TextEditorSingleLine(
      value: exerciseDay.name,
      onSubmitted: (String text) {
        exerciseDaysService.setName(
          exerciseDay: exerciseDay,
          name: text,
        );

        Navigator.of(context).pop();
      },
    );
  }
}

class _TextEditorSingleLineAndWheelWrapper extends ConsumerWidget {
  final ExerciseDayClient exerciseDay;

  const _TextEditorSingleLineAndWheelWrapper({
    Key? key,
    required this.exerciseDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseTypesService = ref.watch(exerciseTypesServiceProvider);

    return TextEditorSingleLineAndWheel(
      value: '',
      buttonLabel: 'Add',
      hintText: 'Enter name',
      options: const ['lb', 'kg'],
      onSubmitted: (String name, String unit) {
        exerciseTypesService.create(
          exerciseDay: exerciseDay,
          name: name,
          unit: unit,
        );

        Navigator.of(context).pop();
      },
    );
  }
}

class _ExerciseTypesList extends StatelessWidget {
  final ExerciseDayClient exerciseDay;

  const _ExerciseTypesList({Key? key, required this.exerciseDay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: ExerciseDayWidget.titleHeight),
      child: Column(
        children: [
          for (final exerciseType in exerciseDay.exerciseTypes)
            Container(
              key: Key(exerciseType.id),
              margin: const EdgeInsets.only(
                bottom: ExerciseDayWidget.spacingBetweenItems,
              ),
              child: ExerciseTypeWidget(exerciseType: exerciseType),
            )
        ],
      ),
    );
  }
}
