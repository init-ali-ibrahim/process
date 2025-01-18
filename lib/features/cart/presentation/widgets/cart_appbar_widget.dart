import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:process/core/service/cart_product_service.dart';
import 'package:process/core/util/logger.dart';

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
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(
            //     content: ScafTest(),
            //     backgroundColor: Colors.white,
            //     behavior: SnackBarBehavior.floating,
            //     dismissDirection: DismissDirection.horizontal,
            //   ),
            // );
            // try {
            //   await cartService.clearCartProducts();
            // } catch (e) {
            //   logger.e('e :$e');
            // }
          },
          icon: const Icon(Icons.delete_outline),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}



///
class ScafTest extends StatefulWidget {
  const ScafTest({super.key});

  @override
  State<ScafTest> createState() => _ScafTestState();
}

class _ScafTestState extends State<ScafTest> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Lottie.asset(
          fit: BoxFit.fitHeight,
          height: 40,
          'assets/anima/trash3.json',
          controller: _controller,
          onLoaded: (composition) {
            _controller.duration = composition.duration;

            _controller.forward();
          },
        ),
        const SizedBox(width: 8),
        const Text(
          'Корзина пуста',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}