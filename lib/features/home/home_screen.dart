import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';

import '../../widgets/button.dart';
import '../../widgets/layout.dart';
import '../training_block/data/models/training_block.dart';
import '../training_block/services/training_blocks_service.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingBlocksService = ref.watch(trainingBlocksServiceProvider);

    final mq = MediaQuery.of(context);

    return Layout(
      child: StreamBuilder<List<TrainingBlock>>(
        // TODO: dispose stream?
        stream: trainingBlocksService.trainingBlocks,
        builder: (context, snapshot) {
          final appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
          final safeAreaHeight = mq.size.height -
              mq.padding.top -
              mq.padding.bottom -
              appBarHeight;

          final data = snapshot.data;

          if (data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SizedBox(
            height: safeAreaHeight,
            width: mq.size.width,
            child: data.isEmpty
                // TODO: add dark mode
                ? const RiveAnimation.asset(
                    alignment: Alignment.center,
                    'empty-state-home-light.riv',
                  )
                : ListView(children: [
                    for (final trainingBlock in data)
                      Container(
                        key: Key(trainingBlock.id),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Button(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 24.0,
                          ),
                          borderRadius: 12,
                          label: trainingBlock.name,
                          onPressed: () => context.go('/${trainingBlock.id}'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                trainingBlock.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                    ),
                              ),
                              Transform.rotate(
                                angle: pi,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  ]),
          );
        },
      ),
    );
  }
}
