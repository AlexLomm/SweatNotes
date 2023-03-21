import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/services/firebase.dart';
import '../../shared/services/shared_preferences.dart';

part 'seed_color_switcher.g.dart';

@riverpod
class SeedColorSwitcher extends _$SeedColorSwitcher {
  static const key = 'seedColor';

  static const defaultSeedColor = Color.fromRGBO(103, 80, 164, 1);
  static const presetColors = [
    Color.fromRGBO(103, 80, 164, 1),
    Color.fromRGBO(47, 88, 205, 1),
    Color.fromRGBO(83, 145, 101, 1),
    Color.fromRGBO(255, 184, 76, 1),
    Color.fromRGBO(223, 46, 56, 1),
  ];

  @override
  Color build() {
    final prefs = ref.watch(prefsProvider);

    final seedColorInt = prefs.getInt(key);

    return seedColorInt == null ? defaultSeedColor : Color(seedColorInt);
  }

  void setSeedColor(Color color) {
    final prefs = ref.watch(prefsProvider);
    final analytics = ref.watch(analyticsProvider);

    state = color;

    prefs.setInt(key, color.value);

    analytics.logEvent(name: 'set_seed_color', parameters: {
      'seed_color': color.value,
      'seed_color_hex': color.value.toRadixString(16),
      'is_preset': presetColors.contains(color),
    });
  }
}
