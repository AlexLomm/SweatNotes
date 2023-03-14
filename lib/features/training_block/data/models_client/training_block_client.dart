import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/training_block.dart';
import 'exercise_day_client.dart';

part 'training_block_client.freezed.dart';

@freezed
class TrainingBlockClient with _$TrainingBlockClient {
  const TrainingBlockClient._();

  Map<String, int> get exerciseDaysOrdering => exerciseDays.asMap().entries.fold<Map<String, int>>(
        {},
        (previousValue, entry) => {
          ...previousValue,
          entry.value.id: entry.key,
        },
      );

  const factory TrainingBlockClient({
    @JsonKey(includeToJson: false) required String id,
    required String userId,
    required String name,
    required List<ExerciseDayClient> exerciseDays,
  }) = _TrainingBlockClient;

  TrainingBlock toTrainingBlock() {
    return TrainingBlock(
      id: id,
      userId: userId,
      name: name,
      exerciseDaysOrdering: exerciseDaysOrdering,
    );
  }

  TrainingBlockClient reorderExerciseDay({
    required String exerciseDayId,
    required int moveBy,
  }) {
    final oldIndex = exerciseDays.indexWhere((element) => element.id == exerciseDayId);

    if (oldIndex == -1) {
      throw Exception('Exercise day with id $exerciseDayId is not found');
    }

    final newIndex = (oldIndex + moveBy).clamp(0, exerciseDays.length - 1);

    if (oldIndex == newIndex) {
      return this;
    }

    final newList = [...exerciseDays];

    final temp = newList[oldIndex];
    newList[oldIndex] = newList[newIndex];
    newList[newIndex] = temp;

    return copyWith(exerciseDays: newList);
  }

  int indexOfExerciseDay(String exerciseDayId) {
    return exerciseDays.indexWhere((element) => element.id == exerciseDayId);
  }
}
