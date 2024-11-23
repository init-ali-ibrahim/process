import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:process/core/entities/cart_product.dart';
import 'package:process/core/service/cart_product_service.dart';
import 'package:process/features/cart/presentation/widgets/cart_bottom_widget.dart';
import 'package:process/features/cart/presentation/widgets/cart_empty_widget.dart';
import 'package:process/features/cart/presentation/widgets/cart_list_tile_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.isar});

  final Isar isar;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with WidgetsBindingObserver {
  late CartProductService cartProductService;
  late Future<List<CartProduct>> cartProductListFuture;
  late List<CartProduct> cartProductList;

  @override
  void initState() {
    super.initState();
    cartProductList = [];
    cartProductService = CartProductService(isar: widget.isar);
    cartProductListFuture = cartProductService.getAllCartProducts();
    initCartProduct();
  }

  initCartProduct() async {
    cartProductList = await cartProductListFuture;
    setState(() {
      cartProductList = cartProductList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        centerTitle: true,
      ),
      body: cartProductList.isEmpty
          ? const CartEmptyWidget()
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: cartProductList.length,
              itemBuilder: (context, index) {
                final cartProduct = cartProductList[index];
                return const CartListTileWidget();
              }),
      bottomNavigationBar: const CartBottomWidget(),
    );
  }
}
