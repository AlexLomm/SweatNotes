import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/models/training_block.dart';
import '../data/models_client/training_block_client.dart';
import '../data/training_blocks_repository.dart';

part 'training_blocks_stream.g.dart';

@riverpod
Stream<List<TrainingBlockClient>> trainingBlocksStream(TrainingBlocksStreamRef ref) async* {
  final trainingBlocksRepository = ref.watch(trainingBlocksRepositoryProvider);

  final Stream<List<TrainingBlockClient>> trainingBlockStream = trainingBlocksRepository
      //
      .queryRef
      .snapshots()
      .map<List<TrainingBlock>>(
        (event) => event.docs.map((doc) => doc.data()).toList(),
      )
      .map(
        (trainingBlocks) => trainingBlocks
            .map(
              (trainingBlock) => TrainingBlockClient(
                dbModel: trainingBlock,
                archivedAt: trainingBlock.archivedAt,
                startedAt: trainingBlock.startedAt,
                name: trainingBlock.name,
                exerciseDays: [],
              ),
            )
            .toList(),
      );

  yield* trainingBlockStream;
}
