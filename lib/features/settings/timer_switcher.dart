import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/services/firebase.dart';
import '../../shared/services/shared_preferences.dart';

part 'timer_switcher.g.dart';

@riverpod
class TimerSwitcher extends _$TimerSwitcher {
  static const key = 'timerEnabled';

  @override
  bool build() {
    final prefs = ref.watch(prefsProvider);

    return prefs.getBool(key) ?? true;
  }

  void toggle() {
    final prefs = ref.watch(prefsProvider);
    final analytics = ref.watch(analyticsProvider);

    final newState = !state;

    state = newState;

    prefs.setBool(key, newState);

    analytics.logEvent(
        name: 'toggle_timer_enabled',
        parameters: {'timer_enabled': newState.toString()});
  }
}
