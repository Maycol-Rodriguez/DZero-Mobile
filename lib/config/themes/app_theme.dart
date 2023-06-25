import 'package:dzero/config/config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: const Color(0xff1f2858),
      scaffoldBackgroundColor: colorPrimary,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: colorTerceary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        iconSize: 30,
        sizeConstraints: BoxConstraints.tightFor(
          width: 50,
          height: 50,
        ),
      ),
      textTheme: TextTheme(
        titleSmall: GoogleFonts.montserratAlternates(color: Colors.white),
        titleMedium: GoogleFonts.montserratAlternates(fontSize: 16),
        titleLarge: GoogleFonts.montserratAlternates(fontSize: 35, color: Colors.white),
        bodySmall: GoogleFonts.montserratAlternates(fontSize: 15),
        bodyMedium: GoogleFonts.montserratAlternates(fontSize: 20),
        bodyLarge: GoogleFonts.montserratAlternates(fontSize: 16),
        labelLarge: GoogleFonts.montserratAlternates(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorTerceary,
          elevation: 0,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.montserratAlternates(fontSize: 16),
          minimumSize: const Size(200, 50),
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xff1f2858),
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.montserratAlternates(fontSize: 25, color: Colors.white),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: colorPrimary,
        selectedItemColor: colorTerceary,
        unselectedItemColor: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 30,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.transparent,
      ),
    );
  }
}
