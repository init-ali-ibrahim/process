import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process/core/util/logger.dart';
import 'package:process/features/home/data/models/category_model.dart';
import 'package:process/features/home/data/models/product_model.dart';

class HomeService {
  late final Dio dio;
  late final Future<void> _initFuture;
  late final HiveCacheStore _cacheStore;

  HomeService() {
    _initFuture = _initDio();
  }

  Future<void> _initDio() async {
    Directory dir = await getTemporaryDirectory();
    String cachePath = '${dir.path}/dio_cache';

    _cacheStore = HiveCacheStore(cachePath);

    CacheOptions cacheOptions = CacheOptions(
      store: _cacheStore,
      policy: CachePolicy.forceCache,
      hitCacheOnErrorExcept: <int>[401, 403],
      priority: CachePriority.high,
      maxStale: const Duration(days: 7),
      keyBuilder: (RequestOptions request) {
        dynamic cityHeader = request.headers['City'] ?? 'almaty';
        return '${request.method}_${request.uri}_$cityHeader';
      },
    );

    dio = Dio(
      BaseOptions(
        baseUrl: 'https://admin.samalcakes.kz/api/v1',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
  }

  Future<void> ensureInitialized() async {
    await _initFuture;
  }

  Future<List<CategoryModel>> getCategoryProducts() async {
    await ensureInitialized();

    try {
      Response<dynamic> response = await dio.get('/categories');
      List<dynamic> data = response.data;

      return data.map((dynamic json) => CategoryModel.fromJson(json)).toList();
    } on DioException catch (e, stackTrace) {
      _logDioError(e, stackTrace);
      return <CategoryModel>[];
    } catch (e, stackTrace) {
      logger.e('Unexpected error: $e', error: e, stackTrace: stackTrace);
      return <CategoryModel>[];
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String citySlug, String category) async {
    await ensureInitialized();

    try {
      Response<dynamic> response = await dio.get(
        '/catalog/products',
        queryParameters: <String, dynamic>{'category': category},
        options: Options(
          headers: <String, dynamic>{'City': citySlug},
        ),
      );

      if (response.data == null || !response.data.containsKey('data')) {
        logger.w('bad');
        return <ProductModel>[];
      }

      List<dynamic> data = response.data['data'];

      return data.take(5).map((dynamic json) => ProductModel.fromJson(json)).toList();
    } on DioException catch (e, stackTrace) {
      _logDioError(e, stackTrace);
      return <ProductModel>[];
    } catch (e, stackTrace) {
      logger.e('Unexpected error: $e', error: e, stackTrace: stackTrace);
      return <ProductModel>[];
    }
  }

  Future<Map<String, List<ProductModel>>> getAllProducts(String citySlug) async {
    await ensureInitialized();

    try {
      List<CategoryModel> categories = await getCategoryProducts();
      Map<String, List<ProductModel>> result = <String, List<ProductModel>>{};

      for (CategoryModel category in categories) {
        if (category.name.toLowerCase() == 'свечи') continue;

        List<ProductModel> products = await getProductsByCategory(citySlug, category.slug);
        if (products.length > 3) {
          result[category.name] = products;
        }
      }

      return result;
    } on DioException catch (e, stackTrace) {
      _logDioError(e, stackTrace);
      return <String, List<ProductModel>>{};
    } catch (e, stackTrace) {
      logger.e('Unexpected error: $e', error: e, stackTrace: stackTrace);
      return <String, List<ProductModel>>{};
    }
  }

  void _logDioError(DioException e, StackTrace stackTrace) {
    logger.e(
      'DioException: ${e.message}, Status: ${e.response?.statusCode}, '
      'Data: ${e.response?.data}, Message: ${e.response?.statusMessage}, '
      'Error: ${e.error}',
      error: e,
      stackTrace: stackTrace,
    );
  }
}
