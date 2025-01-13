import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:process/core/router/route_guard.dart';
import 'package:process/features/home/presentation/screens/home_screen.dart';

/// Names of route (typo secure)
enum RouteNames {
  singleProduct('/singleProduct'),
  cart('/cart'),
  register('/register'),
  login('/login'),
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
    redirect: (context, state) async {
      // return await guard.someMethod();
      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.home.path,
        name: RouteNames.home.name,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: RouteNames.singleProduct.path,
        name: RouteNames.singleProduct.name,
        builder: (context, state) => Container(),
      ),
      GoRoute(
        path: RouteNames.cart.path,
        name: RouteNames.cart.name,
        builder: (context, state) => Container(),
      ),

      /// Auth routes
      GoRoute(
        path: RouteNames.register.path,
        name: RouteNames.register.name,
        builder: (context, state) => Container(),
      ),

      GoRoute(
        path: RouteNames.login.path,
        name: RouteNames.login.name,
        builder: (context, state) => Container(),
      ),
    ]);
