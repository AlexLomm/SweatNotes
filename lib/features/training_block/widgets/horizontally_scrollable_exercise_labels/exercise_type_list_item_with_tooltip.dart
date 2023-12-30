import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweatnotes/features/training_block/data/models_client/training_block_client.dart';

import '../../../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../../../settings/edit_mode_switcher.dart';
import '../../../settings/tutorial_settings.dart';
import '../../data/models_client/exercise_type_client.dart';
import '../../widget_params.dart';
import '../exercise_type_widget.dart';
import 'exercise_type_list_item.dart';

class ExerciseTypeListItemWithTooltip extends ConsumerWidget {
  final bool isTutorialEnabled;
  final int index;
  final TrainingBlockClient trainingBlock;
  final ExerciseTypeClient exerciseType;

  const ExerciseTypeListItemWithTooltip({
    super.key,
    required this.isTutorialEnabled,
    required this.index,
    required this.trainingBlock,
    required this.exerciseType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final child = ExerciseTypeListItem(
      index: index,
      trainingBlock: trainingBlock,
      exerciseType: exerciseType,
    );

    if (!(isTutorialEnabled && index == 0)) return child;

    final settingsNotifier = ref.watch(tutorialSettingsProvider.notifier);

    final isEditMode = ref.watch(editModeSwitcherProvider);
    final isExerciseTypeSeen = ref.watch(
      tutorialSettingsProvider.select((s) => s.isExerciseTypeSeen),
    );

    final showTooltip = !isEditMode && !isExerciseTypeSeen;

    return TutorTooltip(
      key: Key(exerciseType.dbModel.id),
      active: showTooltip,
      order: orderExerciseType,
      onClose: () => settingsNotifier.set(
        (prevState) => prevState.copyWith(isExerciseTypeSeen: true),
      ),
      buildTooltip: (_, rect) => _Tooltip(rect: rect),
      buildChild: (controller) => child,
    );
  }
}

class _Tooltip extends ConsumerWidget {
  final Rect? rect;

  const _Tooltip({
    super.key,
    required this.rect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetParams = ref.watch(widgetParamsProvider);

    return Transform.translate(
      offset: Offset(
        widgetParams.exerciseTypeWidth + 48,
        -((rect?.height ?? 0) + (rect?.top ?? 0)) / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              'Long-press to drag and drop the exercise\n\nClick on the notes icon to write notes',
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: GoogleFonts.indieFlower().fontFamily,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
