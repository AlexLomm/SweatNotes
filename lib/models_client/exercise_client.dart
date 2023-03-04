import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise.dart';
import '../models/exercise_set.dart';
import '../models_client/exercise_set_client.dart';
import '../utils/generate_hash.dart';

part 'exercise_client.freezed.dart';

@freezed
class ExerciseClient with _$ExerciseClient {
  const ExerciseClient._();

  const factory ExerciseClient({
    required String id,
    required String userId,
    required String exerciseDayId,
    required String exerciseTypeId,
    @Default(false) bool isFiller,
    @Default(-1) int placement,
    @Default([]) List<ExerciseSetClient> exerciseSets,
  }) = _ExerciseClient;

  factory ExerciseClient.empty({
    required String userId,
    required String exerciseDayId,
    required String exerciseTypeId,
  }) {
    return ExerciseClient(
      id: generateHash(),
      userId: userId,
      exerciseDayId: exerciseDayId,
      isFiller: true,
      placement: -1,
      exerciseSets: [],
      exerciseTypeId: '',
    );
  }

  Exercise toExercise() {
    return Exercise(
      id: id,
      userId: userId,
      exerciseDayId: exerciseDayId,
      exerciseTypeId: exerciseTypeId,
      placement: placement,
      sets: _setsWithNoTrailingFillers
          .map<ExerciseSet>(
            (ExerciseSetClient set) => set.toExerciseSet(),
          )
          .toList(),
    );
  }

  /// Returns a list of exercise sets, where trailing
  /// filler sets are removed. Example:
  ///
  ///       Included   Filtered out
  ///           │       │
  ///           ▼       ▼
  /// ┌───┬───┬───┬───┬───┐
  /// │ x │ x │   │ x │   │
  /// ├───┼───┼───┼───┼───┤
  /// │ x │ x │   │ x │   │
  /// └───┴───┴───┴───┴───┘
  get _setsWithNoTrailingFillers {
    final i = exerciseSets.lastIndexWhere((set) => !set.isFiller);

    final setsUpToLastPopulatedOne = exerciseSets.sublist(0, i + 1).toList();

    return [
      ...setsUpToLastPopulatedOne,
      ...exerciseSets
          .sublist(i + 1, exerciseSets.length)
          .where((set) => !set.isFiller),
    ];
  }
}
