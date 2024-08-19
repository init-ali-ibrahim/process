import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:process/screens/Auth/SignUp/sign_up_screen.dart';
import 'package:process/screens/Auth/Login/login_screen.dart';
import 'package:process/screens/profile/profile_edit_screen.dart';
import 'package:process/screens/cake_create/cake_create_screen.dart';
import 'package:process/screens/cart/cart_screen.dart';
import 'package:process/screens/item_info/item_info_screeen.dart';
import 'package:process/screens/map_click/map_click_screen.dart';
import 'package:process/screens/navbar.dart';
import 'package:process/screens/see_all_item/see_all_item_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/color.dart';
import 'firebase_options.dart';
import 'screens/httpTest.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CakeCustomizationBloc()),
          BlocProvider(create: (context) => CartBloc()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Process',
            theme: ThemeData(
              textTheme: TextTheme(
                displayLarge: Theme.of(context).textTheme.displayLarge?.copyWith(letterSpacing: -0.2),
                displayMedium: Theme.of(context).textTheme.displayMedium?.copyWith(letterSpacing: -0.2),
                displaySmall: Theme.of(context).textTheme.displaySmall?.copyWith(letterSpacing: -0.2),
                headlineLarge: Theme.of(context).textTheme.headlineLarge?.copyWith(letterSpacing: -0.2),
                headlineMedium: Theme.of(context).textTheme.headlineMedium?.copyWith(letterSpacing: -0.2),
                headlineSmall: Theme.of(context).textTheme.headlineSmall?.copyWith(letterSpacing: -0.2),
                titleLarge: Theme.of(context).textTheme.titleLarge?.copyWith(letterSpacing: -0.2),
                titleMedium: Theme.of(context).textTheme.titleMedium?.copyWith(letterSpacing: -0.2),
                titleSmall: Theme.of(context).textTheme.titleSmall?.copyWith(letterSpacing: -0.2),
                bodyLarge: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: -0.2),
                bodyMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(letterSpacing: -0.2),
                bodySmall: Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: -0.2),
                labelLarge: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: -0.2),
                labelMedium: Theme.of(context).textTheme.labelMedium?.copyWith(letterSpacing: -0.2),
                labelSmall: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: -0.2),
              ),
              fontFamily: 'OpenSans',
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(
                  color: colorPrimary,
                ),
                actionsIconTheme: IconThemeData(
                  color: colorPrimary,
                ),
              ),
            ),
            routes: {
              '/': (context) => Navbar(
                initialPageIndex: 0,
              ),
              '/cart_screen': (context) => Navbar(
                initialPageIndex: 1,
              ),
              '/profile': (context) => Navbar(
                initialPageIndex: 2,
              ),

              '/map': (context) => const MapClickScreen(),
              '/my-profile': (context) => const ProfileEditScreen(),
              '/httpTest': (context) => const httpTest(),
              '/cake_create': (context) => CakeCustomizationScreen(),
              '/item_info': (context) => const ItemInfoScreen(),
              '/see_all_item': (context) => const SeeAllItemScreen(),
              '/signUp': (context) => SignUpScreen(),
              '/logIn': (context) => const LoginScreen(),
              '/noCart': (context) => CartScreen(),
            }));
  }
}