import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/app.dart';
import 'package:process/core/init/init.dart';
import 'package:process/core/init/localization_shell.dart';
import 'package:process/core/init/theme_shell.dart';
import 'core/dependency/eazy_localization_widget.dart';

void main() async {
  await AppInit.initialize();

  runApp(
    const LocalizationShell(
      child: ThemeShell(
        child: ProviderScope(
          child: App(),
        ),
      ),
    ),
  );
}
