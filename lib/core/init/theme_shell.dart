import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/theme/app_theme.dart';
import 'package:process/core/theme/font.dart';

/// Widget from works with AdaptiveTheme (uses the "adaptive_theme" package)
class ThemeShell extends ConsumerWidget {
  final Widget child;

  const ThemeShell({
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String selectedFont = ref.watch(fontProvider);

    return FutureBuilder<AdaptiveThemeMode?>(
      future: AdaptiveTheme.getThemeMode(),
      builder: (
        BuildContext context,
        AsyncSnapshot<AdaptiveThemeMode?> snapshot,
      ) {
        AdaptiveThemeMode initialTheme =
            snapshot.data != null ? snapshot.data! : AdaptiveThemeMode.system;

        return AdaptiveTheme(
          light: AppTheme.lightTheme(selectedFont),
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
