import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:process/core/theme/app_theme.dart';

/// Widget from works with AdaptiveTheme (uses the "adaptive_theme" package)
class ThemeShell extends StatelessWidget {
  final Widget child;

  const ThemeShell({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AdaptiveThemeMode?>(
      future: AdaptiveTheme.getThemeMode(),
      builder: (
          BuildContext context,
          AsyncSnapshot<AdaptiveThemeMode?> snapshot,
          ) {
        AdaptiveThemeMode initialTheme =
        snapshot.data != null ? snapshot.data! : AdaptiveThemeMode.system;

        return AdaptiveTheme(
          light: AppTheme.lightTheme,
          dark: AppTheme.darkTheme,
          initial: initialTheme,
          builder: (
              ThemeData lightTheme,
              ThemeData darkTheme,
              ) {
            return child;
          },
        );
      },
    );
  }
}