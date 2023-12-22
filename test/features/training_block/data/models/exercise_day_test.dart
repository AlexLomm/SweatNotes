import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweatnotes/features/training_block/data/models/exercise_day.dart';

void main() {
  group('ExerciseDay', () {
    test('should correctly serialize from and to JSON with default values', () {
      const exerciseDay = ExerciseDay(
        pseudoId: 'pseudoId',
        name: 'name',
        weekDay: null,
        archivedAt: null,
        exerciseTypesOrdering: {},
      );

      // Convert the exerciseDay to JSON
      final json = exerciseDay.toJson();

      // Check that the JSON has the expected structure and values
      expect(json, {
        'pseudoId': 'pseudoId',
        'name': 'name',
        'weekDay': null,
        'archivedAt': null,
        'exerciseTypesOrdering': {},
      });

      // Create a new exerciseDay from the JSON
      final fromJson = ExerciseDay.fromJson(json);

      // Check that the new exerciseDay has the expected values
      expect(fromJson.pseudoId, 'pseudoId');
      expect(fromJson.name, 'name');
      expect(fromJson.weekDay, null);
      expect(fromJson.archivedAt, null);
      expect(fromJson.exerciseTypesOrdering, {});
    });

    test('should correctly serialize from and to JSON with non-default values',
        () {
      // Replace with actual non-default values
      final exerciseDay = ExerciseDay(
        pseudoId: 'pseudoId',
        name: 'name',
        weekDay: 5,
        archivedAt: Timestamp(10, 5),
        exerciseTypesOrdering: {'exerciseType': 1},
      );

      // Convert the exerciseDay to JSON
      final json = exerciseDay.toJson();

      // Check that the JSON has the expected structure and values
      expect(json, {
        'pseudoId': 'pseudoId',
        'name': 'name',
        'weekDay': 5,
        'archivedAt': 10000,
        'exerciseTypesOrdering': {'exerciseType': 1},
      });

      // Create a new exerciseDay from the JSON
      final fromJson = ExerciseDay.fromJson(json);

      // Check that the new exerciseDay has the expected values
      expect(fromJson.pseudoId, 'pseudoId');
      expect(fromJson.name, 'name');
      expect(fromJson.weekDay, 5);
      expect(fromJson.archivedAt, Timestamp(10, 0));
      expect(fromJson.exerciseTypesOrdering, {'exerciseType': 1});
    });

    test('should handle null weekDay', () {
      const exerciseDay = ExerciseDay(
        pseudoId: 'pseudoId',
        name: 'name',
        weekDay: null,
        archivedAt: null,
        exerciseTypesOrdering: {},
      );

      // Convert the exerciseDay to JSON
      final json = exerciseDay.toJson();

      // Check that the JSON has the expected structure and values
      expect(json, {
        'pseudoId': 'pseudoId',
        'name': 'name',
        'weekDay': null,
        'archivedAt': null,
        'exerciseTypesOrdering': {},
      });

      // Create a new exerciseDay from the JSON
      final fromJson = ExerciseDay.fromJson(json);

      // Check that the new exerciseDay has the expected values
      expect(fromJson.weekDay, null);
    });

    test('should handle non-null weekDay', () {
      const exerciseDay = ExerciseDay(
        pseudoId: 'pseudoId',
        name: 'name',
        weekDay: 5,
        archivedAt: null,
        exerciseTypesOrdering: {},
      );

      // Convert the exerciseDay to JSON
      final json = exerciseDay.toJson();

      // Check that the JSON has the expected structure and values
      expect(json, {
        'pseudoId': 'pseudoId',
        'name': 'name',
        'weekDay': 5,
        'archivedAt': null,
        'exerciseTypesOrdering': {},
      });

      // Create a new exerciseDay from the JSON
      final fromJson = ExerciseDay.fromJson(json);

      // Check that the new exerciseDay has the expected values
      expect(fromJson.weekDay, 5);
    });

    test('should handle null archivedAt', () {
      const exerciseDay = ExerciseDay(
        pseudoId: 'pseudoId',
        name: 'name',
        weekDay: null,
        archivedAt: null,
        exerciseTypesOrdering: {},
      );

      // Convert the exerciseDay to JSON
      final json = exerciseDay.toJson();

      // Check that the JSON has the expected structure and values
      expect(json, {
        'pseudoId': 'pseudoId',
        'name': 'name',
        'weekDay': null,
        'archivedAt': null,
        'exerciseTypesOrdering': {},
      });

      // Create a new exerciseDay from the JSON
      final fromJson = ExerciseDay.fromJson(json);

      // Check that the new exerciseDay has the expected values
      expect(fromJson.archivedAt, null);
    });

    test('should handle non-null archivedAt', () {
      final exerciseDay = ExerciseDay(
        pseudoId: 'pseudoId',
        name: 'name',
        weekDay: null,
        archivedAt: Timestamp(10, 0),
        exerciseTypesOrdering: {},
      );

      // Convert the exerciseDay to JSON
      final json = exerciseDay.toJson();

      // Check that the JSON has the expected structure and values
      expect(json, {
        'pseudoId': 'pseudoId',
        'name': 'name',
        'weekDay': null,
        'archivedAt': 10000,
        'exerciseTypesOrdering': {},
      });

      // Create a new exerciseDay from the JSON
      final fromJson = ExerciseDay.fromJson(json);

      // Check that the new exerciseDay has the expected values
      expect(fromJson.archivedAt, Timestamp(10, 0));
    });

    test('should handle empty exerciseTypesOrdering', () {
      const exerciseDay = ExerciseDay(
        pseudoId: 'pseudoId',
        name: 'name',
        weekDay: null,
        archivedAt: null,
        exerciseTypesOrdering: {},
      );

      // Convert the exerciseDay to JSON
      final json = exerciseDay.toJson();

      // Check that the JSON has the expected structure and values
      expect(json, {
        'pseudoId': 'pseudoId',
        'name': 'name',
        'weekDay': null,
        'archivedAt': null,
        'exerciseTypesOrdering': {},
      });

      // Create a new exerciseDay from the JSON
      final fromJson = ExerciseDay.fromJson(json);

      // Check that the new exerciseDay has the expected values
      expect(fromJson.exerciseTypesOrdering, {});
    });

    test('should handle non-empty exerciseTypesOrdering', () {
      const exerciseDay = ExerciseDay(
        pseudoId: 'pseudoId',
        name: 'name',
        weekDay: null,
        archivedAt: null,
        exerciseTypesOrdering: {'exerciseType': 1},
      );

      // Convert the exerciseDay to JSON
      final json = exerciseDay.toJson();

      // Check that the JSON has the expected structure and values
      expect(json, {
        'pseudoId': 'pseudoId',
        'name': 'name',
        'weekDay': null,
        'archivedAt': null,
        'exerciseTypesOrdering': {'exerciseType': 1},
      });

      // Create a new exerciseDay from the JSON
      final fromJson = ExerciseDay.fromJson(json);

      // Check that the new exerciseDay has the expected values
      expect(fromJson.exerciseTypesOrdering, {'exerciseType': 1});
    });
  });
}
