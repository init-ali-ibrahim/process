import 'package:dio/dio.dart';
import 'package:process/core/util/logger.dart';
import 'package:process/features/search/data/models/category_model.dart';
import 'package:process/features/search/data/models/product_model.dart';

class SearchService {
  final Dio dio;
  final int maxRetries;

  SearchService({int? maxRetries})
      : this.dio = Dio()..interceptors.add(RetryInterceptor()),
        this.maxRetries = maxRetries ?? 3;

  Future<List<CategoryModel>> getCategoryProducts() async {
    try {
      final response = await dio.get(
        'https://admin.samalcakes.kz/api/v1/categories',
        options: Options(
          headers: {'Accept': 'application/json'},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 429) {
        final retryAfter = int.tryParse(response.headers.value('retry-after') ?? '5') ?? 5;

        await Future.delayed(Duration(seconds: retryAfter));
        return getCategoryProducts();
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data;
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load categories: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        await Future.delayed(const Duration(seconds: 5));
        return getCategoryProducts();
      }
      throw Exception('Failed to load categories: ${e.message}');
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String citySlug, String category) async {
    try {
      final response = await dio.get(
        'https://admin.samalcakes.kz/api/v1/catalog/products',
        queryParameters: {'category': category},
        options: Options(
          headers: {'City': citySlug, 'Accept': 'application/json'},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 429) {
        final retryAfter = int.tryParse(response.headers.value('retry-after') ?? '5') ?? 5;
        await Future.delayed(Duration(seconds: retryAfter));
        return getProductsByCategory(citySlug, category);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to load products: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        await Future.delayed(const Duration(seconds: 5));
        return getProductsByCategory(citySlug, category);
      }
      throw Exception('Failed to load products: ${e.message}');
    }
  }
}

class RetryInterceptor extends Interceptor {
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 429) {
      final retryAfter = int.tryParse(err.response?.headers.value('retry-after') ?? '5') ?? 5;

      await Future.delayed(Duration(seconds: retryAfter));

      try {
        final opts = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        );

        final response = await Dio().request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    }
    return handler.next(err);
  }
}