import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class Order {
  final int id;
  final String number;
  final String name;
  final String phone;
  final String status;
  final String deliveryType;
  final String address;
  final String city;
  final String orderedAt;
  final String? comments;
  final List<Ware> products;

  Order({
    required this.id,
    required this.number,
    required this.name,
    required this.phone,
    required this.status,
    required this.deliveryType,
    required this.address,
    required this.city,
    required this.orderedAt,
    this.comments,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      number: json['number'],
      name: json['name'],
      phone: json['phone'],
      status: json['status'],
      deliveryType: json['delivery_type'],
      address: json['address'],
      city: json['city'],
      orderedAt: json['ordered_at'],
      comments: json['comments'],
      products: (json['products'] as List)
          .map((productJson) => Ware.fromJson(productJson))
          .toList(),
    );
  }
}

class Ware {
  final int id;
  final int orderId;
  final int? productId;
  final int quantity;
  final double price;
  final String name;
  final String type;
  final String? color;
  final String? shape;
  final String? flavor;

  Ware({
    required this.id,
    required this.orderId,
    this.productId,
    required this.quantity,
    required this.price,
    required this.name,
    required this.type,
    this.color,
    this.shape,
    this.flavor,
  });

  factory Ware.fromJson(Map<String, dynamic> json) {
    return Ware(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      name: json['name'],
      type: json['type'],
      color: json['color'],
      shape: json['shape'],
      flavor: json['flavor'],
    );
  }
}

class _OrderScreenState extends State<OrderScreen> {
  late Future<List<Order>> _orders;

  @override
  void initState() {
    super.initState();
    _orders = fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заказы'),
      ),
      body: FutureBuilder<List<Order>>(
        future: _orders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Пока заказов нет'));
          }

          final orders = snapshot.data!;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ExpansionTile(
                  title: Text('Заказ #${order.number} - ${order.name}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Номер телефона: ${order.phone}'),
                      Text('Status: ${order.status}'),
                      Text('Delivery Type: ${order.deliveryType}'),
                      Text('Address: ${order.address}'),
                      Text('City: ${order.city}'),
                      Text('Ordered At: ${order.orderedAt}'),
                      if (order.comments != null)
                        Text('Comments: ${order.comments!}'),
                    ],
                  ),
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Products:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: order.products.length,
                      itemBuilder: (context, productIndex) {
                        final product = order.products[productIndex];
                        return ListTile(
                          title: Text('${product.name} (${product.type})'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Quantity: ${product.quantity}'),
                              Text('Price: ${product.price}'),
                              if (product.color != null)
                                Text('Color: ${product.color!}'),
                              if (product.shape != null)
                                Text('Shape: ${product.shape!}'),
                              if (product.flavor != null)
                                Text('Flavor: ${product.flavor!}'),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Future<List<Order>> fetchOrders() async {
  final storage = const FlutterSecureStorage();
  String? tokenAuth = await storage.read(key: 'token');
  final response = await http.get(
    Uri.parse('http://192.168.0.219:80/api/v1/orders'),
    headers: {
      'Authorization': 'Bearer $tokenAuth',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((order) => Order.fromJson(order)).toList();
  } else {
    throw Exception('Failed to load orders');
  }

}
