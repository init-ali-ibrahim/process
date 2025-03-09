import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/app.dart';
import 'package:process/core/init/init.dart';
import 'package:process/core/init/localization_shell.dart';
import 'package:process/core/init/theme_shell.dart';

void main() async {
  await AppInit.initialize();

  runApp(
    const ProviderScope(
      child: ThemeShell(
        child: LocalizationShell(
          child: App(),
        ),
      ),
    ),
  );
}
