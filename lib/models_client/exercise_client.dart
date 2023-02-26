import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:journal_flutter/models_client/exercise_set_client.dart';

part 'exercise_client.freezed.dart';

part 'exercise_client.g.dart';

@freezed
class ExerciseClient with _$ExerciseClient {
  const factory ExerciseClient({
    required String id,
    required String exerciseDayId,
    @Default(false) bool isFiller,
    @Default(-1) int placement,
    @Default([]) List<ExerciseSetClient> exerciseSets,
  }) = _ExerciseClient;

  factory ExerciseClient.fromJson(Map<String, Object?> json) =>
      _$ExerciseClientFromJson(json);
}
