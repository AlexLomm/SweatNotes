import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweatnotes/features/training_block/data/models_client/training_block_client.dart';

import '../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../settings/tutorial_settings.dart';
import 'add_exercise_day_button.dart';

class AddExerciseDayButtonWithTooltip extends ConsumerWidget {
  final bool isTooltipEnabled;
  final TrainingBlockClient trainingBlock;

  const AddExerciseDayButtonWithTooltip({
    super.key,
    required this.isTooltipEnabled,
    required this.trainingBlock,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final child = AddExerciseDayButton(trainingBlock: trainingBlock);

    if (!isTooltipEnabled) return child;

    final isCreateExerciseDaySeen = ref.watch(
      tutorialSettingsProvider.select((s) => s.isCreateExerciseDaySeen),
    );

    final shouldShowTooltip = !isCreateExerciseDaySeen;

    return TutorTooltip(
      active: shouldShowTooltip,
      order: orderCreateExerciseDay,
      buildTooltip: (_, __) => const _Tooltip(),
      buildChild: (_) => child,
    );
  }
}

class _Tooltip extends StatelessWidget {
  const _Tooltip({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(12, -75),
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
