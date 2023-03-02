import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ordering.freezed.dart';

part 'ordering.g.dart';

@freezed
class Ordering with _$Ordering {
  const factory Ordering({
    required String id,
    required String userId,
    @Default({}) Map<String, int> ordering,
  }) = _Ordering;

  factory Ordering.fromJson(Map<String, Object?> json) =>
      _$OrderingFromJson(json);
}
