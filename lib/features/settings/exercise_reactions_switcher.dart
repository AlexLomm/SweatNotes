import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/services/firebase.dart';
import '../../shared/services/shared_preferences.dart';

part 'exercise_reactions_switcher.g.dart';

@riverpod
class ExerciseReactionsSwitcher extends _$ExerciseReactionsSwitcher {
  static const key = 'exerciseReactions';

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

    analytics.logEvent(name: 'toggle_exercise_reactions', parameters: {'exercise_reactions': newState.toString()});
  }
}
