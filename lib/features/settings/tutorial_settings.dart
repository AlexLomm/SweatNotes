import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/services/shared_preferences.dart';

part 'tutorial_settings.freezed.dart';

part 'tutorial_settings.g.dart';

@freezed
class TutorialSettingsState with _$TutorialSettingsState {
  factory TutorialSettingsState({
    @Default(false) bool isCreateTrainingBlockSeen,
    @Default(false) bool isSeeArchivedTrainingBlocksSeen,
    @Default(false) bool isSettingsSeen,
    @Default(false) bool isTrainingBlockListSeen,
  }) = _TutorialSettingsState;

  factory TutorialSettingsState.fromJson(Map<String, Object?> json) =>
      _$TutorialSettingsStateFromJson(json);
}

@riverpod
class TutorialSettings extends _$TutorialSettings {
  static const key = 'tutorialSettings';

  @override
  TutorialSettingsState build() {
    final prefs = ref.read(prefsProvider);

    final tutorialSettingsStateJson = jsonDecode(prefs.getString(key) ?? '{}');

    return TutorialSettingsState.fromJson(tutorialSettingsStateJson);
  }

  void reset() {
    set((_) => TutorialSettingsState());
  }

  void set(
    TutorialSettingsState Function(TutorialSettingsState prevState) setState,
  ) {
    state = setState(state);

    _persist();
  }

  _persist() {
    final prefs = ref.read(prefsProvider);

    prefs.setString(key, jsonEncode(state.toJson()));
  }
}
