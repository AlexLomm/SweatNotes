import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase.dart';
import 'models/exercise_type.dart';

part 'exercise_types_repository.g.dart';

class ExerciseTypesRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  ExerciseTypesRepository(this.firestore, this.firebaseAuth);

  DocumentReference<ExerciseType> getExerciseTypeByIdDocumentRef(String id) {
    return FirebaseFirestore.instance
        .collection('exercise-types')
        .doc(id)
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        );
  }

  Query<ExerciseType> getExerciseTypesQuery() {
    return firestore
        .collection('exercise-types')
        .where('userId', isEqualTo: firebaseAuth.currentUser?.uid)
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        );
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

  Future<List<ExerciseType>> fetchExerciseTypes() async {
    final snapshot = await getExerciseTypesQuery().get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}

@riverpod
ExerciseTypesRepository exerciseTypesRepository(
    ExerciseTypesRepositoryRef ref) {
  final firestore = ref.read(firestoreProvider);
  final firebaseAuth = ref.read(firebaseAuthProvider);

  return ExerciseTypesRepository(firestore, firebaseAuth);
}
