// import 'package:flutter/material.dart';
// import 'package:animations/animations.dart';
// import 'package:process/screens/cart/cart_screen.dart';
// import 'package:process/screens/connection.dart';
// import 'package:process/screens/profile/profile_screen.dart';
// import 'package:process/screens/home/home_screen.dart';
// import 'package:process/screens/color.dart';
//
// class Navbar extends StatefulWidget {
//   Navbar({required this.initialPageIndex});
//
//   final int initialPageIndex;
//
//   @override
//   _Navbar createState() => _Navbar();
// }
//
// class _Navbar extends State<Navbar> {
//   late int pageIndex;
//
//   final pages = [
//     const HomeScreen(),
//     CartScreen(),
//     const ProfileScreen(),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     pageIndex = widgets.initialPageIndex;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ConnectivityChecker(
//         child: PageTransitionSwitcher(
//           transitionBuilder: (child, primaryAnimation, secondaryAnimation) => SharedAxisTransition(
//             animation: primaryAnimation,
//             secondaryAnimation: secondaryAnimation,
//             transitionType: SharedAxisTransitionType.horizontal,
//             child: child,
//           ),
//           child: pages[pageIndex],
//         ),
//       ),
//       bottomNavigationBar: SafeArea(child: buildNavBar(context)),
//     );
//   }
//
//   Container buildNavBar(BuildContext context) {
//     return Container(
//         decoration: const BoxDecoration(color: Colors.white),
//         height: 60,
//         child: ClipRRect(
//             child: Stack(
//           children: [
//             Column(
//               children: [
//                 Container(
//                   color: Colors.black12,
//                   height: 1,
//                   width: MediaQuery.of(context).size.width,
//                   margin: EdgeInsets.only(bottom: 5),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     CustomTextButton(
//                       pageIndex: pageIndex,
//                       buttonIndex: 0,
//                       label: 'Главная',
//                       selectedIcon: Icons.home,
//                       unselectedIcon: Icons.home_outlined,
//                       primaryColor: colorPrimary,
//                       onPressed: () {
//                         setState(() {
//                           pageIndex = 0;
//                         });
//                       },
//                     ),
//                     CustomTextButton(
//                       pageIndex: pageIndex,
//                       buttonIndex: 1,
//                       label: 'Корзина',
//                       selectedIcon: Icons.shopping_basket,
//                       unselectedIcon: Icons.shopping_basket_outlined,
//                       primaryColor: colorPrimary,
//                       onPressed: () {
//                         setState(() {
//                           pageIndex = 1;
//                         });
//                       },
//                     ),
//                     CustomTextButton(
//                       pageIndex: pageIndex,
//                       buttonIndex: 2,
//                       label: 'Профиль',
//                       selectedIcon: Icons.person,
//                       unselectedIcon: Icons.person_outline,
//                       primaryColor: colorPrimary,
//                       onPressed: () {
//                         setState(() {
//                           pageIndex = 2;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         )));
//   }
// }
//
// class CustomTextButton extends StatelessWidget {
//   final int pageIndex;
//   final int buttonIndex;
//   final String label;
//   final IconData selectedIcon;
//   final IconData unselectedIcon;
//   final Color primaryColor;
//   final VoidCallback onPressed;
//
//   const CustomTextButton({
//     super.key,
//     required this.pageIndex,
//     required this.buttonIndex,
//     required this.label,
//     required this.selectedIcon,
//     required this.unselectedIcon,
//     required this.primaryColor,
//     required this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final isSelected = pageIndex == buttonIndex;
//     final icon = isSelected ? selectedIcon : unselectedIcon;
//     final iconColor = isSelected ? primaryColor : Colors.black54;
//     final textColor = isSelected ? primaryColor : Colors.black54;
//
//     return TextButton(
//       onPressed: onPressed,
//       style: TextButton.styleFrom(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//           // shape: const CircleBorder(),
//           splashFactory: NoSplash.splashFactory,
//           overlayColor: Colors.transparent),
//       child: Column(
//         children: [
//           Icon(
//             icon,
//             color: iconColor,
//             size: 25,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               color: textColor,
//               fontSize: 10,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
