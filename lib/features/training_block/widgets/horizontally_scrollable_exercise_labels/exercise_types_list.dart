import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings/edit_mode_switcher.dart';
import '../../constants.dart';
import '../../data/models_client/exercise_day_client.dart';
import '../../services/exercise_days_service.dart';
import '../exercise_type_widget.dart';

class ExerciseTypesList extends ConsumerStatefulWidget {
  final List<ExerciseDayClient> exerciseDays;
  final ExerciseDayClient exerciseDay;

  const ExerciseTypesList({
    Key? key,
    required this.exerciseDays,
    required this.exerciseDay,
  }) : super(key: key);

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
    final exerciseDaysService = ref.watch(exerciseDaysServiceProvider);
    final isEditMode = ref.watch(editModeSwitcherProvider);

    return AnimatedContainer(
      duration: animationDuration,
      curve: animationCurve,
      margin: const EdgeInsets.only(top: elscTitleHeight),
      width: isEditMode ? etWidthExpanded : etWidth,
      height: (etHeight + elscSpacingBetweenItems) * _exerciseDayClientCached.exerciseTypes.length,
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
              _exerciseDayClientCached = exerciseDaysService.getExerciseDayWithReorderedExerciseType(
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
                  bottom: elscSpacingBetweenItems,
                ),
                child: Theme(
                  // this is needed to re-enable the canceled theming above
                  data: Theme.of(context),
                  child: ExerciseTypeWidget(
                    index: entry.key,
                    exerciseDays: widget.exerciseDays,
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
