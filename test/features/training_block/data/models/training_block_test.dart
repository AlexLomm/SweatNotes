import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sweatnotes/features/training_block/data/models/training_block.dart';

void main() {
  group('TrainingBlock', () {
    test('should create TrainingBlock object successfully', () {
      final trainingBlock = TrainingBlock(
        id: 'testId',
        archivedAt: Timestamp.now(),
        startedAt: Timestamp.now(),
        exerciseDaysOrdering: {'day1': 1},
        exercisesCollapsedIncludingIndex: -1,
        name: 'Test Block',
        exerciseDays: [],
      );

      expect(trainingBlock.id, 'testId');
      expect(trainingBlock.archivedAt, isNotNull);
      expect(trainingBlock.startedAt, isNotNull);
      expect(trainingBlock.exerciseDaysOrdering, {'day1': 1});
      expect(trainingBlock.exercisesCollapsedIncludingIndex, -1);
      expect(trainingBlock.name, 'Test Block');
      expect(trainingBlock.exerciseDays, isEmpty);
    });

    test('should convert TrainingBlock object to JSON', () {
      final trainingBlock = TrainingBlock(
        id: 'testId',
        archivedAt: Timestamp.now(),
        startedAt: Timestamp.now(),
        exerciseDaysOrdering: {'day1': 1},
        exercisesCollapsedIncludingIndex: -1,
        name: 'Test Block',
        exerciseDays: [],
      );

      final json = trainingBlock.toJson();

      expect(json['archivedAt'], isNotNull);
      expect(json['startedAt'], isNotNull);
      expect(json['exerciseDaysOrdering'], {'day1': 1});
      expect(json['exercisesCollapsedIncludingIndex'], -1);
      expect(json['name'], 'Test Block');
      expect(json['exerciseDays'], isEmpty);
    });

    test('should create TrainingBlock object from JSON', () {
      final json = {
        'id': 'testId',
        'archivedAt': 10000,
        'startedAt': 10000,
        'exerciseDaysOrdering': {'day1': 1},
        'exercisesCollapsedIncludingIndex': -1,
        'name': 'Test Block',
        'exerciseDays': [],
      };

      final trainingBlock = TrainingBlock.fromJson(json);

      expect(trainingBlock.archivedAt, Timestamp(10, 0));
      expect(trainingBlock.startedAt, Timestamp(10, 0));
      expect(trainingBlock.exerciseDaysOrdering, {'day1': 1});
      expect(trainingBlock.exercisesCollapsedIncludingIndex, -1);
      expect(trainingBlock.name, 'Test Block');
      expect(trainingBlock.exerciseDays, isEmpty);
    });
  });
}
