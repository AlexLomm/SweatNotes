import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/training_block.dart';

part 'training_blocks_repository.g.dart';

class TrainingBlocksRepository {
  Query<TrainingBlock> getTrainingBlocks() {
    return FirebaseFirestore.instance
        .collection('training-blocks')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
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

  DocumentReference<TrainingBlock> getTrainingBlock({required String id}) {
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
    final snapshot = await getTrainingBlock(id: id).get();

    return snapshot.data();
  }
}

@riverpod
TrainingBlocksRepository trainingBlocksRepository(TrainingBlocksRepositoryRef ref) {
  return TrainingBlocksRepository();
}
