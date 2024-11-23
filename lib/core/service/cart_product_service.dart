import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:process/core/entities/cart_product.dart';

class CartProductService {
  final Isar isar;
  final ValueNotifier<int> totalPriceNotifier = ValueNotifier(0);

  CartProductService({
    required this.isar,
  }) {
    _updateTotalPrice();
  }

  Future<List<CartProduct>> getAllCartProducts() async {
    return await isar.cartProducts.where().findAll();
  }

  Future<void> addCartProduct(CartProduct cartProduct) async {
    try {
      await isar.writeTxn(() async {
        await isar.cartProducts.put(cartProduct);
      });
    } catch (e) {
      print("Error in addCartProduct: $e");
    }

    await _updateTotalPrice();
  }

  Future<void> updateQuantity(CartProduct cartProduct, int quantity) async {
    try {
      await isar.writeTxn(() async {
        if (quantity <= 0) {
          await isar.cartProducts.delete(cartProduct.id);
        } else if (quantity > 10) {
          cartProduct.quantity = 10;
          await isar.cartProducts.put(cartProduct);
        } else {
          cartProduct.quantity = quantity;
          await isar.cartProducts.put(cartProduct);
        }
      });
    } catch (e, stackTrace) {
      print("Error in updateQuantity: $e");
      print("Stack trace: $stackTrace");
    }

    await _updateTotalPrice();
  }

  Future<void> deleteCartProduct(int id) async {
    await isar.writeTxn(() async {
      await isar.cartProducts.delete(id);
    });

    await _updateTotalPrice();
  }

  Future clearCartProducts() async {
    final allCartProduct = await getAllCartProducts();
    await isar.writeTxn(() async {
      for (var Cartproduct in allCartProduct) {
        await isar.cartProducts.delete(Cartproduct.id);
      }
    });
  }

  Future<void> _updateTotalPrice() async {
    int totalPrice = (await calculateTotalPrice());
    totalPriceNotifier.value = totalPrice;
  }

  Future<int> calculateTotalPrice() async {
    int totalPrice = 0;

    final allCartProducts = await getAllCartProducts();

    for (var cartProduct in allCartProducts) {
      // totalPrice += cartProduct.price * cartProduct.quantity;
      totalPrice += cartProduct.product_id * cartProduct.quantity;
    }

    return totalPrice;
  }


  Future<void> checkAndNavigateIfNoCartProducts(BuildContext context) async {
    final Cartproducts = await getAllCartProducts();

    if (Cartproducts.isEmpty) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }
}
