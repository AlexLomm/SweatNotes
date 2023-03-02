import 'dart:math';

import '../../models/exercise.dart';
import '../../models/exercise_type.dart';
import '../../models_client/exercise_client.dart';
import '../../models_client/exercise_set_client.dart';
import '../../models_client/exercise_type_client.dart';

ExerciseDaysExerciseTypesMap getExerciseDaysTypesDictionary(
  List<Exercise> exercises,
  List<ExerciseType> exerciseTypes,
) {
  final maxExerciseSetsCount = _getMaxExerciseSetsCount(exercises);
  final maxExercisePlacement = _getMaxExercisePlacement(exercises);

  final map = ExerciseDaysExerciseTypesMap(exercises, exerciseTypes);

  for (final exerciseDayId in map.exerciseDayIds) {
    for (final exerciseTypeId in map.getExerciseTypeIds(exerciseDayId)) {
      final exerciseType = map.getExerciseType(
        exerciseDayId: exerciseDayId,
        exerciseTypeId: exerciseTypeId,
      );

      final exercisesWithFillerSets = exerciseType.exercises.map((exercise) {
        final exerciseWithFillerSets = exercise.copyWith(exerciseSets: [
          ...exercise.exerciseSets,
          ...List.generate(
            // we want 1 more exercise set than the max for
            // users to always have a blank set to fill in
            maxExerciseSetsCount + 1 - exercise.exerciseSets.length,
            (index) => ExerciseSetClient.empty(),
          )
        ]);

        return exerciseWithFillerSets;
      }).toList();

      final exercisesByPlacementMap = ExerciseByPlacementMap(
        exercisesWithFillerSets,
      );

      map.setExerciseTypeExercises(
        exerciseDayId: exerciseDayId,
        exerciseTypeId: exerciseTypeId,
        exercises: [],
      );

      // TODO: ??
      List<ExerciseClient> exercises = [];

      for (var i = 0; i < maxExercisePlacement + 1; i++) {
        final exercise = exercisesByPlacementMap.get(i);

        if (exercise == null) {
          exercises.add(ExerciseClient.empty().copyWith(
            exerciseDayId: exerciseDayId,
            placement: i,
            exerciseSets: List.generate(
              maxExerciseSetsCount + 1,
              (index) => ExerciseSetClient.empty(),
            ),
          ));
        } else {
          exercises.add(exercise);
        }
      }

      map.setExerciseTypeExercises(
        exerciseDayId: exerciseDayId,
        exerciseTypeId: exerciseTypeId,
        exercises: exercises,
      );
    }
  }

  return map;
}

_getMaxExercisePlacement(List<Exercise> exercises) {
  if (exercises.isEmpty) return 0;

  return exercises.map((exercise) => exercise.placement).reduce(max);
}

_getMaxExerciseSetsCount(List<Exercise> exercises) {
  if (exercises.isEmpty) return 0;

  return exercises.map((exercise) => exercise.sets.length).reduce(max);
}

// ---------------------------------------------------------------------------
class ExerciseTypesMap {
  final List<ExerciseType> exerciseTypes;

  Map<String, ExerciseTypeClient> _map = {};

  ExerciseTypesMap(this.exerciseTypes) {
    _map = _generateExerciseTypesMap();
  }

  Map<String, ExerciseTypeClient> _generateExerciseTypesMap() {
    final exerciseTypesMap = <String, ExerciseTypeClient>{};

    for (final exerciseType in exerciseTypes) {
      exerciseTypesMap[exerciseType.id] = ExerciseTypeClient(
        id: exerciseType.id,
        name: exerciseType.name,
        unit: exerciseType.unit,
      );
    }

    return exerciseTypesMap;
  }

  ExerciseTypeClient get(String id) => _map[id]!;
}

class ExerciseByPlacementMap {
  final List<ExerciseClient> exercises;

  Map<int, ExerciseClient> _map = {};

  ExerciseByPlacementMap(this.exercises) {
    _map = _generateExerciseByPlacementMap();
  }

  Map<int, ExerciseClient> _generateExerciseByPlacementMap() {
    final exerciseByPlacementMap = <int, ExerciseClient>{};

    for (final exercise in exercises) {
      exerciseByPlacementMap[exercise.placement] = exercise;
    }

    return exerciseByPlacementMap;
  }

  ExerciseClient? get(int id) => _map[id];
}

class ExerciseDaysExerciseTypesMap {
  final List<Exercise> exercises;
  final List<ExerciseType> exerciseTypes;

  Map<String, Map<String, ExerciseTypeClient>> _map = {};

  Map<String, Map<String, ExerciseTypeClient>> get map => _map;

  ExerciseDaysExerciseTypesMap(this.exercises, this.exerciseTypes) {
    _map = _generateExerciseDaysExerciseTypesMap();
  }

  Map<String, Map<String, ExerciseTypeClient>>
      _generateExerciseDaysExerciseTypesMap() {
    final Map<String, Map<String, ExerciseTypeClient>> map = {};

    final exerciseTypesMap = ExerciseTypesMap(exerciseTypes);

    for (final exercise in exercises) {
      final exerciseDayId = exercise.exerciseDayId;

      if (!map.containsKey(exerciseDayId)) {
        map[exerciseDayId] = {};
      }

      final exerciseTypeIdExercisesMap = map[exerciseDayId]!;

      final exerciseTypeId = exercise.exerciseTypeId;

      if (!exerciseTypeIdExercisesMap.containsKey(exerciseTypeId)) {
        exerciseTypeIdExercisesMap[exerciseTypeId] =
            exerciseTypesMap.get(exerciseTypeId);
      }

      final exerciseType = map[exerciseDayId]![exerciseTypeId]!;

      map[exerciseDayId]![exerciseTypeId] = exerciseType.copyWith(
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

    return map;
  }

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
}
