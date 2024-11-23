import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:process/core/entities/cart_product.dart';
import 'package:process/features/home/presentation/screens/detail_product_screen.dart';
import 'package:process/features/home/presentation/screens/home_screen.dart';
import 'package:process/screens/Auth/SignUp/sign_up_screen.dart';
import 'package:process/screens/Auth/Login/login_screen.dart';
import 'package:process/screens/cake_create/bloc/cake_customization_bloc.dart';
import 'package:process/screens/cart/bloc/cart_bloc.dart';
import 'package:process/screens/demo_screen.dart';
import 'package:process/screens/profile/profile_edit_screen.dart';
import 'package:process/screens/cake_create/cake_create_screen.dart';
// import 'package:process/screens/cart/auth_verification_screen.dart';
import 'package:process/screens/item_info/item_info_screen.dart';
import 'package:process/screens/map_click/map_click_screen.dart';
import 'package:process/screens/navbar.dart';
import 'package:process/screens/see_all_item/see_all_item_screen.dart';
import 'features/cart/presentation/screens/cart_screen.dart';
import 'screens/httpTest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:process/screens/splash_screen.dart';
import 'screens/color.dart';
import 'package:path_provider/path_provider.dart';

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

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarContrastEnforced: true,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
    [CartProductSchema],
    directory: dir.path,
  );

  runApp(MyApp(isar: isar));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isar});

  final Isar isar;

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
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: SharedAxisPageTransitionsBuilder(transitionType: SharedAxisTransitionType.horizontal, fillColor: Colors.white),
                  TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(transitionType: SharedAxisTransitionType.horizontal, fillColor: Colors.white),
                },
              ),
              fontFamily: 'Inter',
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
              useMaterial3: true,
              scaffoldBackgroundColor: const Color(0xFFF5F5F5),
              appBarTheme: const AppBarTheme(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(
                  color: Color(0xE7D51503),
                ),
                actionsIconTheme: IconThemeData(
                  color: Color(0xE7D51503),
                ),
              ),
            ),
            initialRoute: '/',
            routes: {
              // '/': (context) => const SplashScreen(),
              '/': (context) => HomeScreen(isar: isar),
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
              // '/detail': (context) => const DetailProductScreen(),
              '/see_all_item': (context) => const SeeAllItemScreen(),
              '/signUp': (context) => SignUpScreen(),
              '/logIn': (context) => const LoginScreen(),
              // '/noCart': (context) => const CartScreen(),
              '/demo': (context) => const DemoScreen(),

              // '/cart': (context) => CartScreen()
            }));
  }
}
