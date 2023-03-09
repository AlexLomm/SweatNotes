import 'dart:math';

import '../../data/models/exercise.dart';

class ExercisesCollection {
  final List<Exercise> exercises;

  int? _maxExercisePlacement;
  int? _maxExerciseSetsCount;

  int get maxExercisePlacement {
    if (exercises.isEmpty) return 0;

    _maxExercisePlacement ??= exercises.map((exercise) => exercise.placement).reduce(max);

    return _maxExercisePlacement ?? 0;
  }

  int get maxExerciseSetsCount {
    if (exercises.isEmpty) return 0;

    _maxExerciseSetsCount ??= exercises.map((exercise) => exercise.sets.length).reduce(max);

    return _maxExerciseSetsCount ?? 0;
  }

  ExercisesCollection(this.exercises);
}
