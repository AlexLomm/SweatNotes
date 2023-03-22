import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/services/firebase.dart';
import '../data/exercise_types_repository.dart';
import '../data/models/exercise_type.dart';
import '../data/models_client/exercise_day_client.dart';
import '../data/models_client/exercise_type_client.dart';
import '../data/models_client/training_block_client.dart';
import '../data/training_blocks_repository.dart';

part 'exercise_types_service.g.dart';

class ExerciseTypesService {
  TrainingBlocksRepository trainingBlocksRepository;
  ExerciseTypesRepository exerciseTypesRepository;
  FirebaseFirestore firestore;

  ExerciseTypesService(
    this.trainingBlocksRepository,
    this.exerciseTypesRepository,
    this.firestore,
  );

  Future<void> update({
    required ExerciseTypeClient exerciseTypeClient,
    required String name,
    required String unit,
  }) async {
    return exerciseTypesRepository
        //
        .getDocumentRefById(exerciseTypeClient.dbModel.id)
        .set(exerciseTypeClient.copyWith(name: name, unit: unit).toDbModel());
  }

  Future<void> create({
    required TrainingBlockClient trainingBlock,
    required ExerciseDayClient exerciseDay,
    required String name,
    required String unit,
    String notes = '',
  }) async {
    final batch = firestore.batch();

    final exerciseDayIndex = trainingBlock.indexOfExerciseDayByPseudoId(exerciseDay.dbModel.pseudoId);

    final newExerciseTypeRef = exerciseTypesRepository.collectionRef.doc();
    final trainingBlockRef = trainingBlocksRepository.getDocumentRefById(trainingBlock.dbModel.id);

    final dbModel = ExerciseType(
      id: newExerciseTypeRef.id,
      trainingBlockId: trainingBlock.dbModel.id,
      name: name,
      unit: unit,
      notes: notes,
    );

    final updatedTrainingBlock = trainingBlock.updateExerciseDayAt(
      index: exerciseDayIndex,
      exerciseDay: exerciseDay.appendExerciseType(
        ExerciseTypeClient(
          dbModel: dbModel,
          name: dbModel.name,
          unit: dbModel.unit,
          notes: dbModel.notes,
          exercises: [],
        ),
      ),
    );

    batch.set(newExerciseTypeRef, dbModel);
    batch.update(
      trainingBlockRef,
      trainingBlocksRepository.toFirestore(updatedTrainingBlock.toDbModel(), null),
    );

    return batch.commit();
  }

  Future<void> updateNotes(ExerciseTypeClient exerciseTypeClient, String notes) async {
    return exerciseTypesRepository.update(exerciseTypeClient.copyWith(notes: notes).toDbModel());
  }

  Future<void> archive(ExerciseTypeClient exerciseTypeClient, bool archive) async {
    return exerciseTypesRepository.update(exerciseTypeClient.archive(archive).toDbModel());
  }
}

@riverpod
ExerciseTypesService exerciseTypesService(ExerciseTypesServiceRef ref) {
  final TrainingBlocksRepository trainingBlocksRepository = ref.watch(trainingBlocksRepositoryProvider);
  final exerciseTypesRepository = ref.watch(exerciseTypesRepositoryProvider);
  final firestore = ref.watch(firestoreProvider);

  return ExerciseTypesService(
    trainingBlocksRepository,
    exerciseTypesRepository,
    firestore,
  );
}
