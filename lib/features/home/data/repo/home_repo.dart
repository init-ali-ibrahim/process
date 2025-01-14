import 'package:process/core/entities/product.dart';
import 'package:process/features/home/data/service/home_service.dart';

class HomeRepo {
  final HomeService service = HomeService();

  Future<Map<String, List<Product>>> getAllProducts(String citySlug) async {
    return await service.getAllProducts(citySlug);
  }

  // Future<List<Product>> searchProduct(String citySlug, String query) async {
  //   return await service.searchProducts(citySlug, query);
  // }
}
