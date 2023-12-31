import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/services/shared_preferences.dart';

part 'tutorial_settings.freezed.dart';

part 'tutorial_settings.g.dart';

const int orderCreateTrainingBlock = 0;
const int orderSettings = 1;
const int orderTrainingBlockList = 2;
const int orderShowArchived = 3;

const int orderCreateExerciseDay = 100;
const int orderEditModeSwitcher = 200;
const int orderMoreOptionsMenu = 250;

const int orderExerciseDay = 300;
const int orderCreateExerciseType = 400;
const int orderExerciseType = 500;
const int orderExercise = 600;

const int orderArchiveExerciseDay = 700;
const int orderArchiveExerciseType = 800;

@freezed
class TutorialSettingsState with _$TutorialSettingsState {
  factory TutorialSettingsState({
    @Default(false) bool isCreateTrainingBlockSeen,
    @Default(false) bool isArchivedTrainingBlocksButtonSeen,
    @Default(false) bool isSettingsSeen,
    @Default(false) bool isTrainingBlockListSeen,
    @Default(false) bool isCreateExerciseDaySeen,
    @Default(false) bool isEditModeSeen,
    @Default(false) bool isMoreOptionsMenuSeen,
    @Default(false) bool isExerciseDaySeen,
    @Default(false) bool isCreateExerciseTypeSeen,
    @Default(false) bool isExerciseTypeSeen,
    @Default(false) bool isExerciseSeen,
    @Default(false) bool isArchiveExerciseDaySeen,
    @Default(false) bool isArchiveExerciseTypeSeen,
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
