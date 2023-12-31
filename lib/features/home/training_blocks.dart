import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/widgets/full_screen.dart';
import '../../widgets/empty_page_placeholder.dart';
import '../training_block/data/models_client/training_block_client.dart';
import 'training_block_button_with_tooltip.dart';

class TrainingBlocks extends ConsumerWidget {
  final List<TrainingBlockClient> data;

  const TrainingBlocks({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (data.isEmpty) {
      return const Center(child: EmptyPagePlaceholder());
    }

    return FullScreen(
      child: ListView(
        children: [
          for (final entry in data.asMap().entries)
            TrainingBlockButtonWithTooltip(
              key: ValueKey(entry.key),
              isTooltipEnabled: entry.key == 0,
              trainingBlock: entry.value,
            ),
        ],
      ),
    );
  }
}
