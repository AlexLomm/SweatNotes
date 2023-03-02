import '../../models/exercise_day.dart';
import '../../models_client/exercise_day_client.dart';

class ExerciseDaysMap {
  final List<ExerciseDay> exerciseDays;

  Map<String, ExerciseDayClient> _map = {};

  ExerciseDaysMap(this.exerciseDays) {
    // TODO: remove this from constructor?
    _map = _generateExerciseDaysMap();
  }

  Map<String, ExerciseDayClient> _generateExerciseDaysMap() {
    final exerciseDayMap = <String, ExerciseDayClient>{};

    for (final exerciseDay in exerciseDays) {
      // TODO: add "from" constructor
      exerciseDayMap[exerciseDay.id] = ExerciseDayClient(
        id: exerciseDay.id,
        name: exerciseDay.name,
        exerciseTypes: [],
      );
    }

    return exerciseDayMap;
  }

  Iterable<String> getEmptyExerciseDayIds(
    List<ExerciseDayClient> exerciseDays,
  ) {
    return Set.of(_map.keys).difference(
      Set.of(exerciseDays.map((exerciseDay) => exerciseDay.id)),
    );
  }

  ExerciseDayClient get(String id) => _map[id]!;
}
