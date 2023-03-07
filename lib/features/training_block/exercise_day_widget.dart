import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_flutter/features/training_block/data/models_client/exercise_day_client.dart';
import 'package:journal_flutter/widgets/text_editor_single_line.dart';

import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import 'exercise_type_widget.dart';
import 'services/exercise_days_service.dart';

class ExerciseDayWidget extends ConsumerWidget {
  static const borderRadius = 8.0;
  static const rightInsetSize = 24.0;
  static const width = ExerciseTypeWidget.width - rightInsetSize;
  static const titleHeight = 56.0;
  static const spacingBetweenItems = 8.0;
  static const additionalBottomSpaceHeight = 28.0 - spacingBetweenItems;

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
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseDaysService = ref.watch(exerciseDaysServiceProvider);

    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 2,
            surfaceTintColor: Theme.of(context).colorScheme.primary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(borderRadius),
                bottomRight: Radius.circular(borderRadius),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 18, right: 16, left: 16),
              width: width,
              height: height,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => CustomBottomSheet(
                        height: CustomBottomSheet.allSpacing +
                            TextEditorSingleLine.height,
                        title: 'Edit exercise day',
                        child: TextEditorSingleLine(
                          value: exerciseDay.name,
                          onSubmitted: (String text) {
                            // TODO: review api
                            exerciseDaysService.setName(
                              exerciseDay: exerciseDay,
                              name: text,
                            );

                            Navigator.of(context).pop();
                          },
                        ),
                      ).show(context),
                      child: Text(
                        exerciseDay.name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Transform.translate(
                      offset: const Offset(0, 20),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Material(
                          elevation: 2,
                          shape: const CircleBorder(),
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(top: titleHeight),
            child: Column(
              children: [
                for (final exerciseType in exerciseDay.exerciseTypes)
                  Container(
                    key: Key(exerciseType.id),
                    margin: const EdgeInsets.only(bottom: spacingBetweenItems),
                    child: ExerciseTypeWidget(exerciseType: exerciseType),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
