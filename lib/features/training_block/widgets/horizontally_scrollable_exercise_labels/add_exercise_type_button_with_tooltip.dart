import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/widgets/tutor/constants/enums.dart';
import '../../../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../../../settings/edit_mode_switcher.dart';
import '../../../settings/tutorial_settings.dart';
import '../../data/models_client/exercise_day_client.dart';
import '../../data/models_client/training_block_client.dart';
import 'add_exercise_type_button.dart';

class AddExerciseTypeButtonWithTooltip extends ConsumerWidget {
  final bool isTooltipEnabled;
  final TrainingBlockClient trainingBlock;
  final ExerciseDayClient exerciseDay;

  const AddExerciseTypeButtonWithTooltip({
    super.key,
    required this.isTooltipEnabled,
    required this.trainingBlock,
    required this.exerciseDay,
  });

  @override
  Widget build(BuildContext context, ref) {
    final child = AddExerciseTypeButton(
      trainingBlock: trainingBlock,
      exerciseDay: exerciseDay,
    );

    if (!isTooltipEnabled) return child;

    final tutorialSettingsNotifier = ref.watch(
      tutorialSettingsProvider.notifier,
    );

    final isEditMode = ref.watch(editModeSwitcherProvider);
    final isCreateExerciseTypeSeen = ref.watch(
      tutorialSettingsProvider.select(
        (s) => s.isCreateExerciseTypeSeen,
      ),
    );

    final showTooltip = !isEditMode && !isCreateExerciseTypeSeen;

    return TutorTooltip(
      active: showTooltip,
      order: orderCreateExerciseType,
      tooltipPosition: TooltipPosition.top,
      onClose: () => tutorialSettingsNotifier.set(
        (prevState) => prevState.copyWith(isCreateExerciseTypeSeen: true),
      ),
      buildTooltip: (_, childSize) => _Tooltip(childSize: childSize),
      buildChild: (_) => child,
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
      offset: Offset(
        -3,
        childSize.height + 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              'Tap to add a new exercise',
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: GoogleFonts.indieFlower().fontFamily,
                fontWeight: FontWeight.w100,
                color: Colors.white,
              ),
            ),
          ),
          Transform.rotate(
            angle: -pi * 0.65,
            child: SizedBox(
              width: 75,
              child: SvgPicture.asset(
                'assets/tutorial-arrow-pointing-to-circle.svg',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
