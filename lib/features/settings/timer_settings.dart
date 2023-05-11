import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/services/shared_preferences.dart';

part 'timer_settings.freezed.dart';

part 'timer_settings.g.dart';

@freezed
class TimerSettingsState with _$TimerSettingsState {
  factory TimerSettingsState({
    @Default(60) int initialSeconds,
    @Default(false) bool isMuted,
  }) = _TimerSettingsState;

  factory TimerSettingsState.fromJson(Map<String, Object?> json) => _$TimerSettingsStateFromJson(json);
}

@riverpod
class TimerSettings extends _$TimerSettings {
  static const key = 'timerSettings';

  static const maxSeconds = Duration.secondsPerHour - 1;
  static const minSeconds = 0;

  @override
  TimerSettingsState build() {
    final prefs = ref.watch(prefsProvider);

    final timerSettingsStateJson = jsonDecode(prefs.getString(key) ?? '{}');

    return TimerSettingsState.fromJson(timerSettingsStateJson);
  }

  int setInitialSeconds(int value) {
    assert(value >= 0 && value <= maxSeconds);

    final prefs = ref.watch(prefsProvider);

    state = state.copyWith(initialSeconds: value);

    prefs.setString(key, jsonEncode(state.toJson()));

    return value;
  }

  int incrementInitialSecondsBy(int value) {
    assert(value >= 0);

    final prefs = ref.watch(prefsProvider);

    final modifiedInitialSeconds = state.initialSeconds + value;
    final updatedInitialSeconds = modifiedInitialSeconds > maxSeconds ? maxSeconds : modifiedInitialSeconds;

    state = state.copyWith(initialSeconds: updatedInitialSeconds);

    prefs.setString(key, jsonEncode(state.toJson()));

    return updatedInitialSeconds;
  }

  int decrementInitialSecondsBy(int value) {
    assert(value >= 0);

    final prefs = ref.watch(prefsProvider);

    final modifiedInitialSeconds = state.initialSeconds - value;
    final updatedInitialSeconds = modifiedInitialSeconds < minSeconds ? minSeconds : modifiedInitialSeconds;

    state = state.copyWith(initialSeconds: updatedInitialSeconds);

    prefs.setString(key, jsonEncode(state.toJson()));

    return updatedInitialSeconds;
  }

  bool setTimerIsMuted(bool value) {
    final prefs = ref.watch(prefsProvider);

    state = state.copyWith(isMuted: value);

    prefs.setString(key, jsonEncode(state.toJson()));

    return value;
  }
}
