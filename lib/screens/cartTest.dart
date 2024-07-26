// // Cart Event
// import 'package:equatable/equatable.dart';
// import 'package:process/screens/cake_create.dart';
//
// abstract class CartEvent extends Equatable {
//   const CartEvent();
//
//   @override
//   List<Object> get props => [];
// }
//
// class CakeAddedToCart extends CartEvent {
//   final CakeCustomizationState cake;
//
//   const CakeAddedToCart(this.cake);
//
//   @override
//   List<Object> get props => [cake];
// }
//
// // Cart State
// class CartState extends Equatable {
//   final List<CakeCustomizationState> cakes;
//
//   const CartState({this.cakes = const []});
//
//   CartState copyWith({List<CakeCustomizationState>? cakes}) {
//     return CartState(
//       cakes: cakes ?? this.cakes,
//     );
//   }
//
//   @override
//   List<Object> get props => [cakes];
// }
