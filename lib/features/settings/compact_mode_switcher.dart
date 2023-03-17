import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared_preferences.dart';

part 'compact_mode_switcher.g.dart';

@riverpod
class CompactModeSwitcher extends _$CompactModeSwitcher {
  static const key = 'compactMode';

  @override
  bool build() {
    final prefs = ref.watch(prefsProvider);

    return prefs.getBool(key) ?? false;
  }

  void toggle() {
    final prefs = ref.watch(prefsProvider);

    final newState = !state;

    state = newState;

    prefs.setBool(key, newState);
  }
}
