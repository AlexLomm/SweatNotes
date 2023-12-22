import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/services/firebase.dart';
import 'models/exercise_type.dart';

part 'exercise_types_repository.g.dart';

class ExerciseTypesRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  ExerciseTypesRepository(this.firestore, this.firebaseAuth);

  CollectionReference<ExerciseType> get collectionRef => firestore
      //
      .collection('users')
      .doc(firebaseAuth.currentUser?.uid)
      .collection('exercise-types')
      .withConverter(
        fromFirestore: _fromFirestore,
        toFirestore: _toFirestore,
      );

  DocumentReference<ExerciseType> getDocumentRef(String? id) {
    return collectionRef.doc(id);
  }

  Query<ExerciseType> getQueryByTrainingBlockId(String trainingBlockId,
      {required bool includeArchived}) {
    return includeArchived
        ? collectionRef.where('trainingBlockId', isEqualTo: trainingBlockId)
        : collectionRef
            .where('archivedAt', isNull: true)
            .where('trainingBlockId', isEqualTo: trainingBlockId);
  }

  Future<void> update(ExerciseType exerciseType) async {
    return getDocumentRef(exerciseType.id)
        .update(_toFirestore(exerciseType, null));
  }

  ExerciseType _fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc, _) {
    final dataWithoutId = doc.data();

    if (dataWithoutId == null) {
      return ExerciseType.fromJson({});
    }

    final data = {'id': doc.id, ...dataWithoutId};

    return ExerciseType.fromJson(data);
  }

  Map<String, dynamic> _toFirestore(ExerciseType exerciseType, _) =>
      exerciseType.toJson();
}

@riverpod
ExerciseTypesRepository exerciseTypesRepository(
  ExerciseTypesRepositoryRef ref,
) {
  final firestore = ref.read(firestoreProvider);
  final firebaseAuth = ref.read(firebaseAuthProvider);

  return ExerciseTypesRepository(firestore, firebaseAuth);
}
