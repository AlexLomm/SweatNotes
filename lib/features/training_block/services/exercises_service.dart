import 'package:confetti/confetti.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../widgets/layout.dart';
import '../data/exercise_types_repository.dart';
import '../data/models_client/exercise_client.dart';
import '../data/models_client/exercise_type_client.dart';

part 'exercises_service.g.dart';

class ExercisesService {
  ExerciseTypesRepository exerciseTypesRepository;
  ConfettiController confettiController;

  ExercisesService(
    this.exerciseTypesRepository,
    this.confettiController,
  );

  Future<void> setExerciseSet({
    required ExerciseTypeClient exerciseType,
    required ExerciseClient exercise,
    required int exerciseSetIndex,
    required int reps,
    required double load,
  }) async {
    final exerciseIndex = exerciseType.exercises.indexOf(exercise);

    if (exerciseIndex == -1) {
      throw Exception('Exercise not found in exercise type');
    }

    final updatedSet = exercise.sets[exerciseSetIndex].copyWith(reps: reps, load: load);

    final updatedExercise = exercise.updateSet(
      index: exerciseSetIndex,
      set: updatedSet,
    );

    final updatedExerciseType = exerciseType.updateExercise(
      index: exerciseIndex,
      exercise: updatedExercise,
    );

    if (updatedSet.isPersonalRecord) {
      confettiController.play();
    }

    return exerciseTypesRepository.update(updatedExerciseType.toDbModel());
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

@Riverpod(dependencies: [confettiController])
ExercisesService exercisesService(ExercisesServiceRef ref) {
  final confettiController = ref.watch(confettiControllerProvider);
  final exerciseTypesRepository = ref.watch(exerciseTypesRepositoryProvider);

  return ExercisesService(exerciseTypesRepository, confettiController);
}
