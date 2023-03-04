import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models_client/exercise_set_client.dart';
import '../utils/generate_hash.dart';

part 'exercise_client.freezed.dart';

@freezed
class ExerciseClient with _$ExerciseClient {
  const ExerciseClient._();

  const factory ExerciseClient({
    required String id,
    required String exerciseDayId,
    @Default(false) bool isFiller,
    @Default(-1) int placement,
    @Default([]) List<ExerciseSetClient> exerciseSets,
  }) = _ExerciseClient;

  factory ExerciseClient.fromJson(Map<String, Object?> json) =>
      _$ExerciseClientFromJson(json);

  factory ExerciseClient.empty() {
    return ExerciseClient(
      id: generateHash(),
      exerciseDayId: generateHash(),
      isFiller: true,
      placement: -1,
      exerciseSets: [],
    );
  }
}
