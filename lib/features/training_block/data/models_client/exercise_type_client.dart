import 'package:cloud_firestore/cloud_firestore.dart';
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
    Timestamp? archivedAt,
    required String name,
    required String unit,
    required List<ExerciseClient> exercises,
  }) = _ExerciseTypeClient;

  ExerciseType toDbModel() {
    return dbModel.copyWith(
      name: name,
      unit: unit,
      archivedAt: archivedAt,
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

  ExerciseTypeClient enlargeExercisesRow() {
    // the last exercise is always a filler
    final lastExercise = exercises.last;

    final updatedExercises = [...exercises];

    updatedExercises[exercises.length - 1] = lastExercise.copyWith(isFiller: false);

    return copyWith(exercises: updatedExercises);
  }

  ExerciseTypeClient archive() {
    return copyWith(archivedAt: Timestamp.now());
  }

  ExerciseTypeClient unarchive() {
    return copyWith(archivedAt: null);
  }
}
