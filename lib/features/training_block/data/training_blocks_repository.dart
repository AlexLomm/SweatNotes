import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/services/firebase.dart';
import 'models/training_block.dart';
import 'utils/timestamp_to_json.dart';

part 'training_blocks_repository.g.dart';

class TrainingBlocksRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  TrainingBlocksRepository(this.firestore, this.firebaseAuth);

  CollectionReference<TrainingBlock> get _collectionRef => firestore
      //
      .collection('users')
      .doc(firebaseAuth.currentUser?.uid)
      .collection('training-blocks')
      .withConverter(
        fromFirestore: _fromFirestore,
        toFirestore: toFirestore,
      );

  Query<TrainingBlock> getTrainingBlocksQueryRef({
    required bool includeArchived,
  }) {
    // NOTE: Adding orderBy to nullable fields will cause training
    // blocks without that field missing be excluded from the list.
    // i.e if you add orderBy('startedAt') to the query, training
    // blocks without startedAt will be excluded from the list.
    return includeArchived
        ? _collectionRef
        : _collectionRef.where('archivedAt', isNull: true);
  }

  DocumentReference<TrainingBlock> getDocumentRef(String? id) {
    return _collectionRef.doc(id);
  }

  Future<void> create(TrainingBlock trainingBlock) {
    return _collectionRef.add(trainingBlock);
  }

  Future<void> update(TrainingBlock trainingBlock) {
    return getDocumentRef(trainingBlock.id).update(
      toFirestore(trainingBlock, null),
    );
  }

  Future<void> archive(String trainingBlockId, bool isArchived) {
    return getDocumentRef(trainingBlockId).update({
      'archivedAt': isArchived ? timestampToJson(Timestamp.now()) : null,
    });
  }

  TrainingBlock _fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc, _) {
    final dataWithoutId = doc.data();

    if (dataWithoutId == null) {
      return TrainingBlock.fromJson({});
    }

    final data = {'id': doc.id, ...dataWithoutId};

    return TrainingBlock.fromJson(data);
  }

  Map<String, dynamic> toFirestore(TrainingBlock trainingBlock, _) =>
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
