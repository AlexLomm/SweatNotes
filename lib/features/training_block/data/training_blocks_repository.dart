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

  Query<TrainingBlock> getTrainingBlocksQuery() {
    return firestore
        .collection('training-blocks')
        .where('userId', isEqualTo: firebaseAuth.currentUser?.uid)
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        );
  }

  Future<List<TrainingBlock>> fetchTrainingBlocks() async {
    final snapshot = await getTrainingBlocksQuery().get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  DocumentReference<TrainingBlock> getTrainingBlockQuery(String id) {
    return FirebaseFirestore.instance
        .collection('training-blocks')
        .doc(id)
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        );
  }

  Future<TrainingBlock?> fetchTrainingBlock({required String id}) async {
    final snapshot = await getTrainingBlockQuery(id).get();

    return snapshot.data();
  }

  addTrainingBlock(TrainingBlock trainingBlock) {
    firestore.collection('training-blocks').add(trainingBlock.toJson());
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
