import 'package:flutter/material.dart';

class CartBottomWidget extends StatelessWidget {
  const CartBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          border:
          Border(top: BorderSide(width: 1, color: Color(0xFFDADADA)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Итоговая цена'),
              Text(
                '₸: }',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2))),
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'Продолжить',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
