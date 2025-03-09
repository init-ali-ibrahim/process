import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightAppTheme(String selectedFont) {
  return ThemeData(
    primaryColor: Colors.red,
    useMaterial3: true,
    fontFamily: selectedFont,
    textTheme: GoogleFonts.getTextTheme(selectedFont),
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    colorScheme: const ColorScheme.light(
      surface: Colors.white,
      shadow: Colors.grey,
    ),
    dividerColor: Colors.grey.shade200,
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade200,
      thickness: 1,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey.shade50,
    ),

    /// Animation of screen transitions (uses the "animations" package)
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.horizontal,
        ),
        TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.horizontal,
        ),
      },
    ),
  );
}
