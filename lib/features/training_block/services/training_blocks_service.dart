import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app.dart';
import '../../../shared/services/firebase.dart';
import '../data/exercise_types_repository.dart';
import '../data/models/training_block.dart';
import '../data/models_client/exercise_day_client.dart';
import '../data/models_client/training_block_client.dart';
import '../data/training_blocks_repository.dart';

part 'training_blocks_service.g.dart';

class TrainingBlocksService {
  final TrainingBlocksRepository trainingBlocksRepository;
  final ExerciseTypesRepository exerciseTypesRepository;
  final ScaffoldMessengerState? messenger;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  TrainingBlocksService(
    this.trainingBlocksRepository,
    this.exerciseTypesRepository,
    this.messenger,
    this.firebaseAuth,
    this.firestore,
  );

  Future<void> create({
    required String name,
    required Timestamp startedAt,
  }) async {
    final userId = firebaseAuth.currentUser?.uid;

    if (userId == null) {
      throw Exception('User is not logged in');
    }

    return trainingBlocksRepository.create(TrainingBlock(
      id: '',
      name: name,
      startedAt: startedAt,
    ));
  }

  Future<void> updateName(TrainingBlockClient trainingBlock, String name) {
    return trainingBlocksRepository.update(
      trainingBlock.copyWith(name: name).toDbModel(),
    );
  }

  Future<void> moveExerciseDay({
    required TrainingBlockClient trainingBlock,
    required ExerciseDayClient exerciseDay,
    required int moveBy,
  }) {
    final trainingBlockServer = trainingBlock
        .reorderExerciseDay(
          exerciseDay: exerciseDay,
          moveBy: moveBy,
        )
        .toDbModel();

    return trainingBlocksRepository.update(trainingBlockServer);
  }

  Future<void> archiveExerciseDay({
    required TrainingBlockClient trainingBlock,
    required ExerciseDayClient exerciseDay,
    required bool archive,
  }) {
    final batch = firestore.batch();

    final updatedTrainingBlockDbModel = trainingBlock.archiveExerciseDay(exerciseDay, archive).toDbModel();

    batch.update(
      trainingBlocksRepository.getDocumentRefById(updatedTrainingBlockDbModel.id),
      updatedTrainingBlockDbModel.toJson(),
    );

    for (final exerciseType in exerciseDay.exerciseTypes) {
      final updatedExerciseTypeDbModel = exerciseType.archive(archive).toDbModel();

      batch.update(
        exerciseTypesRepository.getDocumentRefById(updatedExerciseTypeDbModel.id),
        updatedExerciseTypeDbModel.toJson(),
      );
    }

    return batch.commit();
  }

  Future<void> archive(TrainingBlockClient trainingBlock, bool archive) {
    return trainingBlocksRepository.update(trainingBlock.archive(archive).toDbModel());
  }
}

@riverpod
TrainingBlocksService trainingBlocksService(TrainingBlocksServiceRef ref) {
  final trainingBlocksRepository = ref.watch(trainingBlocksRepositoryProvider);
  final exerciseTypesRepository = ref.watch(exerciseTypesRepositoryProvider);
  final messenger = ref.watch(messengerProvider);
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final firestore = ref.watch(firestoreProvider);

  return TrainingBlocksService(
    trainingBlocksRepository,
    exerciseTypesRepository,
    messenger,
    firebaseAuth,
    firestore,
  );
}
