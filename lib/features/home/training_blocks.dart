import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/empty_page_placeholder.dart';
import '../settings/tutorial_settings.dart';
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
    return Builder(
      builder: (context) {
        final mq = MediaQuery.of(context);

        final appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
        final safeAreaHeight =
            mq.size.height - mq.padding.top - mq.padding.bottom - appBarHeight;

        if (data.isEmpty) {
          return const Center(child: EmptyPagePlaceholder());
        }

        final tutorialSettings = ref.watch(tutorialSettingsProvider);
        final tutorialSettingsNotifier =
            ref.watch(tutorialSettingsProvider.notifier);

        return SizedBox(
          height: safeAreaHeight,
          width: mq.size.width,
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
      },
    );
  }
}
