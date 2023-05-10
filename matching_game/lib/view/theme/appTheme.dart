import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
    // ignore: deprecated_member_use
    backgroundColor: Colors.white10,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 40, color: Colors.white24),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      primary: const Color.fromARGB(255, 231, 158, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    )));
