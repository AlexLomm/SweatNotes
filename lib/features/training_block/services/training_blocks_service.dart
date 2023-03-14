import 'package:firebase_auth/firebase_auth.dart';
import 'package:journal_flutter/features/training_block/data/models_client/training_block_client.dart';
import 'package:journal_flutter/firebase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/models/training_block.dart';
import '../data/training_blocks_repository.dart';

part 'training_blocks_service.g.dart';

class TrainingBlocksService {
  final TrainingBlocksRepository trainingBlocksRepository;
  final FirebaseAuth firebaseAuth;

  TrainingBlocksService(this.trainingBlocksRepository, this.firebaseAuth);

  Stream<List<TrainingBlock>> get trainingBlocks => trainingBlocksRepository
      //
      .getQuery()
      .snapshots()
      .map<List<TrainingBlock>>(
        (event) => event.docs.map((doc) => doc.data()).toList(),
      );

  void create({required String name}) {
    final userId = firebaseAuth.currentUser?.uid;

    if (userId == null) {
      throw Exception('User is not logged in');
    }

    trainingBlocksRepository.create(
      TrainingBlock(
        id: '',
        userId: userId,
        name: name,
        exerciseDaysOrdering: {},
      ),
    );
  }

  Future<void> moveExerciseDay({
    required TrainingBlockClient trainingBlock,
    required String exerciseDayId,
    required int moveBy,
  }) {
    final trainingBlockServer = trainingBlock
        .reorderExerciseDay(
          exerciseDayId: exerciseDayId,
          moveBy: moveBy,
        )
        .toTrainingBlock();

    return trainingBlocksRepository.update(trainingBlockServer);
  }
}

@riverpod
TrainingBlocksService trainingBlocksService(TrainingBlocksServiceRef ref) {
  final trainingBlocksRepository = ref.watch(trainingBlocksRepositoryProvider);
  final firebaseAuth = ref.watch(firebaseAuthProvider);

  return TrainingBlocksService(trainingBlocksRepository, firebaseAuth);
}
