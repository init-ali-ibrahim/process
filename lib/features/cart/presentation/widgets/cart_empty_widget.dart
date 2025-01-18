import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CartEmptyWidget extends StatefulWidget {
  const CartEmptyWidget({super.key});

  @override
  State<CartEmptyWidget> createState() => _CartEmptyWidgetState();
}

class _CartEmptyWidgetState extends State<CartEmptyWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/anima/cartEmpty.json',
            controller: _controller,
            onLoaded: (composition) {
              _controller.duration = composition.duration;

              _controller.forward();
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Корзина пуста',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: Text(
              'Попробуйте что нибудь добавить, потом она здесь появится',
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
