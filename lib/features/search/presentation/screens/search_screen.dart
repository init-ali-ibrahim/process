import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/router/routes.dart';
import 'package:process/features/search/presentation/riverpod/search_provider.dart';

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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 10,
        automaticallyImplyLeading: false,
        centerTitle: true,
        surfaceTintColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.grey.shade50,
        title: const Text(
          'Поиск',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () => router.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: Padding(
            padding: const EdgeInsets.all(8),
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categoryProducts.length,
                        itemBuilder: (context, productIndex) {
                          final product = categoryProducts[productIndex];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 0.5,
                                  blurRadius: 5,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: ListTile(
                              onTap: () {
                                router.pushNamed(
                                  RouteNames.singleProduct.name,
                                  extra: {'product': product},
                                );
                              },
                              contentPadding: const EdgeInsets.all(12),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  product.imageUrl,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 70,
                                      height: 70,
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    product.category,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${product.price.toStringAsFixed(0)} ₸',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[700],
                                    fontSize: 12,
                                  ),
                                ),
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
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    //   ),
    //   builder: (context) => Padding(
    //     padding: EdgeInsets.only(
    //       bottom: MediaQuery.of(context).viewInsets.bottom,
    //     ),
    //     child: const FilterBottomSheet(),
    //   ),
    // );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
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
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Города',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ChoiceChip(
                      selected: true,
                      label: Text('Алматы'),
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(color: Colors.white),
                      onSelected: null,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Категории',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
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
          // City Filter
          // Container(
          //   padding: const EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(12),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(0.1),
          //         blurRadius: 5,
          //         offset: const Offset(0, 1),
          //       ),
          //     ],
          //   ),
          //   child: const Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Город',
          //         style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //       SizedBox(height: 12),
          //       ChoiceChip(
          //         selected: true,
          //         label: Text('Алматы'),
          //         selectedColor: Colors.red,
          //         labelStyle: TextStyle(color: Colors.white),
          //         onSelected: null,
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 24),
          // // Categories Filter
          // Container(
          //   padding: const EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(12),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.black.withOpacity(0.1),
          //         blurRadius: 5,
          //         offset: const Offset(0, 1),
          //       ),
          //     ],
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text(
          //         'Категории',
          //         style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //       const SizedBox(height: 12),
          //       categoriesAsync.when(
          //         data: (categories) => Wrap(
          //           spacing: 8,
          //           runSpacing: 8,
          //           children: categories.map((category) {
          //             final isSelected = selectedCategories.contains(category.name);
          //             return FilterChip(
          //               selected: isSelected,
          //               label: Text(category.name),
          //               selectedColor: Colors.red,
          //               backgroundColor: Colors.grey[100],
          //               labelStyle: TextStyle(
          //                 color: isSelected ? Colors.white : Colors.black,
          //               ),
          //               onSelected: (bool selected) {
          //                 final notifier = ref.read(selectedCategoriesProvider.notifier);
          //                 if (selected) {
          //                   notifier.state = [...selectedCategories, category.name];
          //                 } else {
          //                   notifier.state = selectedCategories.where((name) => name != category.name).toList();
          //                 }
          //               },
          //             );
          //           }).toList(),
          //         ),
          //         loading: () => const Center(
          //           child: CircularProgressIndicator(),
          //         ),
          //         error: (error, stack) => Center(
          //           child: Column(
          //             children: [
          //               const Icon(
          //                 Icons.error_outline,
          //                 color: Colors.red,
          //                 size: 32,
          //               ),
          //               const SizedBox(height: 8),
          //               Text(
          //                 'Ошибка загрузки категорий: $error',
          //                 textAlign: TextAlign.center,
          //               ),
          //               const SizedBox(height: 8),
          //               ElevatedButton(
          //                 onPressed: () => ref.refresh(categoriesProvider),
          //                 child: const Text('Попробовать снова'),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 24),
          // Apply Button
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),

          // Container(
          //   width: double.infinity,
          //   height: 50,
          //   margin: const EdgeInsets.symmetric(horizontal: 16),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       ref.invalidate(productsProvider);
          //       Navigator.pop(context);
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.red,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //     ),
          //     child: const Text(
          //       'Применить фильтры',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 16,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width,
            height: 45,
            child: TextButton(
              onPressed: () {
                ref.invalidate(productsProvider);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                elevation: 1.5,
                backgroundColor: Colors.red,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                shadowColor: Colors.grey.withOpacity(0.3),
              ),
              child: const Text(
                'Применить фильтры',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 60)
        ],
      ),
    );
  }
}
