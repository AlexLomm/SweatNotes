import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase.dart';
import 'models/exercise_day.dart';

part 'exercise_days_repository.g.dart';

class ExerciseDaysRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  ExerciseDaysRepository(this.firestore, this.firebaseAuth);

  Query<ExerciseDay> getQueryByTrainingBlockId(String trainingBlockId) {
    return firestore
        .collection('exercise-days')
        .where('trainingBlockId', isEqualTo: trainingBlockId)
        .where('userId', isEqualTo: firebaseAuth.currentUser?.uid)
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        );
  }

  DocumentReference<ExerciseDay> getDocumentRefById(String id) {
    return firestore.collection('exercise-days').doc(id).withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        );
  }

  Future<List<ExerciseDay>> fetchTrainingBlockId(
    String trainingBlockId,
  ) async {
    final snapshot = await getQueryByTrainingBlockId(trainingBlockId).get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<DocumentReference<ExerciseDay>> addExerciseDay(
      ExerciseDay exerciseDay) {
    return firestore
        .collection('exercise-days')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(exerciseDay);
  }

  ExerciseDay _fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc, _) {
    final dataWithoutId = doc.data();

    if (dataWithoutId == null) {
      return ExerciseDay.fromJson({});
    }

    final data = {'id': doc.id, ...dataWithoutId};

    return ExerciseDay.fromJson(data);
  }

  Map<String, dynamic> _toFirestore(ExerciseDay exerciseDay, _) =>
      exerciseDay.toJson();
}

@riverpod
ExerciseDaysRepository exerciseDaysRepository(ExerciseDaysRepositoryRef ref) {
  final firestore = ref.read(firestoreProvider);
  final firebaseAuth = ref.read(firebaseAuthProvider);

  return ExerciseDaysRepository(firestore, firebaseAuth);
}
