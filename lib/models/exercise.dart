import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_set.dart';

part 'exercise.freezed.dart';

part 'exercise.g.dart';

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    @JsonKey(includeToJson: false) required String id,
    required String userId,
    required String exerciseDayId,
    required String exerciseTypeId,
    @Default(-1) int placement,
    @Default([]) List<ExerciseSet> sets,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, Object?> json) =>
      _$ExerciseFromJson(json);
}
