import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:process/core/router/routes.dart';
import 'package:process/core/util/device.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AdaptiveTheme.of(context).lightTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: DeviceUtil.isIOS ? const BouncingScrollPhysics() : const ClampingScrollPhysics(),
        platform: DeviceUtil.isIOS ? TargetPlatform.iOS : TargetPlatform.android,
      ),
      scaffoldMessengerKey: AppGlobals.scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Da',
    );
  }
}

class AppGlobals {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}
