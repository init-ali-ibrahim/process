import 'package:flutter/material.dart';
import 'package:process/core/router/routes.dart';
import 'package:process/features/profile/presentation/screens/auth_verification_screen.dart';

class HomeAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbarWidget({
    super.key,
    /*required this.isar*/
  });

  // final Isar isar;

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
            // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(isar: isar)));
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthVerificationScreen()));
          },
        ),
        const SizedBox(width: 4),

      ],
      elevation: 1,
      shadowColor: Colors.grey.shade50,
      // bottom: PreferredSize(
      //   preferredSize: const Size.fromHeight(60),
      //   child: SafeArea(
      //     child: Container(
      //       padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      //       child: Row(
      //         children: [
      //           Expanded(
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 color: const Color(0xFFF8F3F3),
      //                 borderRadius: BorderRadius.circular(4),
      //               ),
      //               child: Row(
      //                 children: [
      //                   IconButton(
      //                     icon: const Icon(
      //                       Icons.search,
      //                       size: 20,
      //                       color: Color(0xFF313131),
      //                     ),
      //                     onPressed: () {
      //                     },
      //                   ),
      //                   Expanded(
      //                     child: TextField(
      //                       onChanged: (query) {
      //                       },
      //                       decoration: const InputDecoration(
      //                         hintText: 'Поиск',
      //                         border: InputBorder.none,
      //                         hintStyle: TextStyle(
      //                           fontSize: 14,
      //                           color: Color(0xFF313131),
      //                           fontWeight: FontWeight.w500,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           const SizedBox(width: 10),
      //           InkWell(
      //             onTap: () async {
      //               await showAppbarCountry(context);
      //             },
      //             highlightColor: Colors.transparent,
      //             splashColor: Colors.transparent,
      //             child: const Row(
      //               children: [
      //                 SizedBox(
      //                   width: 85,
      //                   child: Text(
      //                     'Astana',
      //                     textAlign: TextAlign.end,
      //                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF313131)),
      //                   ),
      //                 ),
      //                 Icon(
      //                   Icons.keyboard_arrow_down,
      //                   color: Color(0xFF313131),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
