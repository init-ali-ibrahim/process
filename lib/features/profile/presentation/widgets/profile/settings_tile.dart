import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? tileColor;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.tileColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      tileColor: tileColor,
      leading: Icon(icon, color: Colors.red[300]),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
      ),
      trailing: trailing ??
          const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      splashColor: Colors.black,
    );
  }
}
