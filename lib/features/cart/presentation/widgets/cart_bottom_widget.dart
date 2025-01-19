import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/features/cart/presentation/riverpod/cart_riverpod.dart';

class CartBottomWidget extends ConsumerWidget {
  const CartBottomWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartRiverpod = ref.watch(cartProvider);

    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            width: 1,
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Итоговая цена'),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                child: Text(
                  '₸ ${cartRiverpod.totalPrice}',
                  key: ValueKey<int>(cartRiverpod.totalPrice),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'Продолжить',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
