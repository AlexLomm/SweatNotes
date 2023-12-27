import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/services/firebase.dart';

part 'edit_mode_switcher.g.dart';

@riverpod
class EditModeSwitcher extends _$EditModeSwitcher {
  @override
  bool build() => false;

  void toggle() {
    final analytics = ref.watch(analyticsProvider);

    final newState = !state;

    state = newState;

    analytics.logEvent(
      name: 'toggle_edit_mode',
      parameters: {'edit_mode': newState.toString()},
    );
  }

  void disable() {
    final analytics = ref.watch(analyticsProvider);

    const newState = false;

    state = newState;

    analytics.logEvent(
      name: 'toggle_edit_mode',
      parameters: {'edit_mode': newState.toString()},
    );
  }
}
