part of 'cart_bloc.dart';

class CartState extends Equatable {
  final Map<Product, int> cart;

  const CartState(this.cart);

  int get totalPrice {
    return cart.entries.fold(0, (sum, entry) => sum + entry.key.price * entry.value);
  }

  @override
  List<Object?> get props => [cart];
}
