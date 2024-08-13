import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_integrity_flutter/play_integrity_flutter.dart';
import 'package:process/NotificationPage.dart';
import 'package:process/SignUpScreen.dart';
import 'package:process/LogInScreen.dart';
import 'package:process/editProfile_screen.dart';
import 'package:process/profile_screen.dart';
import 'package:process/screens/cake_create.dart';
import 'package:process/screens/cake_template.dart';
// import 'package:process/screens/cart/cart_screen.dart';
import 'package:process/screens/cartTest.dart';
import 'package:process/screens/home/bloc/home_bloc.dart';
import 'package:process/screens/item_info.dart';
import 'package:process/screens/navbar.dart';
import 'package:process/screens/profile/profile_screen.dart';
import 'package:process/screens/see_all_item/see_all_item_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'color.dart';
import 'firebase_options.dart';
import 'screens/httpTest.dart';
import 'screens/testItem.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  // playIntegrity(playIntegrity)
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeBloc()),
          BlocProvider(create: (context) => CakeCustomizationBloc()),
          // BlocProvider(create: (context) => CartBloc()),

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
              '/': (context) => navbar(
                initialPageIndex: 0,
              ),

              '/cart_screen': (context) => navbar(
                initialPageIndex: 1,
              ),

              '/profile': (context) => navbar(
                initialPageIndex: 2,
              ),

              '/my-profile': (context) => const profileEdit(),

              '/httpTest': (context) => const httpTest(),

              '/cake_create': (context) => CakeCustomizationScreen(),
              '/item_info': (context) => const itemInfo(),

              '/cake_template': (context) => DoneCustomizationScreen(),
              '/see_all_item': (context) => const see_all_item(),



              // '/profile': (context) => const profile_screen(),
              // '/profile2': (context) => ProfileScreen2(),
              '/signUp': (context) => SignUpScreen(),
              '/logIn': (context) => const LogInScreen(),


              '/noCart': (context) => ProductListScreen(),

              // '/Testitem': (context) => const Testitem(),

              // '/': (context) => const cart_info_screen(),
              // '/': (context) => ProfileScreen2(),
              // '/NotificationPage': (context) => NotificationPage(),

            }));
  }
}