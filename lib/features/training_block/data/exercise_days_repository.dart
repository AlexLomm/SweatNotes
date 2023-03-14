import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:journal_flutter/features/training_block/data/exercises_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase.dart';
import 'models/exercise.dart';
import 'models/exercise_day.dart';

part 'exercise_days_repository.g.dart';

class ExerciseDaysRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final ExercisesRepository exercisesRepository;

  ExerciseDaysRepository(
    this.firestore,
    this.firebaseAuth,
    this.exercisesRepository,
  );

  get collectionRef => firestore
      //
      .collection('exercise-days')
      .withConverter(
        fromFirestore: _fromFirestore,
        toFirestore: _toFirestore,
      );

  Query<ExerciseDay> getQueryByTrainingBlockId(String trainingBlockId) {
    return collectionRef
        .where('trainingBlockId', isEqualTo: trainingBlockId)
        .where('userId', isEqualTo: firebaseAuth.currentUser?.uid);
  }

  DocumentReference<ExerciseDay> getDocumentRefById(String id) {
    return collectionRef.doc(id);
  }

  Future<DocumentReference<ExerciseDay>> add(
    ExerciseDay exerciseDay,
  ) {
    return collectionRef.add(exerciseDay);
  }

  Future<void> update(
    ExerciseDay exerciseDay,
  ) {
    final docRef = getDocumentRefById(exerciseDay.id);

    // TODO: use withConverter?
    return docRef.update(_toFirestore(exerciseDay, null));
  }

  Future<void> moveExerciseTypeIntoAnotherExerciseDay({
    required ExerciseDay oldExerciseDay,
    required ExerciseDay newExerciseDay,
    required List<Exercise> exercises,
  }) async {
    final batch = firestore.batch();

    for (final exerciseDay in [oldExerciseDay, newExerciseDay]) {
      final docRef = getDocumentRefById(exerciseDay.id);

      batch.update(docRef, {"exerciseTypesOrdering": exerciseDay.exerciseTypesOrdering});
    }

    for (final exercise in exercises) {
      final docRef = exercisesRepository.getDocumentRefById(exercise.id);

      batch.update(docRef, {"exerciseDayId": newExerciseDay.id});
    }

    return batch.commit();
  }

  ExerciseDay _fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc, _) {
    final dataWithoutId = doc.data();

    if (dataWithoutId == null) {
      return ExerciseDay.fromJson({});
    }

    final data = {'id': doc.id, ...dataWithoutId};

    return ExerciseDay.fromJson(data);
  }

  Map<String, dynamic> _toFirestore(ExerciseDay exerciseDay, _) => exerciseDay.toJson();
}

@riverpod
ExerciseDaysRepository exerciseDaysRepository(ExerciseDaysRepositoryRef ref) {
  final firestore = ref.read(firestoreProvider);
  final firebaseAuth = ref.read(firebaseAuthProvider);
  final exercisesRepository = ref.read(exercisesRepositoryProvider);

  return ExerciseDaysRepository(firestore, firebaseAuth, exercisesRepository);
}
