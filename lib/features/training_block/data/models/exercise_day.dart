import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/timestamp_from_json.dart';
import '../utils/timestamp_to_json.dart';

part 'exercise_day.freezed.dart';

part 'exercise_day.g.dart';

@Freezed(equal: false)
class ExerciseDay with _$ExerciseDay {
  get isArchived => archivedAt != null;

  get isNotArchived => archivedAt == null;

  const ExerciseDay._();

  const factory ExerciseDay({
    required String pseudoId,
    required String name,
    @Assert(
      'weekDay == null || [1, 2, 3, 4, 5, 6, 7].contains(weekDay)',
      'weekDay must either be `null` or a valid DateTime.<weekDay> day',
    )
    required int? weekDay,
    @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
    Timestamp? archivedAt,
    @Default({}) Map<String, int> exerciseTypesOrdering,
  }) = _ExerciseDay;

  factory ExerciseDay.fromJson(Map<String, Object?> json) =>
      _$ExerciseDayFromJson(json);
}
