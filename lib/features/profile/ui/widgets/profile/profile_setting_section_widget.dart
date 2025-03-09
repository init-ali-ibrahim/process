import 'package:flutter/material.dart';
import 'package:process/features/profile/ui/widgets/profile/profile_bottom_sheet_widget.dart';
import 'package:process/features/profile/ui/widgets/profile/profile_custom_divider_widget.dart';
import 'package:process/features/profile/ui/widgets/profile/profile_tile_widget.dart';

class ProfileSettingsSectionWidget extends StatelessWidget {
  const ProfileSettingsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.5,
      shadowColor: Colors.grey.withValues(alpha: 0.3),
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
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
            ProfileSettingTileWidget(
              icon: Icons.location_on_outlined,
              title: 'Город',
              onTap: () {},
              trailing: const Text(
                'Алматы',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
            const ProfileCustomDividerWidget(),
            ProfileSettingTileWidget(
              icon: Icons.language,
              title: 'Язык',
              onTap: () {},
              trailing: const Text(
                'Русский',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
            const ProfileCustomDividerWidget(),
            ProfileSettingTileWidget(
              icon: Icons.dark_mode_outlined,
              title: 'Тема',
              onTap: () {},
              trailing: const Text(
                'Системное',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
            const ProfileCustomDividerWidget(),
            ProfileSettingTileWidget(
              icon: Icons.text_fields_outlined,
              title: 'Шрифт',
              onTap: () {
                StaticBottomSheet.showFont(context);
              },
              trailing: const Text(
                'По умалчанию',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
