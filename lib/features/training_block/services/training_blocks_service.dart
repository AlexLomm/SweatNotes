import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app.dart';
import '../../../shared/services/firebase.dart';
import '../../../utils/generate_hash.dart';
import '../data/exercise_types_repository.dart';
import '../data/models/exercise_type.dart';
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

  Future<void> updateNameAndStartedAtDate(
    TrainingBlockClient trainingBlock, {
    required String name,
    required Timestamp startedAt,
  }) {
    return trainingBlocksRepository.update(
      trainingBlock.copyWith(name: name, startedAt: startedAt).toDbModel(),
    );
  }

  Future<void> collapsePastExercisesAt(
    TrainingBlockClient trainingBlock, {
    required int index,
  }) {
    assert(trainingBlock.exerciseDays.isNotEmpty);
    assert(index >= 0 &&
        index <
            trainingBlock.exerciseDays[0].exerciseTypes[0].exercises.length);

    return trainingBlocksRepository.update(
      trainingBlock
          .copyWith(exercisesCollapsedIncludingIndex: index)
          .toDbModel(),
    );
  }

  Future<void> expandExercises(TrainingBlockClient trainingBlock) {
    return trainingBlocksRepository.update(
      trainingBlock.copyWith(exercisesCollapsedIncludingIndex: -1).toDbModel(),
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

    final updatedTrainingBlockDbModel =
        trainingBlock.archiveExerciseDay(exerciseDay, archive).toDbModel();

    batch.update(
      trainingBlocksRepository.getDocumentRef(updatedTrainingBlockDbModel.id),
      updatedTrainingBlockDbModel.toJson(),
    );

    for (final exerciseType in exerciseDay.exerciseTypes) {
      final updatedExerciseTypeDbModel =
          exerciseType.archive(archive).toDbModel();

      batch.update(
        exerciseTypesRepository.getDocumentRef(updatedExerciseTypeDbModel.id),
        updatedExerciseTypeDbModel.toJson(),
      );
    }

    return batch.commit();
  }

  Future<void> archive(TrainingBlockClient trainingBlock, bool archive) {
    return trainingBlocksRepository.archive(
      trainingBlock.dbModel.id,
      archive,
    );
  }

  Future<void> copyWithPersonalRecords(
    TrainingBlockClient trainingBlock, {
    required String trainingBlockName,
    required Timestamp startedAt,
  }) async {
    final trainingBlockWithOnlyPersonalRecords =
        trainingBlock.getWithOnlyPersonalRecords();

    final batch = firestore.batch();

    final trainingBlockDocumentRef =
        trainingBlocksRepository.getDocumentRef(null);
    var newTrainingBlock =
        trainingBlockWithOnlyPersonalRecords.toDbModel().copyWith(
              id: trainingBlockDocumentRef.id,
              name: trainingBlockName,
              startedAt: startedAt,
              exerciseDaysOrdering: {},
              exercisesCollapsedIncludingIndex: -1,
              exerciseDays: [],
            );

    final Map<String, int> exerciseDaysOrdering = {};
    for (final exerciseDay
        in trainingBlockWithOnlyPersonalRecords.exerciseDays) {
      final clonedExerciseDayPseudoId = generateHash();
      final clonedExerciseDay = exerciseDay.toDbModel().copyWith(
        pseudoId: clonedExerciseDayPseudoId,
        archivedAt: null,
        exerciseTypesOrdering: {},
      );

      exerciseDaysOrdering[clonedExerciseDayPseudoId] = trainingBlock
              .dbModel.exerciseDaysOrdering[exerciseDay.dbModel.pseudoId] ??
          0;

      final Map<String, int> exerciseTypesOrdering = {};
      for (final exerciseType in exerciseDay.exerciseTypes) {
        final exerciseTypeDocumentRef =
            exerciseTypesRepository.getDocumentRef(null);
        final newExerciseType = exerciseType.toDbModel().copyWith(
              id: exerciseTypeDocumentRef.id,
              trainingBlockId: trainingBlockDocumentRef.id,
            );

        assert(exerciseDay
                .dbModel.exerciseTypesOrdering[exerciseType.dbModel.id] !=
            null);

        exerciseTypesOrdering[exerciseTypeDocumentRef.id] = exerciseDay
                .dbModel.exerciseTypesOrdering[exerciseType.dbModel.id] ??
            0;

        batch.set<ExerciseType>(
          exerciseTypeDocumentRef,
          newExerciseType,
        );
      }

      newTrainingBlock = newTrainingBlock.copyWith(exerciseDays: [
        ...newTrainingBlock.exerciseDays,
        clonedExerciseDay.copyWith(exerciseTypesOrdering: exerciseTypesOrdering)
      ]);
    }

    batch.set<TrainingBlock>(
      trainingBlockDocumentRef,
      newTrainingBlock.copyWith(exerciseDaysOrdering: exerciseDaysOrdering),
    );

    return batch.commit();
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
