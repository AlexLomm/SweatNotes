import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise_set.dart';

part 'exercise_set_client.freezed.dart';

@Freezed(equal: false)
class ExerciseSetClient with _$ExerciseSetClient {
  ExerciseSetClient._();

  bool get isPersonalRecord =>
      (compareProgress(previousPersonalRecord) ?? 0) > 0;

  factory ExerciseSetClient({
    required ExerciseSet? dbModel,
    required ExerciseSetClient? previousPersonalRecord,
    int? progressFactor,
    required String unit,
    required int reps,
    required double load,
    required bool isFiller,
    @Default(0) int predictedReps,
    @Default(0.0) double predictedLoad,
  }) = _ExerciseSetClient;

  factory ExerciseSetClient.empty() {
    return ExerciseSetClient(
      dbModel: null,
      previousPersonalRecord: null,
      progressFactor: null,
      isFiller: true,
      unit: '',
      reps: 0,
      load: 0.0,
    );
  }

  ExerciseSet toDbModel() {
    return ExerciseSet(reps: reps, load: load);
  }

  int? compareProgress(ExerciseSetClient? other) {
    if (other == null) return null;

    if (load > other.load && reps > other.reps) return 4;
    if (load > other.load && reps == other.reps) return 3;
    if (load > other.load && reps < other.reps) return 2;

    if (load == other.load && reps > other.reps) return 1;
    if (load == other.load && reps == other.reps) return 0;
    if (load == other.load && reps < other.reps) return -1;

    if (load < other.load && reps > other.reps) return -2;
    if (load < other.load && reps == other.reps) return -3;
    if (load < other.load && reps < other.reps) return -4;

    return null;
  }
}
