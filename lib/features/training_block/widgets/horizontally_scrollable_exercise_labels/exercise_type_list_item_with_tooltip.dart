import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweatnotes/features/training_block/data/models_client/training_block_client.dart';

import '../../../../shared/widgets/tutor/constants/enums.dart';
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

    final showTooltip = !isEditMode || !isExerciseTypeSeen;

    return TutorTooltip(
      key: Key(exerciseType.dbModel.id),
      tooltipPosition: TooltipPosition.right,
      active: showTooltip,
      order: orderExerciseType,
      onClose: () => settingsNotifier.set(
        (prevState) => prevState.copyWith(isExerciseTypeSeen: true),
      ),
      buildTooltip: (_, childSize) => _Tooltip(childSize: childSize),
      buildChild: (controller) => child,
    );
  }
}

class _Tooltip extends ConsumerWidget {
  final Size childSize;

  const _Tooltip({
    super.key,
    required this.childSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Transform.translate(
      offset: const Offset(
        48,
        -75,
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
