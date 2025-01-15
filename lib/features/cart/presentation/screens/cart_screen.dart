import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/features/cart/presentation/riverpod/cartProvider.dart';
import 'package:process/features/cart/presentation/widgets/cart_appbar_widget.dart';
import 'package:process/features/cart/presentation/widgets/cart_empty_widget.dart';
import 'package:process/features/cart/presentation/widgets/cart_list_tile_widget.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const CartAppbarWidget(),
      body: cartState.products.isEmpty
          ? const CartEmptyWidget()
          : ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: cartState.products.length,
        itemBuilder: (context, index) {
          final product = cartState.products[index];
          return CartListTileWidget(product: product);
        },
      ),
    );
  }
}


// bottomNavigationBar: const CartBottomWidget(),

// bottomNavigationBar: Consumer(
//   builder: (context, ref, child) {
//     final totalPrice = ref.watch(cartProductServiceProvider.select(
//           (service) => service.totalPriceNotifier.value,
//     ));
//     return cartProducts.isEmpty
//         ? null
//         : CartBottomWidget();
//   },
// ),