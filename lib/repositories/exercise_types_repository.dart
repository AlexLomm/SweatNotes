import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/exercise_type.dart';

class ExerciseTypesRepository {
  Query<ExerciseType> getExerciseTypesQuery() {
    return FirebaseFirestore.instance
        .collection('exercise-types')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .withConverter(
          fromFirestore: (doc, _) {
            final dataWithoutId = doc.data();

            if (dataWithoutId == null) {
              return ExerciseType.fromJson({});
            }

            final data = {'id': doc.id, ...dataWithoutId};

            return ExerciseType.fromJson(data);
          },
          toFirestore: (exerciseType, _) => exerciseType.toJson(),
        );
  }

  Future<List<ExerciseType>> fetchExerciseTypes() async {
    final snapshot = await getExerciseTypesQuery().get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
