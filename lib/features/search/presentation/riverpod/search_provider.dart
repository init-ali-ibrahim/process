import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/entities/product.dart';
import 'package:process/features/search/data/repo/search_repo.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedCityProvider = StateProvider<String>((ref) => 'almaty');
final selectedCategoriesProvider = StateProvider<List<String>>((ref) => []);

final searchResultsProvider = FutureProvider<Map<String, List<Product>>>((ref) async {
  final SearchRepo repo = SearchRepo();
  final citySlug = ref.watch(selectedCityProvider).toLowerCase();
  final query = ref.watch(searchQueryProvider).toLowerCase();
  final selectedCategories = ref.watch(selectedCategoriesProvider);

  final allProducts = await repo.getAllProducts(citySlug);

  if (query.isEmpty && selectedCategories.isEmpty) {
    return allProducts;
  }

  final filteredProducts = <String, List<Product>>{};

  allProducts.forEach((category, products) {
    if (selectedCategories.isNotEmpty && !selectedCategories.contains(category)) {
      return;
    }

    final matchingProducts = products.where((product) {
      final nameMatch = product.name.toLowerCase().contains(query);
      final descriptionMatch = product.slug.toLowerCase().contains(query);
      return nameMatch || descriptionMatch;
    }).toList();

    if (matchingProducts.isNotEmpty) {
      filteredProducts[category] = matchingProducts;
    }
  });

  return filteredProducts;
});
