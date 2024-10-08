import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/models/training_block.dart';
import '../data/models_client/training_block_client.dart';
import '../data/training_blocks_repository.dart';

part 'training_blocks_stream.g.dart';

@riverpod
Stream<List<TrainingBlockClient>> trainingBlocksStream(
  TrainingBlocksStreamRef ref, {
  required bool includeArchived,
}) async* {
  final trainingBlocksRepository = ref.watch(trainingBlocksRepositoryProvider);

  final Stream<List<TrainingBlockClient>> trainingBlockStream =
      trainingBlocksRepository
          //
          .getTrainingBlocksQueryRef(includeArchived: includeArchived)
          .snapshots()
          .map<List<TrainingBlock>>(
    (event) {
      final trainingBlocks = event.docs.map((doc) => doc.data()).toList();

      // add sorting on the client side because:
      //   1. `orderBy` on fields that might be missing (example: `startedAt`) will
      //      cause training blocks without that field missing be excluded from the list.
      //   2. might avoid hotspot-related issues, see:
      //      https://cloud.google.com/firestore/docs/best-practices#hotspots
      trainingBlocks.sort((a, b) {
        final timestampA = a.startedAt ?? Timestamp(0, 0);
        final timestampB = b.startedAt ?? Timestamp(0, 0);

        return timestampB.compareTo(timestampA);
      });

      return trainingBlocks;
    },
  ).map(
    (List<TrainingBlock> trainingBlocks) => trainingBlocks
        .map(
          (trainingBlock) => TrainingBlockClient(
            dbModel: trainingBlock,
            archivedAt: trainingBlock.archivedAt,
            startedAt: trainingBlock.startedAt,
            name: trainingBlock.name,
            // TODO: inconsistency between client and db model
            exerciseDays: [],
            exercisesCollapsedIncludingIndex:
                trainingBlock.exercisesCollapsedIncludingIndex,
          ),
        )
        .toList(),
  );

  yield* trainingBlockStream;
}
