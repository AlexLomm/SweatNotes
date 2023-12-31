import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweatnotes/features/training_block/data/models_client/training_block_client.dart';

import '../../shared/widgets/tutor/constants/enums.dart';
import '../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../settings/edit_mode_switcher.dart';
import '../settings/tutorial_settings.dart';
import 'add_exercise_day_button.dart';

class AddExerciseDayButtonWithTooltip extends ConsumerWidget {
  final TrainingBlockClient trainingBlock;

  const AddExerciseDayButtonWithTooltip({
    super.key,
    required this.trainingBlock,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(editModeSwitcherProvider);
    final isCreateExerciseDaySeen = ref.watch(
      tutorialSettingsProvider.select((s) => s.isCreateExerciseDaySeen),
    );
    final tutorialSettingsNotifier = ref.watch(
      tutorialSettingsProvider.notifier,
    );

    final shouldShowTooltip = !isEditMode && !isCreateExerciseDaySeen;

    return TutorTooltip(
      tooltipPosition: TooltipPosition.left,
      active: shouldShowTooltip,
      order: orderCreateExerciseDay,
      onClose: () => tutorialSettingsNotifier.set(
        (prevState) => prevState.copyWith(isCreateExerciseDaySeen: true),
      ),
      buildTooltip: (_, childSize) => _Tooltip(childSize: childSize),
      buildChild: (_) => AddExerciseDayButton(trainingBlock: trainingBlock),
    );
  }
}

class _Tooltip extends StatelessWidget {
  final Size childSize;

  const _Tooltip({
    super.key,
    required this.childSize,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(childSize.width + 12, -25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Transform.scale(
            scale: 0.8,
            child: SizedBox(
              width: 75,
              child: SvgPicture.asset(
                'assets/tutorial-arrow-pointing-to-box.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(-10, -10),
            child: SizedBox(
              width: 200,
              child: Text(
                'Tap to create a new exercise day',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: GoogleFonts.indieFlower().fontFamily,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
