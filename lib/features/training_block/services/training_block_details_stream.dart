import 'dart:async';
import 'dart:math';

import 'package:rxdart/rxdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/exercise_types_repository.dart';
import '../data/models/exercise_type.dart';
import '../data/models/training_block.dart';
import '../data/models_client/exercise_client.dart';
import '../data/models_client/exercise_day_client.dart';
import '../data/models_client/exercise_set_client.dart';
import '../data/models_client/exercise_type_client.dart';
import '../data/models_client/training_block_client.dart';
import '../data/training_blocks_repository.dart';

part 'training_block_details_stream.g.dart';

@riverpod
Stream<TrainingBlockClient?> trainingBlockDetailsStream(
  TrainingBlockDetailsStreamRef ref,
  String trainingBlockId,
) async* {
  final trainingBlocksRepository = ref.watch(trainingBlocksRepositoryProvider);
  final exerciseTypesRepository = ref.watch(exerciseTypesRepositoryProvider);

  final Stream<TrainingBlock?> trainingBlockStream = trainingBlocksRepository
      //
      .getDocumentRefById(trainingBlockId)
      .snapshots()
      .map((event) => event.data());

  final Stream<List<ExerciseType>> exerciseTypesStream = exerciseTypesRepository
      //
      .getQueryByTrainingBlockId(trainingBlockId)
      .snapshots()
      .map<List<ExerciseType>>((event) => event.docs.map((e) => e.data()).toList());

  final combinedStream = Rx.combineLatest2<TrainingBlock?, List<ExerciseType>, TrainingBlockClient?>(
    trainingBlockStream,
    exerciseTypesStream,
    (trainingBlock, exerciseTypes) {
      try {
        return _getNormalizedData(trainingBlock, exerciseTypes);
      } catch (e) {
        // ignore: avoid_print
        print(e);

        return null;
      }
    },
  );

  await for (final data in combinedStream) {
    yield data;
  }
}

TrainingBlockClient? _getNormalizedData(TrainingBlock? trainingBlock, List<ExerciseType> exerciseTypes) {
  if (trainingBlock == null) {
    return null;
  }

  final maxExercisesCount = exerciseTypes
      //
      .map((exerciseType) => exerciseType.exercises.length)
      .fold<int>(0, max);

  final maxExerciseSetsCount = exerciseTypes
      .expand((exerciseType) => exerciseType.exercises.map((exercise) => exercise.sets.length))
      .fold<int>(0, max);

  final List<ExerciseTypeClient> exerciseTypesClient = exerciseTypes
      .map(
    (exerciseType) => ExerciseTypeClient(
      dbModel: exerciseType,
      name: exerciseType.name,
      unit: exerciseType.unit,
      exercises: [
        ...exerciseType.exercises.map(
          (exercise) => ExerciseClient(
            dbModel: exercise,
            isFiller: false,
            sets: [
              ...exercise.sets.map(
                (exerciseSet) => ExerciseSetClient(
                  dbModel: exerciseSet,
                  isFiller: false,
                  isPersonalRecord: false,
                  unit: exerciseType.unit,
                  load: exerciseSet.load,
                  reps: exerciseSet.reps,
                ),
              ),
              // add filler sets
              ...List.generate(
                maxExerciseSetsCount - exercise.sets.length + 1,
                (index) => ExerciseSetClient.empty().copyWith(unit: exerciseType.unit),
              ),
            ].toList(),
          ),
        ),
        // add filler exercises
        ...List.generate(
          maxExercisesCount - exerciseType.exercises.length + 1,
          (index) => ExerciseClient.empty().copyWith(
            sets: List.generate(
              maxExerciseSetsCount + 1,
              (index) => ExerciseSetClient.empty().copyWith(unit: exerciseType.unit),
            ),
          ),
        ),
      ].toList(),
    ),
  )
      .map((exerciseType) {
    final exerciseSetsPerExerciseCount = exerciseType.exercises[0].sets.length;

    var nearestPopulatedExerciseSets = [...exerciseType.exercises[0].sets];
    var personalRecords = [...exerciseType.exercises[0].sets];

    ///                       compared to
    ///                     ┌─────────────┐
    ///                     ▼             │
    /// ┌───┬───┬───┐ ┌───┬───┬───┐ ┌───┬─┴─┬───┐
    /// │ x │ x │   │ │   │ x │   │ │   │ x │   │
    /// ├───┼───┼───┤ ├───┼───┼───┤ ├───┼───┼───┤
    /// │ x │ x │   │ │   │   │   │ │   │ x │   │
    /// └───┴───┴───┘ └───┴───┴───┘ └───┴─┬─┴───┘
    ///       ▲                           │
    ///       └───────────────────────────┘
    ///                compared to
    for (var i = 1; i < exerciseType.exercises.length; i++) {
      for (var j = 0; j < exerciseSetsPerExerciseCount; j++) {
        final prExerciseSet = personalRecords[j];
        final nearestExerciseSet = nearestPopulatedExerciseSets[j];
        final currentExerciseSet = exerciseType.exercises[i].sets[j];

        if (currentExerciseSet.isFiller) continue;

        if (currentExerciseSet.reps.isEmpty || currentExerciseSet.load.isEmpty) continue;

        final progressFactorAgainstPr = currentExerciseSet.compareProgress(prExerciseSet) ?? 0;
        final progressFactorAgainstNearest = currentExerciseSet.compareProgress(nearestExerciseSet);

        final isPersonalRecord = progressFactorAgainstPr > 0;

        exerciseType.exercises[i].sets[j] = exerciseType.exercises[i].sets[j].copyWith(
          isPersonalRecord: isPersonalRecord,
          progressFactor: progressFactorAgainstNearest,
        );

        if (isPersonalRecord) personalRecords[j] = currentExerciseSet;

        nearestPopulatedExerciseSets[j] = currentExerciseSet;
      }
    }

    return exerciseType;
  }).map((exerciseType) {
    final exerciseSetsPerExerciseCount = exerciseType.exercises[0].sets.length;
    var nearestPopulatedExerciseSets = [...exerciseType.exercises[0].sets];

    ///       get prediction from
    ///         ┌─────────────┐
    ///         ▼             │
    ///   ┌───┬───┬───┐ ┌───┬─┴─┬───┐
    ///   │   │ x │   │ │ x │ x │   │
    ///   ├───┼───┼───┤ ├───┼───┼───┤
    ///   │   │   │   │ │   │   │   │
    ///   └───┴───┴───┘ └───┴───┴───┘
    ///
    ///   get prediction from │
    ///                       ▼
    ///   ┌───┬───┬───┐ ┌───┬───┬───┐
    ///   │   │   │   │ │ x │ x │   │
    ///   ├───┼───┼───┤ ├───┼───┼───┤
    ///   │   │   │   │ │   │   │   │
    ///   └───┴───┴───┘ └───┴───┴───┘
    ///
    ///            get prediction from
    ///                   ┌───┐
    ///                   ▼   │
    ///   ┌───┬───┬───┐ ┌───┬─┴─┬───┐
    ///   │   │   │   │ │ x │   │   │
    ///   ├───┼───┼───┤ ├───┼───┼───┤
    ///   │   │   │   │ │   │   │   │
    ///   └───┴───┴───┘ └───┴───┴───┘
    for (var i = 0; i < exerciseType.exercises.length; i++) {
      for (var j = 0; j < exerciseSetsPerExerciseCount; j++) {
        final nearestExerciseSet = nearestPopulatedExerciseSets[j];
        final currentExerciseSet = exerciseType.exercises[i].sets[j];
        final neighboringExerciseSet = j > 0 ? exerciseType.exercises[i].sets[j - 1] : null;

        exerciseType.exercises[i].sets[j] = exerciseType.exercises[i].sets[j].copyWith(
          predictedReps: [
            nearestExerciseSet.reps,
            currentExerciseSet.reps,
            neighboringExerciseSet?.predictedReps ?? '0',
          ].firstWhere((element) => element.isNotEmpty, orElse: () => '0'),
          predictedLoad: [
            nearestExerciseSet.load,
            currentExerciseSet.load,
            neighboringExerciseSet?.predictedLoad ?? '0',
          ].firstWhere((element) => element.isNotEmpty, orElse: () => '0'),
        );

        nearestPopulatedExerciseSets[j] = currentExerciseSet;
      }
    }

    return exerciseType;
  }).toList();

  final trainingBlockClient = TrainingBlockClient(
    dbModel: trainingBlock,
    name: trainingBlock.name,
    exerciseDays: trainingBlock.exerciseDays
        .where((exerciseDay) => exerciseDay.isNotArchived)
        .map(
          (exerciseDay) => ExerciseDayClient(
            dbModel: exerciseDay,
            name: exerciseDay.name,
            exerciseTypes: exerciseTypesClient
                .where((exerciseType) => exerciseDay.exerciseTypesOrdering.containsKey(exerciseType.dbModel.id))
                .toList()
              ..sort((a, b) {
                final orderingA = exerciseDay.exerciseTypesOrdering[a.dbModel.id] ?? double.maxFinite;
                final orderingB = exerciseDay.exerciseTypesOrdering[b.dbModel.id] ?? double.maxFinite;

                return orderingA.compareTo(orderingB);
              }),
          ),
        )
        .toList(),
  );

  return trainingBlockClient;
}
