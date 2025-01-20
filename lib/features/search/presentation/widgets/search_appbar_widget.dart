import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/router/routes.dart';
import 'package:process/features/search/presentation/riverpod/search_provider.dart';
import 'package:process/features/search/presentation/widgets/search_filter_bottom_sheet.dart';

class SearchAppbarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const SearchAppbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 70);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = TextEditingController(text: ref.watch(searchQueryProvider));

    return AppBar(
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
        preferredSize: const Size.fromHeight(kToolbarHeight + 10 + 50 + 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  // controller: searchController,
                  onChanged: (value) {
                    // ref.read(searchQueryProvider.notifier).state = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Что будем искать?',
                    hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.tune),
                onPressed: () => showFilterMenu(context, ref),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
