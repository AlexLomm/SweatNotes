import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_set.freezed.dart';

part 'exercise_set.g.dart';

@Freezed(equal: false)
class ExerciseSet with _$ExerciseSet {
  const factory ExerciseSet({
    @Default(0.0) double load,
    @Default(0) int reps,
  }) = _ExerciseSet;

  factory ExerciseSet.fromJson(Map<String, Object?> json) => _$ExerciseSetFromJson(json);
}
