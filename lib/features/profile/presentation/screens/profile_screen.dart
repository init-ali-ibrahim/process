import 'package:flutter/material.dart';
import 'package:process/core/router/routes.dart';
import 'package:process/features/profile/presentation/widgets/profile/profile_appbar_widget.dart';

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
              _buildSecondSection(),
              const SizedBox(height: 14),
              _buildSettingsSection(),
              const SizedBox(height: 30),

              ///
              ElevatedButton(
                onPressed: () {
                  StaticBottomSheet.show(context);
                },
                child: const Text('Показать BottomSheet'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDataSection() {
    // return Container(
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: const BorderRadius.all(
    //       Radius.circular(12),
    //     ),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.1),
    //         blurRadius: 1,
    //         offset: const Offset(0, 1),
    //       ),
    //     ],
    //   ),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.all(10),
    //             child: CircleAvatar(
    //                 radius: 32,
    //                 backgroundColor: Colors.red[100],
    //                 child: Icon(
    //                   Icons.account_circle_outlined,
    //                   color: Colors.red[900],
    //                   size: 36,
    //                 )),
    //           ),
    //           const SizedBox(
    //             width: 4,
    //           ),
    //           const Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text(
    //                 'Иван Иванов',
    //                 style: TextStyle(
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.w400,
    //                 ),
    //               ),
    //               Text(
    //                 'ivan@gmail.com',
    //                 style: TextStyle(
    //                   fontSize: 12,
    //                   color: Colors.black,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(right: 14),
    //         child: IconButton(
    //           onPressed: () {},
    //           icon: const Icon(
    //             Icons.edit_outlined,
    //             size: 22,
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );

    ///

    return InkWell(
      onTap: (){
        router.pushNamed(RouteNames.register.name);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.grey[700],
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
                      'Вы не вошли в аккаунт',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chevron_right,
                  size: 26,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
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

            ///
            _buildSettingsTile(
              icon: Icons.location_on_outlined,
              title: 'Город',
              onTap: () {},
              trailing: const Text(
                'Алматы',
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ),
            _buildCustomDivider(),
            _buildSettingsTile(
                icon: Icons.language,
                title: 'Язык',
                trailing: const Text(
                  'Русский',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
                onTap: () {}),

            ///
            // _buildCustomDivider(),
            // _buildSettingsTile(
            //   icon: Icons.notifications_outlined,
            //   onTap: () {},
            //   title: 'Уведомления',
            // ),
            ///

            _buildCustomDivider(),
            _buildSettingsTile(
              icon: Icons.dark_mode_outlined,
              onTap: () {},
              title: 'Тема',
            ),
            _buildCustomDivider(),
            _buildSettingsTile(
              icon: Icons.home_repair_service_outlined,
              onTap: () {},
              title: 'О приложении',
            ),
            _buildCustomDivider(),
            _buildSettingsTile(
              icon: Icons.support_agent,
              onTap: () {},
              title: 'Поддержка',
            ),
            _buildCustomDivider(),
            _buildSettingsTile(
              icon: Icons.insert_page_break_outlined,
              title: 'Доки',
              onTap: () {},
            ),
            _buildCustomDivider(),
            _buildSettingsTile(
              onTap: () {},
              icon: Icons.find_in_page_outlined,
              title: 'Политика конфиденциаальности',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondSection() {
    return Material(
      clipBehavior: Clip.antiAlias,
      elevation: 1.5,
      shadowColor: Colors.grey.withOpacity(0.3),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            _buildSettingsTile(
              icon: Icons.book_outlined,
              onTap: () {},
              title: 'Заказы',
            ),
            _buildCustomDivider(),
            _buildSettingsTile(
              icon: Icons.history,
              onTap: () {},
              title: 'История',
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCustomDivider({double? indent = 18, double? endIndent = 18}) {
  return Divider(height: 1, color: Colors.grey.shade300, indent: indent, endIndent: endIndent);
}

Widget _buildSettingsTile({
  required IconData icon,
  required String title,
  Widget? trailing,
  VoidCallback? onTap,
  Color? tileColor,
}) {
  return ListTile(
    dense: true,
    tileColor: tileColor,
    leading: Icon(icon, color: Colors.red[300]),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
    ),
    trailing: trailing ??
        const Padding(
          padding: EdgeInsets.all(0),
          child: Icon(Icons.chevron_right, color: Colors.grey),
        ),
    onTap: onTap,
    splashColor: Colors.black,
  );
}

class StaticBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 26,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
              left: 26,
              right: 26,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Язык',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      Icons.language,
                    )
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Меняем язык приложение. Меняем язык приложение. Меняем язык приложение',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 14),
                Material(
                  elevation: 1.5,
                  shadowColor: Colors.grey.withOpacity(0.3),
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
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
                          tileColor: Colors.grey,
                          icon: Icons.language,
                          onTap: () {},
                          title: 'Казакша',
                        ),
                        _buildCustomDivider(endIndent: 0, indent: 0),
                        _buildSettingsTile(
                          tileColor: Colors.grey,
                          icon: Icons.language,
                          onTap: () {},
                          title: 'Русский',
                        ),
                        _buildCustomDivider(endIndent: 0, indent: 0),
                        _buildSettingsTile(
                          tileColor: Colors.grey,
                          icon: Icons.language,
                          onTap: () {},
                          title: 'Английский',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      elevation: 1.5,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      shadowColor: Colors.grey.withOpacity(0.3),
                    ),
                    child: const Text(
                      'Закрыть',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
