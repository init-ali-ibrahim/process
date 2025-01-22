import 'package:flutter/material.dart';
import 'package:process/core/router/routes.dart';
import 'package:process/features/profile/presentation/widgets/profile/profile_custom_divider.dart';
import 'package:process/features/profile/presentation/widgets/profile/settings_tile.dart';

class StaticBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 300,
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
              children: [
                const Text(
                  'Язык',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 14),
                SettingsTile(icon: Icons.language, title: 'Казакша', onTap: () {}),
                const ProfileCustomDivider(),
                SettingsTile(icon: Icons.language, title: 'Русский', onTap: () {}),
                const ProfileCustomDivider(),
                SettingsTile(icon: Icons.language, title: 'Английский', onTap: () {}),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Закрыть'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void authShow(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                // Bottom sheet handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Войдите в профиль',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Center(
                        child: Text(
                          'Чтобы заказать торты, пироги, чизкейки',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            router.pushNamed(RouteNames.login.name);
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
                            'Логин',
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: TextButton(
                          onPressed: () async {
                            Navigator.pop(context);

                            // try {
                            //   await ref.read(profileProvider.notifier).logout();
                            //   ref.refresh(profileProvider);
                            // } catch (e) {
                            //   logger.e('e: $e');
                            // }
                            router.pushNamed(RouteNames.register.name);
                          },
                          style: TextButton.styleFrom(
                            elevation: 1.5,
                            backgroundColor: Colors.green,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            shadowColor: Colors.grey.withOpacity(0.3),
                          ),
                          child: const Text(
                            'Регистрация',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60)
              ],
            ),
          );
        });
  }
}

Widget _buildChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.blue[50],
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.blue[700],
        fontSize: 14,
      ),
    ),
  );
}
