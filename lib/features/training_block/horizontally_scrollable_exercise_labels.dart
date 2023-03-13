import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/edit_mode_switcher.dart';
import '../training_block/data/models_client/exercise_day_client.dart';
import '../../features/training_block/services/exercise_types_service.dart';
import '../../widgets/text_editor_single_line.dart';
import '../../widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../../widgets/rounded_icon_button.dart';
import '../../widgets/text_editor_single_line_and_wheel.dart';
import 'constants.dart';
import 'exercise_type_widget.dart';
import 'services/exercise_days_service.dart';

class HorizontallyScrollableExerciseLabels extends ConsumerWidget {
  static const borderRadius = 8.0;
  static const rightInsetSize = 24.0;
  static const width = ExerciseTypeWidget.width - rightInsetSize;
  static const titleHeight = 56.0;
  static const spacingBetweenItems = 8.0;
  static const additionalBottomSpaceHeight = 28.0 - spacingBetweenItems;
  static const addExerciseTypeButtonSize = 40.0;
  static const spaceForExerciseTypeButton = addExerciseTypeButtonSize / 2;
  static const marginBottom = 44.0;

  static const widthExpanded = ExerciseTypeWidget.widthExpanded - rightInsetSize;

  final ExerciseDayClient exerciseDay;

  get isEmpty => exerciseDay.exerciseTypes.isEmpty;

  get height {
    final exerciseDaysCount = max(1, exerciseDay.exerciseTypes.length);

    return titleHeight +
        exerciseDaysCount * (ExerciseTypeWidget.height + spacingBetweenItems) +
        additionalBottomSpaceHeight;
  }

  const HorizontallyScrollableExerciseLabels({
    Key? key,
    required this.exerciseDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeSwitcherProvider);

    return Container(
      margin: const EdgeInsets.only(
        bottom: marginBottom,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: AnimatedContainer(
              duration: animationDuration,
              curve: animationCurve,
              width: isEditMode ? widthExpanded : width,
              // add enough space for the add exercise type button's half size to fit
              height: height + spaceForExerciseTypeButton,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: _Background(
                      width: isEditMode ? widthExpanded : width,
                      height: height,
                      borderRadius: borderRadius,
                      child: IgnorePointer(
                        ignoring: !isEditMode,
                        child: GestureDetector(
                          onTap: () => CustomBottomSheet(
                            height: CustomBottomSheet.allSpacing + TextEditorSingleLine.height,
                            title: 'Edit exercise day',
                            child: _TextEditorSingleLineWrapper(exerciseDay: exerciseDay),
                          ).show(context),
                          child: _ExerciseDayName(name: exerciseDay.name),
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
                        size: addExerciseTypeButtonSize,
                        onPressed: isEditMode
                            ? null
                            : () => CustomBottomSheet(
                                  height: CustomBottomSheet.allSpacing + TextEditorSingleLineAndWheel.height,
                                  title: 'Add exercise type',
                                  child: _TextEditorSingleLineAndWheelWrapper(
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
            child: _ExerciseTypesList(exerciseDay: exerciseDay),
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
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: child,
        ),
      ),
    );
  }
}

class _ExerciseDayName extends ConsumerWidget {
  final String name;

  const _ExerciseDayName({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeSwitcherProvider);

    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 56.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: animationDuration,
              curve: animationCurve,
              opacity: isEditMode ? 1.0 : 0.0,
              child: AnimatedContainer(
                duration: animationDuration,
                curve: animationCurve,
                padding: const EdgeInsets.only(top: 4.0),
                width: isEditMode ? ExerciseTypeWidget.dragHandleWidthExpanded : ExerciseTypeWidget.dragHandleWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: ExerciseTypeWidget.dragHandleWidth,
                        height: ExerciseTypeWidget.dragHandleWidth,
                        color: Colors.white.withOpacity(0.0001),
                        child: Transform.rotate(angle: pi / 2, child: const Icon(Icons.chevron_left)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: ExerciseTypeWidget.dragHandleWidth,
                        height: ExerciseTypeWidget.dragHandleWidth,
                        color: Colors.white.withOpacity(0.0001),
                        child: Transform.rotate(angle: pi / 2, child: const Icon(Icons.chevron_right)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              duration: animationDuration,
              curve: animationCurve,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(isEditMode ? 1.0 : 0.0),
                    width: 1.0,
                  ),
                ),
              ),
              child: AutoSizeText(
                name,
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
      // TODO: replace with user preferred value
      unit: 'lb',
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

class _ExerciseTypesList extends ConsumerStatefulWidget {
  final ExerciseDayClient exerciseDay;

  const _ExerciseTypesList({Key? key, required this.exerciseDay}) : super(key: key);

  @override
  ConsumerState createState() => _ExerciseTypesListState();
}

class _ExerciseTypesListState extends ConsumerState<_ExerciseTypesList> {
  late ExerciseDayClient _exerciseDayClientCached;

  @override
  void initState() {
    super.initState();

    _cacheExerciseDayClient();
  }

  @override
  void didUpdateWidget(_ExerciseTypesList oldWidget) {
    super.didUpdateWidget(oldWidget);

    _cacheExerciseDayClient();
  }

  _cacheExerciseDayClient() {
    setState(() => _exerciseDayClientCached = widget.exerciseDay.copyWith());
  }

  @override
  Widget build(BuildContext context) {
    final exerciseDaysService = ref.watch(exerciseDaysServiceProvider);
    final isEditMode = ref.watch(editModeSwitcherProvider);

    return AnimatedContainer(
      duration: animationDuration,
      curve: animationCurve,
      margin: const EdgeInsets.only(top: HorizontallyScrollableExerciseLabels.titleHeight),
      width: isEditMode ? ExerciseTypeWidget.widthExpanded : ExerciseTypeWidget.width,
      height: (ExerciseTypeWidget.height + HorizontallyScrollableExerciseLabels.spacingBetweenItems) *
          _exerciseDayClientCached.exerciseTypes.length,
      child: Theme(
        // this is needed to remove the bottom margin when reordering the items
        // @see https://github.com/flutter/flutter/issues/63527#issuecomment-852740201
        data: ThemeData(
          canvasColor: Colors.transparent,
          shadowColor: Colors.transparent,
          dialogBackgroundColor: Colors.transparent,
        ),
        child: ReorderableListView(
          physics: const NeverScrollableScrollPhysics(),
          onReorder: (int oldIndex, int newIndex) async {
            final exerciseTypesCount = _exerciseDayClientCached.exerciseTypes.length;

            // these two lines are workarounds for ReorderableListView problems
            // @see https://stackoverflow.com/a/54164333/4241959
            if (newIndex > exerciseTypesCount) newIndex = exerciseTypesCount;
            if (oldIndex < newIndex) newIndex--;

            final backup = _exerciseDayClientCached;

            // optimistically update the UI
            setState(() {
              _exerciseDayClientCached = exerciseDaysService.getReorderExerciseTypeInTheSameDay(
                exerciseDay: _exerciseDayClientCached,
                oldIndex: oldIndex,
                newIndex: newIndex,
              );
            });

            try {
              await exerciseDaysService.update(exerciseDay: _exerciseDayClientCached);
            } catch (e) {
              // revert the UI if the call is unsuccessful
              setState(() => _exerciseDayClientCached = backup);
            }
          },
          children: [
            for (final entry in _exerciseDayClientCached.exerciseTypes.asMap().entries)
              Container(
                key: Key(entry.value.id),
                margin: const EdgeInsets.only(
                  bottom: HorizontallyScrollableExerciseLabels.spacingBetweenItems,
                ),
                child: Theme(
                  // this is needed to re-enable the canceled theming above
                  data: Theme.of(context),
                  child: ExerciseTypeWidget(
                    index: entry.key,
                    exerciseType: entry.value,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
