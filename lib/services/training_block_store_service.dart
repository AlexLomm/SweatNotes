import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models_client/exercise_day_client.dart';
import 'normalize_data_service/normalize_data_service.dart';

part 'training_block_store_service.g.dart';

@riverpod
class TrainingBlockStoreService extends _$TrainingBlockStoreService {
  // Stream<List<ExerciseDayClient>> get exerciseDaysClient => _controller.stream;
  // late final StreamController<List<ExerciseDayClient>> _controller;

  // TrainingBlockStoreService() {
  //   _controller = StreamController(onListen: () => _controller.add([]));
  // }

  @override
  FutureOr<List<ExerciseDayClient>> build(String trainingBlockId) async {
    final normalizeDataService = ref.read(normalizeDataServiceProvider);
    // final trainingBlockId = ref.read(selectedTrainingBlockIdProvider);

    print('-----------------------------');
    print(trainingBlockId);

    return normalizeDataService.getNormalizedData(
      trainingBlockId: trainingBlockId,
    );
  }

  Future<void> clear() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async => <ExerciseDayClient>[]);
  }
}

// @riverpod
// class SelectedTrainingBlockId extends _$SelectedTrainingBlockId {
//   @override
//   String build() => '';
//
//   String get value => state;
//
//   set(String value) => state = value;
// }
