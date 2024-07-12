import 'package:flutter/material.dart';
import 'package:process/cart_info.dart';
import 'package:process/screens/cake_create.dart';
import 'package:process/screens/navbar.dart';
import 'package:process/screens/see_all_item/see_all_item_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Process',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const cart_info(),
          '/see_all_item': (context) => const see_all_item(),
          '/cake_create': (context) => cake_create(),
          // '/': (context) => const navbar(),
        });
  }
}
