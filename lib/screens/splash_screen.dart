// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:process/screens/cart/cart_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(microseconds: 1), () {
//       Navigator.of(context).pushReplacementNamed('/home');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//             const CartScreen(),
//             Container(
//               decoration: const BoxDecoration(color: Colors.white),
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//             )
//           ],
//         ));
//   }
// }
