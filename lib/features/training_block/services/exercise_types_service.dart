import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:journal_flutter/features/training_block/data/exercise_days_repository.dart';
import 'package:journal_flutter/features/training_block/data/exercises_repository.dart';
import 'package:journal_flutter/features/training_block/data/models_client/exercise_day_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase.dart';
import '../data/exercise_types_repository.dart';
import '../data/models/exercise.dart';
import '../data/models/exercise_type.dart';
import '../data/models_client/exercise_type_client.dart';

part 'exercise_types_service.g.dart';

class ExerciseTypesService {
  ExerciseTypesRepository exerciseTypesRepository;
  ExerciseDaysRepository exerciseDaysRepository;
  ExercisesRepository exercisesRepository;
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firestore;

  ExerciseTypesService(
    this.exerciseTypesRepository,
    this.exerciseDaysRepository,
    this.exercisesRepository,
    this.firebaseAuth,
    this.firestore,
  );

  Future<void> setName({
    required ExerciseTypeClient exerciseTypeClient,
    required String name,
  }) async {
    exerciseTypesRepository
        .getDocumentRefById(exerciseTypeClient.id)
        .set(exerciseTypeClient.copyWith(name: name).toExerciseType());
  }

  Future<void> create({
    required ExerciseDayClient exerciseDay,
    required String name,
    required String unit,
  }) async {
    final userId = firebaseAuth.currentUser?.uid;

    if (userId == null) throw Exception('User is not logged in');

    final batch = firestore.batch();

    final exerciseTypeRef = exerciseTypesRepository.collectionRef.doc();
    final exerciseRef = exercisesRepository.collectionRef.doc();

    final orderingValues = exerciseDay.exerciseTypesOrdering.values;
    final maxOrder = orderingValues.isEmpty ? 0 : orderingValues.reduce(max);
    final exerciseDayRef = exerciseDaysRepository.getDocumentRefById(
      exerciseDay.id,
    );

    final orderings = {...exerciseDay.exerciseTypesOrdering};
    orderings[exerciseTypeRef.id] = maxOrder + 1;

    batch.update(exerciseDayRef, {'exerciseTypesOrdering': orderings});

    batch.set(
      exerciseTypeRef,
      ExerciseType(
        id: exerciseTypeRef.id,
        userId: userId,
        name: name,
        unit: unit,
      ),
    );

    batch.set(
      exerciseRef,
      Exercise(
        id: exerciseRef.id,
        exerciseTypeId: exerciseTypeRef.id,
        trainingBlockId: exerciseDay.trainingBlockId,
        exerciseDayId: exerciseDay.id,
        userId: userId,
        placement: 0,
      ),
    );

    return batch.commit();
  }
}

@riverpod
ExerciseTypesService exerciseTypesService(ExerciseTypesServiceRef ref) {
  final exerciseTypesRepository = ref.watch(exerciseTypesRepositoryProvider);
  final exerciseDaysRepository = ref.watch(exerciseDaysRepositoryProvider);
  final exercisesRepository = ref.watch(exercisesRepositoryProvider);
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final firestore = ref.watch(firestoreProvider);

  return ExerciseTypesService(
    exerciseTypesRepository,
    exerciseDaysRepository,
    exercisesRepository,
    firebaseAuth,
    firestore,
  );
}
