import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
