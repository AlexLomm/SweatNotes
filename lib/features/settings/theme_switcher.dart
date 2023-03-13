import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared_preferences.dart';

part 'theme_switcher.g.dart';

@riverpod
class ThemeSwitcher extends _$ThemeSwitcher {
  @override
  ThemeMode build() {
    final prefs = ref.watch(prefsProvider);

    final themeMode = prefs.getString('themeMode') ?? 'system';

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

    prefs.setString('themeMode', themeMode.toString().split('.').last);
  }
}
