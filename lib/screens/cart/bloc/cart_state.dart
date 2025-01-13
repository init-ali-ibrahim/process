// part of 'cart_bloc.dart';
//
// class CartState extends Equatable {
//   final Map<Product, int> cart;
//
//   const CartState(this.cart);
//
//   int get totalPrice {
//     return cart.entries.fold(0, (sum, entry) => sum + entry.key.price * entry.value);
//   }
//
//   @override
//   List<Object?> get props => [cart];
//
//   // Преобразование в JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'cart': cart.entries.map((entry) => {
//         'product': entry.key.toJson(),
//         'quantity': entry.value,
//       }).toList(),
//     };
//   }
//
//   // Восстановление из JSON
//   static CartState fromJson(Map<String, dynamic> json) {
//     final cart = Map<Product, int>.fromIterable(
//       json['cart'] as List,
//       key: (item) => Product.fromJson(item['product']),
//       value: (item) => item['quantity'] as int,
//     );
//     return CartState(cart);
//   }
// }
