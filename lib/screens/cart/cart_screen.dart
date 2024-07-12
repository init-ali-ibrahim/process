import 'package:flutter/material.dart';

class cart_screen extends StatefulWidget {
  const cart_screen({super.key});

  @override
  State<cart_screen> createState() => _cart_screenState();
}

class _cart_screenState extends State<cart_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF9F9F9),
          title: const Text(
            'Cart',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Icon(
                Icons.add_a_photo_rounded,
                size: 120,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Center(
                child: Text('Your Cart is Emptyy',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30))),
            const SizedBox(
              height: 10,
            ),
            const Center(
                child: Text(
              'Looks like you have note made your choice yet',
              style: TextStyle(fontSize: 16),
            )),
            const SizedBox(
              height: 50,
            ),
            TextButton(
              onPressed: () {
                  Navigator.pushNamed(context, '/cake_create');
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFA02F7F),
                minimumSize: Size(MediaQuery.of(context).size.width - 120, 10),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6))),
              ),
              child: const Text(
                'Мake your cake',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ));
  }
}
