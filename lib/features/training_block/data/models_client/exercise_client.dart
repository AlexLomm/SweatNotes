import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise.dart';
import '../models/exercise_set.dart';
import 'exercise_set_client.dart';

part 'exercise_client.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ExerciseClient with _$ExerciseClient {
  const ExerciseClient._();

  bool get isFiller => dbModel == null;

  const factory ExerciseClient({
    Exercise? dbModel,
    // TODO: remove?
    required int placement,
    required List<ExerciseSetClient> sets,
  }) = _ExerciseClient;

  factory ExerciseClient.empty() {
    return const ExerciseClient(
      dbModel: null,
      placement: 0,
      sets: [],
    );
  }

  Exercise toExercise() {
    final sets = setsWithNoTrailingFillers
        .map<ExerciseSet>(
          (ExerciseSetClient set) => set.toDbModel(),
        )
        .toList();

    if (isFiller) {
      Exercise(placement: 0, sets: sets);
    }

    return dbModel!.copyWith(sets: sets);
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
  get setsWithNoTrailingFillers {
    final i = sets.lastIndexWhere((set) => !set.isFiller);

    final setsUpToLastPopulatedOne = sets.sublist(0, i + 1).toList();

    return [
      ...setsUpToLastPopulatedOne,
      ...sets.sublist(i + 1, sets.length).where((set) => !set.isFiller),
    ];
  }
}
