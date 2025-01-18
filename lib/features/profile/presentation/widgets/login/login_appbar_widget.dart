import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/router/routes.dart';

class RegisterAppbarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const RegisterAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text(
        'Логин',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      leading: IconButton(
        onPressed: () {
          router.pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      surfaceTintColor: Colors.white,
      elevation: 1,
      shadowColor: Colors.grey.shade50,
      toolbarHeight: kToolbarHeight + 10,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
