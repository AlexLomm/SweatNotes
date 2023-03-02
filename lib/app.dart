import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './router/router.dart';
import './theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final themeFuture = ref.watch(themeProvider.future);

    return FutureBuilder(
      future: themeFuture,
      builder: (context, snapshot) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Journal',
          theme: snapshot.data,
          routerConfig: goRouter,
        );
      },
    );
  }
}
