import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/widgets/tutor/core/tutor_tooltip.dart';
import '../../widgets/empty_page_placeholder.dart';
import '../settings/tutorial_settings.dart';
import '../training_block/data/models_client/training_block_client.dart';
import 'home_screen.dart';
import 'training_block_button.dart';
import 'tutorial_tooltip_training_block.dart';

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

        print('==================================');
        print(tutorialSettings.isTrainingBlockListSeen);

        return SizedBox(
          height: safeAreaHeight,
          width: mq.size.width,
          child: ListView(
            children: [
              for (final entry in data.asMap().entries)
                if (entry.key == 0)
                  TutorTooltip(
                    key: Key(entry.value.dbModel.id),
                    order: orderTrainingBlockList,
                    active: !tutorialSettings.isTrainingBlockListSeen,
                    // TODO: fix, gets called prematurely
                    onClose: () {
                      tutorialSettingsNotifier.set((prevState) {
                        return prevState.copyWith(isTrainingBlockListSeen: true);
                      });
                    },
                    buildTooltip: (controller, globalPaintBounds) {
                      return TutorialTooltipTrainingBlock(
                        paintBounds: globalPaintBounds,
                      );
                    },
                    buildChild: (controller) => TrainingBlockButton(
                      key: Key(entry.value.dbModel.id),
                      trainingBlock: entry.value,
                    ),
                  )
                else
                  TrainingBlockButton(
                    key: Key(entry.value.dbModel.id),
                    trainingBlock: entry.value,
                  )
            ],
          ),
        );
      },
    );
  }
}
