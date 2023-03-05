import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/exercise.dart';
import '../../models/exercise_day.dart';
import '../../models/exercise_type.dart';
import '../../models/training_block.dart';
import '../../models_client/exercise_day_client.dart';
import '../../repositories/exercise_days_repository.dart';
import '../../repositories/exercise_types_repository.dart';
import '../../repositories/exercises_repository.dart';
import '../../repositories/training_blocks_repository.dart';
import 'exercise_days_by_ids_exercise_types_by_ids_map.dart';
import 'exercise_days_by_ids_map.dart';

part 'normalize_data_service.g.dart';

// TODO: rename service
/// @throws Exception if training block is not found
class NormalizeDataService {
  final TrainingBlocksRepository trainingBlocksRepository;
  final ExerciseDaysRepository exerciseDaysRepository;
  final ExercisesRepository exercisesRepository;
  final ExerciseTypesRepository exerciseTypesRepository;

  NormalizeDataService({
    required this.trainingBlocksRepository,
    required this.exerciseDaysRepository,
    required this.exercisesRepository,
    required this.exerciseTypesRepository,
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

    final exercisesFuture = exercisesRepository.fetchExercisesByTrainingBlockId(
      trainingBlockId,
    );

    final trainingBlock = await trainingBlockFuture;

    if (trainingBlock == null) throw Exception('Training block not found');

    final exerciseTypes = await exerciseTypesFuture;
    final exercises = await exercisesFuture;

    final exerciseDaysMap = ExerciseDaysByIdsMap(exerciseDays);

    final exerciseDaysTypesMap = ExerciseDaysByIdsExerciseTypesByIdsMap(
      userId: trainingBlock.userId,
      trainingBlockId: trainingBlock.id,
      exercises: exercises,
      exerciseTypes: exerciseTypes,
    );

    // TODO: refactor into ExerciseDaysByIdsExerciseTypesByIdsMap
    final exerciseDaysWithSortedExerciseTypes =
        exerciseDaysTypesMap.entries.map((entry) {
      final exerciseDayId = entry.key;
      final exerciseTypes = entry.value.values.toList();

      final exerciseTypesOrdering =
          exerciseDaysMap.get(exerciseDayId).exerciseTypesOrdering;

      exerciseTypes.sort((a, b) {
        final orderingA = exerciseTypesOrdering[a.id] ?? double.maxFinite;
        final orderingB = exerciseTypesOrdering[b.id] ?? double.maxFinite;

        return orderingA.toInt() - orderingB.toInt();
      });

      final exerciseDay = exerciseDaysMap.get(entry.key);

      return exerciseDay.copyWith(
        id: exerciseDay.id,
        name: exerciseDay.name,
        exerciseTypes: exerciseTypes,
      );
    }).toList();

    // TODO: refactor into ExerciseDaysByIdsExerciseTypesByIdsMap
    final emptyExerciseDayIds = exerciseDaysMap.getEmptyExerciseDayIds(
      exerciseDaysWithSortedExerciseTypes,
    );

    // TODO: refactor into ExerciseDaysByIdsExerciseTypesByIdsMap
    for (final emptyExerciseDayId in emptyExerciseDayIds) {
      exerciseDaysWithSortedExerciseTypes.add(ExerciseDayClient(
        id: emptyExerciseDayId,
        name: exerciseDaysMap.get(emptyExerciseDayId).name,
        exerciseTypesOrdering: {},
        exerciseTypes: [],
      ));
    }

    // TODO: refactor into ExerciseDaysByIdsExerciseTypesByIdsMap
    exerciseDaysWithSortedExerciseTypes.sort((a, b) {
      final o1 = trainingBlock.exerciseDaysOrdering[a.id] ?? double.infinity;
      final o2 = trainingBlock.exerciseDaysOrdering[b.id] ?? double.infinity;

      return o1.toInt() - o2.toInt();
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

  return NormalizeDataService(
    trainingBlocksRepository: trainingBlocksRepository,
    exerciseDaysRepository: exerciseDaysRepository,
    exercisesRepository: exercisesRepository,
    exerciseTypesRepository: exerciseTypesRepository,
  );
}
