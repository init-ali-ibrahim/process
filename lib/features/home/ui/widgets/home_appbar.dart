import 'package:flutter/material.dart';
import 'package:process/core/router/routes.dart';
import 'package:process/core/util/scaffold_messenger.dart';

// class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
//   const HomeAppbar({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       toolbarHeight: kToolbarHeight,
//       backgroundColor: Colors.white,
//       surfaceTintColor: Colors.transparent,
//       title: InkWell(
//         highlightColor: Colors.transparent,
//         splashColor: Colors.transparent,
//         onTap: () {
//           // _launchUrl('https://samalcakes.kz/');
//         },
//         child: Image.asset(
//           'assets/image/logo_appbar.png',
//           width: 130,
//         ),
//       ),
//       actions: <Widget>[
//         IconButton(
//           icon: const Icon(
//             Icons.search,
//             color: Colors.red,
//           ),
//           onPressed: () {
//             router.pushNamed(RouteNames.search.name);
//           },
//         ),
//         IconButton(
//           icon: const Icon(
//             Icons.add,
//             color: Colors.red,
//           ),
//           onPressed: () {
//             showScaffoldMessenger(context: context, textContent: 'dara');
//           },
//         ),
//         IconButton(
//           icon: const Icon(
//             Icons.shopping_cart_outlined,
//             color: Colors.red,
//           ),
//           onPressed: () {
//             router.pushNamed(RouteNames.cart.name);
//           },
//         ),
//         IconButton(
//           icon: const Icon(
//             Icons.person_2_outlined,
//             color: Colors.red,
//           ),
//           onPressed: () {
//             router.pushNamed(RouteNames.profile.name);
//           },
//         ),
//         const SizedBox(width: 4),
//       ],
//       // elevation: 1,
//       // shadowColor: Colors.grey.shade50,
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: kToolbarHeight,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.red,
      title: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          // _launchUrl('https://samalcakes.kz/');
        },
        child: Image.asset(
          'assets/image/logo_appbar.png',
          width: 130,
        ),
      ),
      automaticallyImplyLeading: true,
      floating: true,
      stretch: true,
      flexibleSpace: const FlexibleSpaceBar(
        title: Text('data'),
        centerTitle: false,
        titlePadding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
      ),
      actions: <Widget>[
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
            Icons.add,
            color: Colors.red,
          ),
          onPressed: () {
            showScaffoldMessenger(context: context, textContent: 'dara');
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
      // elevation: 1,
      // shadowColor: Colors.grey.shade50,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
