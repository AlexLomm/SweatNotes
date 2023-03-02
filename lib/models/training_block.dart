import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_block.freezed.dart';

part 'training_block.g.dart';

@freezed
class TrainingBlock with _$TrainingBlock {
  const factory TrainingBlock({
    required String id,
    required String userId,
    required String name,
    @Default({}) Map<String, int> exerciseDayOrdering,
  }) = _TrainingBlock;

  factory TrainingBlock.fromJson(Map<String, Object?> json) =>
      _$TrainingBlockFromJson(json);
}
