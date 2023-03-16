import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise.dart';
import '../models/exercise_set.dart';
import 'exercise_set_client.dart';

part 'exercise_client.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class ExerciseClient with _$ExerciseClient {
  const ExerciseClient._();

  const factory ExerciseClient({
    Exercise? dbModel,
    required bool isFiller,
    required List<ExerciseSetClient> sets,
  }) = _ExerciseClient;

  factory ExerciseClient.empty() {
    return const ExerciseClient(
      dbModel: null,
      isFiller: true,
      sets: [],
    );
  }

  Exercise toExercise() {
    final dbModel = this.dbModel;

    final sets = setsWithNoTrailingFillers
        .map<ExerciseSet>(
          (ExerciseSetClient set) => set.toDbModel(),
        )
        .toList();

    if (isFiller || dbModel == null) {
      return Exercise(sets: sets);
    }

    return dbModel.copyWith(sets: sets);
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

    return setsUpToLastPopulatedOne;
  }

  ExerciseClient updateSet({
    required int index,
    required ExerciseSetClient set,
  }) {
    return copyWith(sets: [
      ...sets.sublist(0, index),
      set.copyWith(isFiller: false),
      ...sets.sublist(index + 1),
    ]);
  }
}
