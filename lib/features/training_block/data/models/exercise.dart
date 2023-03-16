import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_set.dart';

part 'exercise.freezed.dart';

part 'exercise.g.dart';

@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    @JsonKey(includeToJson: false) required int placement,
    @Default([]) List<ExerciseSet> sets,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, Object?> json) => _$ExerciseFromJson(json);
}
