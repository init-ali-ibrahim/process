import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:process/core/constants/app_colors.dart';

ThemeData lightAppTheme = ThemeData(
  primaryColor: AppColors.primary,
  useMaterial3: true,
  fontFamily: 'Inter',
  scaffoldBackgroundColor: AppColors.white,
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
  dividerColor: AppColors.greyShade200,
  dividerTheme: const DividerThemeData(
    color: AppColors.greyShade200,
    thickness: 1,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: AppColors.greyShade50,
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