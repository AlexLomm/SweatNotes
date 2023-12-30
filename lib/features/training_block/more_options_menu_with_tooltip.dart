import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../settings/edit_mode_switcher.dart';
import '../settings/tutorial_settings.dart';
import 'more_options_menu.dart';

class MoreOptionsMenuWithTooltip extends ConsumerWidget {
  final bool isTooltipEnabled;

  const MoreOptionsMenuWithTooltip({
    super.key,
    required this.isTooltipEnabled,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const child = MoreOptionsMenu();

    if (!isTooltipEnabled) return child;

    final isEditMode = ref.watch(editModeSwitcherProvider);
    final isMoreOptionsMenuSeen = ref.watch(
      tutorialSettingsProvider.select((s) => s.isMoreOptionsMenuSeen),
    );

    final showTooltip = !isEditMode && !isMoreOptionsMenuSeen;

    return TutorTooltip(
      active: showTooltip,
      order: orderMoreOptionsMenu,
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
                'Tap to customize various aspects of your training plan',
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
