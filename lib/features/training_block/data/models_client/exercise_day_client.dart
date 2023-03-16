import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise_day.dart';
import 'exercise_type_client.dart';

part 'exercise_day_client.freezed.dart';

@freezed
class ExerciseDayClient with _$ExerciseDayClient {
  const ExerciseDayClient._();

  Map<String, int> get _exerciseTypesNewOrdering => exerciseTypes
      //
      .asMap()
      .map((key, value) => MapEntry(value.dbModel.id, key));

  const factory ExerciseDayClient({
    ExerciseDay? dbModel,
    required String name,
    required List<ExerciseTypeClient> exerciseTypes,
  }) = _ExerciseDayClient;

  ExerciseDay toDbModel() {
    final dbModel = this.dbModel;

    if (dbModel == null) {
      return ExerciseDay(
        name: name,
        exerciseTypesOrdering: _exerciseTypesNewOrdering,
      );
    }

    return dbModel.copyWith(
      name: name,
      exerciseTypesOrdering: _exerciseTypesNewOrdering,
    );
  }

  ExerciseDayClient reorderExerciseType({
    required int from,
    required int to,
  }) {
    if (from == to) return this;

    if (from < 0 || from >= exerciseTypes.length) throw Exception('Invalid from index $from');

    if (to < 0 || to >= exerciseTypes.length) throw Exception('Invalid to index $to');

    final newList = [...exerciseTypes];

    if (from < to) {
      for (var i = from; i < to; i++) {
        newList[i] = newList[i + 1];
      }
    } else {
      for (var i = from; i > to; i--) {
        newList[i] = newList[i - 1];
      }
    }

    newList[to] = exerciseTypes[from];

    return copyWith(exerciseTypes: newList);
  }

  ExerciseDayClient addExerciseType(ExerciseTypeClient exerciseTypeClient) {
    return copyWith(
      exerciseTypes: [...exerciseTypes, exerciseTypeClient],
    );
  }
}
