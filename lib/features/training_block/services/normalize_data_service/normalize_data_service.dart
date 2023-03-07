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

    // TODO: refactor into ExerciseDaysByIdsExerciseTypesByIdsMap
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

    // TODO: refactor into ExerciseDaysByIdsExerciseTypesByIdsMap
    final emptyExerciseDayIds = exerciseDaysMap.getEmptyExerciseDayIds(
      exerciseDaysWithSortedExerciseTypes,
    );

    // TODO: refactor into ExerciseDaysByIdsExerciseTypesByIdsMap
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

    return exerciseDaysWithSortedExerciseTypes;
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
