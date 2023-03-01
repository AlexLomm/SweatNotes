import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wheel_selector_value.freezed.dart';

@freezed
class WheelSelectorValue<T> with _$WheelSelectorValue<T> {
  const factory WheelSelectorValue({
    required String label,
    required T value,
  }) = _WheelSelectorValue<T>;
}
