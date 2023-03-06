import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise_set.dart';

part 'exercise_set_client.freezed.dart';

@freezed
class ExerciseSetClient with _$ExerciseSetClient {
  const ExerciseSetClient._();

  const factory ExerciseSetClient({
    @Default(false) bool isFiller,
    @Default(0) int progressFactor,
    // TODO: change to int
    required String reps,
    // TODO: change to double
    required String load,
  }) = _ExerciseSetClient;

  factory ExerciseSetClient.empty() {
    return const ExerciseSetClient(
      isFiller: true,
      progressFactor: -1,
      reps: '',
      load: '',
    );
  }

  ExerciseSet toExerciseSet() {
    return ExerciseSet(reps: reps, load: load);
  }
}
