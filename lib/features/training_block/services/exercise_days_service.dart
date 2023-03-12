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
        //
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

    exerciseDaysRepository.add(ExerciseDay(
      id: '',
      userId: userId,
      trainingBlockId: trainingBlockId,
      name: name,
    ));
  }

  Future<void> update({required ExerciseDayClient exerciseDay}) async {
    return exerciseDaysRepository.update(exerciseDay.toExerciseDay());
  }

  // TODO: move this into the ExerciseDayClient class
  ExerciseDayClient getReorderExerciseTypeInTheSameDay({
    required ExerciseDayClient exerciseDay,
    required int oldIndex,
    required int newIndex,
  }) {
    // TODO: extract
    final newOrderingMap = exerciseDay.exerciseTypes.asMap().entries.fold(
      <String, int>{},
      (previousValue, entry) {
        final index = entry.key;
        final exerciseTypeId = entry.value.id;

        previousValue[exerciseTypeId] = index;

        return previousValue;
      },
    );

    // TODO: extract
    final reorderedNewOrderingMap = newOrderingMap.entries.fold(
      <String, int>{},
      (previousValue, entry) {
        final exerciseTypeId = entry.key;
        final i = entry.value;

        if (i == oldIndex) {
          previousValue[exerciseTypeId] = newIndex;
        } else if (i > oldIndex && i <= newIndex) {
          previousValue[exerciseTypeId] = i - 1;
        } else if (i < oldIndex && i >= newIndex) {
          previousValue[exerciseTypeId] = i + 1;
        } else {
          previousValue[exerciseTypeId] = i;
        }

        return previousValue;
      },
    );

    // TODO: extract
    final newExerciseTypes = exerciseDay.exerciseTypes.toList();

    newExerciseTypes.sort((a, b) => reorderedNewOrderingMap[a.id]!.compareTo(reorderedNewOrderingMap[b.id]!));

    return exerciseDay.copyWith(
      exerciseTypesOrdering: reorderedNewOrderingMap,
      exerciseTypes: newExerciseTypes,
    );
  }
}

@riverpod
ExerciseDaysService exerciseDaysService(ExerciseDaysServiceRef ref) {
  final exerciseDaysRepository = ref.watch(exerciseDaysRepositoryProvider);
  final firebaseAuth = ref.watch(firebaseAuthProvider);

  return ExerciseDaysService(exerciseDaysRepository, firebaseAuth);
}
