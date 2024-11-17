import 'package:isar/isar.dart';

part 'cart_product.g.dart';

@collection
class CartProduct {
  Id id = Isar.autoIncrement;
  final int product_id;
  final String name;
  final String slug;
  final int quantity;
  final String category;

  final String flavor;
  final String shape;
  final String colour;

  CartProduct({
    required this.product_id,
    required this.name,
    required this.slug,
    required this.quantity,
    required this.category,

    required this.flavor,
    required this.shape,
    required this.colour,
  });
}