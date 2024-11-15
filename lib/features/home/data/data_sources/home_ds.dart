import 'dart:convert';
import 'package:process/features/home/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class HomeDataSource {
  final http.Client client;

  HomeDataSource(this.client);

  Future<List<ProductModel>> fetchProductsTorty(String citySlug) async {
    final url = Uri.parse('https://admin.samalcakes.kz/api/v1/catalog/products?category=torty');
    final response = await client.get(url, headers: {'City': citySlug});

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data.map((item) {
          ProductModel.fromJson(item);
        }).toList();
      } else {
        throw Exception('fetchProductsTorty ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('fetchProductsTorty: $e');
    }
  }
}
