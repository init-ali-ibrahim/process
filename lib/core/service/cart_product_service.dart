import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:process/core/entities/cart_product.dart';
import 'package:process/core/util/isar_get.dart';
import 'package:flutter/foundation.dart';
import 'package:process/core/util/logger.dart';

final cartProductServiceProvider = Provider<CartProductService>((ref) {
  return CartProductService(ref: ref);
});


class CartProductService {
  final Ref _ref;
  final ValueNotifier<int> totalPriceNotifier = ValueNotifier(0);

  CartProductService({required Ref ref}) : _ref = ref;

  Future<Isar> _getIsarInstance() async {
    final isar = await _ref.read(isarProvider.future);
    return isar;
  }

  Future<List<CartProduct>> getAllCartProducts() async {
    try {
      final isar = await _getIsarInstance();
      return await isar.cartProducts.where().findAll();
    } catch (e) {
      logger.e('e: $e');
      return [];
    }
  }

  Future<void> addCartProduct(CartProduct cartProduct) async {
    try {
      final isar = await _getIsarInstance();
      await isar.writeTxn(() async {
        final existingProduct = await isar.cartProducts.where().filter().product_idEqualTo(cartProduct.product_id).findFirst();

        if (existingProduct != null) {
          existingProduct.quantity += cartProduct.quantity;
          existingProduct.quantity = existingProduct.quantity.clamp(1, 10);
          await isar.cartProducts.put(existingProduct);
        } else {
          await isar.cartProducts.put(cartProduct);
        }
      });
      await _updateTotalPrice();
    } catch (e) {
      logger.e("e: $e");
    }
  }

  Future<void> _updateTotalPrice() async {
    final totalPrice = await calculateTotalPrice();
    if (totalPriceNotifier.value != totalPrice) {
      totalPriceNotifier.value = totalPrice;
    }
  }

  Future<void> updateQuantity({
    required int productId,
    required bool increment,
  }) async {
    try {
      final isar = await _getIsarInstance();

      await isar.writeTxn(() async {
        final existingProduct = await isar.cartProducts.where().filter().product_idEqualTo(productId).findFirst();

        if (existingProduct != null) {
          if (increment) {
            existingProduct.quantity = (existingProduct.quantity + 1).clamp(1, 10);
          } else {
            existingProduct.quantity -= 1;
            if (existingProduct.quantity <= 0) {
              await isar.cartProducts.delete(existingProduct.id);
              return;
            }
          }
          await isar.cartProducts.put(existingProduct);
        }
      });
      await _updateTotalPrice();
    } catch (e) {
      logger.e("e: $e");
    }
  }

  Future<void> clearCartProducts() async {
    try {
      final isar = await _getIsarInstance();

      await isar.writeTxn(() async {
        await isar.cartProducts.clear();
      });
      await _updateTotalPrice();
    } catch (e) {
      logger.e("e: $e");
    }
  }

  Future<int> calculateTotalPrice() async {
    try {
      final products = await getAllCartProducts();
      return products.fold<int>(0, (sum, product) => sum + (product.price * product.quantity));
    } catch (e) {
      logger.e("e: $e");
      return 0;
    }
  }
}
