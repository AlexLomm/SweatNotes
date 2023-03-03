import '../../models/exercise.dart';
import '../../models/exercise_type.dart';
import '../../models_client/exercise_client.dart';
import '../../models_client/exercise_set_client.dart';
import '../../models_client/exercise_type_client.dart';
import 'data/exercise_types_map.dart';
import 'data/exercises_client_collection.dart';
import 'data/exercises_collection.dart';

// TODO: rename
class ExerciseDaysTypesDictionary {
  final List<Exercise> exercises;
  final List<ExerciseType> exerciseTypes;

  final _map = _ExerciseDaysExerciseTypesMap();

  Iterable<MapEntry<String, Map<String, ExerciseTypeClient>>> get entries =>
      _map.entries;

  ExerciseDaysTypesDictionary(this.exercises, this.exerciseTypes) {
    _init();
  }

  void _init() {
    final exercisesCollection = ExercisesCollection(exercises);

    // we want 1 more exercise set than the max for
    // users to always have a blank set to fill in
    final maxExerciseSetsCount = exercisesCollection.maxExerciseSetsCount + 1;

    // as well as we want 1 more exercise
    final maxExercisePlacement = exercisesCollection.maxExercisePlacement + 1;

    final exerciseTypesMap = ExerciseTypesMap(exerciseTypes);

    for (final exercise in exercises) {
      _map.setExerciseType(
        exerciseDayId: exercise.exerciseDayId,
        exerciseTypeId: exercise.exerciseTypeId,
        exerciseType: exerciseTypesMap.get(exercise.exerciseTypeId),
      );

      final exerciseType = _map.getExerciseType(
        exerciseDayId: exercise.exerciseDayId,
        exerciseTypeId: exercise.exerciseTypeId,
      );

      _map.setExerciseTypeExercises(
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

    for (final exerciseDayId in _map.exerciseDayIds) {
      for (final exerciseTypeId in _map.getExerciseTypeIds(exerciseDayId)) {
        final exerciseType = _map.getExerciseType(
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

        _map.setExerciseTypeExercises(
          exerciseDayId: exerciseDayId,
          exerciseTypeId: exerciseTypeId,
          exercises: exercisesCollection.exercises,
        );
      }
    }
  }
}

class _ExerciseDaysExerciseTypesMap {
  final Map<String, Map<String, ExerciseTypeClient>> _map = {};

  Iterable<MapEntry<String, Map<String, ExerciseTypeClient>>> get entries =>
      _map.entries;

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
    final exerciseType = getExerciseType(
      exerciseDayId: exerciseDayId,
      exerciseTypeId: exerciseTypeId,
    );

    _map[exerciseDayId]![exerciseTypeId] = exerciseType.copyWith(
      exercises: exercises,
    );
  }

  void setExerciseType({
    required String exerciseDayId,
    required String exerciseTypeId,
    required ExerciseTypeClient exerciseType,
  }) {
    if (!_map.containsKey(exerciseDayId)) {
      _map[exerciseDayId] = {};
    }

    final exerciseTypeIdExercisesMap = _map[exerciseDayId]!;

    if (!exerciseTypeIdExercisesMap.containsKey(exerciseTypeId)) {
      exerciseTypeIdExercisesMap[exerciseTypeId] = exerciseType;
    }
  }
}
