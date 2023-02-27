import 'package:journal_flutter/repositories/exercise_days_repository.dart';
import 'package:journal_flutter/repositories/orderings_repository.dart';

import '../repositories/exercise_types_repository.dart';
import '../repositories/exercises_repository.dart';
import '../repositories/training_blocks_repository.dart';

class NormalizeDataService {
  final _trainingBlockRepository = TrainingBlocksRepository();
  final _exerciseDaysRepository = ExerciseDaysRepository();
  final _exercisesRepository = ExercisesRepository();
  final _exerciseTypesRepository = ExerciseTypesRepository();
  final _orderingsRepository = OrderingsRepository();

  getNormalizedData({required String trainingBlockId}) async {
    final trainingBlockFuture = _trainingBlockRepository.fetchTrainingBlock(
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

    print('----------------------------------------');
    print(trainingBlock);
    // print(exerciseTypes);
  }
}
