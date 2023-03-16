import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise_set.dart';

part 'exercise_set_client.freezed.dart';

@freezed
class ExerciseSetClient with _$ExerciseSetClient {
  ExerciseSetClient._();

  bool get isFiller => dbModel == null;

  factory ExerciseSetClient({
    required ExerciseSet? dbModel,
    int? progressFactor,
    required String unit,
    // TODO: change to int
    required String reps,
    // TODO: change to double
    required String load,
    @Default('0') String predictedReps,
    @Default('0') String predictedLoad,
  }) = _ExerciseSetClient;

  factory ExerciseSetClient.empty() {
    return ExerciseSetClient(
      dbModel: null,
      progressFactor: null,
      unit: '',
      reps: '',
      load: '',
    );
  }

  ExerciseSet toDbModel() {
    return ExerciseSet(reps: reps, load: load);
  }

  int? compareProgress(ExerciseSetClient? other) {
    if (isFiller || (reps.isEmpty && load.isEmpty)) return null;

    if (other == null) return null;

    final repA = reps.isEmpty ? 0 : double.parse(reps);
    final loadA = load.isEmpty ? 0 : double.parse(load);

    final repB = other.reps.isEmpty ? 0 : double.parse(other.reps);
    final loadB = other.load.isEmpty ? 0 : double.parse(other.load);

    if (loadA > loadB && repA > repB) return 4;
    if (loadA > loadB && repA == repB) return 3;
    if (loadA > loadB && repA < repB) return 2;

    if (loadA == loadB && repA > repB) return 1;
    if (loadA == loadB && repA == repB) return 0;
    if (loadA == loadB && repA < repB) return -1;

    if (loadA < loadB && repA > repB) return -2;
    if (loadA < loadB && repA == repB) return -3;
    if (loadA < loadB && repA < repB) return -4;

    return null;
  }
}
