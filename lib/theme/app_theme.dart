import 'package:flutter/material.dart';

//for theme main.dart
class AppTheme {
  // --- COLOR CONSTANTS ---
  static const Color oceanDark = Color(0xFF0D47A1);
  static const Color accentOrange = Color(0xFFFF6F00);
  static const Color oceanLight = Color(0xFFE3F2FD);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: oceanDark,
    scaffoldBackgroundColor: Colors.white,

    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: oceanDark,
      secondary: accentOrange,
      surface: oceanLight,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: oceanDark,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentOrange,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: oceanDark, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      prefixIconColor: Colors.blueGrey,
    ),

    /* cardTheme: CardTheme(
      elevation: 4,
      shadowColor: Colors.black54,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    ),*/
  );
}
