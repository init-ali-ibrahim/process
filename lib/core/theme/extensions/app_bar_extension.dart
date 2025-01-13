import 'package:flutter/material.dart';

@immutable
class AppBarExtension extends ThemeExtension<AppBarExtension> {
  final TextStyle? titleTextStyle;

  const AppBarExtension({this.titleTextStyle});

  @override
  AppBarExtension copyWith({TextStyle? titleTextStyle}) {
    return AppBarExtension(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    );
  }

  @override
  AppBarExtension lerp(ThemeExtension<AppBarExtension>? other, double t) {
    if (other is! AppBarExtension) return this;
    return AppBarExtension(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t),
    );
  }
}
