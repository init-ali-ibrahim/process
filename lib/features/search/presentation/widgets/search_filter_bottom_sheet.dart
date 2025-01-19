import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/entities/category.dart';
import 'package:process/features/search/data/service/search_service.dart';
import 'package:process/features/search/presentation/riverpod/search_provider.dart';

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final searchService = SearchService();
  return await searchService.getCategoryProducts();
});

final selectedCategoriesProvider = StateProvider<List<String>>((ref) => []);

void showFilterMenu(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Consumer(
        builder: (context, ref, child) {
          final categoriesAsync = ref.watch(categoriesProvider);
          final selectedCategories = ref.watch(selectedCategoriesProvider);

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
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
                  // City Filter (статичный для Алматы)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 1),
                          blurRadius: 5,
                          spreadRadius: 1.5,
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
                          onSelected: null, // Disabled since we only use Almaty
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Categories Filter
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 1),
                          blurRadius: 5,
                          spreadRadius: 1.5,
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
                            spacing: 12,
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
                                  if (selected) {
                                    ref.read(selectedCategoriesProvider.notifier)
                                        .state = [...selectedCategories, category.name];
                                  } else {
                                    ref.read(selectedCategoriesProvider.notifier)
                                        .state = selectedCategories
                                        .where((name) => name != category.name)
                                        .toList();
                                  }
                                },
                              );
                            }).toList(),
                          ),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (error, stack) => Center(
                            child: Text('Ошибка загрузки категорий: $error'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Apply Filters Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        // Обновляем поиск при применении фильтров
                        ref.invalidate(searchResultsProvider);
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Применить фильтры',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}