import 'package:isar/isar.dart';

part 'cart_product.g.dart';

@collection
class CartProduct {
  Id id = Isar.autoIncrement;
  int quantity;
  final int product_id;
  final int price;
  final String name;
  final String slug;
  final String category;
  final String imageUrl;
  
  final String flavor;
  final String shape;
  final String colour;

  CartProduct({
    required this.product_id,
    required this.price,
    required this.name,
    required this.slug,
    required this.quantity,
    required this.category,
    required this.imageUrl,

    required this.flavor,
    required this.shape,
    required this.colour,
  });
}
