import 'package:process/core/entities/product.dart';

abstract class ProductServiceRepo {
  Future<Map<String, List<Product>>> fetchProduct(String citySlug);
  Future<List<Product>> searchProduct(String citySlug, String query);
}