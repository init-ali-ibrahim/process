import 'package:flutter/material.dart';
import 'package:process/core/entities/product.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.red),
            onPressed: () => Navigator.pop(context),
            color: Colors.white,
            style: IconButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.5)),
          ),
          // title: Text(product.name),
          // centerTitle: true,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              FadeInImage.assetNetwork(
                  placeholder: 'assets/image/loadingItem.jpg',
                  image: 'img',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.3,
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.red,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.3
                    );
                  }),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3.4,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(product.name,
                                    style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Text('₸ ${product.quantity}',
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600)),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width - 40, 52),
                          ),
                          onPressed: () {},
                          child: const Text('В корзину',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
