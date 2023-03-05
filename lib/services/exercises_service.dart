import 'package:journal_flutter/repositories/exercises_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models_client/exercise_client.dart';
import '../models_client/exercise_set_client.dart';

part 'exercises_service.g.dart';

class ExercisesService {
  ExercisesRepository exercisesRepository;

  ExercisesService(this.exercisesRepository);

  Future<void> setExerciseSet({
    required ExerciseClient exercise,
    required String reps,
    required String load,
    required int index,
  }) async {
    final exerciseSet = exercise.exerciseSets[index];

    final ExerciseSetClient modifiedExerciseSet = exerciseSet.copyWith(
      isFiller: false,
      reps: reps,
      load: load,
    );

    final modifiedExercise = exercise.copyWith(exerciseSets: [
      ...exercise.exerciseSets.sublist(0, index),
      modifiedExerciseSet,
      ...exercise.exerciseSets.sublist(index + 1),
    ]);

    exercisesRepository.setExercise(modifiedExercise);
  }
}

@riverpod
ExercisesService exercisesService(ExercisesServiceRef ref) {
  final exercisesRepository = ref.watch(exercisesRepositoryProvider);

  return ExercisesService(exercisesRepository);
}
