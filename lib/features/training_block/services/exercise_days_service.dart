import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/services/firebase.dart';
import '../data/models_client/exercise_day_client.dart';
import '../data/models_client/training_block_client.dart';
import '../data/training_blocks_repository.dart';

part 'exercise_days_service.g.dart';

class ExerciseDaysService {
  TrainingBlocksRepository trainingBlocksRepository;
  FirebaseAuth firebaseAuth;

  ExerciseDaysService(
    this.trainingBlocksRepository,
    this.firebaseAuth,
  );

  Future<void> updateNameAndWeekDay({
    required TrainingBlockClient trainingBlock,
    required ExerciseDayClient exerciseDay,
    required String name,
    required int? weekDay,
  }) async {
    final index = trainingBlock.exerciseDays.indexOf(exerciseDay);

    if (index == -1) {
      throw Exception('Exercise day not found');
    }

    trainingBlocksRepository.update(
      trainingBlock
          .updateExerciseDayAt(
            index: index,
            exerciseDay: exerciseDay.copyWith(
              name: name,
              dbModel: exerciseDay.dbModel.copyWith(weekDay: weekDay),
            ),
          )
          .toDbModel(),
    );
  }

  Future<void> create({
    required TrainingBlockClient trainingBlock,
    required String name,
    required int? weekDay,
  }) async {
    assert(
      weekDay == null || (weekDay >= 1 && weekDay <= 7),
      'Invalid week day $weekDay, must be in range [1, 7]',
    );

    final emptyExerciseDay = ExerciseDayClient.empty();

    final updatedTrainingBlock = trainingBlock.addExerciseDay(
      emptyExerciseDay.copyWith(
        name: name,
        dbModel: emptyExerciseDay.dbModel.copyWith(weekDay: weekDay),
      ),
    );

    return trainingBlocksRepository.update(updatedTrainingBlock.toDbModel());
  }

  Future<void> updateAt({
    required TrainingBlockClient trainingBlock,
    required ExerciseDayClient exerciseDay,
    required int index,
  }) async {
    final updatedTrainingBlock = trainingBlock.updateExerciseDayAt(
      index: index,
      exerciseDay: exerciseDay,
    );

    return trainingBlocksRepository.update(updatedTrainingBlock.toDbModel());
  }

  Future<void> moveExerciseTypeIntoAnotherExerciseDay({
    required TrainingBlockClient trainingBlock,
    required ExerciseDayClient fromExerciseDay,
    required ExerciseDayClient toExerciseDay,
    required String exerciseTypeId,
  }) async {
    final fromExerciseDayIndex = trainingBlock.exerciseDays.indexOf(fromExerciseDay);
    final toExerciseDayIndex = trainingBlock.exerciseDays.indexOf(toExerciseDay);

    final exerciseType = fromExerciseDay.getExerciseTypeById(exerciseTypeId);

    final updatedFromExerciseDay = fromExerciseDay.removeExerciseTypeById(exerciseTypeId);
    final updatedToExerciseDay = toExerciseDay.prependExerciseType(exerciseType);

    final updatedTrainingBlock = trainingBlock
        .updateExerciseDayAt(index: fromExerciseDayIndex, exerciseDay: updatedFromExerciseDay)
        .updateExerciseDayAt(index: toExerciseDayIndex, exerciseDay: updatedToExerciseDay);

    return trainingBlocksRepository.update(updatedTrainingBlock.toDbModel());
  }
}

@riverpod
ExerciseDaysService exerciseDaysService(ExerciseDaysServiceRef ref) {
  final trainingBlocksRepository = ref.watch(trainingBlocksRepositoryProvider);
  final firebaseAuth = ref.watch(firebaseAuthProvider);

  return ExerciseDaysService(trainingBlocksRepository, firebaseAuth);
}
