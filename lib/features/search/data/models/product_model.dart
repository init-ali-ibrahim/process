import 'package:process/core/global/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required int id,
    required String name,
    required String slug,
    required int price,
    required int quantity,
    required String category,
    required String imageUrl,
  }) : super(
          id: id,
          name: name,
          slug: slug,
          price: price,
          quantity: quantity,
          category: category,
          imageUrl: imageUrl,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      price: json['price'],
      quantity: json['quantity'],
      category: json['category'],
      imageUrl: json['images'][0],
    );
  }
}
