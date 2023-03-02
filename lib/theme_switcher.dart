import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../shared_preferences.dart';

part 'theme_switcher.g.dart';

@riverpod
class ThemeSwitcher extends _$ThemeSwitcher {
  Future<bool> get isDark async {
    final prefs = await ref.watch(prefsProvider.future);

    return prefs.getBool('isDark') ?? false;
  }

  @override
  FutureOr<ThemeMode> build() async {
    return await isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggle() async {
    final isCurrentThemeDark = state.value == ThemeMode.dark;

    state = AsyncValue.data(
      isCurrentThemeDark ? ThemeMode.light : ThemeMode.dark,
    );

    final prefs = await ref.watch(prefsProvider.future);

    await prefs.setBool('isDark', !isCurrentThemeDark);
  }
}
