import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'router/router.dart';
import 'theme.dart';

part 'app.g.dart';

final GlobalKey<ScaffoldMessengerState> _snackBarKey = GlobalKey<ScaffoldMessengerState>();

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final theme = ref.watch(themeProvider);

    return MaterialApp.router(
      scaffoldMessengerKey: _snackBarKey,
      debugShowCheckedModeBanner: false,
      title: 'Journal',
      theme: theme,
      routerConfig: goRouter,
    );
  }
}

@riverpod
ScaffoldMessengerState? messenger(MessengerRef ref) {
  return _snackBarKey.currentState;
}
