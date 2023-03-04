import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../firebase.dart';
import '../models/exercise.dart';
import '../models_client/exercise_client.dart';

part 'exercises_repository.g.dart';

class ExercisesRepository {
  final FirebaseFirestore firestore;

  ExercisesRepository(this.firestore);

  Query<Exercise> getExercisesByExerciseDayIdQuery({
    required String exerciseDayId,
  }) {
    return firestore
        .collection('exercises')
        .where('exerciseDayId', isEqualTo: exerciseDayId)
        .where(
          'userId',
          isEqualTo: FirebaseAuth.instance.currentUser?.uid,
        )
        .orderBy('placement')
        .withConverter(
          fromFirestore: _fromFirestoreConverter,
          toFirestore: _toFirestoreConverter,
        );
  }

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

  return ExercisesRepository(firestore);
}
