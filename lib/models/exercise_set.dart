import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_set.freezed.dart';
part 'exercise_set.g.dart';

@freezed
class ExerciseSet with _$ExerciseSet {
  const factory ExerciseSet({
    @Default('') String load,
    @Default('') String reps,
  }) = _ExerciseSet;

  factory ExerciseSet.fromJson(Map<String, Object?> json) =>
      _$ExerciseSetFromJson(json);
}
