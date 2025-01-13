// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:process/screens/cart/cart_screen.dart';
//
// part 'cart_event.dart';
// part 'cart_state.dart';
//
// class CartBloc extends HydratedBloc<CartEvent, CartState> {
//   CartBloc() : super(const CartState({})) {
//
//     on<AddProduct>((event, emit) async {
//       final newCart = Map<Product, int>.from(state.cart);
//       if (newCart.containsKey(event.product)) {
//         newCart[event.product] = newCart[event.product]! + 1;
//       } else {
//         newCart[event.product] = 1;
//       }
//       emit(CartState(newCart));
//     });
//
//     on<RemoveProduct>((event, emit) async {
//       final newCart = Map<Product, int>.from(state.cart);
//       newCart.remove(event.product);
//       emit(CartState(newCart));
//     });
//
//     on<IncrementProductQuantity>((event, emit) async {
//       final newCart = Map<Product, int>.from(state.cart);
//       newCart[event.product] = newCart[event.product]! + 1;
//       emit(CartState(newCart));
//     });
//
//     on<DecrementProductQuantity>((event, emit) async {
//       final newCart = Map<Product, int>.from(state.cart);
//       if (newCart[event.product]! > 1) {
//         newCart[event.product] = newCart[event.product]! - 1;
//       } else {
//         newCart.remove(event.product);
//       }
//       emit(CartState(newCart));
//     });
//
//     on<ClearAllProduct>((event, emit) async {
//       emit(const CartState({}));
//     });
//   }
//
//
//   //
//   @override
//   CartState? fromJson(Map<String, dynamic> json) {
//     try {
//       print('Restoring cart state from JSON');
//       return CartState.fromJson(json);
//     } catch (e) {
//       print('Error restoring cart state: $e');
//       return null;
//     }
//   }
//
//   @override
//   Map<String, dynamic>? toJson(CartState state) {
//     try {
//       print('Saving cart state to JSON');
//       return state.toJson();
//     } catch (e) {
//       print('Error saving cart state: $e');
//       return null;
//     }
//   }
// }
//
