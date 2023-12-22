import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/timestamp_from_json.dart';
import '../utils/timestamp_to_json.dart';
import 'exercise.dart';

part 'exercise_type.freezed.dart';

part 'exercise_type.g.dart';

@Freezed(equal: false)
class ExerciseType with _$ExerciseType {
  const factory ExerciseType({
    @JsonKey(includeToJson: false) required String id,
    @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
    Timestamp? archivedAt,
    required String trainingBlockId,
    required String name,
    required String unit,
    required String notes,
    @Default([]) List<Exercise> exercises,
  }) = _ExerciseType;

  factory ExerciseType.fromJson(Map<String, Object?> json) =>
      _$ExerciseTypeFromJson(json);
}
