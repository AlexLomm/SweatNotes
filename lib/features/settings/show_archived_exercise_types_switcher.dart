import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/services/firebase.dart';

part 'show_archived_exercise_types_switcher.g.dart';

@riverpod
class ShowArchivedExerciseTypesSwitcher extends _$ShowArchivedExerciseTypesSwitcher {
  @override
  bool build() {
    return false;
  }

  void toggle({bool? show}) {
    final analytics = ref.watch(analyticsProvider);

    final newState = show ?? !state;

    state = newState;

    analytics.logEvent(
      name: 'show_archived_exercise_types',
      parameters: {'show_archived_exercise_types': newState.toString()},
    );
  }
}
