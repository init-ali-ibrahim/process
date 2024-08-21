import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:process/screens/cart/cart_screen.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState({})) {
    on<AddProduct>((event, emit) {
      final newCart = Map<Product, int>.from(state.cart);
      if (newCart.containsKey(event.product)) {
        newCart[event.product] = newCart[event.product]! + 1;
      } else {
        newCart[event.product] = 1;
      }
      emit(CartState(newCart));
    });

    on<RemoveProduct>((event, emit) {
      final newCart = Map<Product, int>.from(state.cart);
      newCart.remove(event.product);
      emit(CartState(newCart));
    });

    on<IncrementProductQuantity>((event, emit) {
      final newCart = Map<Product, int>.from(state.cart);
      newCart[event.product] = newCart[event.product]! + 1;
      emit(CartState(newCart));
    });

    on<DecrementProductQuantity>((event, emit) {
      final newCart = Map<Product, int>.from(state.cart);
      if (newCart[event.product]! > 1) {
        newCart[event.product] = newCart[event.product]! - 1;
      } else {
        newCart.remove(event.product);
      }
      emit(CartState(newCart));
    });

    on<ClearAllProduct>((event, emit) {
      emit(const CartState({}));
    });
  }
}