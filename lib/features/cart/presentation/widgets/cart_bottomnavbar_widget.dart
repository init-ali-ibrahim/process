import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/features/cart/presentation/riverpod/cart_riverpod.dart';
import 'package:process/features/cart/presentation/widgets/cart_bottom_sheet_widget.dart';
import 'package:process/features/profile/presentation/riverpod/profile_riverpod.dart';

class CartBottomnavbarWidget extends ConsumerWidget {
  const CartBottomnavbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartRefRiverpod = ref.watch(cartProvider);
    final profileRefProvider = ref.watch(profileProvider);
    final user = profileRefProvider.user;

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
                  '₸ ${cartRefRiverpod.totalPrice}',
                  key: ValueKey<int>(cartRefRiverpod.totalPrice),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              if (user == null) {
                // showDialog(
                //   context: context,
                //   builder: (context) => const AlertDialog(
                //     title: Text('Ошибка'),
                //     content: Text('Для продолжения необходимо авторизоваться.'),
                //   ),
                // );

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => CartBottomSheetWidget(totalPrice: cartRefRiverpod.totalPrice),
                );
              } else {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => CartBottomSheetWidget(totalPrice: cartRefRiverpod.totalPrice),
                );
              }
            },
            style: TextButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
