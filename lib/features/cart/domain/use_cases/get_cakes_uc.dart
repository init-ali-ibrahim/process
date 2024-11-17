import 'package:process/core/entities/product.dart';
import 'package:process/features/home/data/repositories/product_service_repo_impl.dart';

class GetFetchProductUseCase {
  final ProductServiceRepoImpl repository;

  GetFetchProductUseCase(this.repository);

  Future<Map<String, List<Product>>> call(String citySlug) async {
    return await repository.fetchProduct(citySlug);
  }
}