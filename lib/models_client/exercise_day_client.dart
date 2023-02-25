import 'package:equatable/equatable.dart';

import 'exercise_type_client.dart';

class ExerciseDayClient extends Equatable {
  final String id;
  final String name;
  final List<ExerciseTypeClient> exerciseTypes;

  const ExerciseDayClient({
    required this.id,
    required this.name,
    this.exerciseTypes = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        exerciseTypes,
      ];
}
