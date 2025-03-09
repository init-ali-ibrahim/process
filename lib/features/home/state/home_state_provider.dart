import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/global/entities/product.dart';
import 'package:process/features/home/data/models/product_model.dart';
import 'package:process/features/home/data/service/home_service.dart';

class HomeState {
  final Map<String, List<Product>> products;
  final bool isLoading;
  final String? error;

  HomeState({
    this.products = const <String, List<Product>>{},
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    Map<String, List<Product>>? products,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeService _homeService;

  HomeNotifier(this._homeService) : super(HomeState());

  Future<void> fetchProducts() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      Map<String, List<ProductModel>> products =
          await _homeService.getAllProducts('almaty') ?? <String, List<ProductModel>>{};
      state = state.copyWith(products: products, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final StateNotifierProvider<HomeNotifier, HomeState> homeStateProvider =
    StateNotifierProvider<HomeNotifier, HomeState>(
  (Ref ref) => HomeNotifier(HomeService())..fetchProducts(),
);
