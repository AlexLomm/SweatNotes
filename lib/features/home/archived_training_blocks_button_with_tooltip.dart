import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../settings/show_archived_training_blocks_switcher.dart';
import '../settings/tutorial_settings.dart';

class ArchivedTrainingBlocksButtonWithTooltip extends ConsumerWidget {
  final bool hasAtLeastOneTrainingBlock;

  const ArchivedTrainingBlocksButtonWithTooltip({
    super.key,
    required this.hasAtLeastOneTrainingBlock,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tutorialSettingsNotifier = ref.watch(
      tutorialSettingsProvider.notifier,
    );

    final showArchivedTrainingBlocksSwitcher = ref.watch(
      showArchivedTrainingBlocksSwitcherProvider.notifier,
    );
    final areArchivedTrainingBlocksShown = ref.watch(
      showArchivedTrainingBlocksSwitcherProvider,
    );

    final isSeeArchivedTrainingBlocksSeen = ref.watch(
      tutorialSettingsProvider.select(
        (s) => s.isSeeArchivedTrainingBlocksSeen,
      ),
    );

    final shouldShowTooltip = !isSeeArchivedTrainingBlocksSeen &&
        !areArchivedTrainingBlocksShown &&
        hasAtLeastOneTrainingBlock;

    final cs = Theme.of(context).colorScheme;

    return TutorTooltip(
      order: orderShowArchived,
      active: shouldShowTooltip,
      onClose: () => tutorialSettingsNotifier.set(
        (prevState) => prevState.copyWith(
          isSeeArchivedTrainingBlocksSeen: true,
        ),
      ),
      buildTooltip: (_, __) =>
          const _TutorialTooltipSeeArchivedTrainingBlocks(),
      buildChild: (controller) => IconButton(
        icon: Icon(
          areArchivedTrainingBlocksShown
              ? Icons.cancel_outlined
              : Icons.unarchive_outlined,
          color: areArchivedTrainingBlocksShown ? cs.tertiary : cs.onSurface,
        ),
        tooltip: 'Archive',
        splashRadius: 20,
        onPressed: () {
          if (controller.isInProgress) {
            controller.next();
          } else {
            showArchivedTrainingBlocksSwitcher.toggle();
          }
        },
      ),
    );
  }
}

class _TutorialTooltipSeeArchivedTrainingBlocks extends StatelessWidget {
  const _TutorialTooltipSeeArchivedTrainingBlocks({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(10, -30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 75,
            child: SvgPicture.asset(
              'assets/tutorial-arrow-pointing-to-wave.svg',
              fit: BoxFit.contain,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -10),
            child: SizedBox(
              width: 225,
              child: Text(
                'Tap to view archived training blocks',
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
