import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_set.dart';

part 'exercise.freezed.dart';

part 'exercise.g.dart';

@Freezed(equal: false)
class Exercise with _$Exercise {
  const Exercise._();

  const factory Exercise({
    @Default([]) List<ExerciseSet> sets,
  }) = _Exercise;

  factory Exercise.empty() => const Exercise(sets: []);

  factory Exercise.fromJson(Map<String, Object?> json) => _$ExerciseFromJson(json);
}
