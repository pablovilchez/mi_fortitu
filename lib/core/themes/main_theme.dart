import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MainTheme {
  static ThemeData get theme {
    return ThemeData(
      // General
      useMaterial3: true,

      // Colors
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // Text
      textTheme: TextTheme(
          titleLarge: GoogleFonts.montserratAlternates()
              .copyWith( fontSize: 40, fontWeight: FontWeight.bold ),
          titleMedium: GoogleFonts.montserratAlternates()
              .copyWith( fontSize: 30, fontWeight: FontWeight.bold ),
          titleSmall: GoogleFonts.montserratAlternates()
              .copyWith( fontSize: 20 )
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.blue),
          textStyle: WidgetStateProperty.all(TextStyle(
            color: Colors.white,
            fontSize: 20,
          )),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          )),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
        ),
      ),
    );
  }
}