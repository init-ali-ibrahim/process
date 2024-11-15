import 'package:process/features/home/data/data_sources/home_ds.dart';
import 'package:process/features/home/data/models/product_model.dart';
import 'package:process/features/home/domain/repositories/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeDataSource homeDataSource;

  HomeRepoImpl(this.homeDataSource);

  @override
  Future<List<ProductModel>> fetchProduct(String citySlug) async {
    return await homeDataSource.fetchProductsTorty(citySlug);
  }
}
