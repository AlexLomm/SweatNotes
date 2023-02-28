import 'dart:math';

import 'package:journal_flutter/models/ordering.dart';
import 'package:journal_flutter/models_client/exercise_set_client.dart';
import 'package:journal_flutter/repositories/exercise_days_repository.dart';
import 'package:journal_flutter/repositories/orderings_repository.dart';

import '../models/exercise.dart';
import '../models/exercise_day.dart';
import '../models/exercise_type.dart';
import '../models_client/exercise_client.dart';
import '../models_client/exercise_day_client.dart';
import '../models_client/exercise_type_client.dart';
import '../repositories/exercise_types_repository.dart';
import '../repositories/exercises_repository.dart';
import '../repositories/training_blocks_repository.dart';

class NormalizeDataService {
  final _trainingBlockRepository = TrainingBlocksRepository();
  final _exerciseDaysRepository = ExerciseDaysRepository();
  final _exercisesRepository = ExercisesRepository();
  final _exerciseTypesRepository = ExerciseTypesRepository();
  final _orderingsRepository = OrderingsRepository();

  Future<List<ExerciseDayClient>> getNormalizedData({
    required String trainingBlockId,
  }) async {
    final trainingBlockFuture = _trainingBlockRepository.fetchTrainingBlock(
      id: trainingBlockId,
    );
    final exerciseTypesFuture = _exerciseTypesRepository.fetchExerciseTypes();

    final exerciseDays = await _exerciseDaysRepository.fetchExerciseDays(
      trainingBlockId: trainingBlockId,
    );

    final exerciseDayIds =
        exerciseDays.map((exerciseDay) => exerciseDay.id).toList();

    final exercisesFuture = _exercisesRepository
        .fetchExercisesByMultipleExerciseDayIds(exerciseDayIds: exerciseDayIds);

    final orderingsFuture =
        _orderingsRepository.fetchOrderingsByIds(ids: exerciseDayIds);

    final trainingBlock = await trainingBlockFuture;
    final exerciseTypes = await exerciseTypesFuture;
    final exercises = await exercisesFuture;
    final orderings = await orderingsFuture;

    final exerciseDayExerciseTypeOrderings = generateOrderingsMap(orderings);

    final exerciseDaysMap = generateExerciseDayMap(exerciseDays);
    final exerciseDaysTypesDictionary = getExerciseDaysTypesDictionary(
      exercises,
      exerciseTypes,
    );

    final exerciseDaysWithSortedExerciseTypes =
        exerciseDaysTypesDictionary.entries.map((entry) {
      final exerciseDayId = entry.key;
      final exerciseTypes = entry.value.values.toList();

      exerciseTypes.sort((a, b) {
        final orderingA =
            exerciseDayExerciseTypeOrderings[exerciseDayId]?.ordering[a.id] ??
                double.infinity;

        final orderingB =
            exerciseDayExerciseTypeOrderings[exerciseDayId]?.ordering[b.id] ??
                double.infinity;

        return orderingA.toInt() - orderingB.toInt();
      });

      return exerciseDaysMap[entry.key]!.copyWith(
        id: exerciseDaysMap[entry.key]!.id,
        name: exerciseDaysMap[entry.key]!.name,
        exerciseTypes: exerciseTypes,
      );
    }).toList();

    final emptyExerciseDayIds = Set.of(exerciseDaysMap.keys).difference(
      Set.of(exerciseDaysWithSortedExerciseTypes.map(
        (exerciseDay) => exerciseDay.id,
      )),
    );

    for (final emptyExerciseDayId in emptyExerciseDayIds) {
      exerciseDaysWithSortedExerciseTypes.add(
        ExerciseDayClient(
          id: emptyExerciseDayId,
          name: exerciseDaysMap[emptyExerciseDayId]!.name,
          exerciseTypes: [],
        ),
      );
    }

    exerciseDaysWithSortedExerciseTypes.sort((a, b) {
      final orderingA =
          trainingBlock?.exerciseDayOrdering[a.id] ?? double.infinity;
      final orderingB =
          trainingBlock?.exerciseDayOrdering[b.id] ?? double.infinity;

      return orderingA.toInt() - orderingB.toInt();
    });

    return exerciseDaysWithSortedExerciseTypes;
  }
}

Map<String, Ordering> generateOrderingsMap(
  List<Ordering> orderings,
) {
  final orderingsMap = <String, Ordering>{};

  for (final ordering in orderings) {
    orderingsMap[ordering.id] = ordering;
  }

  return orderingsMap;
}

// TODO: convert to a collection class
Map<String, ExerciseDayClient> generateExerciseDayMap(
  List<ExerciseDay> exerciseDays,
) {
  final exerciseDayMap = <String, ExerciseDayClient>{};

  for (final exerciseDay in exerciseDays) {
    // TODO: add "from" constructor
    exerciseDayMap[exerciseDay.id] = ExerciseDayClient(
      id: exerciseDay.id,
      name: exerciseDay.name,
      exerciseTypes: [],
    );
  }

  return exerciseDayMap;
}

// TODO: refactor
Map<String, Map<String, ExerciseTypeClient>> getExerciseDaysTypesDictionary(
  List<Exercise> exercises,
  List<ExerciseType> exerciseTypes,
) {
  final maxExerciseSetsCount = _getMaxExerciseSetsCount(exercises);
  final maxExercisePlacement = _getMaxExercisePlacement(exercises);

  final map = _generateExerciseDaysExerciseTypesMap(exercises, exerciseTypes);

  for (final exerciseDayId in map.keys) {
    final exerciseTypesMap = map[exerciseDayId]!;

    for (final exerciseTypeId in exerciseTypesMap.keys) {
      final exerciseType = exerciseTypesMap[exerciseTypeId]!;

      final exercisesWithFillerSets = exerciseType.exercises.map((exercise) {
        final exerciseWithFillerSets = exercise.copyWith(exerciseSets: [
          ...exercise.exerciseSets,
          ...List.generate(
            // we want 1 more exercise set than the max for
            // users to always have a blank set to fill in
            maxExerciseSetsCount + 1 - exercise.exerciseSets.length,
            (index) => ExerciseSetClient.empty(),
          )
        ]);

        return exerciseWithFillerSets;
      }).toList();

      final exercisesByPlacementMap = _generateExerciseByPlacementMap(
        exercisesWithFillerSets,
      );

      map[exerciseDayId]![exerciseTypeId] =
          map[exerciseDayId]![exerciseTypeId]!.copyWith(exercises: []);

      var exercises = [...map[exerciseDayId]![exerciseTypeId]!.exercises];

      for (var i = 0; i < maxExercisePlacement + 1; i++) {
        final exercise = exercisesByPlacementMap[i];

        if (exercise == null) {
          exercises.add(ExerciseClient.empty().copyWith(
            exerciseDayId: exerciseDayId,
            placement: i,
            exerciseSets: List.generate(
              maxExerciseSetsCount + 1,
              (index) => ExerciseSetClient.empty(),
            ),
          ));
        } else {
          exercises.add(exercise);
        }
      }

      map[exerciseDayId]![exerciseTypeId] =
          map[exerciseDayId]![exerciseTypeId]!.copyWith(exercises: exercises);
    }
  }

  return map;
}

_getMaxExerciseSetsCount(List<Exercise> exercises) {
  if (exercises.isEmpty) return 0;

  return exercises.map((exercise) => exercise.sets.length).reduce(max);
}

_getMaxExercisePlacement(List<Exercise> exercises) {
  if (exercises.isEmpty) return 0;

  return exercises.map((exercise) => exercise.placement).reduce(max);
}

Map<int, ExerciseClient> _generateExerciseByPlacementMap(
  List<ExerciseClient> exercises,
) {
  final exerciseByPlacementMap = <int, ExerciseClient>{};

  for (final exercise in exercises) {
    exerciseByPlacementMap[exercise.placement] = exercise;
  }

  return exerciseByPlacementMap;
}

Map<String, Map<String, ExerciseTypeClient>>
    _generateExerciseDaysExerciseTypesMap(
  List<Exercise> exercises,
  List<ExerciseType> exerciseTypes,
) {
  final Map<String, Map<String, ExerciseTypeClient>> map = {};

  final exerciseTypesMap = _generateExerciseTypesMap(exerciseTypes);

  for (final exercise in exercises) {
    final exerciseDayId = exercise.exerciseDayId;

    if (!map.containsKey(exerciseDayId)) {
      map[exerciseDayId] = {};
    }

    final exerciseTypeIdExercisesMap = map[exerciseDayId]!;

    final exerciseTypeId = exercise.exerciseTypeId;

    if (!exerciseTypeIdExercisesMap.containsKey(exerciseTypeId)) {
      exerciseTypeIdExercisesMap[exerciseTypeId] =
          exerciseTypesMap[exerciseTypeId]!;
    }

    final exerciseType = map[exerciseDayId]![exerciseTypeId]!;

    map[exerciseDayId]![exerciseTypeId] = exerciseType.copyWith(
      exercises: [
        ...exerciseType.exercises,
        ExerciseClient(
          id: exercise.id,
          exerciseDayId: exercise.exerciseDayId,
          placement: exercise.placement,
          exerciseSets: exercise.sets.map((set) {
            return ExerciseSetClient(
              isFiller: false,
              reps: set.reps,
              load: set.load,
            );
          }).toList(),
        )
      ],
    );
  }

  return map;
}

Map<String, ExerciseTypeClient> _generateExerciseTypesMap(
  List<ExerciseType> exerciseTypes,
) {
  final exerciseTypesMap = <String, ExerciseTypeClient>{};

  for (final exerciseType in exerciseTypes) {
    exerciseTypesMap[exerciseType.id] = ExerciseTypeClient(
      id: exerciseType.id,
      name: exerciseType.name,
      unit: exerciseType.unit,
    );
  }

  return exerciseTypesMap;
}
