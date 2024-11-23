import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:process/features/cart/presentation/screens/cart_screen.dart';
import 'package:process/features/home/presentation/widgets/home_bottom_model_widget.dart';
import 'package:process/features/profile/presentation/screens/auth_verification_screen.dart';

class HomeAppbarWidget extends StatelessWidget {
  const HomeAppbarWidget({super.key, required this.isar});

  final Isar isar;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      pinned: true,
      stretchTriggerOffset: 1,
      surfaceTintColor: Colors.transparent,
      title: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          // _launchUrl('https://samalcakes.kz/');
        },
        child: Image.asset(
          'assets/image/logo_appbar.png',
          width: 160,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthVerificationScreen()));
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(isar: isar)));
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F3F3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 20,
                            color: Color(0xFF313131),
                          ),
                          onPressed: () {
                            // Действие при нажатии на иконку поиска
                          },
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (query) {
                              // Функция поиска
                            },
                            decoration: const InputDecoration(
                              hintText: 'Поиск',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF313131),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () async {
                    await showAppbarCountry(context);
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 85,
                        child: Text(
                          'Astana',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF313131)),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFF313131),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
