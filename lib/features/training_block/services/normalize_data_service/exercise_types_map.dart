import '../../data/models/exercise_type.dart';
import '../../data/models_client/exercise_type_client.dart';

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
        userId: exerciseType.userId,
        name: exerciseType.name,
        unit: exerciseType.unit,
        exercises: [],
      );
    }

    return exerciseTypesMap;
  }

  /// @throws Exception if the exercise type with the given id does not exist
  ExerciseTypeClient get(String id) {
    final exerciseType = _map[id];

    // this can happen if the list of exercises is fetched
    // before the list of exercise types is fetched. i.e race
    // a race condition happens
    if (exerciseType == null) {
      throw Exception('Exercise type with id $id does not exist');
    }

    return exerciseType;
  }
}
