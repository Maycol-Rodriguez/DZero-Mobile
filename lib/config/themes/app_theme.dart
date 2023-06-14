import 'package:dzero/config/themes/colors_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  ThemeData theme() {
    return ThemeData(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      textTheme: const TextTheme(
        titleSmall: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        bodyLarge: TextStyle(
          color: Colors.black, //!
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
      ),
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: const Color(0xff1f2858),
      scaffoldBackgroundColor: colorPrimary,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xff1f2858),
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
    );
  }
}
