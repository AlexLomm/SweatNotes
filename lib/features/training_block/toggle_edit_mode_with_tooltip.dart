import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../settings/show_archived_exercise_types_switcher.dart';
import '../settings/tutorial_settings.dart';
import 'toggle_edit_mode_button.dart';

class ToggleEditModeWithTooltip extends ConsumerWidget {
  final bool isTooltipEnabled;

  const ToggleEditModeWithTooltip({
    super.key,
    required this.isTooltipEnabled,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const child = ToggleEditModeButton();

    if (!isTooltipEnabled) return child;

    final showArchived = ref.watch(showArchivedExerciseTypesSwitcherProvider);
    final isEditModeSeen = ref.watch(
      tutorialSettingsProvider.select((s) => s.isEditModeSeen),
    );

    final shouldShowTooltip = !showArchived && !isEditModeSeen;

    return TutorTooltip(
      active: shouldShowTooltip,
      order: orderEditModeSwitcher,
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
      offset: const Offset(15, -75),
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
