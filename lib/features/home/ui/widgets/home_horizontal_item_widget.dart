import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:process/core/global/entities/product.dart';
import 'package:process/core/router/routes.dart';

class HomeHorizontalItemWidget extends StatelessWidget {
  const HomeHorizontalItemWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        router.pushNamed(
          RouteNames.singleProduct.name,
          extra: <String, Product>{'product': product},
        );
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        width: 175,
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                placeholder: (BuildContext context, String url) => Image.asset(
                  'assets/image/loadingItem.jpg',
                  width: 170,
                  height: 155,
                  fit: BoxFit.cover,
                ),
                errorWidget: (BuildContext context, String url, Object error) => Container(
                  color: Colors.white,
                  width: 170,
                  height: 155,
                ),
                width: 170,
                height: 155,
                fit: BoxFit.cover,
                memCacheWidth: 340,
                memCacheHeight: 310,
                cacheKey: 'product_${product.id}',
                maxWidthDiskCache: 340,
                maxHeightDiskCache: 310,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              height: 95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '₸ ${product.price}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFBB4242),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          size: 20,
                          Icons.keyboard_arrow_right,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
