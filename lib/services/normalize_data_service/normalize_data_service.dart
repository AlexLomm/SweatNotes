import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models_client/exercise_day_client.dart';
import '../../repositories/exercise_days_repository.dart';
import '../../repositories/exercise_types_repository.dart';
import '../../repositories/exercises_repository.dart';
import '../../repositories/orderings_repository.dart';
import '../../repositories/training_blocks_repository.dart';
import 'exercise_days.dart';
import 'exercise_days_types_map.dart';
import 'orderings_map.dart';

part 'normalize_data_service.g.dart';

// TODO: rename
class NormalizeDataService {
  final TrainingBlocksRepository trainingBlocksRepository;
  final ExerciseDaysRepository exerciseDaysRepository;
  final ExercisesRepository exercisesRepository;
  final ExerciseTypesRepository exerciseTypesRepository;
  final OrderingsRepository orderingsRepository;

  NormalizeDataService({
    required this.trainingBlocksRepository,
    required this.exerciseDaysRepository,
    required this.exercisesRepository,
    required this.exerciseTypesRepository,
    required this.orderingsRepository,
  });

  Future<List<ExerciseDayClient>> getNormalizedData({
    required String trainingBlockId,
  }) async {
    final trainingBlockFuture = trainingBlocksRepository.fetchTrainingBlock(
      id: trainingBlockId,
    );
    final exerciseTypesFuture = exerciseTypesRepository.fetchExerciseTypes();

    final exerciseDays = await exerciseDaysRepository.fetchExerciseDays(
      trainingBlockId: trainingBlockId,
    );

    final exerciseDayIds =
        exerciseDays.map((exerciseDay) => exerciseDay.id).toList();

    final exercisesFuture = exercisesRepository
        .fetchExercisesByMultipleExerciseDayIds(exerciseDayIds: exerciseDayIds);

    final orderingsFuture =
        orderingsRepository.fetchOrderingsByIds(ids: exerciseDayIds);

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

@riverpod
NormalizeDataService normalizeDataService(NormalizeDataServiceRef ref) {
  final trainingBlocksRepository = ref.watch(trainingBlocksRepositoryProvider);
  final exerciseDaysRepository = ref.watch(exerciseDaysRepositoryProvider);
  final exercisesRepository = ref.watch(exercisesRepositoryProvider);
  final exerciseTypesRepository = ref.watch(exerciseTypesRepositoryProvider);
  final orderingsRepository = ref.watch(orderingsRepositoryProvider);

  return NormalizeDataService(
    trainingBlocksRepository: trainingBlocksRepository,
    exerciseDaysRepository: exerciseDaysRepository,
    exercisesRepository: exercisesRepository,
    exerciseTypesRepository: exerciseTypesRepository,
    orderingsRepository: orderingsRepository,
  );
}
