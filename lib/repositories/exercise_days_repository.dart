import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../firebase.dart';
import '../models/exercise_day.dart';

part 'exercise_days_repository.g.dart';

class ExerciseDaysRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  ExerciseDaysRepository(this.firestore, this.firebaseAuth);

  Query<ExerciseDay> getExerciseDaysQuery(String trainingBlockId) {
    return firestore
        .collection('exercise-days')
        .where('trainingBlockId', isEqualTo: trainingBlockId)
        .where('userId', isEqualTo: firebaseAuth.currentUser?.uid)
        .withConverter(
          fromFirestore: (doc, _) {
            final dataWithoutId = doc.data();

            if (dataWithoutId == null) {
              return ExerciseDay.fromJson({});
            }

            final data = {'id': doc.id, ...dataWithoutId};

            return ExerciseDay.fromJson(data);
          },
          toFirestore: (exerciseDay, _) => exerciseDay.toJson(),
        );
  }

  Future<List<ExerciseDay>> fetchExerciseDays({
    required String trainingBlockId,
  }) async {
    final snapshot = await getExerciseDaysQuery(trainingBlockId).get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}

@riverpod
ExerciseDaysRepository exerciseDaysRepository(ExerciseDaysRepositoryRef ref) {
  final firestore = ref.read(firestoreProvider);
  final firebaseAuth = ref.read(firebaseAuthProvider);

  return ExerciseDaysRepository(firestore, firebaseAuth);
}
