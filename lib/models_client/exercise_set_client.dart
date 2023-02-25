import 'package:equatable/equatable.dart';

class ExerciseSetClient extends Equatable {
  final bool isFiller;
  final int progressFactor;
  final String reps;
  final String load;

  const ExerciseSetClient({
    this.isFiller = false,
    this.progressFactor = 0,
    required this.reps,
    required this.load,
  });

  @override
  List<Object?> get props => [isFiller, progressFactor, reps, load];
}
