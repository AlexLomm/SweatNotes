import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/training_block.dart';

// TODO: remove
class TrainingBlockState {
  final String trainingBlockId;

  Stream<TrainingBlock> get trainingBlock => _trainingBlockController.stream;
  late final StreamController<TrainingBlock> _trainingBlockController;

  TrainingBlockState({required this.trainingBlockId}) {
    _trainingBlockController = StreamController.broadcast(onListen: () {
      _trainingBlockController.add(const TrainingBlock(
        id: '',
        userId: '',
        name: '',
        exerciseDayOrdering: {},
      ));
    });

    _listen();
  }

  void _listen() {
    FirebaseFirestore.instance
        .doc('training-blocks/$trainingBlockId')
        .snapshots()
        .listen((doc) {
      final dataWithoutId = doc.data();

      if (dataWithoutId == null) {
        return;
      }

      final data = {'id': doc.id, ...dataWithoutId};

      _trainingBlockController.add(TrainingBlock.fromJson(data));
    });
  }

  // void write(TrainingBlock trainingBlock) {
  //   FirebaseFirestore.instance
  //       .collection('training-blocks')
  //       .add(trainingBlock.toJson());
  // }

  void dispose() {
    _trainingBlockController.close();
  }
}
