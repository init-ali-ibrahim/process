import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/router/routes.dart';
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
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 4),
      //     child: IconButton(
      //       onPressed: () async {},
      //       icon: const Icon(Icons.logout),
      //     ),
      //   ),
      // ],
      leading: IconButton(
        onPressed: () {
          router.pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      backgroundColor: Colors.white,
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
