import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/features/search/data/models/category_model.dart';
import 'package:process/features/search/data/models/product_model.dart';
import 'package:process/features/search/data/service/search_service.dart';

final searchServiceProvider = Provider((ref) => SearchService());

final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedCityProvider = StateProvider<String>((ref) => 'almaty');
final selectedCategoriesProvider = StateProvider<List<String>>((ref) => []);

final categoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  final searchService = ref.watch(searchServiceProvider);
  return await searchService.getCategoryProducts();
});

final productsProvider = FutureProvider<Map<String, List<ProductModel>>>((ref) async {
  final searchService = ref.watch(searchServiceProvider);
  final citySlug = ref.watch(selectedCityProvider).toLowerCase();
  final selectedCategories = ref.watch(selectedCategoriesProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  try {
    final categories = await ref.watch(categoriesProvider.future);
    final Map<String, List<ProductModel>> allProducts = {};

    for (final category in categories) {
      if (selectedCategories.isNotEmpty && !selectedCategories.contains(category.name)) {
        continue;
      }

      final products = await searchService.getProductsByCategory(citySlug, category.slug);

      final filteredProducts = products.where((product) {
        return product.name.toLowerCase().contains(searchQuery) || product.slug.toLowerCase().contains(searchQuery);
      }).toList();

      if (filteredProducts.isNotEmpty) {
        allProducts[category.name] = filteredProducts;
      }
    }

    return allProducts;
  } catch (e) {
    throw Exception('Failed to load products: $e');
  }
});