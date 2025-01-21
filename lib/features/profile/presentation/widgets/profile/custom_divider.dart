import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double? indent;
  final double? endIndent;

  const CustomDivider({super.key, this.indent = 18, this.endIndent = 18});

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
