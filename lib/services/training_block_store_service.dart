import 'package:journal_flutter/models_client/exercise_client.dart';
import 'package:journal_flutter/repositories/exercises_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models_client/exercise_day_client.dart';
import '../models_client/exercise_set_client.dart';
import 'normalize_data_service/normalize_data_service.dart';

part 'training_block_store_service.g.dart';

@riverpod
class TrainingBlockStoreService extends _$TrainingBlockStoreService {
  @override
  FutureOr<List<ExerciseDayClient>> build(String trainingBlockId) async {
    final normalizeDataService = ref.read(normalizeDataServiceProvider);

    return normalizeDataService.getNormalizedData(
      trainingBlockId: trainingBlockId,
    );
  }

  Future<void> clear() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async => <ExerciseDayClient>[]);
  }

  Future<void> setExerciseSet({
    required ExerciseClient exercise,
    required String reps,
    required String load,
    required int index,
  }) async {
    final repository = ref.read(exercisesRepositoryProvider);

    final exerciseSet = exercise.exerciseSets[index];

    final ExerciseSetClient modifiedExerciseSet = exerciseSet.copyWith(
      isFiller: false,
      reps: reps,
      load: load,
    );

    final modifiedExercise = exercise.copyWith(exerciseSets: [
      ...exercise.exerciseSets.sublist(0, index),
      modifiedExerciseSet,
      ...exercise.exerciseSets.sublist(index + 1),
    ]);

    repository.setExercise(modifiedExercise);
  }
}
