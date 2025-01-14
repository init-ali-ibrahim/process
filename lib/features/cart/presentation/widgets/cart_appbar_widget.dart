import 'package:flutter/material.dart';

class ChatAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Корзина'),
      centerTitle: true,
      surfaceTintColor: Colors.white,
      elevation: 1,
      shadowColor: Colors.grey.shade50,
      toolbarHeight: kToolbarHeight + 10,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete_outline),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
