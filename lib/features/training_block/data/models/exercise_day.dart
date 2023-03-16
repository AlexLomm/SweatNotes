import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_day.freezed.dart';

part 'exercise_day.g.dart';

@freezed
class ExerciseDay with _$ExerciseDay {
  const factory ExerciseDay({
    required String name,
    @Default({}) Map<String, int> exerciseTypesOrdering,
  }) = _ExerciseDay;

  factory ExerciseDay.fromJson(Map<String, Object?> json) => _$ExerciseDayFromJson(json);
}
