import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_type_client.dart';

part 'exercise_day_client.freezed.dart';

part 'exercise_day_client.g.dart';

@freezed
class ExerciseDayClient with _$ExerciseDayClient {
  const factory ExerciseDayClient({
    required String id,
    required String name,
    @Default([]) List<ExerciseTypeClient> exerciseTypes,
  }) = _ExerciseDayClient;

  factory ExerciseDayClient.fromJson(Map<String, Object?> json) =>
      _$ExerciseDayClientFromJson(json);
}
