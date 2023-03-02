import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/exercise.dart';

class ExercisesRepository {
  Query<Exercise> getExercisesByExerciseDayIdQuery({
    required String exerciseDayId,
  }) {
    return FirebaseFirestore.instance
        .collection('exercises')
        .where('exerciseDayId', isEqualTo: exerciseDayId)
        .where(
          'userId',
          isEqualTo: FirebaseAuth.instance.currentUser?.uid,
        )
        .orderBy('placement')
        .withConverter(
          fromFirestore: (doc, _) {
            final dataWithoutId = doc.data();

            if (dataWithoutId == null) {
              return Exercise.fromJson({});
            }

            final data = {'id': doc.id, ...dataWithoutId};

            return Exercise.fromJson(data);
          },
          toFirestore: (exercise, _) => exercise.toJson(),
        );
  }

  Future<List<Exercise>> fetchExercisesByExerciseDayId({
    required String exerciseDayId,
  }) async {
    final snapshot = await getExercisesByExerciseDayIdQuery(
      exerciseDayId: exerciseDayId,
    ).get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Exercise>> fetchExercisesByMultipleExerciseDayIds({
    required List<String> exerciseDayIds,
  }) async {
    final exercises = exerciseDayIds.map(
      (exerciseDayId) => fetchExercisesByExerciseDayId(
        exerciseDayId: exerciseDayId,
      ),
    );

    final exercisesListList = await Future.wait(exercises);

    return exercisesListList.expand((exercisesList) => exercisesList).toList();
  }
}
