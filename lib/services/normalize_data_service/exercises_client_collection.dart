import '../../models_client/exercise_client.dart';
import '../../models_client/exercise_set_client.dart';

class ExercisesClientCollection {
  List<ExerciseClient> _exercises;
  _ExercisesByPlacementMap? _exerciseByPlacementMap;

  List<ExerciseClient> get exercises => _exercises;

  ExercisesClientCollection(exercises) : _exercises = exercises;

  /// [fillUntil] is the max number of sets this exercise should have
  void addFillerSets({
    required int fillUntil,
  }) {
    _exercises = _exercises.map((exercise) {
      final exerciseWithFillerSets = exercise.copyWith(exerciseSets: [
        ...exercise.exerciseSets,
        ...List.generate(
          fillUntil - exercise.exerciseSets.length,
          (index) => ExerciseSetClient.empty(),
        )
      ]);

      return exerciseWithFillerSets;
    }).toList();
  }

  /// [maxPlacement] is the max placement throughout all exercises
  /// [maxSets] is the max sets throughout all exercises
  void addFillerExercises({
    required String userId,
    required String exerciseTypeId,
    required String exerciseDayId,
    required String trainingBlockId,
    required int maxPlacement,
    required int maxSets,
  }) {
    List<ExerciseClient> exercises = [];

    // maxPlacement + 1 because placements start from 0
    for (var i = 0; i < maxPlacement + 1; i++) {
      final exercise = getByPlacement(i);

      if (exercise == null) {
        exercises.add(ExerciseClient.empty(
          userId: userId,
          exerciseTypeId: exerciseTypeId,
          exerciseDayId: exerciseDayId,
          trainingBlockId: trainingBlockId,
        ).copyWith(
          placement: i,
          exerciseSets: List.generate(
            maxSets,
            (index) => ExerciseSetClient.empty(),
          ),
        ));
      } else {
        exercises.add(exercise);
      }
    }

    _exercises = exercises;
  }

  getByPlacement(int placement) {
    _exerciseByPlacementMap ??= _ExercisesByPlacementMap(_exercises);

    return _exerciseByPlacementMap!.get(placement);
  }
}

class _ExercisesByPlacementMap {
  final List<ExerciseClient> exercises;

  Map<int, ExerciseClient> _map = {};

  _ExercisesByPlacementMap(this.exercises) {
    _map = _generateExerciseByPlacementMap();
  }

  Map<int, ExerciseClient> _generateExerciseByPlacementMap() {
    final exerciseByPlacementMap = <int, ExerciseClient>{};

    for (final exercise in exercises) {
      exerciseByPlacementMap[exercise.placement] = exercise;
    }

    return exerciseByPlacementMap;
  }

  ExerciseClient? get(int placement) => _map[placement];
}
