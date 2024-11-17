import 'package:process/core/entities/product.dart';
import 'package:process/features/home/data/data_sources/fetch_product_service_ds.dart';
import 'package:process/features/home/domain/repositories/product_service_repo.dart';

class ProductServiceRepoImpl extends ProductServiceRepo {
  final FetchProductRemoteDataSource fetchProductRemoteDataSource;

  ProductServiceRepoImpl(this.fetchProductRemoteDataSource);

  @override
  Future<Map<String, List<Product>>> fetchProduct(String citySlug) async {
    return await fetchProductRemoteDataSource.getAllProducts(citySlug);
  }

  @override
  Future<List<Product>> searchProduct(String citySlug, String query) async {
    return await fetchProductRemoteDataSource.searchProducts(citySlug, query);
  }
}
