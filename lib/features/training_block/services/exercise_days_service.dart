import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase.dart';
import '../data/exercise_days_repository.dart';
import '../data/models/exercise_day.dart';
import '../data/models_client/exercise_day_client.dart';

part 'exercise_days_service.g.dart';

class ExerciseDaysService {
  ExerciseDaysRepository exerciseDaysRepository;
  FirebaseAuth firebaseAuth;

  ExerciseDaysService(this.exerciseDaysRepository, this.firebaseAuth);

  Future<void> setName({
    required ExerciseDayClient exerciseDay,
    required String name,
  }) async {
    exerciseDaysRepository
        .getDocumentRefById(exerciseDay.id)
        .set(exerciseDay.copyWith(name: name).toExerciseDay());
  }

  Future<void> create({
    required String trainingBlockId,
    required String name,
  }) async {
    final userId = firebaseAuth.currentUser?.uid;

    if (userId == null) {
      throw Exception('User is not logged in');
    }

    exerciseDaysRepository.addExerciseDay(ExerciseDay(
      id: '',
      userId: userId,
      trainingBlockId: trainingBlockId,
      name: name,
    ));
  }
}

@riverpod
ExerciseDaysService exerciseDaysService(ExerciseDaysServiceRef ref) {
  final exerciseDaysRepository = ref.watch(exerciseDaysRepositoryProvider);
  final firebaseAuth = ref.watch(firebaseAuthProvider);

  return ExerciseDaysService(exerciseDaysRepository, firebaseAuth);
}
