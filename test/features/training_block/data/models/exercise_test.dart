import 'package:flutter_test/flutter_test.dart';
import 'package:sweatnotes/features/training_block/data/models/exercise.dart';
import 'package:sweatnotes/features/training_block/data/models/exercise_set.dart';

void main() {
  group('Exercise', () {
    test('should correctly serialize from and to JSON', () {
      final exercise = Exercise.empty();

      // Convert the exercise to JSON
      final json = exercise.toJson();

      // Check that the JSON has the expected structure and values
      expect(json, {
        'reactionScore': null,
        'sets': [],
      });

      // Create a new exercise from the JSON
      final fromJson = Exercise.fromJson(json);

      // Check that the new exercise has the expected values
      expect(fromJson.reactionScore, null);
      expect(fromJson.sets, isEmpty);
    });

    test('should correctly serialize from and to JSON when not empty', () {
      const exercise = Exercise(
        reactionScore: 5,
        sets: [ExerciseSet(reps: 10, load: 20.0)],
      );

      // Convert the exercise to JSON
      final json = exercise.toJson();

      // Check that the JSON has the expected structure and values
      expect(json, {
        'reactionScore': 5,
        'sets': [
          {'reps': 10, 'load': 20.0},
        ],
      });

      // Create a new exercise from the JSON
      final fromJson = Exercise.fromJson(json);

      // Check that the new exercise has the expected values
      expect(fromJson.reactionScore, 5);
      expect(fromJson.sets.length, 1);
      expect(fromJson.sets[0].reps, 10);
      expect(fromJson.sets[0].load, 20.0);
    });

    test('should handle empty sets list', () {
      final exercise = Exercise.empty();

      // Convert the exercise to JSON
      final json = exercise.toJson();

      // Check that the JSON has the expected structure and values
      expect(json, {
        'reactionScore': null,
        'sets': [],
      });

      // Create a new exercise from the JSON
      final fromJson = Exercise.fromJson(json);

      // Check that the new exercise has the expected values
      expect(fromJson.reactionScore, null);
      expect(fromJson.sets, isEmpty);
    });

    test('should handle non-empty sets list', () {
      const exercise = Exercise(
        reactionScore: 5,
        sets: [ExerciseSet(reps: 10, load: 20.0)],
      );

      // Convert the exercise to JSON
      final json = exercise.toJson();

      // Check that the JSON has the expected structure and values
      expect(json, {
        'reactionScore': 5,
        'sets': [
          {'reps': 10, 'load': 20.0},
        ],
      });

      // Create a new exercise from the JSON
      final fromJson = Exercise.fromJson(json);

      // Check that the new exercise has the expected values
      expect(fromJson.reactionScore, 5);
      expect(fromJson.sets.length, 1);
      expect(fromJson.sets[0].reps, 10);
      expect(fromJson.sets[0].load, 20.0);
    });

    test('should handle null reactionScore', () {
      final exercise = Exercise.empty();

      // Convert the exercise to JSON
      final json = exercise.toJson();

      // Check that the JSON has the expected structure and values
      expect(json, {
        'reactionScore': null,
        'sets': [],
      });

      // Create a new exercise from the JSON
      final fromJson = Exercise.fromJson(json);

      // Check that the new exercise has the expected values
      expect(fromJson.reactionScore, null);
      expect(fromJson.sets, isEmpty);
    });

    test('should handle non-null reactionScore', () {
      const exercise = Exercise(
        reactionScore: 5,
        sets: [ExerciseSet(reps: 10, load: 20.0)],
      );

      // Convert the exercise to JSON
      final json = exercise.toJson();

      // Check that the JSON has the expected structure and values
      expect(json, {
        'reactionScore': 5,
        'sets': [
          {'reps': 10, 'load': 20.0},
        ],
      });

      // Create a new exercise from the JSON
      final fromJson = Exercise.fromJson(json);

      // Check that the new exercise has the expected values
      expect(fromJson.reactionScore, 5);
      expect(fromJson.sets.length, 1);
      expect(fromJson.sets[0].reps, 10);
      expect(fromJson.sets[0].load, 20.0);
    });
  });
}
