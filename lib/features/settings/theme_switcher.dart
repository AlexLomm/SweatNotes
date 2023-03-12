import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared_preferences.dart';

part 'theme_switcher.g.dart';

@riverpod
class ThemeSwitcher extends _$ThemeSwitcher {
  @override
  ThemeMode build() {
    final prefs = ref.watch(prefsProvider);

    final isDark = prefs.getBool('isDark') ?? false;

    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggle() {
    final prefs = ref.watch(prefsProvider);

    final isCurrentThemeDark = state == ThemeMode.dark;
    final nextState = isCurrentThemeDark ? ThemeMode.light : ThemeMode.dark;

    state = nextState;
    prefs.setBool('isDark', !isCurrentThemeDark);
  }
}
