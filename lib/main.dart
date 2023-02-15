import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journal_flutter/screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal',
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          actions: [
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
          ],
        ),
        body: const Home(),
      ),
    );
  }
}

final theme = ThemeData(
  colorSchemeSeed: Colors.purple,
  textTheme: TextTheme(
    titleLarge: GoogleFonts.robotoTextTheme().bodyLarge!.copyWith(
          fontSize: 22,
          height: 1.27,
          color: const Color.fromRGBO(28, 27, 31, 1),
        ),
    labelSmall: GoogleFonts.robotoTextTheme().labelSmall!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 11,
          height: 1.45,
          color: const Color.fromRGBO(73, 69, 79, 1),
        ),
  ),
);
