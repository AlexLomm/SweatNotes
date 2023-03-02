import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'theme_switcher.dart';

part 'theme.g.dart';

const seedColor = Color.fromRGBO(103, 80, 164, 1);

final colorSchemeLight = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: seedColor,
);

final ColorScheme colorSchemeDark = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: seedColor,
);

final textTheme = TextTheme(
  displayLarge: GoogleFonts.robotoTextTheme().displayLarge!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 57,
        height: 1.12,
        color: Colors.black,
      ),
  displayMedium: GoogleFonts.robotoTextTheme().displayMedium!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 45,
        height: 1.16,
        color: Colors.black,
      ),
  displaySmall: GoogleFonts.robotoTextTheme().displaySmall!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 36,
        height: 1.22,
        color: Colors.black,
      ),
  headlineLarge: GoogleFonts.robotoTextTheme().displaySmall!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 32,
        height: 1.25,
        color: Colors.black,
      ),
  headlineMedium: GoogleFonts.robotoTextTheme().headlineMedium!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 28,
        height: 1.29,
        color: Colors.black,
      ),
  headlineSmall: GoogleFonts.robotoTextTheme().headlineSmall!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 24,
        height: 1.33,
        color: Colors.black,
      ),
  titleLarge: GoogleFonts.robotoTextTheme().bodyLarge!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 22,
        height: 1.27,
        color: Colors.black,
      ),
  titleMedium: GoogleFonts.robotoTextTheme().bodyMedium!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 1.5,
        color: Colors.black,
        letterSpacing: 0.15,
      ),
  titleSmall: GoogleFonts.robotoTextTheme().bodySmall!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.43,
        color: Colors.black,
        letterSpacing: 0.1,
      ),
  labelLarge: GoogleFonts.robotoTextTheme().bodyLarge!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.43,
        color: Colors.black,
        letterSpacing: 0.1,
      ),
  labelMedium: GoogleFonts.robotoTextTheme().bodyMedium!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 1.33,
        color: Colors.black,
        letterSpacing: 0.5,
      ),
  labelSmall: GoogleFonts.robotoTextTheme().labelSmall!.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 11,
        height: 1.45,
        color: Colors.black,
        letterSpacing: 0.5,
      ),
  bodyLarge: GoogleFonts.robotoTextTheme().bodyLarge!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.5,
        color: Colors.black,
        letterSpacing: 0.5,
      ),
  bodyMedium: GoogleFonts.robotoTextTheme().bodyMedium!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.43,
        color: Colors.black,
        letterSpacing: 0.25,
      ),
  bodySmall: GoogleFonts.robotoTextTheme().bodySmall!.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.33,
        color: Colors.black,
        letterSpacing: 0.4,
      ),
);

@riverpod
ThemeData theme(ThemeRef ref) {
  final themeMode = ref.watch(themeSwitcherProvider);

  final isLight = themeMode == ThemeMode.light;

  final colorScheme = isLight ? colorSchemeLight : colorSchemeDark;
  final systemOverlayStyle =
      isLight ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;

  return ThemeData(
    useMaterial3: true,
    textTheme: textTheme,
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: systemOverlayStyle,
      // gets rid of the AppBar changing color when scrolling
      // @see https://stackoverflow.com/a/72773421/4241959
      scrolledUnderElevation: 0.0,
    ),
  );
}
