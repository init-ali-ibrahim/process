import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/service/cart_product_service.dart';
import 'package:process/core/util/logger.dart';

class CartAppbarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const CartAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartService = ref.read(cartProductServiceProvider);

    return AppBar(
      title: const Text('Корзина', style: TextStyle(fontWeight: FontWeight.w500),),
      centerTitle: true,
      surfaceTintColor: Colors.white,
      elevation: 1,
      shadowColor: Colors.grey.shade50,
      toolbarHeight: kToolbarHeight + 10,
      actions: [
        IconButton(
          onPressed: () async {
            try {
              await cartService.clearCartProducts();
            } catch (e) {
              logger.e('e :$e');
            }
          },
          icon: const Icon(Icons.delete_outline),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
