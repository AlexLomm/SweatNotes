import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase.dart';
import 'models/exercise.dart';
import 'models_client/exercise_client.dart';

part 'exercises_repository.g.dart';

class ExercisesRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  ExercisesRepository(this.firestore, this.firebaseAuth);

  CollectionReference<Exercise> get collectionRef => firestore
      //
      .collection('exercises')
      .withConverter(
        fromFirestore: _fromFirestore,
        toFirestore: _toFirestore,
      );

  DocumentReference<Exercise> getDocumentRefById(String id) {
    return collectionRef.doc(id);
  }

  Future<void> setExercise(ExerciseClient exerciseClient) {
    final exercise = exerciseClient.toExercise();

    // if the exercise doesn't exist, create it
    if (exerciseClient.isFiller) {
      return collectionRef.add(exercise);
    }

    // otherwise, update it
    return collectionRef.doc(exerciseClient.id).set(exercise, SetOptions(merge: true));
  }

  Future<void> addExercise(ExerciseClient exerciseClient) {
    final exercise = exerciseClient.toExercise();

    return collectionRef.add(exercise);
  }

  Query<Exercise> getQueryByTrainingBlockId(String trainingBlockId) {
    return collectionRef
        .where('trainingBlockId', isEqualTo: trainingBlockId)
        .where('userId', isEqualTo: firebaseAuth.currentUser?.uid)
        .orderBy('placement');
  }

  Exercise _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? _,
  ) {
    final dataWithoutId = doc.data();

    if (dataWithoutId == null) {
      return Exercise.fromJson({});
    }

    return Exercise.fromJson({'id': doc.id, ...dataWithoutId});
  }

  Map<String, dynamic> _toFirestore(
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
