import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:process/NotificationPage.dart';
import 'package:process/SignUpScreen.dart';
import 'package:process/LogInScreen.dart';
import 'package:process/profile_screen.dart';
import 'package:process/screens/cake_create.dart';
import 'package:process/screens/home/bloc/home_bloc.dart';
import 'package:process/screens/navbar.dart';
import 'package:process/screens/profile/profile_screen.dart';
import 'package:process/screens/see_all_item/see_all_item_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.debug,
  //   webRecaptchaSiteKey: 'your-recaptcha-site-key',
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final colorPrimary = Color(0xFF953282);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeBloc()),
          BlocProvider(create: (context) => CakeCustomizationBloc()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Process',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
              useMaterial3: true,
              appBarTheme: AppBarTheme(
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

              // '/': (context) => const cart_info_screen(),
              '/see_all_item': (context) => const see_all_item(),
              '/cake_create': (context) => cake_create(),

              // '/': (context) => ProfileScreen2(),

              '/profile': (context) => const profile_screen(),

              '/profile2': (context) => ProfileScreen2(),

              '/signUp': (context) => SignUpScreen(),
              '/logIn': (context) => const LogInScreen(),
              // '/NotificationPage': (context) => NotificationPage()
            }));
  }
}
