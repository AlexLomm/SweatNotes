import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../router/router.dart';
import '../../shared/widgets/tutor/constants/enums.dart';
import '../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../settings/tutorial_settings.dart';

class SettingsButtonWithTooltip extends ConsumerWidget {
  const SettingsButtonWithTooltip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tutorialSettingsNotifier = ref.watch(
      tutorialSettingsProvider.notifier,
    );
    final shouldShowTooltip = !ref.watch(
      tutorialSettingsProvider.select((s) => s.isSettingsSeen),
    );

    final cs = Theme.of(context).colorScheme;

    return TutorTooltip(
      tooltipPosition: TooltipPosition.left,
      order: orderSettings,
      active: shouldShowTooltip,
      onClose: () => tutorialSettingsNotifier.set((prevState) {
        return prevState.copyWith(isSettingsSeen: true);
      }),
      buildTooltip: (_, childSize) => _Tooltip(childSize: childSize),
      buildChild: (controller) => IconButton(
        icon: Icon(Icons.settings_outlined, color: cs.onSurface),
        tooltip: 'Settings',
        splashRadius: 20,
        onPressed: () => context.pushNamed(RouteNames.settings),
      ),
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
        childSize.width + 5,
        15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 75,
            child: SvgPicture.asset(
              'assets/tutorial-double-arrow-pointing-to-underline.svg',
              fit: BoxFit.contain,
            ),
          ),
          Transform.translate(
            offset: const Offset(-20, -10),
            child: SizedBox(
              width: 250,
              child: Text(
                'Tap to view and change settings to your liking.\n\nYou can customize theme, reset tutorials, etc.',
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
