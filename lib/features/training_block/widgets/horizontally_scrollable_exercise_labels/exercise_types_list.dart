import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models_client/exercise_day_client.dart';
import '../../data/models_client/training_block_client.dart';
import '../../services/exercise_days_service.dart';
import '../../widget_params.dart';
import '../exercise_type_widget.dart';

class ExerciseTypesList extends ConsumerStatefulWidget {
  final TrainingBlockClient trainingBlock;
  final ExerciseDayClient exerciseDay;

  const ExerciseTypesList({
    super.key,
    required this.trainingBlock,
    required this.exerciseDay,
  });

  @override
  ConsumerState createState() => _ExerciseTypesListState();
}

class _ExerciseTypesListState extends ConsumerState<ExerciseTypesList> {
  late ExerciseDayClient _exerciseDayClientCached;

  @override
  void initState() {
    super.initState();

    _cacheExerciseDayClient();
  }

  @override
  void didUpdateWidget(ExerciseTypesList oldWidget) {
    super.didUpdateWidget(oldWidget);

    _cacheExerciseDayClient();
  }

  _cacheExerciseDayClient() {
    setState(() => _exerciseDayClientCached = widget.exerciseDay.copyWith());
  }

  @override
  Widget build(BuildContext context) {
    final widgetParams = ref.watch(widgetParamsProvider);
    final exerciseDaysService = ref.watch(exerciseDaysServiceProvider);

    return AnimatedContainer(
      duration: WidgetParams.animationDuration,
      curve: WidgetParams.animationCurve,
      margin: EdgeInsets.only(top: widgetParams.exerciseDayTitleHeight),
      width: widgetParams.exerciseTypeWidth,
      height: widgetParams.getExerciseTypesListHeight(_exerciseDayClientCached.exerciseTypes.length),
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
          onReorder: (int fromIndex, int toIndex) async {
            final exerciseDayIndex = widget.trainingBlock.indexOfExerciseDayByPseudoId(
              widget.exerciseDay.dbModel.pseudoId,
            );

            final exerciseTypesCount = _exerciseDayClientCached.exerciseTypes.length;

            // these two lines are workarounds for ReorderableListView problems
            // @see https://stackoverflow.com/a/54164333/4241959
            if (toIndex > exerciseTypesCount) toIndex = exerciseTypesCount;
            if (fromIndex < toIndex) toIndex--;

            final backup = _exerciseDayClientCached;

            // optimistically update the UI
            setState(() {
              _exerciseDayClientCached = _exerciseDayClientCached.reorderExerciseType(
                from: fromIndex,
                to: toIndex,
              );
            });

            try {
              await exerciseDaysService.updateAt(
                trainingBlock: widget.trainingBlock,
                exerciseDay: _exerciseDayClientCached,
                index: exerciseDayIndex,
              );
            } catch (e) {
              // revert the UI if the call is unsuccessful
              setState(() => _exerciseDayClientCached = backup);
            }
          },
          children: [
            for (final entry in _exerciseDayClientCached.exerciseTypes.asMap().entries)
              Container(
                key: Key(entry.value.dbModel.id),
                margin: EdgeInsets.only(
                  bottom: widgetParams.exerciseTypesVerticalSpacing,
                ),
                child: Theme(
                  // this is needed to re-enable the canceled theming above
                  data: Theme.of(context),
                  child: ExerciseTypeWidget(
                    index: entry.key,
                    trainingBlock: widget.trainingBlock,
                    exerciseDays: widget.trainingBlock.exerciseDays,
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
