import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Category {
  final String name;
  final String slug;

  Category({required this.name, required this.slug});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}

class Product {
  final String name;
  final String slug;
  final double price;

  Product({
    required this.name,
    required this.slug,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}

class SearchService {
  final Dio dio;
  final int maxRetries;

  SearchService({int? maxRetries})
      : this.dio = Dio()..interceptors.add(RetryInterceptor()),
        this.maxRetries = maxRetries ?? 3;

  Future<List<Category>> getCategoryProducts() async {
    try {
      final response = await dio.get(
        'https://admin.samalcakes.kz/api/v1/categories',
        options: Options(
          headers: {'Accept': 'application/json'},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 429) {
        final retryAfter = int.tryParse(response.headers.value('retry-after') ?? '5') ?? 5;

        await Future.delayed(Duration(seconds: retryAfter));
        return getCategoryProducts();
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data;
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load categories: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        await Future.delayed(const Duration(seconds: 5));
        return getCategoryProducts();
      }
      throw Exception('Failed to load categories: ${e.message}');
    }
  }

  Future<List<Product>> getProductsByCategory(String citySlug, String category) async {
    try {
      final response = await dio.get(
        'https://admin.samalcakes.kz/api/v1/catalog/products',
        queryParameters: {'category': category},
        options: Options(
          headers: {'City': citySlug, 'Accept': 'application/json'},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 429) {
        final retryAfter = int.tryParse(response.headers.value('retry-after') ?? '5') ?? 5;
        await Future.delayed(Duration(seconds: retryAfter));
        return getProductsByCategory(citySlug, category);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load products: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        await Future.delayed(const Duration(seconds: 5));
        return getProductsByCategory(citySlug, category);
      }
      throw Exception('Failed to load products: ${e.message}');
    }
  }
}

class RetryInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 429) {
      final retryAfter = int.tryParse(err.response?.headers.value('retry-after') ?? '5') ?? 5;

      await Future.delayed(Duration(seconds: retryAfter));

      try {
        final opts = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        );

        final response = await Dio().request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}

final searchServiceProvider = Provider((ref) => SearchService());

final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedCityProvider = StateProvider<String>((ref) => 'almaty');
final selectedCategoriesProvider = StateProvider<List<String>>((ref) => []);

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final searchService = ref.watch(searchServiceProvider);
  return await searchService.getCategoryProducts();
});

final productsProvider = FutureProvider<Map<String, List<Product>>>((ref) async {
  final searchService = ref.watch(searchServiceProvider);
  final citySlug = ref.watch(selectedCityProvider).toLowerCase();
  final selectedCategories = ref.watch(selectedCategoriesProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

  try {
    final categories = await ref.watch(categoriesProvider.future);
    final Map<String, List<Product>> allProducts = {};

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

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchController.text = ref.read(searchQueryProvider);
  }

  void _onSearchChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      ref.read(searchQueryProvider.notifier).state = value;
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      decoration: const InputDecoration(
                        hintText: 'Что будем искать?',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune),
                    onPressed: () => _showFilterBottomSheet(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: productsAsync.when(
        data: (products) => products.isEmpty
            ? const Center(child: Text('Ничего не найдено'))
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final category = products.keys.elementAt(index);
                  final categoryProducts = products[category]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          category,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categoryProducts.length,
                        itemBuilder: (context, productIndex) {
                          final product = categoryProducts[productIndex];
                          return ListTile(
                            title: Text(product.name),
                            subtitle: Text(product.slug),
                            trailing: Text(
                              '${product.price.toStringAsFixed(0)} ₸',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Ошибка загрузки: ${error.toString()}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.refresh(productsProvider),
                  child: const Text('Попробовать снова'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const FilterBottomSheet(),
      ),
    );
  }
}

class FilterBottomSheet extends ConsumerWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final selectedCategories = ref.watch(selectedCategoriesProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Фильтры',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // City Filter
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Город',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                const ChoiceChip(
                  selected: true,
                  label: Text('Алматы'),
                  selectedColor: Colors.red,
                  labelStyle: TextStyle(color: Colors.white),
                  onSelected: null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Categories Filter
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Категории',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                categoriesAsync.when(
                  data: (categories) => Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: categories.map((category) {
                      final isSelected = selectedCategories.contains(category.name);
                      return FilterChip(
                        selected: isSelected,
                        label: Text(category.name),
                        selectedColor: Colors.red,
                        backgroundColor: Colors.grey[100],
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        onSelected: (bool selected) {
                          final notifier = ref.read(selectedCategoriesProvider.notifier);
                          if (selected) {
                            notifier.state = [...selectedCategories, category.name];
                          } else {
                            notifier.state = selectedCategories.where((name) => name != category.name).toList();
                          }
                        },
                      );
                    }).toList(),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stack) => Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ошибка загрузки категорий: $error',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => ref.refresh(categoriesProvider),
                          child: const Text('Попробовать снова'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Apply Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ref.invalidate(productsProvider);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Применить фильтры',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
