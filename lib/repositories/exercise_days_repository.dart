import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/exercise_day.dart';

part 'exercise_days_repository.g.dart';

class ExerciseDaysRepository {
  Query<ExerciseDay> getExerciseDaysQuery({
    required String trainingBlockId,
  }) {
    // TODO: add provider
    return FirebaseFirestore.instance
        .collection('exercise-days')
        .where('trainingBlockId', isEqualTo: trainingBlockId)
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
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
    final snapshot = await getExerciseDaysQuery(
      trainingBlockId: trainingBlockId,
    ).get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}

@riverpod
ExerciseDaysRepository exerciseDaysRepository(ExerciseDaysRepositoryRef ref) {
  return ExerciseDaysRepository();
}
