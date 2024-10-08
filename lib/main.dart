import 'dart:developer';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:process/screens/onboarding_screen.dart';

import 'package:flutter/material.dart';
import 'package:process/screens/Auth/SignUp/sign_up_screen.dart';
import 'package:process/screens/Auth/Login/login_screen.dart';
import 'package:process/screens/cake_create/bloc/cake_customization_bloc.dart';
import 'package:process/screens/cart/bloc/cart_bloc.dart';
import 'package:process/screens/demo_screen.dart';
import 'package:process/screens/profile/profile_edit_screen.dart';
import 'package:process/screens/cake_create/cake_create_screen.dart';
import 'package:process/screens/cart/cart_screen.dart';
import 'package:process/screens/item_info/item_info_screen.dart';
import 'package:process/screens/map_click/map_click_screen.dart';
import 'package:process/screens/navbar.dart';
import 'package:process/screens/see_all_item/see_all_item_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:process/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/color.dart';
import 'firebase_options.dart';
import 'screens/httpTest.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
  FlutterError.onError = (details) {
  };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Container(
        width: 400,
        child: const Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_sharp,
              color: Colors.red,
            ),
            Text(
              "Произошла ошибка. Пожалуйста попробуйте перезарузить приложение.",
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
          ],
        )),
      );
    };

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
                displayLarge: Theme.of(context).textTheme.displayLarge?.copyWith(letterSpacing: -0.1),
                displayMedium: Theme.of(context).textTheme.displayMedium?.copyWith(letterSpacing: -0.1),
                displaySmall: Theme.of(context).textTheme.displaySmall?.copyWith(letterSpacing: -0.1),
                headlineLarge: Theme.of(context).textTheme.headlineLarge?.copyWith(letterSpacing: -0.1),
                headlineMedium: Theme.of(context).textTheme.headlineMedium?.copyWith(letterSpacing: -0.1),
                headlineSmall: Theme.of(context).textTheme.headlineSmall?.copyWith(letterSpacing: -0.1),
                titleLarge: Theme.of(context).textTheme.titleLarge?.copyWith(letterSpacing: -0.1),
                titleMedium: Theme.of(context).textTheme.titleMedium?.copyWith(letterSpacing: -0.1),
                titleSmall: Theme.of(context).textTheme.titleSmall?.copyWith(letterSpacing: -0.1),
                bodyLarge: Theme.of(context).textTheme.bodyLarge?.copyWith(letterSpacing: -0.1),
                bodyMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(letterSpacing: -0.1),
                bodySmall: Theme.of(context).textTheme.bodySmall?.copyWith(letterSpacing: -0.1),
                labelLarge: Theme.of(context).textTheme.labelLarge?.copyWith(letterSpacing: -0.1),
                labelMedium: Theme.of(context).textTheme.labelMedium?.copyWith(letterSpacing: -0.1),
                labelSmall: Theme.of(context).textTheme.labelSmall?.copyWith(letterSpacing: -0.1),
              ),
              fontFamily: 'OpenSans',
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
              useMaterial3: true,
              scaffoldBackgroundColor: bgColor,
              appBarTheme: const AppBarTheme(
                // surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(
                  color: colorPrimary,
                ),
                actionsIconTheme: IconThemeData(
                  color: colorPrimary,
                ),
              ),
            ),
            initialRoute: '/',
            // home: const DemoScreen(),
            routes: {
              '/': (context) => SplashScreen(),
              '/home': (context) => Navbar(
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
              '/httpTest': (context) => const HttpTest(),
              '/cake_create': (context) => const CakeCustomizationScreen(),
              '/item_info': (context) => const ItemInfoScreen(),
              '/see_all_item': (context) => const SeeAllItemScreen(),
              '/signUp': (context) => SignUpScreen(),
              '/logIn': (context) => const LoginScreen(),
              '/noCart': (context) => const CartScreen(),
              '/demo': (context) => const DemoScreen(),
            }));
  }
}

// '/': (context) {
//   if (onboardingCompleted == false) {
//     return Navbar(initialPageIndex: 0);
//   } else {
//     return const OnboardingPage();
//   }
// },

// '/': (context) => onboardingCompleted
//     ? Navbar(
//         initialPageIndex: 0,
//       )
//     : Navbar(
//         initialPageIndex: 0,
//       ),
