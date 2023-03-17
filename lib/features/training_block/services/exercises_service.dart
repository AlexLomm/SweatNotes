import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/exercise_types_repository.dart';
import '../data/models_client/exercise_client.dart';
import '../data/models_client/exercise_type_client.dart';

part 'exercises_service.g.dart';

class ExercisesService {
  ExerciseTypesRepository exerciseTypesRepository;

  ExercisesService(this.exerciseTypesRepository);

  Future<void> setExerciseSet({
    required ExerciseTypeClient exerciseType,
    required ExerciseClient exercise,
    required int exerciseSetIndex,
    required String reps,
    required String load,
  }) async {
    final exerciseIndex = exerciseType.exercises.indexOf(exercise);

    if (exerciseIndex == -1) {
      throw Exception('Exercise not found in exercise type');
    }

    final set = exercise.sets[exerciseSetIndex];

    final updatedExercise = exercise.updateSet(
      index: exerciseSetIndex,
      set: set.copyWith(reps: reps, load: load),
    );

    final updatedExerciseType = exerciseType.updateExercise(
      index: exerciseIndex,
      exercise: updatedExercise,
    );

    exerciseTypesRepository.update(updatedExerciseType.toDbModel());
  }

  /// adds an empty exercise at the end of one of the
  /// exercise types referenced in the exerciseDay,
  /// thereby forcing the creation of a new "column"
  Future<void> addEmptyExercise({
    required ExerciseTypeClient exerciseType,
  }) async {
    final updatedExerciseType = exerciseType.enlargeExercisesRow();

    exerciseTypesRepository.update(updatedExerciseType.toDbModel());
  }
}

@riverpod
ExercisesService exercisesService(ExercisesServiceRef ref) {
  final exerciseTypesRepository = ref.watch(exerciseTypesRepositoryProvider);

  return ExercisesService(exerciseTypesRepository);
}
