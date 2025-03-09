import 'package:flutter/material.dart';

class ProfileCustomDividerWidget extends StatelessWidget {
  final double? indent;
  final double? endIndent;

  const ProfileCustomDividerWidget({super.key, this.indent = 18, this.endIndent = 18});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Colors.grey.shade300,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
