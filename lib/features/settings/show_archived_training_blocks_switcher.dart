import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../shared/services/firebase.dart';

part 'show_archived_training_blocks_switcher.g.dart';

@riverpod
class ShowArchivedTrainingBlocksSwitcher
    extends _$ShowArchivedTrainingBlocksSwitcher {
  @override
  bool build() {
    return false;
  }

  void toggle({bool? show}) {
    final analytics = ref.watch(analyticsProvider);

    final newState = show ?? !state;

    state = newState;

    analytics.logEvent(
      name: 'show_archived_training_blocks',
      parameters: {'show_archived_training_blocks': newState.toString()},
    );
  }
}
