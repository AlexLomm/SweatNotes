import 'dart:async';
import 'dart:math';

import 'package:journal_flutter/features/training_block/data/models_client/exercise_type_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/exercise_types_repository.dart';
import '../../data/models/exercise_type.dart';
import '../../data/models/training_block.dart';
import '../../data/models_client/exercise_client.dart';
import '../../data/models_client/exercise_day_client.dart';
import '../../data/models_client/exercise_set_client.dart';
import '../../data/models_client/training_block_client.dart';
import '../../data/training_blocks_repository.dart';

part 'normalize_data_service.g.dart';

// TODO: rename service
// TODO: convert to riverpod?
class NormalizeDataService {
  final String trainingBlockId;
  final TrainingBlocksRepository trainingBlocksRepository;
  final ExerciseTypesRepository exerciseTypesRepository;

  TrainingBlock? _trainingBlock;
  List<ExerciseType>? _exerciseTypes;

  Stream<TrainingBlockClient?> get data => _dataController.stream;
  late final StreamController<TrainingBlockClient?> _dataController;

  NormalizeDataService({
    required this.trainingBlockId,
    required this.trainingBlocksRepository,
    required this.exerciseTypesRepository,
  }) {
    _dataController = StreamController<TrainingBlockClient?>(
      onListen: _recalculateState,
      onCancel: () => _dataController.close(),
    );

    trainingBlocksRepository
        //
        .getDocumentRefById(trainingBlockId)
        .snapshots()
        .listen((event) {
      _trainingBlock = event.data();

      _recalculateState();
    });

    exerciseTypesRepository
        //
        .getQueryByTrainingBlockId(trainingBlockId)
        .snapshots()
        .listen((event) {
      _exerciseTypes = event.docs.map((e) => e.data()).toList();

      _recalculateState();
    });
  }

  _recalculateState() {
    try {
      _dataController.add(getNormalizedData(trainingBlockId));
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  TrainingBlockClient? getNormalizedData(trainingBlockId) {
    final trainingBlock = _trainingBlock;
    final exerciseTypes = _exerciseTypes;

    if (trainingBlock == null || exerciseTypes == null) {
      return null;
    }

    final maxExerciseSetsCount = exerciseTypes
        .map((exerciseType) => exerciseType.exercises.map((exercise) => exercise.sets.length).reduce(max))
        .reduce(max);

    final List<ExerciseTypeClient> exerciseTypesClient = exerciseTypes
        .map(
      (exerciseType) => ExerciseTypeClient(
        dbModel: exerciseType,
        name: exerciseType.name,
        unit: exerciseType.unit,
        exercises: exerciseType.exercises
            .map<ExerciseClient>(
              (exercise) => ExerciseClient(
                dbModel: exercise,
                placement: exercise.placement,
                sets: [
                  ...exercise.sets.map(
                    (exerciseSet) => ExerciseSetClient(
                      dbModel: exerciseSet,
                      unit: exerciseType.unit,
                      load: exerciseSet.load,
                      reps: exerciseSet.reps,
                    ),
                  ),
                  // add filler sets
                  ...List.generate(
                    maxExerciseSetsCount - exercise.sets.length + 1,
                    (index) => ExerciseSetClient(
                      dbModel: null,
                      unit: exerciseType.unit,
                      load: '',
                      reps: '',
                    ),
                  ),
                ].toList(),
              ),
            )
            .toList(),
      ),
    )
        .map((exerciseType) {
      final exerciseSetsPerExerciseCount = exerciseType.exercises[0].sets.length;

      var nearestPopulatedExerciseSets = [...exerciseType.exercises[0].sets];

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
          final currentExerciseSet = exerciseType.exercises[i].sets[j];

          if (currentExerciseSet.isFiller) continue;

          if (currentExerciseSet.reps.isEmpty || currentExerciseSet.load.isEmpty) continue;

          exerciseType.exercises[i].sets[j] = exerciseType.exercises[i].sets[j].copyWith(
            progressFactor: currentExerciseSet.compareProgress(nearestExerciseSet),
          );

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
              neighboringExerciseSet?.predictedReps ?? '',
            ].firstWhere((element) => element.isNotEmpty, orElse: () => ''),
            predictedLoad: [
              nearestExerciseSet.load,
              currentExerciseSet.load,
              neighboringExerciseSet?.predictedLoad ?? '',
            ].firstWhere((element) => element.isNotEmpty, orElse: () => ''),
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
          .map(
            (exerciseDay) => ExerciseDayClient(
              dbModel: exerciseDay,
              name: exerciseDay.name,
              exerciseTypes: exerciseTypesClient
                  .where((exerciseType) => exerciseDay
                  .exerciseTypesOrdering.containsKey(exerciseType.dbModel.id))
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
}

@riverpod
NormalizeDataService normalizeDataService(
  NormalizeDataServiceRef ref,
  String trainingBlockId,
) {
  final trainingBlocksRepository = ref.watch(trainingBlocksRepositoryProvider);
  final exerciseTypesRepository = ref.watch(exerciseTypesRepositoryProvider);

  return NormalizeDataService(
    trainingBlockId: trainingBlockId,
    trainingBlocksRepository: trainingBlocksRepository,
    exerciseTypesRepository: exerciseTypesRepository,
  );
}
