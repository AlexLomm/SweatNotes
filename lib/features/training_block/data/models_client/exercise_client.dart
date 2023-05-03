import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise.dart';
import '../models/exercise_set.dart';
import 'exercise_set_client.dart';

part 'exercise_client.freezed.dart';

@Freezed(
  makeCollectionsUnmodifiable: false,
  equal: false,
)
class ExerciseClient with _$ExerciseClient {
  const ExerciseClient._();

  const factory ExerciseClient({
    Exercise? dbModel,
    required bool isFiller,
    required int? reactionScore,
    required List<ExerciseSetClient> sets,
  }) = _ExerciseClient;

  factory ExerciseClient.empty() {
    return const ExerciseClient(
      dbModel: null,
      isFiller: true,
      reactionScore: null,
      sets: [],
    );
  }

  Exercise toDbModel() {
    final dbModel = this.dbModel;

    final sets = _setsWithNoTrailingFillers
        .map<ExerciseSet>(
          (ExerciseSetClient set) => set.toDbModel(),
    )
        .toList();

    if (isFiller || dbModel == null) {
      return Exercise(
        sets: sets,
        reactionScore: reactionScore,
      );
    }

    return dbModel.copyWith(
      sets: sets,
      reactionScore: reactionScore,
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
    final i = sets.lastIndexWhere((set) => !set.isFiller);

    final setsUpToLastPopulatedOne = sets.sublist(0, i + 1).toList();

    return setsUpToLastPopulatedOne;
  }

  ExerciseClient updateSet({
    required int index,
    required ExerciseSetClient set,
  }) {
    final updatedSets = [...sets];

    updatedSets[index] = set.copyWith(isFiller: false);

    return copyWith(sets: updatedSets);
  }

  ExerciseClient updateScore(int? reactionScore) {
    assert(reactionScore == null || [-5, 0, 5].contains(reactionScore));

    return copyWith(reactionScore: reactionScore);
  }
}
