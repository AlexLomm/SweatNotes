import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise_type.dart';
import 'exercise_client.dart';

part 'exercise_type_client.freezed.dart';

@freezed
class ExerciseTypeClient with _$ExerciseTypeClient {
  const ExerciseTypeClient._();

  const factory ExerciseTypeClient({
    required String id,
    required String userId,
    required String name,
    required String unit,
    required List<ExerciseClient> exercises,
  }) = _ExerciseTypeClient;

  ExerciseType toExerciseType() {
    return ExerciseType(id: id, userId: userId, name: name, unit: unit);
  }
}
