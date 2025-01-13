import 'package:flutter/material.dart';

@immutable
class ChatContainerExtension extends ThemeExtension<ChatContainerExtension> {
  final Color? backgroundColor;

  ChatContainerExtension({required this.backgroundColor});

  @override
  ChatContainerExtension copyWith({Color? backgroundColor}) {
    return ChatContainerExtension(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  ChatContainerExtension lerp(
      ThemeExtension<ChatContainerExtension> other, double t) {
    if (other is! ChatContainerExtension) return this;
    return ChatContainerExtension(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
    );
  }
}
