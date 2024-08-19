import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderScreen extends StatelessWidget {
  final User user;

  OrderScreen({required this.user});

  Future<Map<String, dynamic>> fetchCartData() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final docSnapshot = await firestore.collection('users').doc(user.uid).get();
    return docSnapshot.data() ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Просмотр данных'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchCartData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет данных для отображения.'));
          }

          final data = snapshot.data!;
          final cartData = data['cart'] as List<dynamic>;
          final totalPrice = data['totalPrice'] as double;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'стоимость: $totalPrice',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...cartData.map((item) {
                final product = item['product'];
                final quantity = item['quantity'];
                return ListTile(
                  title: Text(product['name']),
                  subtitle: Text(
                    'flavor: ${product['flavor']}\n'
                    'price: ${product['price']} за единицу\n'
                    'colour: ${product['colour']}\n'
                    'shape: ${product['shape']}\n'
                    'quantity: $quantity\n'
                    'total price: ${quantity * product['price']}',
                  ),
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}
