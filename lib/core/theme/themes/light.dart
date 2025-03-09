import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

ThemeData lightAppTheme = ThemeData(
  primaryColor: Colors.red,
  useMaterial3: true,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: Colors.white,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.black),
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