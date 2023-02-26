import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'exercise_client.dart';

part 'exercise_type_client.freezed.dart';

part 'exercise_type_client.g.dart';

@freezed
class ExerciseTypeClient with _$ExerciseTypeClient {
  const factory ExerciseTypeClient({
    required String id,
    required String name,
    required String unit,
    @Default([]) List<ExerciseClient> exercises,
  }) = _ExerciseTypeClient;

  factory ExerciseTypeClient.fromJson(Map<String, Object?> json) =>
      _$ExerciseTypeClientFromJson(json);
}
