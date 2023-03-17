import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared_preferences.dart';

part 'theme_switcher.g.dart';

@riverpod
class ThemeSwitcher extends _$ThemeSwitcher {
  static const key = 'themeMode';

  @override
  ThemeMode build() {
    final prefs = ref.watch(prefsProvider);

    final themeMode = prefs.getString(key) ?? 'system';

    if (themeMode == 'system') {
      final platformBrightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;

      return platformBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    }

    if (themeMode == 'light') {
      return ThemeMode.light;
    }

    return ThemeMode.dark;
  }

  void setThemeMode(ThemeMode themeMode) {
    final prefs = ref.watch(prefsProvider);

    state = themeMode;

    prefs.setString(key, themeMode.toString().split('.').last);
  }
}
