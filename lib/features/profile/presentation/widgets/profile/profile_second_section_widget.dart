import 'package:flutter/material.dart';
import 'package:process/features/profile/presentation/widgets/profile/profile_custom_divider_widget.dart';
import 'package:process/features/profile/presentation/widgets/profile/profile_tile_widget.dart';

class ProfileSecondSectionWidget extends StatelessWidget {
  const ProfileSecondSectionWidget({super.key});

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
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ProfileSettingTileWidget(icon: Icons.book_outlined, title: 'Заказы', onTap: () {}),
            const ProfileCustomDividerWidget(),
            ProfileSettingTileWidget(icon: Icons.history, title: 'История', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
