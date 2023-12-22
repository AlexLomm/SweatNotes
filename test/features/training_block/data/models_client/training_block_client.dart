import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweatnotes/features/training_block/data/models/exercise_type.dart';
import 'package:sweatnotes/features/training_block/data/models_client/exercise_type_client.dart';
import 'package:sweatnotes/features/training_block/data/models_client/training_block_client.dart';
import 'package:sweatnotes/features/training_block/data/models_client/exercise_day_client.dart';
import 'package:sweatnotes/features/training_block/data/models/training_block.dart';
import 'package:sweatnotes/features/training_block/data/models/exercise_day.dart';

TrainingBlockClient getTrainingBlockClient({bool isArchived = false}) {
  return TrainingBlockClient(
    name: 'Training Block',
    archivedAt: isArchived ? Timestamp(10, 0) : null,
    startedAt: Timestamp(10, 0),
    exercisesCollapsedIncludingIndex: -1,
    exerciseDays: [],
    dbModel: TrainingBlock(
      id: 'trainingBlockId',
      name: 'Training Block',
      archivedAt: Timestamp(10, 0),
      startedAt: Timestamp(10, 0),
      exercisesCollapsedIncludingIndex: -1,
      exerciseDays: [],
    ),
  );
}

ExerciseDayClient getExerciseDayClient({String? id}) {
  return ExerciseDayClient(
    name: 'test-1',
    dates: [],
    exerciseTypes: [],
    dbModel: ExerciseDay(
      pseudoId: id ?? 'pseudoId',
      weekDay: null,
      name: 'Exercise Day',
    ),
  );
}

ExerciseTypeClient getExerciseTypeClient() {
  return const ExerciseTypeClient(
    name: 'Exercise Type',
    exercises: [],
    unit: 'lb',
    notes: 'One two',
    dbModel: ExerciseType(
      id: 'exerciseTypeId',
      trainingBlockId: '',
      unit: 'lb',
      notes: 'One two',
      name: 'Exercise Type',
      archivedAt: null,
      exercises: [],
    ),
  );
}

void main() {
  group('TrainingBlockClient', () {
    test('should create TrainingBlockClient object successfully', () {
      final trainingBlockClient = getTrainingBlockClient(isArchived: true);

      expect(trainingBlockClient.dbModel.id, 'trainingBlockId');
      expect(trainingBlockClient.archivedAt, isNotNull);
      expect(trainingBlockClient.startedAt, isNotNull);
      expect(trainingBlockClient.name, 'Training Block');
      expect(trainingBlockClient.exercisesCollapsedIncludingIndex, -1);
    });

    test('should convert TrainingBlockClient object to TrainingBlock', () {
      final trainingBlockClient = getTrainingBlockClient(isArchived: true)
          .addExerciseDay(getExerciseDayClient());

      final trainingBlock = trainingBlockClient.toDbModel();

      expect(trainingBlock.id, 'trainingBlockId');
      expect(trainingBlock.archivedAt, isNotNull);
      expect(trainingBlock.startedAt, isNotNull);
      expect(trainingBlock.name, 'Training Block');
      expect(trainingBlock.exercisesCollapsedIncludingIndex, -1);
      expect(trainingBlock.exerciseDays, isNotEmpty);
    });

    test('should add ExerciseDayClient to TrainingBlockClient', () {
      final trainingBlockClient = getTrainingBlockClient()
          .addExerciseDay(getExerciseDayClient(id: 'test'));

      expect(trainingBlockClient.exerciseDays.length, 1);
      expect(
        trainingBlockClient.exerciseDays[0].toDbModel().pseudoId,
        'test',
      );
    });

    test(
      'should update ExerciseDayClient at specific index in TrainingBlockClient',
      () {
        final exerciseDayClient1 = getExerciseDayClient(id: '1');
        final exerciseDayClient2 = getExerciseDayClient(id: '2');

        final trainingBlockClient = getTrainingBlockClient()
            .addExerciseDay(exerciseDayClient1)
            .addExerciseDay(exerciseDayClient2)
            .updateExerciseDayAt(
              exerciseDay: getExerciseDayClient(id: 'test'),
              index: 0,
            );

        expect(
          trainingBlockClient.exerciseDays[0].dbModel.pseudoId,
          'test',
        );
      },
    );

    test('should reorder ExerciseDayClient in TrainingBlockClient', () {
      final day1 = getExerciseDayClient(id: '1');
      final day2 = getExerciseDayClient(id: '2');
      final day3 = getExerciseDayClient(id: '3');
      final trainingBlockClient = getTrainingBlockClient();

      final reorderedTrainingBlockClient = trainingBlockClient
          .addExerciseDay(day1)
          .addExerciseDay(day2)
          .addExerciseDay(day3)
          .reorderExerciseDay(exerciseDay: day1, moveBy: 2);

      expect(
        reorderedTrainingBlockClient.exerciseDays[2].dbModel.pseudoId,
        '1',
      );
    });

    test('should archive ExerciseDayClient in TrainingBlockClient', () {
      final day1 = getExerciseDayClient(id: '1');
      final day2 = getExerciseDayClient(id: '2');

      final trainingBlockClient = getTrainingBlockClient()
          .addExerciseDay(day1)
          .addExerciseDay(day2)
          .archiveExerciseDay(day2, true);

      expect(trainingBlockClient.archivedAt, isNull);
      expect(
        trainingBlockClient.exerciseDays[1].toDbModel().archivedAt,
        isNotNull,
      );
    });

    test('should archive TrainingBlockClient', () {
      final trainingBlockClient = getTrainingBlockClient();

      expect(trainingBlockClient.archivedAt, isNull);

      final updatedTrainingBlock = trainingBlockClient.archive(true);

      expect(updatedTrainingBlock.archivedAt, isNotNull);
    });

    test(
      'should not archive exercise days when archiving TrainingBlockClient',
      () {
        final day1 = getExerciseDayClient(id: '1');
        final day2 = getExerciseDayClient(id: '2');

        final trainingBlockClient = getTrainingBlockClient()
            .addExerciseDay(day1)
            .addExerciseDay(day2)
            .archive(true);

        expect(trainingBlockClient.archivedAt, isNotNull);
        expect(
          trainingBlockClient.exerciseDays[0].toDbModel().archivedAt,
          isNull,
        );
        expect(
          trainingBlockClient.exerciseDays[1].toDbModel().archivedAt,
          isNull,
        );
      },
    );

    test(
      'should not archive exercise types when archiving TrainingBlockClient',
      () {
        final exerciseType1 = getExerciseTypeClient();
        final exerciseType2 = getExerciseTypeClient();

        final trainingBlockClient = getTrainingBlockClient()
            .addExerciseDay(
                getExerciseDayClient().appendExerciseType(exerciseType1))
            .addExerciseDay(
                getExerciseDayClient().appendExerciseType(exerciseType2))
            .archive(true);

        expect(trainingBlockClient.archivedAt, isNotNull);
        expect(
          trainingBlockClient.exerciseDays[0].exerciseTypes[0]
              .toDbModel()
              .archivedAt,
          isNull,
        );
        expect(
          trainingBlockClient.exerciseDays[1].exerciseTypes[0]
              .toDbModel()
              .archivedAt,
          isNull,
        );
      },
    );

    test('should get TrainingBlockClient with only personal records', () {
      final trainingBlockClient = getTrainingBlockClient()
          .addExerciseDay(getExerciseDayClient())
          .getWithOnlyPersonalRecords();

      expect(
        trainingBlockClient.exerciseDays[0].toDbModel().weekDay,
        isNull,
      );
    });

    test('should preserve exercise days when toDbModel is called', () {
      final trainingBlockClient = getTrainingBlockClient()
          .addExerciseDay(getExerciseDayClient(id: '1'))
          .addExerciseDay(getExerciseDayClient(id: '2'))
          .addExerciseDay(getExerciseDayClient(id: '3'));

      expect(trainingBlockClient.toDbModel().exerciseDays.length, 3);
    });

    test('should preserve exercise days when toJson is called', () {
      final trainingBlockClient = getTrainingBlockClient()
          .addExerciseDay(getExerciseDayClient())
          .addExerciseDay(getExerciseDayClient())
          .addExerciseDay(getExerciseDayClient());

      final json = trainingBlockClient.toDbModel().toJson();

      expect(json['exerciseDays'].length, 3);
    });

    test('should preserve exerciseDaysOrdering when toDbModel is called', () {
      final trainingBlockClient = getTrainingBlockClient()
          .addExerciseDay(getExerciseDayClient(id: '1'))
          .addExerciseDay(getExerciseDayClient(id: '2'))
          .addExerciseDay(getExerciseDayClient(id: '3'));

      final trainingBlock = trainingBlockClient.toDbModel();

      expect(trainingBlock.exerciseDaysOrdering['1'], 0);
      expect(trainingBlock.exerciseDaysOrdering['2'], 1);
      expect(trainingBlock.exerciseDaysOrdering['3'], 2);
    });

    test('should preserve exerciseDaysOrdering when toJson is called', () {
      final trainingBlockClient = getTrainingBlockClient()
          .addExerciseDay(getExerciseDayClient(id: '1'))
          .addExerciseDay(getExerciseDayClient(id: '2'))
          .addExerciseDay(getExerciseDayClient(id: '3'));

      final json = trainingBlockClient.toDbModel().toJson();

      expect(json['exerciseDaysOrdering']['1'], 0);
      expect(json['exerciseDaysOrdering']['2'], 1);
      expect(json['exerciseDaysOrdering']['3'], 2);
    });
  });
}
