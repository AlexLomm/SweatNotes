import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweatnotes/features/home/training_block_button.dart';
import 'package:sweatnotes/features/home/tutorial_tooltip_training_block.dart';

import '../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../settings/tutorial_settings.dart';
import '../training_block/data/models_client/training_block_client.dart';

class TrainingBlockButtonWithTooltip extends ConsumerWidget {
  final bool isTooltipEnabled;
  final TrainingBlockClient trainingBlock;

  const TrainingBlockButtonWithTooltip({
    super.key,
    required this.isTooltipEnabled,
    required this.trainingBlock,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final child =
    final tutorialSettings = ref.watch(tutorialSettingsProvider);
    final tutorialSettingsNotifier = ref.watch(
      tutorialSettingsProvider.notifier,
    );

    final child = TrainingBlockButton(
      trainingBlock: trainingBlock,
    );

    if (!isTooltipEnabled) return child;

    return TutorTooltip(
      order: orderTrainingBlockList,
      active: !tutorialSettings.isTrainingBlockListSeen,
      onClose: () => tutorialSettingsNotifier.set((prevState) {
        return prevState.copyWith(isTrainingBlockListSeen: true);
      }),
      buildTooltip: (controller, globalPaintBounds) =>
          TutorialTooltipTrainingBlock(paintBounds: globalPaintBounds),
      buildChild: (controller) => TrainingBlockButton(
        trainingBlock: trainingBlock,
      ),
    );
  }
}
