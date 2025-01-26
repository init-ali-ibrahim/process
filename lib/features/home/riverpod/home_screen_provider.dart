// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:process/core/entities/product.dart';
//
// class HomeScreenState {
//   final List<Product>? products;
//   final bool isLoading;
//   final String? error;
//
//   const HomeScreenState({
//     this.products,
//     this.isLoading = false,
//     this.error,
//   });
//
//   HomeScreenState copyWith({
//     User? user,
//     bool? isLoading,
//     String? error,
//   }) {
//     return HomeScreenState(
//       user: user ?? this.user,
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//     );
//   }
// }
//
//
// class HomeScreenNotifier extends StateNotifier<HomeScreenState> {
//   HomeScreenNotifier(super.state);
//
// }
//
// final homeScreenProvider = StateNotifierProvider<>(
//       (ref) {
//       return HomeScreenNotifier();
//   },
// );