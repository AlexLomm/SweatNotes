import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'exercise_set_client.freezed.dart';

part 'exercise_set_client.g.dart';

@freezed
class ExerciseSetClient with _$ExerciseSetClient {
  const factory ExerciseSetClient({
    @Default(false) bool isFiller,
    @Default(0) int progressFactor,
    required String reps,
    required String load,
  }) = _ExerciseSetClient;

  factory ExerciseSetClient.fromJson(Map<String, Object?> json) =>
      _$ExerciseSetClientFromJson(json);
}
