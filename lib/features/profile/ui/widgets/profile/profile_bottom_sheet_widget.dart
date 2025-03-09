import 'package:flutter/material.dart';
import 'package:process/core/router/routes.dart';
import 'package:process/features/profile/ui/widgets/profile/profile_custom_divider_widget.dart';
import 'package:process/features/profile/ui/widgets/profile/profile_tile_widget.dart';

class StaticBottomSheet {
  static void showLocal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
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
              children: <Widget>[
                const Text(
                  'Язык',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 14),
                ProfileSettingTileWidget(icon: Icons.language, title: 'Казакша', onTap: () {}),
                const ProfileCustomDividerWidget(),
                ProfileSettingTileWidget(icon: Icons.language, title: 'Русский', onTap: () {}),
                const ProfileCustomDividerWidget(),
                ProfileSettingTileWidget(icon: Icons.language, title: 'Английский', onTap: () {}),
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
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
                  children: <Widget>[
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
                  children: <Widget>[
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
                          shadowColor: Colors.grey.withValues(alpha: 0.3),
                        ),
                        child: const Text(
                          'Логин',
                          style: TextStyle(color: Colors.red, fontSize: 16),
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
                          router.pushNamed(RouteNames.register.name);
                        },
                        style: TextButton.styleFrom(
                          elevation: 1.5,
                          backgroundColor: Colors.red,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          shadowColor: Colors.grey.withValues(alpha: 0.3),
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
              const SizedBox(height: 60),
            ],
          ),
        );
      },
    );
  }

  static void showFont(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 360,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 26,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Шрифт приложение',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 14),
                    ProfileSettingTileWidget(title: 'Интер', onTap: () {}),
                    const ProfileCustomDividerWidget(),
                    ProfileSettingTileWidget(title: 'Монтсеррат', onTap: () {}),
                    const ProfileCustomDividerWidget(),
                    ProfileSettingTileWidget(title: 'Опен санс', onTap: () {}),
                    const ProfileCustomDividerWidget(),
                    ProfileSettingTileWidget(title: 'Ариал', onTap: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: const Text(
                    'Закрыть',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
