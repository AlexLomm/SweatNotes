import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise_day.dart';
import 'exercise_type_client.dart';

part 'exercise_day_client.freezed.dart';

@freezed
class ExerciseDayClient with _$ExerciseDayClient {
  const ExerciseDayClient._();

  const factory ExerciseDayClient({
    required String id,
    required String name,
    required String userId,
    required String trainingBlockId,
    required Map<String, int> exerciseTypesOrdering,
    required List<ExerciseTypeClient> exerciseTypes,
  }) = _ExerciseDayClient;

  toExerciseDay() => ExerciseDay(
        id: id,
        name: name,
        userId: userId,
        trainingBlockId: trainingBlockId,
        exerciseTypesOrdering: exerciseTypesOrdering,
      );
}
