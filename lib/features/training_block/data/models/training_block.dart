import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/timestamp_from_json.dart';
import '../utils/timestamp_to_json.dart';
import 'exercise_day.dart';

part 'training_block.freezed.dart';

part 'training_block.g.dart';

@Freezed(equal: false)
class TrainingBlock with _$TrainingBlock {
  const factory TrainingBlock({
    @JsonKey(includeToJson: false) required String id,
    @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson) Timestamp? archivedAt,
    @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson) Timestamp? startedAt,
    @Default({}) Map<String, int> exerciseDaysOrdering,
    required String name,
    @Default([]) List<ExerciseDay> exerciseDays,
  }) = _TrainingBlock;

  factory TrainingBlock.fromJson(Map<String, Object?> json) => _$TrainingBlockFromJson(json);
}
