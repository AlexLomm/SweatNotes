import 'package:equatable/equatable.dart';

import 'exercise_client.dart';

class ExerciseTypeClient extends Equatable {
  final String id;
  final String name;
  final String unit;
  final List<ExerciseClient> exercises;

  const ExerciseTypeClient({
    required this.id,
    required this.name,
    required this.unit,
    this.exercises = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        unit,
        exercises,
      ];
}
