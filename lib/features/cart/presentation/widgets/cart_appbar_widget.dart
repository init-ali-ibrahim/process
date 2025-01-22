import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/service/cart_product_service.dart';
import 'package:process/core/util/logger.dart';
import 'package:process/core/util/scaffold_messenger.dart';

class CartAppbarWidget extends ConsumerWidget implements PreferredSizeWidget {
  const CartAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartService = ref.read(cartProductServiceProvider);

    return AppBar(
      title: const Text('Корзина', style: TextStyle(fontWeight: FontWeight.w500),),
      centerTitle: true,
      surfaceTintColor: Colors.white,
      elevation: 1,
      shadowColor: Colors.grey.shade50,
      toolbarHeight: kToolbarHeight + 10,
      actions: [
        IconButton(
          onPressed: () async {
            showScaffoldMessenger(context: context, lottieAssetsJson: 'assets/anima/bin.json', textContent: 'da');
            try {
              await cartService.clearCartProducts();
            } catch (e) {
              logger.e('e :$e');
            }
          },
          icon: const Icon(Icons.delete_outline),
        ),
      ],
    );
  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const Center(
          child: CustomAlertDialog(),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Очистить корзину?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Назад'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Очистить'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}