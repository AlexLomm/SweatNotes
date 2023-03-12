import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/exercises_repository.dart';
import '../data/models_client/exercise_client.dart';
import '../data/models_client/exercise_day_client.dart';
import '../data/models_client/exercise_set_client.dart';

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

  /// adds an empty exercise at the end of one of the
  /// exercise types referenced in the exerciseDay,
  /// thereby forcing the creation of a new "column"
  Future<void> addEmptyExercise({
    required ExerciseDayClient exerciseDay,
  }) async {
    if (exerciseDay.exerciseTypes.isEmpty) return;

    if (exerciseDay.exerciseTypes.first.exercises.isEmpty) return;

    final lastExercise = exerciseDay.exerciseTypes.first.exercises.last;

    final newExercise = lastExercise.copyWith(
      exerciseSets: [
        lastExercise.exerciseSets.first.copyWith(
          isFiller: false,
          reps: '',
          load: '',
        )
      ],
    );

    exercisesRepository.addExercise(newExercise);
  }
}

@riverpod
ExercisesService exercisesService(ExercisesServiceRef ref) {
  final exercisesRepository = ref.watch(exercisesRepositoryProvider);

  return ExercisesService(exercisesRepository);
}
