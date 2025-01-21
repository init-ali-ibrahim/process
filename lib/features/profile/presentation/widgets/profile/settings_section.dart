import 'package:flutter/material.dart';
import 'package:process/features/profile/presentation/widgets/profile/custom_divider.dart';
import 'package:process/features/profile/presentation/widgets/profile/settings_tile.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.5,
      shadowColor: Colors.grey.withOpacity(0.3),
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 10, top: 16),
              child: Text(
                'Настройки',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            SettingsTile(
              icon: Icons.location_on_outlined,
              title: 'Город',
              onTap: () {},
              trailing: const Text(
                'Алматы',
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ),
            const CustomDivider(),
            SettingsTile(
              icon: Icons.language,
              title: 'Язык',
              trailing: const Text(
                'Русский',
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              onTap: () {},
            ),
            const CustomDivider(),
            SettingsTile(
              icon: Icons.dark_mode_outlined,
              title: 'Тема',
              onTap: () {},
            ),
            const CustomDivider(),
            SettingsTile(
              icon: Icons.home_repair_service_outlined,
              title: 'О приложении',
              onTap: () {},
            ),
            const CustomDivider(),
            SettingsTile(
              icon: Icons.support_agent,
              title: 'Поддержка',
              onTap: () {},
            ),
            const CustomDivider(),
            SettingsTile(
              icon: Icons.insert_page_break_outlined,
              title: 'Доки',
              onTap: () {},
            ),
            const CustomDivider(),
            SettingsTile(
              icon: Icons.find_in_page_outlined,
              title: 'Политика конфиденциальности',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
