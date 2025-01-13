import 'package:dio/dio.dart';
import 'package:process/features/home/data/models/category_model.dart';
import 'package:process/features/home/data/models/product_model.dart';

class HomeService {
  final Dio dio = Dio();

  Future<List<ProductModel>> getProductsByCategory(String citySlug, String category) async {
    try {
      final response = await dio.get(
        'https://admin.samalcakes.kz/api/v1/catalog/products',
        queryParameters: {'category': category},
        options: Options(headers: {'City': citySlug}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('statusCode: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getProductsByCategory() error: $e');
    }
  }

  Future<List<CategoryModel>> getCategoryProducts() async {
    try {
      final response = await dio.get('https://admin.samalcakes.kz/api/v1/categories');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data;
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw Exception('statusCode: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getCategoryProducts() error: $e');
    }
  }

  Future<Map<String, List<ProductModel>>> getAllProducts(String citySlug) async {
    try {
      final categories = await getCategoryProducts();
      final Map<String, List<ProductModel>> result = {};

      for (var category in categories) {
        final products = await getProductsByCategory(citySlug, category.slug);
        result[category.name] = products;
      }
      return result;
    } catch (e) {
      throw Exception('getAllProducts() error: $e');
    }
  }

  Future<List<ProductModel>> searchProducts(String citySlug, String query) async {
    try {
      final response = await dio.get(
        'https://admin.samalcakes.kz/api/v1/catalog/products',
        queryParameters: {'search': query},
        options: Options(headers: {'City': citySlug}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data;
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('statusCode: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('searchProducts() error: $e');
    }
  }
}
