import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
        // TODO: dispose stream
        stream: trainingBlocksService.trainingBlocks,
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SizedBox(
            height: mq.size.height,
            width: mq.size.width,
            child: ListView(
              children: [
                for (final trainingBlock
                    in snapshot.data as List<TrainingBlock>)
                  TextButton(
                    child: Text(trainingBlock.name),
                    onPressed: () => context.go('/${trainingBlock.id}'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
