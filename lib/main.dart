import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/app.dart';
import 'package:process/core/dependency/cart_product_service_init.dart';
import 'package:process/core/dependency/init.dart';
import 'core/dependency/eazy_localization_widget.dart';

void main() async {
  await AppInit.initialize();

  runApp(
    easyLocalizationInitWidget(
      child: ProviderScope(
        child: await cartProductServiceInitWidget(
          child: const App(),
        ),
      ),
    ),
  );
}

//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key, required this.isar});
//
//   final Isar isar;
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (context) => CustomizationBloc()),
//         ],
//         child: MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'Samal Cakes',
//             theme: ThemeData(
//               pageTransitionsTheme: const PageTransitionsTheme(
//                 builders: {
//                   TargetPlatform.android: SharedAxisPageTransitionsBuilder(transitionType: SharedAxisTransitionType.horizontal, fillColor: Colors.white),
//                   TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(transitionType: SharedAxisTransitionType.horizontal, fillColor: Colors.white),
//                 },
//               ),
//               fontFamily: 'Inter',
//               colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
//               useMaterial3: true,
//               scaffoldBackgroundColor: const Color(0xFFF5F5F5),
//               appBarTheme: const AppBarTheme(
//                 surfaceTintColor: Colors.transparent,
//                 backgroundColor: Colors.white,
//                 iconTheme: IconThemeData(
//                   color: Color(0xE7D51503),
//                 ),
//                 actionsIconTheme: IconThemeData(
//                   color: Color(0xE7D51503),
//                 ),
//               ),
//             ),
//             initialRoute: '/',
//             routes: {
//               // '/': (context) => const SplashScreen(),
//               '/': (context) => HomeScreen(isar: isar),
//               '/home': (context) => Navbar(
//                     initialPageIndex: 0,
//                   ),
//               '/cart_screen': (context) => Navbar(
//                     initialPageIndex: 1,
//                   ),
//               '/profile': (context) => Navbar(
//                     initialPageIndex: 2,
//                   ),
//               '/map': (context) => const MapClickScreen(),
//               '/my-profile': (context) => const ProfileEditScreen(),
//               '/httpTest': (context) => const HttpTest(),
//               '/cake_create': (context) => const CakeCustomizationScreen(),
//               '/item_info': (context) => const ItemInfoScreen(),
//               // '/detail': (context) => const DetailProductScreen(),
//               '/see_all_item': (context) => const SeeAllItemScreen(),
//               '/signUp': (context) => SignUpScreen(),
//               '/logIn': (context) => const LoginScreen(),
//               // '/noCart': (context) => const CartScreen(),
//               '/demo': (context) => const DemoScreen(),
//
//               // '/cart': (context) => CartScreen()
//             }));
//   }
// }

// Future<void> main() async {
//
//   runApp(easyLocalizationWidget(const ProviderScope(child: App())));
// }
