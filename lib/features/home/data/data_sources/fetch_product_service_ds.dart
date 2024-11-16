import 'dart:convert';
import 'package:process/features/home/data/models/category_model.dart';
import 'package:process/features/home/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class FetchProductRemoteDataSource {
  final http.Client client;

  FetchProductRemoteDataSource(this.client);

  Future<List<ProductModel>> getProductsByCategory(String citySlug, String category) async {
    try {
      final url = Uri.parse('https://admin.samalcakes.kz/api/v1/catalog/products?category=$category');
      final response = await client.get(url, headers: {'City': citySlug});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = json.decode(response.body);

        // print('getProductsByCategory() data: $data');

        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('statusCode: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getProductsByCategory() tryCatch $e');
    }
  }

  Future<List<CategoryModel>> getCategoryProducts() async {
    try {
      final url = Uri.parse('https://admin.samalcakes.kz/api/v1/categories');
      final response = await client.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = json.decode(response.body);

        // print('getCategoryProducts() data: $data');

        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw Exception('statusCode: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getCategoryProducts() tryCatch $e');
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
      throw Exception('getAllProductsByCategories() tryCatch $e');
    }
  }

  Future<List<ProductModel>> searchProducts(String citySlug, String query) async {
    try {
      final url = Uri.parse('https://admin.samalcakes.kz/api/v1/catalog/products?search=$query');
      final response = await client.get(url, headers: {'City': citySlug});

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('statusCode ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('searchProducts() tryCatch $e');
    }
  }
}
