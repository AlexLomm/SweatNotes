import 'package:flutter/material.dart';
import 'package:journal_flutter/screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Demo Home Page'), actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add new entry',
            splashRadius: 20,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'View entries',
            splashRadius: 20,
            onPressed: () {},
          ),
        ]),
        body: const Home(),
      ),
    );
  }
}

final theme = ThemeData(
  colorSchemeSeed: Colors.purple,
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 22,
      height: 1.27,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  )
);
