import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/entities/cart_product.dart';
import 'package:process/core/service/cart_product_service.dart';
import 'package:process/core/util/isar_get.dart';
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
  late CartProductService cartProductService;
  late Future<List<CartProduct>> cartProductListFuture;
  late List<CartProduct> cartProductList;

  @override
  void initState() {
    super.initState();
    cartProductList = [];
    initCartProductService();
  }

  Future<void> initCartProductService() async {
    cartProductListFuture = cartProductService.getAllCartProducts();
    cartProductList = await cartProductListFuture;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const ChatAppbarWidget(),
      body: cartProductList.isEmpty
          ? const CartEmptyWidget()
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: cartProductList.length,
              itemBuilder: (context, index) {
                final cartProduct = cartProductList[index];
                return CartListTileWidget(
                  product: cartProduct,
                );
              }),
      bottomNavigationBar: cartProductList.isEmpty ? null : const CartBottomWidget(),
    );
  }
}
