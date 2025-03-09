import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/global/entities/cart_product.dart';
import 'package:process/core/global/entities/product.dart';
import 'package:process/core/router/routes.dart';
import 'package:process/core/util/logger.dart';
import 'package:process/core/util/nil_protect.dart';
import 'package:process/features/cart/presentation/riverpod/cart_riverpod.dart';

class DetailProductScreen extends ConsumerWidget {
  const DetailProductScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CartNotifier cartRiverpod = ref.read(cartProvider.notifier);

    CartProduct cartProduct = CartProduct(
      category: product.category,
      name: product.name,
      product_id: product.id,
      quantity: 1,
      slug: product.slug,
      price: product.price,
      shape: nilProtect.string,
      colour: nilProtect.string,
      flavor: nilProtect.string,
      imageUrl: product.imageUrl,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.redAccent),
          onPressed: () => router.pop(context),
          style: IconButton.styleFrom(backgroundColor: Colors.white.withValues(alpha: 0.8)),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Hero(
          tag: 'product_imageUrl_${product.id}',
          child: Material(
            type: MaterialType.transparency,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    placeholder: (BuildContext context, String url) => Image.asset(
                      'assets/image/loadingItem.jpg',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.34,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (BuildContext context, String url, Object error) => Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.34,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.6,
                    fit: BoxFit.fitHeight,
                    memCacheWidth: 800,
                    memCacheHeight: 800,
                    cacheKey: 'product_${product.id}',
                    maxWidthDiskCache: 800,
                    maxHeightDiskCache: 800,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.4,
                    decoration:
                        BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                '₸ ${product.price}',
                                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: Size(MediaQuery.of(context).size.width - 40, 52),
                            ),
                            onPressed: () {
                              try {
                                cartRiverpod.addCartProduct(cartProduct);
                                router.pop();
                              } catch (e) {
                                logger.e('e: $e');
                              }
                            },
                            child: const Text(
                              'В корзину',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
