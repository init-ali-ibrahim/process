import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/app.dart';
import 'package:process/core/dependency/init.dart';
import 'core/dependency/eazy_localization_widget.dart';

void main() async {
  await AppInit.initialize();

  runApp(
    easyLocalizationInitWidget(
      child: const ProviderScope(
        child: App(),
      ),
    ),
  );
}
