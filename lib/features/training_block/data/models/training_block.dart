import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_day.dart';

part 'training_block.freezed.dart';

part 'training_block.g.dart';

Timestamp? _archivedAtFromJson(int? millisecondsSinceEpoch) {
  if (millisecondsSinceEpoch == null) return null;

  return Timestamp.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
}

int? _archivedAtToJson(Timestamp? timestamp) {
  if (timestamp == null) return null;

  return timestamp.millisecondsSinceEpoch;
}

@Freezed(equal: false)
class TrainingBlock with _$TrainingBlock {
  const factory TrainingBlock({
    @JsonKey(includeToJson: false) required String id,
    @JsonKey(fromJson: _archivedAtFromJson, toJson: _archivedAtToJson) Timestamp? archivedAt,
    required String name,
    @Default([]) List<ExerciseDay> exerciseDays,
  }) = _TrainingBlock;

  factory TrainingBlock.fromJson(Map<String, Object?> json) => _$TrainingBlockFromJson(json);
}
