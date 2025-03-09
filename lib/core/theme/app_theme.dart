import 'package:flutter/material.dart';
import 'package:process/core/theme/themes/dark.dart';
import 'package:process/core/theme/themes/light.dart';

class AppTheme {
  static ThemeData lightTheme(String selectedFont) => lightAppTheme(selectedFont);
  static ThemeData darkTheme = darkAppTheme;
}