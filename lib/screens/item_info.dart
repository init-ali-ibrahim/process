import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:process/color.dart';
import 'package:process/screens/cartTest.dart';
import 'package:process/screens/navbar.dart';

class itemInfo extends StatefulWidget {
  const itemInfo({super.key});

  @override
  State<itemInfo> createState() => _itemInfoState();
}

class _itemInfoState extends State<itemInfo> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    String cash = args['cash'];
    var cleanString = cash.replaceAll(" ", "");
    var price = double.parse(cleanString);

    return Scaffold(
      appBar: AppBar(
        title: Text(args['title']),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                args['img'],
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color(0xE3FFE3E3)),
            child: Text(args['type']),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width - 40, 50),
              ),
              onPressed: () {
                var productItem = Product(args['title'], price, 'pies', 'pies', args['type'], args['img']);

                context.read<CartBloc>().add(AddProduct(productItem));

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => navbar(initialPageIndex: 1)),
                      (Route<dynamic> route) => false,
                );
              },
              child: Text('В корзину за ${args['cash']} ₸', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
