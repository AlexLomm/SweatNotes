import 'package:flutter/material.dart';
import 'package:journal_flutter/router/router.dart';
import 'package:journal_flutter/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Journal',
      theme: theme,
      routerConfig: router,
    );
  }
}
