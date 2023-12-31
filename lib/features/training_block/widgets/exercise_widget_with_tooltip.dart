import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweatnotes/features/training_block/widget_params.dart';

import '../../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../../settings/compact_mode_switcher.dart';
import '../../settings/edit_mode_switcher.dart';
import '../../settings/tutorial_settings.dart';
import '../data/models_client/exercise_client.dart';
import '../data/models_client/exercise_type_client.dart';
import 'exercise_widget.dart';

class ExerciseWidgetWithTooltip extends ConsumerWidget {
  final bool isEnabled;
  final ExerciseTypeClient exerciseType;
  final ExerciseClient exercise;

  const ExerciseWidgetWithTooltip({
    super.key,
    required this.isEnabled,
    required this.exerciseType,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final child = ExerciseWidget(
      exerciseType: exerciseType,
      exercise: exercise,
    );

    if (!isEnabled) return child;

    final isEditMode = ref.watch(editModeSwitcherProvider);
    final isExerciseSeen = ref.watch(
      tutorialSettingsProvider.select((s) => s.isExerciseSeen),
    );

    final showTooltip = !isEditMode || !isExerciseSeen;

    return TutorTooltip(
      active: showTooltip,
      order: orderExercise,
      buildTooltip: (_, rect) => const _Tooltip(),
      // wrapping in ProviderScope is necessary, because the child depends on a service
      // that'll be outside of the scope of the parent TutorTooltip, hence it'll throw
      //
      // @see https://riverpod.dev/docs/concepts/scopes#showing-dialogs
      buildChild: (_) => ProviderScope(
        parent: ProviderScope.containerOf(context),
        child: child,
      ),
    );
  }
}

class _Tooltip extends ConsumerWidget {
  const _Tooltip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exerciseSetWidth = ref.watch(
      widgetParamsProvider.select((s) => s.exerciseSetWidth),
    );
    final exerciseTypeHeight = ref.watch(
      widgetParamsProvider.select((s) => s.exerciseTypeHeight),
    );

    final isCompactMode = ref.watch(compactModeSwitcherProvider);

    final double dimension = isCompactMode ? 120 : 140;

    return Transform.translate(
      offset: Offset(
        -(dimension - exerciseSetWidth) / 2 - 15,
        -(dimension + exerciseTypeHeight) / 2 + 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.rotate(
            angle: pi / 16,
            child: Transform.flip(
              flipX: true,
              child: SizedBox(
                width: dimension,
                height: dimension,
                child: SvgPicture.asset(
                  'assets/tutorial-circle.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(10, -20),
            child: SizedBox(
              width: 150,
              child: Text(
                'Tap to record a set',
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
