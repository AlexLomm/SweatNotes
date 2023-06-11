import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/exercise.dart';
import '../models/exercise_type.dart';
import 'exercise_client.dart';
import 'exercise_set_client.dart';

part 'exercise_type_client.freezed.dart';

@Freezed(equal: false)
class ExerciseTypeClient with _$ExerciseTypeClient {
  const ExerciseTypeClient._();

  const factory ExerciseTypeClient({
    required ExerciseType dbModel,
    Timestamp? archivedAt,
    required String name,
    required String unit,
    required String notes,
    required List<ExerciseClient> exercises,
  }) = _ExerciseTypeClient;

  ExerciseType toDbModel() {
    return dbModel.copyWith(
      name: name,
      unit: unit,
      notes: notes,
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
    final emptyExercise = ExerciseClient.empty().copyWith(
      isFiller: false,
      sets: [ExerciseSetClient.empty().copyWith(isFiller: false)],
    );

    return copyWith(exercises: [...exercises, emptyExercise]);
  }

  ExerciseTypeClient archive(bool archive) {
    return copyWith(archivedAt: archive ? Timestamp.now() : null);
  }

  ExerciseTypeClient getWithOnlyPersonalRecords() {
    assert(exercises.isNotEmpty);
    assert(exercises.first.sets.isNotEmpty);

    final List<ExerciseSetClient> prSets = [...exercises.first.sets];

    for (int i = 0; i < exercises.first.sets.length; i++) {
      for (final exercise in exercises.reversed) {
        if (exercise.sets[i].isPersonalRecord) {
          prSets[i] = exercise.sets[i];

          break;
        }
      }
    }

    return copyWith(exercises: [exercises.first.copyWith(sets: prSets)]);
  }
}
