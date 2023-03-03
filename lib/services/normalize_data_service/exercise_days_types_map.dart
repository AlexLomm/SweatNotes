import '../../models/exercise.dart';
import '../../models/exercise_type.dart';
import '../../models_client/exercise_client.dart';
import '../../models_client/exercise_set_client.dart';
import '../../models_client/exercise_type_client.dart';
import 'data/exercise_types_map.dart';
import 'data/exercises_client_collection.dart';
import 'data/exercises_collection.dart';

ExerciseDaysExerciseTypesMap getExerciseDaysTypesDictionary(
  List<Exercise> exercises,
  List<ExerciseType> exerciseTypes,
) {
  final exercisesCollection = ExercisesCollection(exercises);

  // we want 1 more exercise set than the max for
  // users to always have a blank set to fill in
  final maxExerciseSetsCount = exercisesCollection.maxExerciseSetsCount + 1;

  // as well as we want 1 more exercise
  final maxExercisePlacement = exercisesCollection.maxExercisePlacement + 1;

  final map = ExerciseDaysExerciseTypesMap();

  final exerciseTypesMap = ExerciseTypesMap(exerciseTypes);

  for (final exercise in exercises) {
    map.setExerciseTypeSafely(
      exerciseDayId: exercise.exerciseDayId,
      exerciseTypeId: exercise.exerciseTypeId,
      exerciseType: exerciseTypesMap.get(exercise.exerciseTypeId),
    );

    final exerciseType = map.getExerciseType(
      exerciseDayId: exercise.exerciseDayId,
      exerciseTypeId: exercise.exerciseTypeId,
    );

    map.setExerciseTypeExercises(
      exerciseDayId: exercise.exerciseDayId,
      exerciseTypeId: exercise.exerciseTypeId,
      exercises: [
        ...exerciseType.exercises,
        ExerciseClient(
          id: exercise.id,
          exerciseDayId: exercise.exerciseDayId,
          placement: exercise.placement,
          exerciseSets: exercise.sets.map((set) {
            return ExerciseSetClient(
              isFiller: false,
              reps: set.reps,
              load: set.load,
            );
          }).toList(),
        )
      ],
    );
  }

  for (final exerciseDayId in map.exerciseDayIds) {
    for (final exerciseTypeId in map.getExerciseTypeIds(exerciseDayId)) {
      final exerciseType = map.getExerciseType(
        exerciseDayId: exerciseDayId,
        exerciseTypeId: exerciseTypeId,
      );

      final exercisesCollection = ExercisesClientCollection(
        exerciseType.exercises,
      )
        ..addFillerSets(
          fillUntil: maxExerciseSetsCount,
        )
        ..addFillerExercises(
          maxSets: maxExerciseSetsCount,
          maxPlacement: maxExercisePlacement,
          exerciseDayId: exerciseDayId,
        );

      map.setExerciseTypeExercises(
        exerciseDayId: exerciseDayId,
        exerciseTypeId: exerciseTypeId,
        exercises: exercisesCollection.exercises,
      );
    }
  }

  return map;
}

// TODO: refactor
class ExerciseDaysExerciseTypesMap {
  final Map<String, Map<String, ExerciseTypeClient>> _map = {};

  // TODO: remove
  Map<String, Map<String, ExerciseTypeClient>> get map => _map;

  List<String> get exerciseDayIds => _map.keys.toList();

  List<String> getExerciseTypeIds(String exerciseDayId) =>
      _map[exerciseDayId]!.keys.toList();

  ExerciseTypeClient getExerciseType({
    required String exerciseDayId,
    required String exerciseTypeId,
  }) =>
      _map[exerciseDayId]![exerciseTypeId]!;

  void setExerciseTypeExercises({
    required String exerciseDayId,
    required String exerciseTypeId,
    required List<ExerciseClient> exercises,
  }) {
    final exerciseType = _map[exerciseDayId]![exerciseTypeId]!;

    _map[exerciseDayId]![exerciseTypeId] = exerciseType.copyWith(
      exercises: exercises,
    );
  }

  // TODO: remove
  void setExerciseTypeSafely({
    required String exerciseDayId,
    required String exerciseTypeId,
    required ExerciseTypeClient exerciseType,
  }) {
    if (!_map.containsKey(exerciseDayId)) {
      _map[exerciseDayId] = {};
    }

    final exerciseTypeIdExercisesMap = map[exerciseDayId]!;

    if (!exerciseTypeIdExercisesMap.containsKey(exerciseTypeId)) {
      exerciseTypeIdExercisesMap[exerciseTypeId] = exerciseType;
    }
  }
}
