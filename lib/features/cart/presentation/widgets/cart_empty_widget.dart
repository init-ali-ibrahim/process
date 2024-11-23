import 'package:flutter/material.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: const BoxDecoration(
                color: Color(0xFFE7A8A8), shape: BoxShape.circle),
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
              size: 180,
            ),
          ),
          const SizedBox(height: 20),
          const Text('Корзина пуста',
              style:
              TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
                'Попробуйте что нибудь добавить, потом она здесь появится',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
