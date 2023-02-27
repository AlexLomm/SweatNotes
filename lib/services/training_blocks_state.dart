import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/training_block.dart';

// TODO: remove
class TrainingBlocksState {
  Stream<List<TrainingBlock>> get trainingBlocks =>
      _trainingBlocksController.stream;
  late final StreamController<List<TrainingBlock>> _trainingBlocksController;

  TrainingBlocksState() {
    _trainingBlocksController = StreamController.broadcast(onListen: () {
      _trainingBlocksController.add([]);
    });

    _listen();
  }

  void _listen() {
    FirebaseFirestore.instance
        .collection('training-blocks')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((event) {
      final trainingBlocks = event.docs.map((doc) {
        final data = {'id': doc.id, ...doc.data()};

        return TrainingBlock.fromJson(data);
      }).toList();

      _trainingBlocksController.add(trainingBlocks);
    });
  }

  void write(TrainingBlock trainingBlock) {
    FirebaseFirestore.instance
        .collection('training-blocks')
        .add(trainingBlock.toJson());
  }

  void dispose() {
    _trainingBlocksController.close();
  }
}
