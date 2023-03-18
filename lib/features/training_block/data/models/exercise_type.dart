import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise.dart';

part 'exercise_type.freezed.dart';

part 'exercise_type.g.dart';

Timestamp? _archivedAtFromJson(int? millisecondsSinceEpoch) {
  if (millisecondsSinceEpoch == null) return null;

  return Timestamp.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
}

int? _archivedAtToJson(Timestamp? timestamp) {
  if (timestamp == null) return null;

  return timestamp.millisecondsSinceEpoch;
}

@Freezed(equal: false)
class ExerciseType with _$ExerciseType {
  const factory ExerciseType({
    @JsonKey(includeToJson: false) required String id,
    @JsonKey(fromJson: _archivedAtFromJson, toJson: _archivedAtToJson) Timestamp? archivedAt,
    required String trainingBlockId,
    required String name,
    required String unit,
    @Default([]) List<Exercise> exercises,
  }) = _ExerciseType;

  factory ExerciseType.fromJson(Map<String, Object?> json) => _$ExerciseTypeFromJson(json);
}
