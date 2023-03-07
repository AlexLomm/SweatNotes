import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/exercise_days_repository.dart';
import '../data/models_client/exercise_day_client.dart';

part 'exercise_days_service.g.dart';

class ExerciseDaysService {
  ExerciseDaysRepository exerciseDaysRepository;

  ExerciseDaysService(this.exerciseDaysRepository);

  Future<void> setName({
    required ExerciseDayClient exerciseDay,
    required String name,
  }) async {
    exerciseDaysRepository
        .getExerciseDayByIdDocumentRef(exerciseDay.id)
        .set(exerciseDay.copyWith(name: name).toExerciseDay());
  }
}

@riverpod
ExerciseDaysService exerciseDaysService(ExerciseDaysServiceRef ref) {
  final exerciseDaysRepository = ref.watch(exerciseDaysRepositoryProvider);

  return ExerciseDaysService(exerciseDaysRepository);
}
