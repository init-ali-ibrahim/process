import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:process/core/entities/product.dart' as Product;
import 'package:process/core/router/route_guard.dart';
import 'package:process/features/cart/presentation/screens/cart_screen.dart';
import 'package:process/features/detail_product/presentation/screens/detail_product_screen.dart';
import 'package:process/features/home/presentation/screens/home_screen.dart';
import 'package:process/features/profile/presentation/screens/login_screen.dart';
import 'package:process/features/profile/presentation/screens/profile_screen.dart';
import 'package:process/features/profile/presentation/screens/register_screen.dart';
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
final guard = RouteGuard();

final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteNames.home.path,
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      // return await guard.someMethod();
      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.home.path,
        name: RouteNames.home.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
          path: RouteNames.singleProduct.path,
          name: RouteNames.singleProduct.name,
          builder: (context, state) {
            final Map<String, dynamic> extraData = state.extra as Map<String, dynamic>;
            final Product.Product product = extraData['product'];
            return DetailProductScreen(product: product);
          }
      ),
      GoRoute(
        path: RouteNames.cart.path,
        name: RouteNames.cart.name,
        builder: (context, state) => const CartScreen(),
      ),

      GoRoute(
        path: RouteNames.profile.path,
        name: RouteNames.profile.name,
        builder: (context, state) => const ProfileScreen(),
      ),

      GoRoute(
        path: RouteNames.search.path,
        name: RouteNames.search.name,
        builder: (context, state) => const SearchScreen(),
      ),

      /// Auth routes
      GoRoute(
        path: RouteNames.register.path,
        name: RouteNames.register.name,
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        path: RouteNames.login.path,
        name: RouteNames.login.name,
        builder: (context, state) => const LoginScreen(),
      ),
    ]);
