// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class ProductService {
//   final String baseUrl;
//   final String citySlug;
//
//   ProductService(this.baseUrl, this.citySlug);
//
//   Future<List<Product>> fetchProducts() async {
//     final url = Uri.parse('$baseUrl/api/v1/catalog/products');
//     final response = await http.get(
//       url,
//       headers: {
//         'City': citySlug, // Добавляем город в заголовок
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final products = (data['data'] as List)
//           .map((item) => Product.fromJson(item))
//           .toList();
//       return products;
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
// }
//
// class Product {
//   final int id;
//   final String name;
//   final String slug;
//   final int price;
//   final String category;
//   final String city;
//   final List<String> images;
//   final int quantity;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.price,
//     required this.category,
//     required this.city,
//     required this.images,
//     required this.quantity,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       name: json['name'],
//       slug: json['slug'],
//       price: json['price'],
//       category: json['category'],
//       city: json['city'],
//       images: List<String>.from(json['images']),
//       quantity: json['quantity'],
//     );
//   }
// }
