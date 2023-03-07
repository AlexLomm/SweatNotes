import '../../data/models/exercise.dart';
import '../../data/models/exercise_type.dart';
import '../../data/models_client/exercise_client.dart';
import '../../data/models_client/exercise_set_client.dart';
import '../../data/models_client/exercise_type_client.dart';
import 'exercise_types_map.dart';
import 'exercises_client_collection.dart';
import 'exercises_collection.dart';

class ExerciseDaysByIdsExerciseTypesByIdsMap {
  final String userId;
  final String trainingBlockId;
  final List<Exercise> exercises;
  final List<ExerciseType> exerciseTypes;

  final _map = _ExerciseDaysExerciseTypesHelperMap();

  Iterable<MapEntry<String, Map<String, ExerciseTypeClient>>> get entries =>
      _map.entries;

  ExerciseDaysByIdsExerciseTypesByIdsMap({
    required this.userId,
    required this.trainingBlockId,
    required this.exercises,
    required this.exerciseTypes,
  }) {
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
        // this can throw if the exercise type ids referenced in the exercises
        // do not appear in the map. This can happen because of race conditions
        // when the exercises are added before the exercise types are added.
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
            userId: exercise.userId,
            exerciseTypeId: exercise.exerciseTypeId,
            exerciseDayId: exercise.exerciseDayId,
            trainingBlockId: exercise.trainingBlockId,
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
            userId: userId,
            exerciseTypeId: exerciseTypeId,
            exerciseDayId: exerciseDayId,
            trainingBlockId: trainingBlockId,
            maxSets: maxExerciseSetsCount,
            maxPlacement: maxExercisePlacement,
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

class _ExerciseDaysExerciseTypesHelperMap {
  final Map<String, Map<String, ExerciseTypeClient>> _map = {};

  Iterable<MapEntry<String, Map<String, ExerciseTypeClient>>> get entries =>
      _map.entries;

  List<String> get exerciseDayIds => _map.keys.toList();

  List<String> getExerciseTypeIds(String exerciseDayId) {
    final exerciseDayMap = _map[exerciseDayId];

    if (exerciseDayMap == null) {
      throw Exception('Exercise day id not found: $exerciseDayId');
    }

    return exerciseDayMap.keys.toList();
  }

  ExerciseTypeClient getExerciseType({
    required String exerciseDayId,
    required String exerciseTypeId,
  }) {
    final exerciseDayMap = _map[exerciseDayId];

    if (exerciseDayMap == null) {
      throw Exception('Exercise day id not found: $exerciseDayId');
    }

    final exerciseType = exerciseDayMap[exerciseTypeId];

    if (exerciseType == null) {
      throw Exception('Exercise type id not found: $exerciseTypeId');
    }

    return exerciseType;
  }

  void setExerciseTypeExercises({
    required String exerciseDayId,
    required String exerciseTypeId,
    required List<ExerciseClient> exercises,
  }) {
    final exerciseType = getExerciseType(
      exerciseDayId: exerciseDayId,
      exerciseTypeId: exerciseTypeId,
    );

    final exerciseTypesByIdMap = _map[exerciseDayId];

    if (exerciseTypesByIdMap == null) {
      throw Exception('Exercise day id not found: $exerciseDayId');
    }

    exerciseTypesByIdMap[exerciseTypeId] = exerciseType.copyWith(
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

    final exerciseDay = _map[exerciseDayId];

    if (exerciseDay == null) {
      throw Exception('Exercise day id not found: $exerciseDayId');
    }

    final exerciseTypeIdExercisesMap = exerciseDay;

    if (!exerciseTypeIdExercisesMap.containsKey(exerciseTypeId)) {
      exerciseTypeIdExercisesMap[exerciseTypeId] = exerciseType;
    }
  }
}
