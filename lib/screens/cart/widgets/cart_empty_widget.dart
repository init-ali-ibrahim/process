import 'package:flutter/material.dart';

Widget CartEmptyWidget(context) {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(color: Color(0xFFE7A8A8), shape: BoxShape.circle),
          child: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 180,
          ),
        ),
        const SizedBox(height: 20),
        const Text('Корзина пуста', style: TextStyle(fontSize: 18)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Попробуйте что нибудь'),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text(
                ' добавить',
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        )
      ],
    ),
  );
}