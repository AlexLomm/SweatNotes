import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/models/training_block.dart';
import '../data/training_blocks_repository.dart';

part 'training_blocks_service.g.dart';

class TrainingBlocksService {
  final TrainingBlocksRepository trainingBlocksRepository;

  TrainingBlocksService(this.trainingBlocksRepository);

  Stream<List<TrainingBlock>> get trainingBlocks => trainingBlocksRepository
      .getTrainingBlocks()
      .snapshots()
      .map<List<TrainingBlock>>(
        (event) => event.docs.map((doc) => doc.data()).toList(),
      );

  void addTrainingBlock(TrainingBlock trainingBlock) {
    trainingBlocksRepository.addTrainingBlock(trainingBlock);
  }
}

@riverpod
TrainingBlocksService trainingBlocksService(TrainingBlocksServiceRef ref) {
  final trainingBlocksRepository = ref.watch(trainingBlocksRepositoryProvider);

  return TrainingBlocksService(trainingBlocksRepository);
}
