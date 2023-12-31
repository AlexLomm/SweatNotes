import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/widgets/tutor/constants/enums.dart';
import '../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../settings/show_archived_exercise_types_switcher.dart';
import '../settings/tutorial_settings.dart';
import 'toggle_edit_mode_button.dart';

class ToggleEditModeWithTooltip extends ConsumerWidget {
  final bool hasAtLeastOneExerciseDay;

  const ToggleEditModeWithTooltip({
    super.key,
    required this.hasAtLeastOneExerciseDay,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showArchived = ref.watch(showArchivedExerciseTypesSwitcherProvider);
    final isEditModeSeen = ref.watch(
      tutorialSettingsProvider.select((s) => s.isEditModeSeen),
    );

    final shouldShowTooltip =
        hasAtLeastOneExerciseDay && !showArchived && !isEditModeSeen;

    return TutorTooltip(
      tooltipPosition: TooltipPosition.left,
      active: shouldShowTooltip,
      order: orderEditModeSwitcher,
      buildTooltip: (_, childSize) => _Tooltip(childSize: childSize),
      buildChild: (_) => const ToggleEditModeButton(),
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
            child: Transform.rotate(
              angle: pi,
              child: SizedBox(
                width: 75,
                child: SvgPicture.asset(
                  'assets/tutorial-arrow-pointing-to-box.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(-10, -10),
            child: SizedBox(
              width: 200,
              child: Text(
                'Tap to edit exercises, rename your plan, etc.',
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
