import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../firebase.dart';
import '../models/exercise.dart';
import '../models_client/exercise_client.dart';

part 'exercises_repository.g.dart';

class ExercisesRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  ExercisesRepository(this.firestore, this.firebaseAuth);

  Future<void> setExercise(ExerciseClient exerciseClient) {
    final collection = firestore.collection('exercises');

    final exercise = exerciseClient.toExercise();

    // if the exercise doesn't exist, create it
    if (exerciseClient.isFiller) {
      return collection
          .withConverter(
            fromFirestore: _fromFirestoreConverter,
            toFirestore: _toFirestoreConverter,
          )
          .add(exercise);
    }

    // otherwise, update it
    return collection
        .withConverter(
          fromFirestore: _fromFirestoreConverter,
          toFirestore: _toFirestoreConverter,
        )
        .doc(exerciseClient.id)
        .set(exercise, SetOptions(merge: true));
  }

  Future<List<Exercise>> fetchExercisesByTrainingBlockId(
    String trainingBlockId,
  ) async {
    final snapshot = await firestore
        .collection('exercises')
        .withConverter(
          fromFirestore: _fromFirestoreConverter,
          toFirestore: _toFirestoreConverter,
        )
        .where('trainingBlockId', isEqualTo: trainingBlockId)
        .where('userId', isEqualTo: firebaseAuth.currentUser?.uid)
        .orderBy('placement')
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Exercise _fromFirestoreConverter(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? _,
  ) {
    final dataWithoutId = doc.data();

    if (dataWithoutId == null) {
      return Exercise.fromJson({});
    }

    return Exercise.fromJson({'id': doc.id, ...dataWithoutId});
  }

  Map<String, dynamic> _toFirestoreConverter(
    Exercise exercise,
    SetOptions? _,
  ) =>
      exercise.toJson();
}

@riverpod
ExercisesRepository exercisesRepository(ExercisesRepositoryRef ref) {
  final firestore = ref.read(firestoreProvider);
  final firebaseAuth = ref.read(firebaseAuthProvider);

  return ExercisesRepository(firestore, firebaseAuth);
}
