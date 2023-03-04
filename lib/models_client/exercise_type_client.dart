import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_client.dart';

part 'exercise_type_client.freezed.dart';

@freezed
class ExerciseTypeClient with _$ExerciseTypeClient {
  const factory ExerciseTypeClient({
    required String id,
    required String name,
    required String unit,
    @Default([]) List<ExerciseClient> exercises,
  }) = _ExerciseTypeClient;
}
