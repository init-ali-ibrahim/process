import 'package:flutter/material.dart';
import 'package:process/core/router/routes.dart';

class HomeAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: kToolbarHeight + 10,
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
          icon: const Icon(
            Icons.search,
            color: Colors.red,
          ),
          onPressed: () {
            router.pushNamed(RouteNames.search.name);
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.red,
          ),
          onPressed: () {
            router.pushNamed(RouteNames.cart.name);
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.person_2_outlined,
            color: Colors.red,
          ),
          onPressed: () {
            router.pushNamed(RouteNames.profile.name);
          },
        ),
        const SizedBox(width: 4),

      ],
      elevation: 1,
      shadowColor: Colors.grey.shade50,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
