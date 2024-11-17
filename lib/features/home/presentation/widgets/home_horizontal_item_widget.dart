import 'package:flutter/material.dart';
import 'package:process/core/entities/product.dart';
import 'package:process/features/home/presentation/screens/detail_product_screen.dart';

class HomeHorizontalItemWidget extends StatelessWidget {
  const HomeHorizontalItemWidget({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProductScreen(product: product),
          ),
        );
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        width: 175,
        child: Column(
          children: [
            product.quantity == 1
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                        placeholder: 'assets/image/loadingItem.jpg',
                        image: 'assets/image/loadingItem.jpg',
                        width: 170,
                        height: 155,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.white,
                            width: 170,
                            height: 155,
                          );
                        }),
                    // Image.network(widget.img),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                        placeholder: 'assets/image/loadingItem.jpg',
                        image: 'product.id',
                        width: 170,
                        height: 155,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.white,
                            width: 170,
                            height: 155,
                          );
                        }),
                    // Image.network(widget.img),
                  ),
            Container(
              padding: const EdgeInsets.all(8),
              height: 95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        product.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.quantity == 'null'
                            ? '₸ 0'
                            : '₸ ${product.quantity}',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFBB4242)),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFBB4242),
                              borderRadius: BorderRadius.circular(4)),
                          child: const Icon(
                            size: 19,
                            Icons.add,
                            color: Colors.white,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
