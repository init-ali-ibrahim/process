import 'package:flutter/material.dart';
import 'package:process/features/profile/presentation/widgets/profile_appbar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const ProfileAppbarWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),
              _buildProfileDataSection(),
              const SizedBox(height: 30),
              _buildSettingsSection(),
              const SizedBox(height: 30),
              _buildSecondSection(),
              const SizedBox(height: 30),

              ///
              // Center(
              //   child: ElevatedButton.icon(
              //     onPressed: () {
              //       // logOut();
              //     },
              //     icon: const Icon(Icons.logout),
              //     label: const Text('Выйти'),
              //     style: ElevatedButton.styleFrom(
              //       foregroundColor: Colors.white,
              //       backgroundColor: Colors.redAccent,
              //       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDataSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CircleAvatar(
                radius: 32,
                backgroundColor: Colors.red[100],
                // child: Text(
                //   'D',
                //   style: TextStyle(color: Colors.red[900], fontSize: 30),
                // ),

                child: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.red[900],
                  size: 36,
                )),
          ),
          const SizedBox(
            width: 4,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Иван Иванов',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'ivan@gmail.com',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
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

          ///
          // _buildSettingsTile(
          //   icon: Icons.location_on_outlined,
          //   title: 'Город',
          //   onTap: () {},
          //   trailing: const Text(
          //     'Алматы',
          //     style: TextStyle(color: Colors.grey, fontSize: 11),
          //   ),
          // ),
          // _buildCustomDivider(),
          // _buildSettingsTile(
          //   icon: Icons.language,
          //   title: 'Язык',
          //   trailing: const Text(
          //     'Русский',
          //     style: TextStyle(color: Colors.grey, fontSize: 11),
          //   ),
          // ),
          // _buildCustomDivider(),
          ///

          _buildSettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Уведомления',
          ),
          _buildCustomDivider(),
          _buildSettingsTile(
            icon: Icons.dark_mode_outlined,
            title: 'Тема',
          ),
          _buildCustomDivider(),
          _buildSettingsTile(
            icon: Icons.home_repair_service_outlined,
            title: 'О приложении',
          ),
          _buildCustomDivider(),
          _buildSettingsTile(
            icon: Icons.support_agent,
            title: 'Поддержка',
          ),
          _buildCustomDivider(),
          _buildSettingsTile(
            icon: Icons.language,
            title: 'Язык',
            trailing: const Text(
              'Русский',
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ),
          _buildCustomDivider(),
          _buildSettingsTile(
            icon: Icons.location_on_outlined,
            title: 'Город',
            onTap: () {},
            trailing: const Text(
              'Алматы',
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            icon: Icons.book_outlined,
            title: 'Заказы',
          ),
          _buildCustomDivider(),
          _buildSettingsTile(
            icon: Icons.insert_page_break_outlined,
            title: 'Публична оферта',
            onTap: () {},
          ),
          _buildCustomDivider(),
          _buildSettingsTile(
            icon: Icons.find_in_page_outlined,
            title: 'Политика конфиденциаальности',
          ),
        ],
      ),
    );
  }

  Widget _buildCustomDivider() {
    return Divider(height: 1, color: Colors.grey.shade300, indent: 18, endIndent: 18);
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      tileColor: Colors.white,
      dense: true,
      leading: Icon(icon, color: Colors.red[300]),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      splashColor: Colors.black,
    );
  }
}
