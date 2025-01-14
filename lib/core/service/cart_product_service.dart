import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:process/core/entities/cart_product.dart';
import 'package:process/core/util/isar_get.dart';
import 'package:process/core/util/logger.dart';

final cartServiceProvider = Provider<CartProductService>((ref) {
  return CartProductService(ref: ref);
});

class CartProductService {
  final Ref _ref;
  final ValueNotifier<int> totalPriceNotifier = ValueNotifier(0);

  CartProductService({required Ref ref}) : _ref = ref;

  Isar get _isar {
    final isar = _ref.read(isarProvider);
    if (isar == null) throw StateError('e');
    return isar;
  }

  Future<List<CartProduct>> getAllCartProducts() async {
    return await _isar.cartProducts.where().findAll();
  }

  Future<void> addCartProduct(CartProduct cartProduct) async {
    try {
      await _isar.writeTxn(() async {
        final existingProduct = await _isar.cartProducts
            .where()
            .filter()
            .product_idEqualTo(cartProduct.product_id)
            .findFirst();

        if (existingProduct != null) {
          existingProduct.quantity += cartProduct.quantity;
          existingProduct.quantity = existingProduct.quantity.clamp(1, 10);
          await _isar.cartProducts.put(existingProduct);
        } else {
          await _isar.cartProducts.put(cartProduct);
        }
      });
      await _updateTotalPrice();
    } catch (e) {
      logger.e("e: $e");
    }
  }

  Future<void> updateQuantity(CartProduct cartProduct, int quantity) async {
    try {
      await _isar.writeTxn(() async {
        final existingProduct = await _isar.cartProducts.get(cartProduct.id);

        if (existingProduct != null) {
          if (quantity <= 0) {
            await _isar.cartProducts.delete(existingProduct.id);
          } else {
            existingProduct.quantity = quantity.clamp(1, 10);
            await _isar.cartProducts.put(existingProduct);
          }
        }
      });
      await _updateTotalPrice();
    } catch (e) {
      logger.e("e: $e");
    }
  }

  Future<void> deleteCartProduct(int id) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.cartProducts.delete(id);
      });
      await _updateTotalPrice();
    } catch (e) {
      logger.e("e: $e");
    }
  }

  Future<void> clearCartProducts() async {
    try {
      final allCartProducts = await getAllCartProducts();
      await _isar.writeTxn(() async {
        for (var cartProduct in allCartProducts) {
          await _isar.cartProducts.delete(cartProduct.id);
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

  Future<int> calculateTotalPrice() async {
    int totalPrice = 0;
    try {
      final allCartProducts = await getAllCartProducts();
      for (var cartProduct in allCartProducts) {
        totalPrice += cartProduct.price * cartProduct.quantity;
      }
    } catch (e) {
      logger.e("e: $e");
    }
    return totalPrice;
  }
}