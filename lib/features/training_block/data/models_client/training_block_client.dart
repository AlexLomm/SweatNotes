import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise_day.dart';
import '../models/training_block.dart';
import 'exercise_day_client.dart';

part 'training_block_client.freezed.dart';

@Freezed(equal: false)
class TrainingBlockClient with _$TrainingBlockClient {
  const TrainingBlockClient._();

  const factory TrainingBlockClient({
    required TrainingBlock dbModel,
    required String name,
    required List<ExerciseDayClient> exerciseDays,
  }) = _TrainingBlockClient;

  TrainingBlock toDbModel() {
    return dbModel.copyWith(
      name: name,
      exerciseDays: exerciseDays.map<ExerciseDay>((e) => e.toDbModel()).toList(),
    );
  }

  TrainingBlockClient addExerciseDay(ExerciseDayClient exerciseDayClient) {
    return copyWith(
      exerciseDays: [...exerciseDays, exerciseDayClient],
    );
  }

  TrainingBlockClient updateExerciseDay({
    required ExerciseDayClient exerciseDay,
    required int index,
  }) {
    final newExerciseDays = [...exerciseDays];

    newExerciseDays[index] = exerciseDay;

    return copyWith(exerciseDays: newExerciseDays);
  }

  TrainingBlockClient reorderExerciseDay({
    required ExerciseDayClient exerciseDay,
    required int moveBy,
  }) {
    final oldIndex = exerciseDays.indexWhere((e) => e == exerciseDay);

    if (oldIndex == -1) throw Exception('Exercise day not found');

    final newIndex = (oldIndex + moveBy).clamp(0, exerciseDays.length - 1);

    if (oldIndex == newIndex) return this;

    final newList = [...exerciseDays];

    final temp = newList[oldIndex];
    newList[oldIndex] = newList[newIndex];
    newList[newIndex] = temp;

    return copyWith(exerciseDays: newList);
  }

  int indexOfExerciseDay(ExerciseDayClient exerciseDayClient) {
    final index = exerciseDays.indexWhere((e) => e == exerciseDayClient);

    if (index == -1) throw Exception('Exercise day not found');

    return index;
  }
}
