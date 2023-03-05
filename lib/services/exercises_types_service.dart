import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models_client/exercise_type_client.dart';
import '../repositories/exercise_types_repository.dart';

part 'exercises_types_service.g.dart';

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
