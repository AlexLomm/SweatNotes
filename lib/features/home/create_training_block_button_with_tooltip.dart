import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../router/router.dart';
import '../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../settings/tutorial_settings.dart';

class CreateTrainingBlockButtonWithTooltip extends ConsumerWidget {
  const CreateTrainingBlockButtonWithTooltip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tutorialSettingsNotifier = ref.watch(
      tutorialSettingsProvider.notifier,
    );

    final showCreateTrainingBlockTooltip = ref.watch(
      tutorialSettingsProvider.select(
        (s) => !s.isCreateTrainingBlockSeen,
      ),
    );

    final cs = Theme.of(context).colorScheme;

    return TutorTooltip(
      order: orderCreateTrainingBlock,
      active: showCreateTrainingBlockTooltip,
      onClose: () => tutorialSettingsNotifier.set((prevState) {
        return prevState.copyWith(isCreateTrainingBlockSeen: true);
      }),
      buildTooltip: (_, __) => const _TutorialTooltipCreateTrainingBlock(),
      buildChild: (controller) => IconButton(
        icon: Icon(Icons.add, color: cs.onSurface),
        tooltip: 'Add new training block',
        splashRadius: 20,
        onPressed: () {
          if (controller.isInProgress) {
            controller.next();
          } else {
            context.pushNamed(RouteNames.trainingBlockCreateUpdate);
          }
        },
      ),
    );
  }
}

class _TutorialTooltipCreateTrainingBlock extends StatelessWidget {
  const _TutorialTooltipCreateTrainingBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 75,
            child: SvgPicture.asset(
              'assets/tutorial-arrow-pointing-to-circle.svg',
              fit: BoxFit.contain,
            ),
          ),
          Transform.translate(
            offset: const Offset(10, 0),
            child: SizedBox(
              width: 200,
              child: Text(
                'Tap to create a new training block',
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
