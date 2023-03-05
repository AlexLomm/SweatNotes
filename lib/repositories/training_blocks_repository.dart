import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../firebase.dart';
import '../models/training_block.dart';

part 'training_blocks_repository.g.dart';

class TrainingBlocksRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  TrainingBlocksRepository(this.firestore, this.firebaseAuth);

  Query<TrainingBlock> getTrainingBlocks() {
    return firestore
        .collection('training-blocks')
        .where('userId', isEqualTo: firebaseAuth.currentUser?.uid)
        .withConverter(
          fromFirestore: (doc, _) {
            final dataWithoutId = doc.data();

            if (dataWithoutId == null) {
              // TODO: add proper empty object
              return TrainingBlock.fromJson({});
            }

            final data = {'id': doc.id, ...dataWithoutId};

            return TrainingBlock.fromJson(data);
          },
          toFirestore: (trainingBlock, _) => trainingBlock.toJson(),
        );
  }

  Future<List<TrainingBlock>> fetchTrainingBlocks() async {
    final snapshot = await getTrainingBlocks().get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  DocumentReference<TrainingBlock> getTrainingBlockQuery(String id) {
    return FirebaseFirestore.instance
        .collection('training-blocks')
        .doc(id)
        .withConverter(
          fromFirestore: (doc, _) {
            final dataWithoutId = doc.data();

            if (dataWithoutId == null) {
              // TODO: add proper empty object
              return TrainingBlock.fromJson({});
            }

            final data = {'id': doc.id, ...dataWithoutId};

            return TrainingBlock.fromJson(data);
          },
          toFirestore: (trainingBlock, _) => trainingBlock.toJson(),
        );
  }

  Future<TrainingBlock?> fetchTrainingBlock({required String id}) async {
    final snapshot = await getTrainingBlockQuery(id).get();

    return snapshot.data();
  }
}

@riverpod
TrainingBlocksRepository trainingBlocksRepository(
  TrainingBlocksRepositoryRef ref,
) {
  final firestore = ref.read(firestoreProvider);
  final firebaseAuth = ref.read(firebaseAuthProvider);

  return TrainingBlocksRepository(firestore, firebaseAuth);
}
