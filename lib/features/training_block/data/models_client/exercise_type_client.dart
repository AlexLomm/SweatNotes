import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise.dart';
import '../models/exercise_type.dart';
import 'exercise_client.dart';

part 'exercise_type_client.freezed.dart';

@Freezed(equal: false)
class ExerciseTypeClient with _$ExerciseTypeClient {
  const ExerciseTypeClient._();

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
      name: name,
      unit: unit,
      exercises: _exercisesWithNoTrailingFillers.map<Exercise>((e) => e.toDbModel()).toList(),
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
  List<ExerciseClient> get _exercisesWithNoTrailingFillers {
    final i = exercises.lastIndexWhere((e) => !e.isFiller);

    final exercisesUpToLastPopulatedOne = exercises.sublist(0, i + 1).toList();

    return exercisesUpToLastPopulatedOne;
  }

  ExerciseTypeClient updateExercise({
    required int index,
    required ExerciseClient exercise,
  }) {
    final updatedExercises = [...exercises];

    updatedExercises[index] = exercise.copyWith(isFiller: false);

    return copyWith(exercises: updatedExercises);
  }
}
