import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise.dart';

part 'exercise_type.freezed.dart';

part 'exercise_type.g.dart';

List<Exercise> _exercisesFromJson(List<dynamic> exercises) {
  return exercises.asMap().entries.map(
    (entry) {
      return Exercise.fromJson({
        'placement': entry.key,
        ...entry.value,
      });
    },
  ).toList();
}

@freezed
class ExerciseType with _$ExerciseType {
  const factory ExerciseType({
    @JsonKey(includeToJson: false) required String id,
    required String trainingBlockId,
    required String name,
    required String unit,
    @JsonKey(fromJson: _exercisesFromJson) @Default([]) List<Exercise> exercises,
  }) = _ExerciseType;

  factory ExerciseType.fromJson(Map<String, Object?> json) => _$ExerciseTypeFromJson(json);
}
