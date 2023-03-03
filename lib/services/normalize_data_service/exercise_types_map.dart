import '../../models/exercise_type.dart';
import '../../models_client/exercise_type_client.dart';

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
