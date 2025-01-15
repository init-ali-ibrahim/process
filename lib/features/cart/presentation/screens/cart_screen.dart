import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/entities/cart_product.dart';
import 'package:process/core/service/cart_product_service.dart';
import 'package:process/core/util/isar_get.dart';
import 'package:process/features/cart/presentation/widgets/cart_appbar_widget.dart';
import 'package:process/features/cart/presentation/widgets/cart_empty_widget.dart';
import 'package:process/features/cart/presentation/widgets/cart_list_tile_widget.dart';
import 'package:process/features/cart/presentation/widgets/cart_bottom_widget.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartService = ref.watch(cartProductServiceProvider);
    final isarAsyncValue = ref.watch(isarProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const CartAppbarWidget(),
      body: isarAsyncValue.when(
        data: (_) => FutureBuilder<List<CartProduct>>(
          future: cartService.getAllCartProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('e: ${snapshot.error}'));
            }
            final cartProducts = snapshot.data ?? [];
            if (cartProducts.isEmpty) {
              return const CartEmptyWidget();
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: cartProducts.length,
              itemBuilder: (context, index) {
                final product = cartProducts[index];
                return CartListTileWidget(product: product);
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('у: $e')),
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