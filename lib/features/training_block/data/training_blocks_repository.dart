import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../firebase.dart';
import 'models/training_block.dart';

part 'training_blocks_repository.g.dart';

class TrainingBlocksRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  TrainingBlocksRepository(this.firestore, this.firebaseAuth);

  get collectionRef => firestore
      //
      .collection('training-blocks')
      .withConverter(
        fromFirestore: _fromFirestore,
        toFirestore: _toFirestore,
      );

  Query<TrainingBlock> getQuery() {
    return collectionRef.where(
      'userId',
      isEqualTo: firebaseAuth.currentUser?.uid,
    );
  }

  DocumentReference<TrainingBlock> getDocumentRefById(String id) {
    return collectionRef.doc(id);
  }

  Future<void> addTrainingBlock(TrainingBlock trainingBlock) {
    return collectionRef.add(trainingBlock.toJson());
  }

  TrainingBlock _fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc, _) {
    final dataWithoutId = doc.data();

    if (dataWithoutId == null) {
      return TrainingBlock.fromJson({});
    }

    final data = {'id': doc.id, ...dataWithoutId};

    return TrainingBlock.fromJson(data);
  }

  Map<String, dynamic> _toFirestore(TrainingBlock trainingBlock, _) =>
      trainingBlock.toJson();
}

@riverpod
TrainingBlocksRepository trainingBlocksRepository(
  TrainingBlocksRepositoryRef ref,
) {
  final firestore = ref.read(firestoreProvider);
  final firebaseAuth = ref.read(firebaseAuthProvider);

  return TrainingBlocksRepository(firestore, firebaseAuth);
}