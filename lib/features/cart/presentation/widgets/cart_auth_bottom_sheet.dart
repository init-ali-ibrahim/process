import 'package:flutter/material.dart';
import 'package:process/core/router/routes.dart';

void authShow(BuildContext context) {
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
