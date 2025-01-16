import 'package:process/core/entities/product.dart';
import 'package:process/features/home/data/service/search_service.dart';

class SearchRepo {
  final SearchService service = SearchService();

  Future<Map<String, List<Product>>> getAllProducts(String citySlug) async {
    return await service.getAllProducts(citySlug);
  }

// Future<List<Product>> searchProduct(String citySlug, String query) async {
//   return await service.searchProducts(citySlug, query);
// }
}
