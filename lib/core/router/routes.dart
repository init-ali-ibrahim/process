import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:process/core/global/entities/product.dart';
import 'package:process/features/cart/presentation/screens/cart_screen.dart';
import 'package:process/features/detail_product/ui/screens/detail_product_screen.dart';
import 'package:process/features/home/ui/screens/home_screen.dart';
import 'package:process/features/profile/ui/screens/login_screen.dart';
import 'package:process/features/profile/ui/screens/profile_screen.dart';
import 'package:process/features/profile/ui/screens/register_screen.dart';
import 'package:process/features/search/presentation/screens/search_screen.dart';

/// Names of route (typo secure)
enum RouteNames {
  singleProduct('/singleProduct'),
  cart('/cart'),
  register('/register'),
  login('/login'),
  profile('/profile'),
  search('/search'),
  home('/home');

  final String path;

  const RouteNames(this.path);
}

/// Routing logic for the app (using go_router package)
/// Routes on screens only
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteNames.home.path,
    // debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: RouteNames.home.path,
        name: RouteNames.home.name,
        builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
      ),
      GoRoute(
          path: RouteNames.singleProduct.path,
          name: RouteNames.singleProduct.name,
          builder: (BuildContext context, GoRouterState state) {
            Map<String, dynamic> extraData = state.extra as Map<String, dynamic>;
            Product product = extraData['product'];
            return DetailProductScreen(product: product);
          },
      ),
      GoRoute(
        path: RouteNames.cart.path,
        name: RouteNames.cart.name,
        builder: (BuildContext context, GoRouterState state) => const CartScreen(),
      ),

      GoRoute(
        path: RouteNames.profile.path,
        name: RouteNames.profile.name,
        builder: (BuildContext context, GoRouterState state) => const ProfileScreen(),
      ),

      GoRoute(
        path: RouteNames.search.path,
        name: RouteNames.search.name,
        builder: (BuildContext context, GoRouterState state) => const SearchScreen(),
      ),

      /// Auth routes
      GoRoute(
        path: RouteNames.register.path,
        name: RouteNames.register.name,
        builder: (BuildContext context, GoRouterState state) => const RegisterScreen(),
      ),

      GoRoute(
        path: RouteNames.login.path,
        name: RouteNames.login.name,
        builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
      ),
    ],);
