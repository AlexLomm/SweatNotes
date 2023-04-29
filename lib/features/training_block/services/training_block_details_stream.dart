import 'dart:async';
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

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

  yield* combinedStream;
}

TrainingBlockClient? _getNormalizedData(
  TrainingBlock? trainingBlock,
  List<ExerciseType> exerciseTypes,
) {
  if (trainingBlock == null) {
    return null;
  }

  final maxExercisesCount = exerciseTypes
      //
      .map((exerciseType) => exerciseType.exercises.length)
      .fold<int>(2, max);

  final maxExerciseSetsCount = exerciseTypes
      .expand((exerciseType) => exerciseType.exercises.map((exercise) => exercise.sets.length))
      .fold<int>(2, max);

  final List<ExerciseTypeClient> exerciseTypesClient = exerciseTypes
      .map(
    (exerciseType) => ExerciseTypeClient(
      dbModel: exerciseType,
      name: exerciseType.name,
      unit: exerciseType.unit,
      notes: exerciseType.notes,
      archivedAt: exerciseType.archivedAt,
      exercises: [
        ...exerciseType.exercises.map(
          (exercise) => ExerciseClient(
            dbModel: exercise,
            isFiller: false,
            sets: [
              ...exercise.sets.map(
                (exerciseSet) => ExerciseSetClient(
                  dbModel: exerciseSet,
                  previousPersonalRecord: null,
                  isFiller: false,
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
          maxExercisesCount - exerciseType.exercises.length,
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
        final nearestExerciseSet = nearestPopulatedExerciseSets[j];

        final exerciseSetWithPreviousPr = exerciseType.exercises[i].sets[j].copyWith(
          previousPersonalRecord: personalRecords[j],
        );

        // add previous pr
        exerciseType.exercises[i].sets[j] = exerciseSetWithPreviousPr;

        if (exerciseSetWithPreviousPr.isFiller) continue;

        if (exerciseSetWithPreviousPr.reps == 0 || exerciseSetWithPreviousPr.load == 0) continue;

        final progressAgainstNearestSet = exerciseSetWithPreviousPr.compareProgress(nearestExerciseSet);

        // add progress against nearest neighbour
        exerciseType.exercises[i].sets[j] = exerciseSetWithPreviousPr.copyWith(
          progressFactor: progressAgainstNearestSet,
        );

        nearestPopulatedExerciseSets[j] = exerciseSetWithPreviousPr;

        if (exerciseSetWithPreviousPr.isPersonalRecord) personalRecords[j] = exerciseSetWithPreviousPr;
      }
    }

    return exerciseType;
  }).map((exerciseType) {
    final exerciseSetsPerExerciseCount = exerciseType.exercises[0].sets.length;

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
        final currentExerciseSet = exerciseType.exercises[i].sets[j];
        final neighboringExerciseSet = i > 0 ? exerciseType.exercises[i - 1].sets[j] : null;
        final neighborSet = j > 0 ? exerciseType.exercises[i].sets[j - 1] : null;

        exerciseType.exercises[i].sets[j] = currentExerciseSet.copyWith(
          predictedReps: [
            currentExerciseSet.reps,
            neighboringExerciseSet?.predictedReps ?? 0,
            neighborSet?.predictedReps ?? 0,
          ].firstWhere((element) => element != 0, orElse: () => 0),
          predictedLoad: [
            currentExerciseSet.load,
            neighboringExerciseSet?.predictedLoad ?? 0,
            neighborSet?.predictedLoad ?? 0,
          ].firstWhere((element) => element != 0, orElse: () => 0),
        );
      }
    }

    return exerciseType;
  }).toList();

  final trainingBlockClient = TrainingBlockClient(
    dbModel: trainingBlock,
    archivedAt: trainingBlock.archivedAt,
    startedAt: trainingBlock.startedAt,
    name: trainingBlock.name,
    exercisesCollapsedIncludingIndex: trainingBlock.exercisesCollapsedIncludingIndex,
    exerciseDays: trainingBlock.exerciseDays.where((exerciseDay) => exerciseDay.isNotArchived).map(
      (exerciseDay) {
        final exerciseTypes = exerciseTypesClient
            .where((exerciseType) => exerciseDay.exerciseTypesOrdering.containsKey(exerciseType.dbModel.id))
            .toList()
          ..sort((a, b) {
            final orderingA = exerciseDay.exerciseTypesOrdering[a.dbModel.id] ?? double.maxFinite;
            final orderingB = exerciseDay.exerciseTypesOrdering[b.dbModel.id] ?? double.maxFinite;

            return orderingA.compareTo(orderingB);
          });

        final List<DateTime> dates = [];
        final startedAtDate = trainingBlock.startedAt?.toDate();
        final weekDay = exerciseDay.weekDay;

        if (exerciseTypes.isNotEmpty && startedAtDate != null && weekDay != null) {
          final daysDifference = (weekDay - startedAtDate.weekday) % DateTime.daysPerWeek;
          final firstDate = startedAtDate.add(Duration(days: daysDifference));

          // -1, because we don't want to include a date for the "Previous PRs" column
          for (var i = 0; i < exerciseTypes[0].exercises.length - 1; i++) {
            dates.add(firstDate.add(Duration(days: i * DateTime.daysPerWeek)));
          }
        }

        return ExerciseDayClient(
          dbModel: exerciseDay,
          name: exerciseDay.name,
          dates: dates,
          archivedAt: exerciseDay.archivedAt,
          exerciseTypes: exerciseTypes,
        );
      },
    ).toList()
      ..sort((a, b) {
        final orderingA = trainingBlock.exerciseDaysOrdering[a.dbModel.pseudoId] ?? double.maxFinite;
        final orderingB = trainingBlock.exerciseDaysOrdering[b.dbModel.pseudoId] ?? double.maxFinite;

        return orderingA.compareTo(orderingB);
      }),
  );

  return trainingBlockClient;
}
