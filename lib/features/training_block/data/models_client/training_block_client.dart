import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../models/exercise_day.dart';
import '../models/training_block.dart';
import 'exercise_day_client.dart';

part 'training_block_client.freezed.dart';

@Freezed(equal: false)
class TrainingBlockClient with _$TrainingBlockClient {
  const TrainingBlockClient._();

  get startedAtFormatted => startedAt == null
      ? 'No start date'
      : DateFormat.yMMMMd('en_US').format(startedAt!.toDate());

  const factory TrainingBlockClient({
    required TrainingBlock dbModel,
    Timestamp? archivedAt,
    Timestamp? startedAt,
    required String name,
    required int exercisesCollapsedIncludingIndex,
    required List<ExerciseDayClient> exerciseDays,
  }) = _TrainingBlockClient;

  TrainingBlock toDbModel() {
    // toDbModel is generating a new pseudoId for each exercise day so it's
    // crucial for these same pseudoIds to be used in the `exerciseDaysOrdering` map
    final exerciseDayDbModels =
        exerciseDays.map<ExerciseDay>((e) => e.toDbModel()).toList();

    return dbModel.copyWith(
      archivedAt: archivedAt,
      startedAt: startedAt,
      name: name,
      exercisesCollapsedIncludingIndex: exercisesCollapsedIncludingIndex,
      exerciseDays: exerciseDayDbModels,
      exerciseDaysOrdering: exerciseDayDbModels
          .asMap()
          .map((key, value) => MapEntry(value.pseudoId, key)),
    );
  }

  TrainingBlockClient addExerciseDay(ExerciseDayClient exerciseDayClient) {
    return copyWith(
      exerciseDays: [...exerciseDays, exerciseDayClient],
    );
  }

  TrainingBlockClient updateExerciseDayAt({
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
    final oldIndex = indexOfExerciseDayByPseudoId(exerciseDay.dbModel.pseudoId);

    if (oldIndex == -1) throw Exception('Exercise day not found');

    final newIndex = (oldIndex + moveBy).clamp(0, exerciseDays.length - 1);

    if (oldIndex == newIndex) return this;

    final newList = [...exerciseDays];

    final temp = newList[oldIndex];
    newList[oldIndex] = newList[newIndex];
    newList[newIndex] = temp;

    return copyWith(exerciseDays: newList);
  }

  int indexOfExerciseDayByPseudoId(String pseudoId) {
    final index =
        exerciseDays.indexWhere((e) => e.dbModel.pseudoId == pseudoId);

    if (index == -1) throw Exception('Exercise day not found');

    return index;
  }

  TrainingBlockClient archiveExerciseDay(
    ExerciseDayClient exerciseDayClient,
    bool archive,
  ) {
    final index = indexOfExerciseDayByPseudoId(
      exerciseDayClient.dbModel.pseudoId,
    );

    final exerciseDaysUpdated = [...exerciseDays];

    exerciseDaysUpdated[index] = exerciseDayClient.archive(archive);

    return copyWith(exerciseDays: exerciseDaysUpdated);
  }

  TrainingBlockClient archive(bool archive) {
    return copyWith(archivedAt: archive ? Timestamp.now() : null);
  }

  TrainingBlockClient getWithOnlyPersonalRecords() {
    return copyWith(
      exerciseDays:
          exerciseDays.map((e) => e.getWithOnlyPersonalRecords()).toList(),
    );
  }
}
