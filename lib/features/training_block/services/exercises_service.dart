import 'package:confetti/confetti.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/services/firebase.dart';
import '../../../widgets/layout.dart';
import '../data/exercise_types_repository.dart';
import '../data/models_client/exercise_client.dart';
import '../data/models_client/exercise_type_client.dart';

part 'exercises_service.g.dart';

class ExercisesService {
  ExerciseTypesRepository exerciseTypesRepository;
  ConfettiController confettiController;
  FirebaseAnalytics analytics;

  ExercisesService(
    this.exerciseTypesRepository,
    this.confettiController,
    this.analytics,
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

    final updatedSet =
        exercise.sets[exerciseSetIndex].copyWith(reps: reps, load: load);

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

  Future<void> setExerciseReaction({
    required ExerciseTypeClient exerciseType,
    required ExerciseClient exercise,
    required int? reactionScore,
  }) async {
    final exerciseIndex = exerciseType.exercises.indexOf(exercise);

    if (exerciseIndex == -1) {
      throw Exception('Exercise not found in exercise type');
    }

    final updatedExercise = exercise.updateScore(reactionScore);

    final updatedExerciseType = exerciseType.updateExercise(
      index: exerciseIndex,
      exercise: updatedExercise,
    );

    analytics.logEvent(name: 'set_exercise_reaction');

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
  final analytics = ref.watch(analyticsProvider);

  return ExercisesService(
    exerciseTypesRepository,
    confettiController,
    analytics,
  );
}
