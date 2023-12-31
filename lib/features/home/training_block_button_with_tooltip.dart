import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweatnotes/features/home/training_block_button.dart';
import 'package:sweatnotes/features/home/tutorial_tooltip_training_block.dart';

import '../../shared/widgets/tutor/constants/enums.dart';
import '../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../settings/show_archived_training_blocks_switcher.dart';
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
    final child = TrainingBlockButton(
      trainingBlock: trainingBlock,
    );

    if (!isTooltipEnabled) return child;

    final tutorialSettingsNotifier = ref.watch(
      tutorialSettingsProvider.notifier,
    );

    final showArchivedTrainingBlocks = ref.watch(
      showArchivedTrainingBlocksSwitcherProvider,
    );

    final isTrainingBlockListSeen = ref.watch(
      tutorialSettingsProvider.select(
        (s) => s.isTrainingBlockListSeen,
      ),
    );

    final shouldShowTooltip =
        !isTrainingBlockListSeen && !showArchivedTrainingBlocks;

    return TutorTooltip(
      tooltipPosition: TooltipPosition.bottom,
      order: orderTrainingBlockList,
      active: shouldShowTooltip,
      onClose: () => tutorialSettingsNotifier.set(
        (prevState) => prevState.copyWith(isTrainingBlockListSeen: true),
      ),
      buildTooltip: (_, childSize) => TutorialTooltipTrainingBlock(
        childSize: childSize,
      ),
      buildChild: (controller) => TrainingBlockButton(
        trainingBlock: trainingBlock,
      ),
    );
  }
}
