import 'package:flutter/material.dart';

@immutable
class ChatBgExtension extends ThemeExtension<ChatBgExtension> {
  final Color? backgroundColor;

  ChatBgExtension({required this.backgroundColor});

  @override
  ChatBgExtension copyWith({Color? backgroundColor}) {
    return ChatBgExtension(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  ChatBgExtension lerp(ThemeExtension<ChatBgExtension> other, double t) {
    if (other is! ChatBgExtension) return this;
    return ChatBgExtension(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
    );
  }
}
