import 'package:process/core/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String title,
    required String description,
    required double price,
    required String currency,
    required int quantity,
    required String category,
    required String imageUrl,
  }) : super(
    title: title,
    description: description,
    price: price,
    currency: currency,
    quantity: quantity,
    category: category,
    imageUrl: imageUrl,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      title: json['title'],
      description: json['description'],
      price: json['price'],
      currency: json['currency'],
      quantity: json['quantity'],
      category: json['category'],
      imageUrl: json['imageUrl'],
    );
  }
}

