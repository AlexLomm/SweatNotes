import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/services/shared_preferences.dart';

part 'seed_color_switcher.g.dart';

@riverpod
class SeedColorSwitcher extends _$SeedColorSwitcher {
  static const key = 'seedColor';
  static const defaultSeedColor = Color.fromRGBO(103, 80, 164, 1);

  @override
  Color build() {
    final prefs = ref.watch(prefsProvider);

    final seedColorInt = prefs.getInt(key);

    return seedColorInt == null ? defaultSeedColor : Color(seedColorInt);
  }

  void setSeedColor(Color color) {
    final prefs = ref.watch(prefsProvider);

    state = color;

    prefs.setInt(key, color.value);
  }
}
