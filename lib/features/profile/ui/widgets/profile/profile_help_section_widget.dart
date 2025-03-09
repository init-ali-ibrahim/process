import 'package:flutter/material.dart';
import 'package:process/features/profile/ui/widgets/profile/profile_custom_divider_widget.dart';
import 'package:process/features/profile/ui/widgets/profile/profile_tile_widget.dart';

class ProfileHelpSectionWidget extends StatelessWidget {
  const ProfileHelpSectionWidget({super.key});

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
                'Сервис',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
            ProfileSettingTileWidget(
              icon: Icons.home_repair_service_outlined,
              title: 'О приложении',
              onTap: () {},
            ),
            const ProfileCustomDividerWidget(),
            ProfileSettingTileWidget(
              icon: Icons.support_agent,
              title: 'Поддержка',
              onTap: () {},
            ),
            const ProfileCustomDividerWidget(),
            ProfileSettingTileWidget(
              icon: Icons.insert_page_break_outlined,
              title: 'Доки',
              onTap: () {},
            ),
            const ProfileCustomDividerWidget(),
            ProfileSettingTileWidget(
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
