import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/global/entities/cart_product.dart';
import 'package:process/core/global/service/cart_product_service.dart';

class CartState {
  final List<CartProduct> products;
  final int totalPrice;

  const CartState({
    this.products = const [],
    this.totalPrice = 0,
  });

  CartState copyWith({
    List<CartProduct>? products,
    int? totalPrice,
  }) {
    return CartState(
      products: products ?? this.products,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}

class CartNotifier extends StateNotifier<CartState> {
  final Ref _ref;

  CartNotifier(this._ref) : super(const CartState()) {
    _loadCartProducts();
  }

  Future<void> _loadCartProducts() async {
    final cartService = _ref.read(cartProductServiceProvider);
    final products = await cartService.getAllCartProducts();
    final totalPrice = await cartService.calculateTotalPrice();
    state = state.copyWith(products: products, totalPrice: totalPrice);
  }

  Future<void> updateQuantity(int productId, bool increment) async {
    final cartService = _ref.read(cartProductServiceProvider);
    await cartService.updateQuantity(productId: productId, increment: increment);
    await _loadCartProducts();
  }

  Future<void> addCartProduct(CartProduct cartProduct) async {
    final cartService = _ref.read(cartProductServiceProvider);
    await cartService.addCartProduct(cartProduct);
    await _loadCartProducts();
  }

  Future<void> clearCartProducts() async {
    final cartService = _ref.read(cartProductServiceProvider);
    await cartService.clearCartProducts();
    await _loadCartProducts();
  }

  Future<void> removeProduct(CartProduct product) async {
    final cartService = _ref.read(cartProductServiceProvider);
    await cartService.updateQuantity(productId: product.product_id, increment: false);
    await _loadCartProducts();
  }

  Future<int> calculateTotalPrice() async {
    final cartService = _ref.read(cartProductServiceProvider);
    final totalPrice = await cartService.calculateTotalPrice();
    state = state.copyWith(totalPrice: totalPrice);
    return totalPrice;
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier(ref);
});
