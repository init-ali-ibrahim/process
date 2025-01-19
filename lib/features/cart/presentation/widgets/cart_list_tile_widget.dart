import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/entities/cart_product.dart';
import 'package:process/features/cart/presentation/riverpod/cart_riverpod.dart';

class CartListTileWidget extends ConsumerWidget {
  const CartListTileWidget({super.key, required this.product, this.onRemove});

  final CartProduct product;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartRiverpod = ref.read(cartProvider.notifier);

    return Container(
      height: 90,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
                placeholder: 'assets/image/loadingItem.jpg',
                image: product.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.red,
                    width: 70,
                    height: 70,
                  );
                }),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: const TextStyle(fontSize: 14)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('₸ ${product.price}', style: const TextStyle(fontSize: 12), softWrap: true),
                      SizedBox(
                        width: 120,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove,
                                size: 18,
                                color: Colors.grey.shade700,
                              ),
                              onPressed: () {
                                cartRiverpod.updateQuantity(product.product_id, false);
                                if (product.quantity == 1 && onRemove != null) {
                                  onRemove!();
                                }
                              },
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 100),
                              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                              child: Text(
                                product.quantity.toString(),
                                key: ValueKey<int>(product.quantity),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                size: 18,
                                color: Colors.grey.shade700,
                              ),
                              onPressed: () {
                                cartRiverpod.updateQuantity(product.product_id, true);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
