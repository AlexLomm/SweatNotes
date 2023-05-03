import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_set.dart';

part 'exercise.freezed.dart';

part 'exercise.g.dart';

@Freezed(equal: false)
class Exercise with _$Exercise {
  const Exercise._();

  const factory Exercise({
    @Assert(
      'reactionScore == null || [-5, 0, 5].contains(reactionScore)',
      'Invalid `reactionScore`, must be in [-5, 0, 5] (or null)',
    )
        int? reactionScore,
    @Default([])
        List<ExerciseSet> sets,
  }) = _Exercise;

  factory Exercise.empty() => const Exercise(reactionScore: null, sets: []);

  factory Exercise.fromJson(Map<String, Object?> json) => _$ExerciseFromJson(json);
}
