import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_block_client.freezed.dart';

@freezed
class TrainingBlockClient with _$TrainingBlockClient {
  const factory TrainingBlockClient({
    @JsonKey(includeToJson: false) required String id,
    required String userId,
    required String name,
    required Map<String, int> exerciseDaysOrdering,
  }) = _TrainingBlockClient;
}
