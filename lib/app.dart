import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'features/auth/services/user.dart';
import 'features/settings/edit_mode_switcher.dart';
import 'features/settings/show_archived_exercise_types_switcher.dart';
import 'router/router.dart';
import 'shared/services/firebase.dart';
import 'theme.dart';

part 'app.g.dart';

final GlobalKey<ScaffoldMessengerState> _snackBarKey = GlobalKey<ScaffoldMessengerState>();

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final theme = ref.watch(themeProvider);
    final crashlytics = ref.watch(crashlyticsProvider);
    final analytics = ref.watch(analyticsProvider);

    ref.listen(
      userProvider,
      (_, user) => user.whenData((value) async {
        if (value != null) await crashlytics.setUserIdentifier(value.uid);
      }),
    );

    ref.listen(
      userProvider,
      (_, user) => user.whenData((value) async {
        if (value != null) await analytics.setUserId(id: value.uid);
      }),
    );

    ref.listen(
      editModeSwitcherProvider,
      (_, isEditMode) {
        if (isEditMode) return;

        ref.read(showArchivedExerciseTypesSwitcherProvider.notifier).toggle(show: false);
      },
    );

    return MaterialApp.router(
      scaffoldMessengerKey: _snackBarKey,
      debugShowCheckedModeBanner: false,
      title: 'SweatNotes',
      theme: theme,
      routerConfig: goRouter,
    );
  }
}

@riverpod
ScaffoldMessengerState? messenger(MessengerRef ref) {
  return _snackBarKey.currentState;
}
