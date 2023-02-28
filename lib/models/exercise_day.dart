import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'exercise_day.freezed.dart';

part 'exercise_day.g.dart';

@freezed
class ExerciseDay with _$ExerciseDay {
  const factory ExerciseDay({
    required String id,
    required String userId,
    required String trainingBlockId,
    required String name,
  }) = _ExerciseDay;

  factory ExerciseDay.fromJson(Map<String, Object?> json) =>
      _$ExerciseDayFromJson(json);
}