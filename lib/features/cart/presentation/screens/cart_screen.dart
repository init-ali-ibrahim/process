import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/features/cart/presentation/riverpod/cart_riverpod.dart';
import 'package:process/features/cart/presentation/widgets/cart_appbar_widget.dart';
import 'package:process/features/cart/presentation/widgets/cart_bottom_widget.dart';
import 'package:process/features/cart/presentation/widgets/cart_empty_widget.dart';
import 'package:process/features/cart/presentation/widgets/cart_list_tile_widget.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const CartAppbarWidget(),
      body: cartState.products.isEmpty
          ? const CartEmptyWidget()
          : AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: 1.0,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: cartState.products.length,
                itemBuilder: (context, index) {
                  final product = cartState.products[index];
                  return CartListTileWidget(product: product);
                },
              ),
            ),
      bottomNavigationBar: cartState.products.isEmpty ? null : const CartBottomWidget(),
    );
  }
}