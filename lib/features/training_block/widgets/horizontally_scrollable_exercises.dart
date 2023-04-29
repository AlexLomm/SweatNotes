import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sweatnotes/features/training_block/data/models_client/training_block_client.dart';
import 'package:sweatnotes/features/training_block/services/training_blocks_service.dart';

import '../../settings/edit_mode_switcher.dart';
import '../data/models_client/exercise_type_client.dart';
import '../widget_params.dart';
import '../data/models_client/exercise_day_client.dart';
import 'exercise_widget.dart';
import '../services/exercises_service.dart';
import 'ignore_pointer_edit_mode.dart';

class HorizontallyScrollableExercises extends ConsumerStatefulWidget {
  final ScrollController? scrollController;
  final TrainingBlockClient trainingBlock;
  final ExerciseDayClient exerciseDay;

  const HorizontallyScrollableExercises({
    Key? key,
    this.scrollController,
    required this.trainingBlock,
    required this.exerciseDay,
  }) : super(key: key);

  @override
  ConsumerState<HorizontallyScrollableExercises> createState() => _HorizontallyScrollableExercisesState();
}

class _HorizontallyScrollableExercisesState extends ConsumerState<HorizontallyScrollableExercises> {
  late String _key;

  int _counter = 0;

  @override
  void initState() {
    super.initState();

    _updateKey();
  }

  @override
  void didUpdateWidget(HorizontallyScrollableExercises oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.scrollController == widget.scrollController) return;

    _updateKey();
  }

  // this is needed to force the list to rebuild when the scroll controller
  // changes from null to not null. Otherwise, the list will throw an error
  void _updateKey() {
    setState(() {
      _counter++;
      _key = '${widget.exerciseDay.dbModel.pseudoId}#$_counter';
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgetParams = ref.watch(widgetParamsProvider);
    final isEditMode = ref.watch(editModeSwitcherProvider);

    final List<ExerciseTypeClient> exerciseTypes =
        widget.exerciseDay.exerciseTypes.isEmpty ? [] : widget.exerciseDay.exerciseTypes;

    final exerciseTypesCount = exerciseTypes.length;

    int numberOfColumnsPerExerciseType = 0;
    if (exerciseTypes.isNotEmpty && exerciseTypes.first.exercises.isNotEmpty) {
      numberOfColumnsPerExerciseType = exerciseTypes.first.exercises.length;
    }

    final areColumnsCollapsed = widget.trainingBlock.exercisesCollapsedIncludingIndex > -1;
    final collapsedColumnsCount = widget.trainingBlock.exercisesCollapsedIncludingIndex + 1;

    return AnimatedOpacity(
      opacity: isEditMode ? 0.32 : 1.0,
      duration: WidgetParams.animationDuration,
      curve: WidgetParams.animationCurve,
      child: IgnorePointerInEditMode(
        ignoreWhenEditMode: true,
        child: AnimatedContainer(
          duration: WidgetParams.animationDuration,
          curve: WidgetParams.animationCurve,
          height: widgetParams.getExercisesHeight(exerciseTypesCount),
          margin: EdgeInsets.only(
            left: widgetParams.exercisesMarginLeft,
          ),
          child: ListView.builder(
            key: PageStorageKey(_key),
            controller: widget.scrollController,
            padding: EdgeInsets.only(
              right: widgetParams.exercisesSideSpacing,
              left: widgetParams.exercisesScrollInwardsDepth,
            ),
            itemCount: areColumnsCollapsed
                // +2 is needed for the "add button" to be shown at the end of the list
                // as well as the collapsed columns to be shown at the start of the list
                ? numberOfColumnsPerExerciseType + 2 - collapsedColumnsCount
                // +1 is needed for the "add button" to be shown at the end of the list
                : numberOfColumnsPerExerciseType + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, horizontalIndex) {
              final adjustedHorizontalIndex = areColumnsCollapsed
                  // -1 is needed to account for the placeholder for the collapsed columns
                  // which is displayed at the beginning of the list when there are collapsed
                  // columns present
                  ? horizontalIndex - 1
                  : horizontalIndex;

              final adjustedNumberOfColumnsPerExerciseType = areColumnsCollapsed
                  ? numberOfColumnsPerExerciseType - collapsedColumnsCount
                  : numberOfColumnsPerExerciseType;

              if (areColumnsCollapsed && adjustedHorizontalIndex == -1) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    // TODO: review
                    margin: const EdgeInsets.only(right: 24),
                    child: CollapsedExerciseColumns(
                      count: collapsedColumnsCount,
                      exerciseTypesCount: exerciseTypesCount,
                      trainingBlock: widget.trainingBlock,
                    ),
                  ),
                );
              }

              // the alignment is needed to prevent the underlying container
              // from being stretched to the `exerciseWithMargin` width (and
              // thereby losing border radius on the right) instead of being
              // of the `exerciseWithoutMargin` width
              return adjustedHorizontalIndex == adjustedNumberOfColumnsPerExerciseType && adjustedHorizontalIndex > 0
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: AddExerciseColumnButton(
                        exerciseType: exerciseTypes.first,
                        exerciseTypesCount: exerciseTypesCount,
                      ),
                    )
                  : Align(
                      alignment: Alignment.topLeft,
                      child: ExercisesColumn(
                        hasCollapseButton: adjustedHorizontalIndex != adjustedNumberOfColumnsPerExerciseType - 1,
                        trainingBlock: widget.trainingBlock,
                        exerciseDayClient: widget.exerciseDay,
                        horizontalIndex: adjustedHorizontalIndex + collapsedColumnsCount,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}

class CollapsedExerciseColumns extends ConsumerWidget {
  final int count;
  final int exerciseTypesCount;
  final TrainingBlockClient trainingBlock;

  const CollapsedExerciseColumns({
    Key? key,
    required this.count,
    required this.exerciseTypesCount,
    required this.trainingBlock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);
    final trainingBlocksService = ref.watch(trainingBlocksServiceProvider);

    return GestureDetector(
      onTap: () => trainingBlocksService.expandExercises(trainingBlock),
      child: Container(
        margin: EdgeInsets.only(
          top: widgetParams.exercisesTitleHeight,
        ),
        child: Stack(
          children: [
            if (count > 2)
              Align(
                alignment: Alignment.topCenter,
                child: Stick(
                  height: widgetParams.getExerciseTypesListHeight(exerciseTypesCount),
                  scale: 0.9,
                  opacity: 0.5,
                  depth: 2,
                ),
              ),
            if (count > 1)
              Align(
                alignment: Alignment.topCenter,
                child: Stick(
                  height: widgetParams.getExerciseTypesListHeight(exerciseTypesCount),
                  scale: 0.95,
                  opacity: 0.7,
                  depth: 1,
                ),
              ),
            Align(
              alignment: Alignment.topCenter,
              child: Stick(
                height: widgetParams.getExerciseTypesListHeight(exerciseTypesCount),
                scale: 1.0,
                opacity: 1.0,
                depth: 0,
                text: Intl.plural(
                  count,
                  zero: '0 days',
                  one: '1 day',
                  other: '$count days',
                  args: [count],
                  desc: 'How many columns are collapsed',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: rename
class Stick extends ConsumerWidget {
  final double height;
  final double scale;
  final double opacity;
  final int depth;
  final String? text;

  const Stick({
    Key? key,
    required this.height,
    required this.scale,
    required this.opacity,
    required this.depth,
    this.text,
  })  : assert(scale >= 0 && scale <= 1.0),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    return Opacity(
      opacity: opacity,
      child: SizedBox(
        height: height,
        child: Center(
          child: Material(
            elevation: 1,
            surfaceTintColor: Theme.of(context).colorScheme.primary,
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.all(Radius.circular(widgetParams.borderRadius)),
            shadowColor: Colors.transparent,
            child: Container(
              width: 48,
              height: height * scale,
              margin: EdgeInsets.only(
                left: 8.0 * depth,
              ),
              child: text == null
                  ? Container()
                  : RotatedBox(
                      quarterTurns: 3,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: AutoSizeText(
                            text!,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddExerciseColumnButton extends ConsumerWidget {
  final ExerciseTypeClient exerciseType;
  final int exerciseTypesCount;

  const AddExerciseColumnButton({
    Key? key,
    required this.exerciseType,
    required this.exerciseTypesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);
    final exercisesService = ref.watch(exercisesServiceProvider);

    return GestureDetector(
      onTap: () => exercisesService.addEmptyExercise(exerciseType: exerciseType),
      child: Container(
        width: 48,
        height: widgetParams.getExerciseTypesListHeight(exerciseTypesCount),
        margin: EdgeInsets.only(
          top: widgetParams.exercisesTitleHeight,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.all(Radius.circular(widgetParams.borderRadius)),
        ),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}

class ExercisesColumn extends ConsumerWidget {
  final bool hasCollapseButton;
  final TrainingBlockClient trainingBlock;
  final ExerciseDayClient exerciseDayClient;
  final int horizontalIndex;

  const ExercisesColumn({
    Key? key,
    required this.hasCollapseButton,
    required this.trainingBlock,
    required this.exerciseDayClient,
    required this.horizontalIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);
    final trainingBlocksService = ref.watch(trainingBlocksServiceProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExerciseColumnLabel(
          hasCollapseButton: hasCollapseButton,
          areDatesEmpty: exerciseDayClient.areDatesEmpty,
          text: horizontalIndex == 0 ? 'Previous PRs' : exerciseDayClient.getFormattedDateAt(horizontalIndex - 1),
          exerciseTypes: exerciseDayClient.exerciseTypes,
          onCollapse: () => trainingBlocksService.collapsePastExercisesAt(
            trainingBlock,
            index: horizontalIndex,
          ),
        ),
        for (var verticalIndex = 0; verticalIndex < exerciseDayClient.exerciseTypes.length; verticalIndex++)
          Container(
            margin: EdgeInsets.only(
              right: widgetParams.exercisesSideSpacing,
              bottom: widgetParams.exercisesMarginBottomNotLast,
            ),
            child: ExerciseWidget(
              exerciseType: exerciseDayClient.exerciseTypes[verticalIndex],
              exercise: exerciseDayClient.exerciseTypes[verticalIndex].exercises[horizontalIndex],
            ),
          ),
      ],
    );
  }
}

class ExerciseColumnLabel extends ConsumerWidget {
  final bool hasCollapseButton;
  final bool areDatesEmpty;
  final String text;
  final List<ExerciseTypeClient> exerciseTypes;
  final void Function() onCollapse;

  const ExerciseColumnLabel({
    Key? key,
    required this.hasCollapseButton,
    required this.areDatesEmpty,
    required this.text,
    required this.exerciseTypes,
    required this.onCollapse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    final labelWidth =
        exerciseTypes.isEmpty ? 0.0 : exerciseTypes[0].exercises[0].sets.length * widgetParams.exerciseSetWidth;

    return Container(
      width: labelWidth,
      height: widgetParams.exercisesTitleHeight - widgetParams.exercisesMarginBottomNotLast,
      margin: EdgeInsets.only(bottom: widgetParams.exercisesMarginBottomNotLast),
      child: Material(
        elevation: 1.0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(widgetParams.borderRadius)),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: areDatesEmpty
                    ? Tooltip(
                        showDuration: const Duration(seconds: 2),
                        padding: const EdgeInsets.all(16.0),
                        textAlign: TextAlign.left,
                        triggerMode: TooltipTriggerMode.tap,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.all(Radius.circular(widgetParams.borderRadius)),
                        ),
                        richMessage: TextSpan(
                          text: 'Set dates first by editing the exercise day!',
                          children: const [
                            TextSpan(text: '\n\n'),
                            TextSpan(text: '1. Tap the pencil icon in the top right corner.\n'),
                            TextSpan(text: '2. Click on the exercise day name.'),
                          ],
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        child: AutoSizeText(
                          text,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      )
                    : AutoSizeText(
                        text,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
              ),
              if (hasCollapseButton)
                IconButton(
                  iconSize: 18,
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: onCollapse,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
