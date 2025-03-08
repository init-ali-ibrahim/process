import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationShell extends StatelessWidget {
  final Widget child;

  const LocalizationShell({
    super.key,
    required this.child,
  });

  static const List<Locale> _supportedLocales = <Locale>[
    Locale('kk'),
    Locale('ru'),
    Locale('en'),
  ];
  static const String _path = 'assets/locals';
  static const Locale _fallbackLocale = Locale('ru');

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: _supportedLocales,
      fallbackLocale: _fallbackLocale,
      path: _path,
      child: child,
    );
  }
}