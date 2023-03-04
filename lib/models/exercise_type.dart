import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise_type.freezed.dart';

part 'exercise_type.g.dart';

@freezed
class ExerciseType with _$ExerciseType {
  const factory ExerciseType({
    @JsonKey(includeToJson: false) required String id,
    required String userId,
    required String name,
    required String unit,
  }) = _ExerciseType;

  factory ExerciseType.fromJson(Map<String, Object?> json) =>
      _$ExerciseTypeFromJson(json);
}
