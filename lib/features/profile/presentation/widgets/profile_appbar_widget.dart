import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/util/logger.dart';

class ProfileAppbarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const ProfileAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return AppBar(
      title: const Text(
        'Профиль',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      surfaceTintColor: Colors.white,
      elevation: 1,
      shadowColor: Colors.grey.shade50,
      toolbarHeight: kToolbarHeight + 10,
      actions: [
        IconButton(
          onPressed: () async {},
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
