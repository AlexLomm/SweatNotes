import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise_type.dart';
import 'exercise_client.dart';

part 'exercise_type_client.freezed.dart';

@freezed
class ExerciseTypeClient with _$ExerciseTypeClient {
  const ExerciseTypeClient._();

  List<ExerciseClient> get exercisesWithoutFillers {
    final exercisesWithoutFillerSets = exercises
        .where((exercise) => !exercise.isFiller)
        .map((exercise) => exercise.copyWith(sets: exercise.setsWithNoTrailingFillers))
        .toList();

    return exercisesWithoutFillerSets;
  }

  const factory ExerciseTypeClient({
    required ExerciseType dbModel,
    // TODO: remove?
    required String name,
    // TODO: remove?
    required String unit,
    required List<ExerciseClient> exercises,
  }) = _ExerciseTypeClient;

  ExerciseType toDbModel() {
    return dbModel.copyWith(
      exercises: exercisesWithoutFillers.map((exercise) => exercise.toExercise()).toList(),
    );
  }

  ///              Included          Filtered out
  ///                 │                   │
  ///                 ▼                   ▼
  ///   ┌───┬───┐ ┌───┬───┐ ┌───┬───┐ ┌───┬───┐
  ///   │ x │   │ │   │   │ │   │ x │ │   │   │
  ///   ├───┼───┤ ├───┼───┤ ├───┼───┤ ├───┼───┤
  ///   │ x │   │ │   │   │ │   │ x │ │   │   │
  ///   └───┴───┘ └───┴───┘ └───┴───┘ └───┴───┘
  get exercisesWithNoTrailingFillers {
    final i = exercises.lastIndexWhere((e) => !e.isFiller);

    final exercisesUpToLastPopulatedOne = exercises.sublist(0, i + 1).toList();

    return exercisesUpToLastPopulatedOne;
  }

  ExerciseTypeClient updateExercise({
    required int index,
    required ExerciseClient exercise,
  }) {
    return copyWith(exercises: [
      ...exercises.sublist(0, index),
      exercise.copyWith(isFiller: false),
      ...exercises.sublist(index + 1),
    ]);
  }
}
