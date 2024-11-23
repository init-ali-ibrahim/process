import 'package:flutter/material.dart';

class CartListTileWidget extends StatelessWidget {
  const CartListTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                    placeholder: 'assets/image/loadingItem.jpg',
                    image: 'product.urlImage',
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
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('product.name', style: TextStyle(fontSize: 14)),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Text('₸ }',
                        style: TextStyle(fontSize: 12), softWrap: true),
                  )
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, size: 18),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 2),
                  const Text(
                    '',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(width: 2),
                  IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
