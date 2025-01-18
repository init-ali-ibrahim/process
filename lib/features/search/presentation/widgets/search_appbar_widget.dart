import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/router/routes.dart';
import 'package:process/features/search/presentation/widgets/search_filter_bottom_sheet.dart';

class SearchAppbarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const SearchAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      toolbarHeight: kToolbarHeight + 10,
      automaticallyImplyLeading: false,
      centerTitle: true,
      surfaceTintColor: Colors.white,
      elevation: 1,
      shadowColor: Colors.grey.shade50,
      title: const Text(
        'Пойск',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      leading: IconButton(
        onPressed: () {
          router.pop();
        },
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
                child: const TextField(
                  decoration: InputDecoration(
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
                onPressed: () {
                  showFilterMenu(context);
                },
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),

      ///
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 4),
      //     child: IconButton(
      //       onPressed: () async {},
      //       icon: const Icon(Icons.logout),
      //     ),
      //   ),
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 60 + 10);
}
