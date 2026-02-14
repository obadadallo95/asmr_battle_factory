// Lines: 60/300
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF8B5CF6); // Electric Purple
  static const Color background = Color(0xFF0F0F0F); // Deep Black
  static const Color surface = Color(0xFF1E1E1E); // Surface
  static const Color error = Color(0xFFCF6679);

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: primary,
        surface: surface,
        error: error,
      ),
      textTheme: GoogleFonts.cairoTextTheme().copyWith(
        displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: Colors.white),
        displayMedium: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.white),
        bodyLarge: TextStyle(fontSize: 16.sp, color: Colors.white70),
        bodyMedium: TextStyle(fontSize: 14.sp, color: Colors.white60),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
