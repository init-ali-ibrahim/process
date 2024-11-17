import 'package:flutter/material.dart';
import 'package:process/features/cart/presentation/widgets/cart_bottom_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView(shrinkWrap: true, physics: const BouncingScrollPhysics(), children: [
          Container(
            height: 90,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                // border: Border.all(width: 1, color: const Color(0xFFDADADA))
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
                        const Text('product.name',
                            style: TextStyle(fontSize: 14)),
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
          ),
        ]),
      ),
      bottomNavigationBar: const CartBottomWidget(),
    );
  }
}
