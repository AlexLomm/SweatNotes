import 'package:equatable/equatable.dart';

import 'exercise_set_client.dart';

class ExerciseClient extends Equatable {
  final String id;
  final String exerciseDayId;
  final bool isFiller;
  final int placement;
  final List<ExerciseSetClient> exerciseSets;

  const ExerciseClient({
    required this.id,
    required this.exerciseDayId,
    this.isFiller = false,
    this.placement = -1,
    this.exerciseSets = const [],
  });

  @override
  List<Object?> get props => [
        id,
        exerciseDayId,
        isFiller,
        placement,
        exerciseSets,
      ];
}
