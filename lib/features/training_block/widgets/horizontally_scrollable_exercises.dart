import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/edit_mode_switcher.dart';
import '../data/models_client/exercise_type_client.dart';
import '../widget_params.dart';
import '../data/models_client/exercise_day_client.dart';
import 'exercise_widget.dart';
import '../services/exercises_service.dart';
import 'ignore_pointer_edit_mode.dart';

class HorizontallyScrollableExercises extends ConsumerStatefulWidget {
  final ScrollController? scrollController;
  final ExerciseDayClient exerciseDay;

  const HorizontallyScrollableExercises({
    Key? key,
    this.scrollController,
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

    int numberOfExercisesPerExerciseType = 0;
    if (exerciseTypes.isNotEmpty && exerciseTypes.first.exercises.isNotEmpty) {
      numberOfExercisesPerExerciseType = exerciseTypes.first.exercises.length;
    }

    return AnimatedOpacity(
      opacity: isEditMode ? 0.32 : 1.0,
      duration: WidgetParams.animationDuration,
      curve: WidgetParams.animationCurve,
      child: IgnorePointerEditMode(
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
            // +1 is needed for the "add button" to be shown
            itemCount: numberOfExercisesPerExerciseType + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, horizontalIndex) {
              // the alignment is needed to prevent the underlying container
              // from being stretched to the `exerciseWithMargin` width (and
              // thereby losing border radius on the right) instead of being
              // of the `exerciseWithoutMargin` width
              return horizontalIndex == numberOfExercisesPerExerciseType && horizontalIndex > 0
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: AddExerciseButton(
                        exerciseType: exerciseTypes.first,
                        exerciseTypesCount: exerciseTypesCount,
                      ),
                    )
                  : Align(
                      alignment: Alignment.topLeft,
                      child: ExercisesColumn(
                        exerciseTypes: exerciseTypes,
                        horizontalIndex: horizontalIndex,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}

class AddExerciseButton extends ConsumerWidget {
  final ExerciseTypeClient exerciseType;
  final int exerciseTypesCount;

  const AddExerciseButton({
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
  final List<ExerciseTypeClient> exerciseTypes;
  final int horizontalIndex;

  const ExercisesColumn({
    Key? key,
    required this.exerciseTypes,
    required this.horizontalIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExerciseColumnLabel(
          text: horizontalIndex == 0 ? 'Previous PRs' : '',
          exerciseTypes: exerciseTypes,
        ),
        for (var verticalIndex = 0; verticalIndex < exerciseTypes.length; verticalIndex++)
          Container(
            margin: EdgeInsets.only(
              right: widgetParams.exercisesSideSpacing,
              bottom: widgetParams.exercisesMarginBottomNotLast,
            ),
            child: ExerciseWidget(
              exerciseType: exerciseTypes[verticalIndex],
              exercise: exerciseTypes[verticalIndex].exercises[horizontalIndex],
            ),
          ),
      ],
    );
  }
}

class ExerciseColumnLabel extends ConsumerWidget {
  final String text;
  final List<ExerciseTypeClient> exerciseTypes;

  const ExerciseColumnLabel({
    Key? key,
    required this.text,
    required this.exerciseTypes,
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
        surfaceTintColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(widgetParams.borderRadius)),
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
          child: AutoSizeText(
            text,
            maxLines: 1,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      ),
    );
  }
}
