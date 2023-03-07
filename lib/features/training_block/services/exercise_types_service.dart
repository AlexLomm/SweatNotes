import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/exercise_types_repository.dart';
import '../data/models_client/exercise_type_client.dart';

part 'exercise_types_service.g.dart';

class ExerciseTypesService {
  ExerciseTypesRepository exerciseTypesRepository;

  ExerciseTypesService(this.exerciseTypesRepository);

  Future<void> setExerciseType({
    required ExerciseTypeClient exerciseTypeClient,
    required String name,
  }) async {
    exerciseTypesRepository
        .getExerciseTypeByIdDocumentRef(exerciseTypeClient.id)
        .set(exerciseTypeClient.copyWith(name: name).toExerciseType());
  }
}

@riverpod
ExerciseTypesService exerciseTypesService(ExerciseTypesServiceRef ref) {
  final exerciseTypesRepository = ref.watch(exerciseTypesRepositoryProvider);

  return ExerciseTypesService(exerciseTypesRepository);
}
