import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 58, 177, 229),
  primary: const Color.fromRGBO(44, 135, 190, 1),
  secondary: const Color.fromRGBO(16, 96, 166, 1.0),
  tertiary: const Color.fromARGB(255, 22, 78, 130),
  
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

final lightThemeData = ThemeData().copyWith(
    useMaterial3: true,
    colorScheme: kColorScheme,
    inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 12, color: Colors.black26)),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      titleSmall: GoogleFonts.inter(
          fontSize: 22, color: Colors.black, fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.inter(
          fontWeight: FontWeight.w500, fontSize: 26, color: Colors.black),
      titleLarge: GoogleFonts.inter(
          fontWeight: FontWeight.w900, fontSize: 30, color: Colors.black),
      bodyMedium: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          color: const Color.fromARGB(122, 0, 0, 0),
          fontSize: 14),
      bodyLarge:
          GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.black26),
    ));

final darkThemeData =
    ThemeData().copyWith(useMaterial3: true, colorScheme: kDarkColorScheme);
