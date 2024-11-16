import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:process/features/home/presentation/screens/home_screen.dart';
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
import 'package:process/screens/splash_screen.dart';
import 'screens/color.dart';
import 'screens/httpTest.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   BindingBase.debugZoneErrorsAreFatal = false;
//
//   final storage = await HydratedStorage.build(
//     storageDirectory: await getApplicationDocumentsDirectory(),
//   );
//
//   HydratedBlocOverrides.runZoned(
//     () => runApp(const MyApp()),
//     storage: storage,
//   );
//   FlutterError.onError = (details) {};
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // BindingBase.debugZoneErrorsAreFatal = false;
  // final storage = await HydratedStorage.build(
  //   storageDirectory: await getApplicationDocumentsDirectory(),
  // );
  // HydratedBlocOverrides.runZoned(
  //   () => runApp(const MyApp()),
  //   storage: storage,
  // );
  // FlutterError.onError = (details) {};
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ErrorWidget.builder = (FlutterErrorDetails details) {
    //   return const SizedBox(
    //     width: 400,
    //     child: Center(
    //         child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Icon(
    //           Icons.warning_amber_sharp,
    //           color: Colors.red,
    //         ),
    //         Text(
    //           "Произошла ошибка. Пожалуйста попробуйте перезарузить приложение.",
    //           style: TextStyle(color: Colors.black, fontSize: 10),
    //         ),
    //       ],
    //     )),
    //   );
    // };

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CakeCustomizationBloc()),
          BlocProvider(create: (context) => CartBloc()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Samal Cakes',
            theme: ThemeData(
              fontFamily: 'Inter',
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
              useMaterial3: true,
              scaffoldBackgroundColor: bgColor,
              appBarTheme: const AppBarTheme(
                surfaceTintColor: Colors.transparent,
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
              // '/': (context) => const SplashScreen(),
              '/': (context) => const HomeScreen(),
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
