import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/exercise_days_repository.dart';
import '../../data/exercise_types_repository.dart';
import '../../data/exercises_repository.dart';
import '../../data/models/exercise.dart';
import '../../data/models/exercise_day.dart';
import '../../data/models/exercise_type.dart';
import '../../data/models/training_block.dart';
import '../../data/models_client/exercise_day_client.dart';
import '../../data/models_client/exercise_set_client.dart';
import '../../data/training_blocks_repository.dart';
import 'exercise_days_by_ids_exercise_types_by_ids_map.dart';
import 'exercise_days_by_ids_map.dart';

part 'normalize_data_service.g.dart';

// TODO: rename service
class NormalizeDataService {
  final String trainingBlockId;
  final TrainingBlocksRepository trainingBlocksRepository;
  final ExerciseDaysRepository exerciseDaysRepository;
  final ExerciseTypesRepository exerciseTypesRepository;
  final ExercisesRepository exercisesRepository;

  TrainingBlock? _trainingBlock;
  List<ExerciseDay>? _exerciseDays;
  List<ExerciseType>? _exerciseTypes;
  List<Exercise>? _exercises;

  // TODO: rename and include training block
  Stream<List<ExerciseDayClient>> get exerciseDays =>
      _exerciseDaysClientController.stream;
  late final StreamController<List<ExerciseDayClient>>
      _exerciseDaysClientController;

  NormalizeDataService({
    required this.trainingBlockId,
    required this.trainingBlocksRepository,
    required this.exerciseDaysRepository,
    required this.exerciseTypesRepository,
    required this.exercisesRepository,
  }) {
    _exerciseDaysClientController = StreamController<List<ExerciseDayClient>>(
      onListen: _recalculateState,
      // onCancel: () => _exerciseDaysClientController.close(),
    );

    trainingBlocksRepository
        .getDocumentRefById(trainingBlockId)
        .snapshots()
        .listen((event) {
      _trainingBlock = event.data();

      _recalculateState();
    });

    exerciseDaysRepository
        .getQueryByTrainingBlockId(trainingBlockId)
        .snapshots()
        .listen((event) {
      _exerciseDays = event.docs.map((e) => e.data()).toList();

      _recalculateState();
    });

    exerciseTypesRepository
        //
        .getQuery()
        .snapshots()
        .listen((event) {
      _exerciseTypes = event.docs.map((e) => e.data()).toList();

      _recalculateState();
    });

    exercisesRepository
        .getQueryByTrainingBlockId(trainingBlockId)
        .snapshots()
        .listen(
      (event) {
        _exercises = event.docs.map((e) => e.data()).toList();

        _recalculateState();
      },
    );
  }

  _recalculateState() {
    try {
      _exerciseDaysClientController.add(getNormalizedData(trainingBlockId));
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  List<ExerciseDayClient> getNormalizedData(String trainingBlockId) {
    final trainingBlock = _trainingBlock;
    final exerciseDays = _exerciseDays;
    final exerciseTypes = _exerciseTypes;
    final exercises = _exercises;

    if (trainingBlock == null ||
        exerciseDays == null ||
        exerciseTypes == null ||
        exercises == null) return [];

    final exerciseDaysMap = ExerciseDaysByIdsMap(exerciseDays);

    final exerciseDaysTypesMap = ExerciseDaysByIdsExerciseTypesByIdsMap(
      userId: trainingBlock.userId,
      trainingBlockId: trainingBlock.id,
      exercises: exercises,
      exerciseTypes: exerciseTypes,
    );

    // TODO: refactor into ExerciseDaysByIdsExerciseTypesByIdsMap??
    final exerciseDaysWithSortedExerciseTypes =
        exerciseDaysTypesMap.entries.map((entry) {
      final exerciseDayId = entry.key;
      final exerciseTypes = entry.value.values.toList();

      final exerciseTypesOrdering =
          exerciseDaysMap.get(exerciseDayId).exerciseTypesOrdering;

      exerciseTypes.sort((a, b) {
        final orderingA = exerciseTypesOrdering[a.id] ?? double.maxFinite;
        final orderingB = exerciseTypesOrdering[b.id] ?? double.maxFinite;

        return orderingA.toInt() - orderingB.toInt();
      });

      final exerciseDay = exerciseDaysMap.get(entry.key);

      return exerciseDay.copyWith(
        id: exerciseDay.id,
        name: exerciseDay.name,
        exerciseTypes: exerciseTypes,
      );
    }).toList();

    // TODO: refactor into ExerciseDaysByIdsExerciseTypesByIdsMap??
    final emptyExerciseDayIds = exerciseDaysMap.getEmptyExerciseDayIds(
      exerciseDaysWithSortedExerciseTypes,
    );

    // TODO: refactor into ExerciseDaysByIdsExerciseTypesByIdsMap??
    for (final emptyExerciseDayId in emptyExerciseDayIds) {
      exerciseDaysWithSortedExerciseTypes.add(ExerciseDayClient(
        id: emptyExerciseDayId,
        userId: trainingBlock.userId,
        trainingBlockId: trainingBlockId,
        name: exerciseDaysMap.get(emptyExerciseDayId).name,
        exerciseTypesOrdering: {},
        exerciseTypes: [],
      ));
    }

    // TODO: refactor into ExerciseDaysByIdsExerciseTypesByIdsMap
    exerciseDaysWithSortedExerciseTypes.sort((a, b) {
      final o1 = trainingBlock.exerciseDaysOrdering[a.id] ?? double.maxFinite;
      final o2 = trainingBlock.exerciseDaysOrdering[b.id] ?? double.maxFinite;

      return o1.toInt() - o2.toInt();
    });

    // TODO: refactor out
    final exerciseDaysWithProgress =
        exerciseDaysWithSortedExerciseTypes.map((exerciseDay) {
      final exerciseTypesWithProgress =
          exerciseDay.exerciseTypes.map((exerciseType) {
        final allExerciseSets = exerciseType.exercises
            .map(
              (exercise) => exercise.exerciseSets.map(
                (exerciseSet) => _ExerciseSetClientWithExerciseId(
                  exerciseId: exercise.id,
                  exerciseSet: exerciseSet,
                ),
              ),
            )
            .expand<_ExerciseSetClientWithExerciseId>((element) => element)
            .toList();

        final exerciseSetCountPerExercise =
            exerciseType.exercises[0].exerciseSets.length;

        final nearestExerciseSets =
            exerciseType.exercises[0].exerciseSets.toList();

        for (var i = exerciseSetCountPerExercise;
            i < allExerciseSets.length;
            i++) {
          final nearestExerciseSetIndex = i % exerciseSetCountPerExercise;
          final nearestExerciseSet =
              nearestExerciseSets[nearestExerciseSetIndex];

          final currentExerciseSet = allExerciseSets[i].exerciseSet;

          if (currentExerciseSet.isFiller) continue;

          if (currentExerciseSet.reps.isEmpty ||
              currentExerciseSet.load.isEmpty) continue;

          nearestExerciseSets[nearestExerciseSetIndex] = currentExerciseSet;

          allExerciseSets[i] = allExerciseSets[i].copyWith(
            exerciseSet: allExerciseSets[i].exerciseSet.copyWith(
                  progressFactor: currentExerciseSet.compareProgress(
                    nearestExerciseSet,
                  ),
                ),
          );
        }

        final map = <String, List<ExerciseSetClient>>{};

        for (var e in allExerciseSets) {
          map[e.exerciseId] ??= [];
          map[e.exerciseId]!.add(e.exerciseSet);
        }

        return exerciseType.copyWith(
          exercises: exerciseType.exercises.map((exercise) {
            return exercise.copyWith(
              exerciseSets: exercise.exerciseSets.asMap().entries.map((entry) {
                final i = entry.key;
                final exerciseSet = entry.value;

                return exerciseSet.copyWith(
                  progressFactor: map[exercise.id]![i].progressFactor,
                );
              }).toList(),
            );
          }).toList(),
        );
      });

      return exerciseDay.copyWith(
        exerciseTypes: exerciseTypesWithProgress.toList(),
      );
    }).toList();

    return exerciseDaysWithProgress;
  }
}

/// temporary class that determines which
/// exercise set belongs to which exercise
class _ExerciseSetClientWithExerciseId {
  final String exerciseId;
  final ExerciseSetClient exerciseSet;

  _ExerciseSetClientWithExerciseId({
    required this.exerciseId,
    required this.exerciseSet,
  });

  _ExerciseSetClientWithExerciseId copyWith({
    String? exerciseId,
    ExerciseSetClient? exerciseSet,
  }) {
    return _ExerciseSetClientWithExerciseId(
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseSet: exerciseSet ?? this.exerciseSet,
    );
  }
}

@riverpod
NormalizeDataService normalizeDataService(
  NormalizeDataServiceRef ref,
  String trainingBlockId,
) {
  final trainingBlocksRepository = ref.watch(trainingBlocksRepositoryProvider);
  final exerciseDaysRepository = ref.watch(exerciseDaysRepositoryProvider);
  final exercisesRepository = ref.watch(exercisesRepositoryProvider);
  final exerciseTypesRepository = ref.watch(exerciseTypesRepositoryProvider);

  return NormalizeDataService(
    trainingBlockId: trainingBlockId,
    trainingBlocksRepository: trainingBlocksRepository,
    exerciseDaysRepository: exerciseDaysRepository,
    exercisesRepository: exercisesRepository,
    exerciseTypesRepository: exerciseTypesRepository,
  );
}
