part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddProduct extends CartEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveProduct extends CartEvent {
  final Product product;

  const RemoveProduct(this.product);

  @override
  List<Object?> get props => [product];
}

class IncrementProductQuantity extends CartEvent {
  final Product product;

  const IncrementProductQuantity(this.product);

  @override
  List<Object?> get props => [product];
}

class DecrementProductQuantity extends CartEvent {
  final Product product;

  const DecrementProductQuantity(this.product);

  @override
  List<Object?> get props => [product];
}

class ClearAllProduct extends CartEvent {
  const ClearAllProduct();

  @override
  List<Object?> get props => [];
}
