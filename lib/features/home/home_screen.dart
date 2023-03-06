import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
          final data = snapshot.data;

          if (data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SizedBox(
            height: mq.size.height,
            width: mq.size.width,
            child: ListView(
              children: [
                for (final trainingBlock
                    in snapshot.data as List<TrainingBlock>)
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
              ],
            ),
          );
        },
      ),
    );
  }
}
