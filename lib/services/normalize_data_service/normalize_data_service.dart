import '../../models_client/exercise_day_client.dart';
import '../../repositories/exercise_days_repository.dart';
import '../../repositories/exercise_types_repository.dart';
import '../../repositories/exercises_repository.dart';
import '../../repositories/orderings_repository.dart';
import '../../repositories/training_blocks_repository.dart';
import 'exercise_days.dart';
import 'exercise_days_types_map.dart';
import 'orderings_map.dart';

class NormalizeDataService {
  final _trainingBlocksRepository = TrainingBlocksRepository();
  final _exerciseDaysRepository = ExerciseDaysRepository();
  final _exercisesRepository = ExercisesRepository();
  final _exerciseTypesRepository = ExerciseTypesRepository();
  final _orderingsRepository = OrderingsRepository();

  Future<List<ExerciseDayClient>> getNormalizedData({
    required String trainingBlockId,
  }) async {
    final trainingBlockFuture = _trainingBlocksRepository.fetchTrainingBlock(
      id: trainingBlockId,
    );
    final exerciseTypesFuture = _exerciseTypesRepository.fetchExerciseTypes();

    final exerciseDays = await _exerciseDaysRepository.fetchExerciseDays(
      trainingBlockId: trainingBlockId,
    );

    final exerciseDayIds =
        exerciseDays.map((exerciseDay) => exerciseDay.id).toList();

    final exercisesFuture = _exercisesRepository
        .fetchExercisesByMultipleExerciseDayIds(exerciseDayIds: exerciseDayIds);

    final orderingsFuture =
        _orderingsRepository.fetchOrderingsByIds(ids: exerciseDayIds);

    final trainingBlock = await trainingBlockFuture;
    final exerciseTypes = await exerciseTypesFuture;
    final exercises = await exercisesFuture;
    final orderings = await orderingsFuture;

    final orderingsMap = OrderingsMap(orderings);
    final exerciseDaysMap = ExerciseDaysMap(exerciseDays);

    final exerciseDaysTypesMap = getExerciseDaysTypesDictionary(
      exercises,
      exerciseTypes,
    );

    final exerciseDaysWithSortedExerciseTypes =
        exerciseDaysTypesMap.map.entries.map((entry) {
      final exerciseDayId = entry.key;
      final exerciseTypes = entry.value.values.toList();

      exerciseTypes.sort((a, b) {
        final orderingA = orderingsMap.get(exerciseDayId, a.id);
        final orderingB = orderingsMap.get(exerciseDayId, b.id);

        return orderingA - orderingB;
      });

      final exerciseDay = exerciseDaysMap.get(entry.key);

      return exerciseDay.copyWith(
        id: exerciseDay.id,
        name: exerciseDay.name,
        exerciseTypes: exerciseTypes,
      );
    }).toList();

    final emptyExerciseDayIds = exerciseDaysMap.getEmptyExerciseDayIds(
      exerciseDaysWithSortedExerciseTypes,
    );

    for (final emptyExerciseDayId in emptyExerciseDayIds) {
      exerciseDaysWithSortedExerciseTypes.add(
        ExerciseDayClient(
          id: emptyExerciseDayId,
          name: exerciseDaysMap.get(emptyExerciseDayId).name,
          exerciseTypes: [],
        ),
      );
    }

    exerciseDaysWithSortedExerciseTypes.sort((a, b) {
      final orderingA =
          trainingBlock?.exerciseDayOrdering[a.id] ?? double.infinity;
      final orderingB =
          trainingBlock?.exerciseDayOrdering[b.id] ?? double.infinity;

      return orderingA.toInt() - orderingB.toInt();
    });

    return exerciseDaysWithSortedExerciseTypes;
  }
}
