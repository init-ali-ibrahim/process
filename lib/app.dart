import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:process/core/router/routes.dart';
import 'package:process/core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(

    /// Theme
    theme: AppTheme.lightTheme,

    /// Localization
    localizationsDelegates: context.localizationDelegates,
    supportedLocales: context.supportedLocales,
    locale: context.locale,

    /// Router
    routerConfig: router,

    /// Other
    debugShowCheckedModeBanner: false,
  );
}