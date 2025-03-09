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

    // Инициализация хранилища кэша
    _cacheStore = HiveCacheStore(cachePath);

    CacheOptions cacheOptions = CacheOptions(
      store: _cacheStore,
      policy: CachePolicy.refreshForceCache,
      // Обновляем кэш при успешном запросе, но всегда используем кэш сначала
      hitCacheOnErrorExcept: <int>[401, 403],
      priority: CachePriority.high,
      maxStale: const Duration(days: 7),
      keyBuilder: (request) {
        // Создаем уникальный ключ, учитывая headers, особенно City
        final cityHeader = request.headers['City'] ?? 'almaty';
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

    // Добавляем interceptor кэширования
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));

    // Опционально: добавляем логирование запросов
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (log) => logger.d(log),
    ));
  }

  /// Убедитесь, что Dio инициализирован перед использованием
  Future<void> ensureInitialized() async {
    await _initFuture;
  }

  /// Получить все категории
  Future<List<CategoryModel>> getCategoryProducts() async {
    await ensureInitialized();

    try {
      Response<dynamic> response = await dio.get('/categories');
      List<dynamic> data = response.data;

      logger.i('Получены категории: ${data.length}');
      return data.map((dynamic json) => CategoryModel.fromJson(json)).toList();
    } on DioException catch (e, stackTrace) {
      _logDioError(e, stackTrace);
      return <CategoryModel>[];
    } catch (e, stackTrace) {
      logger.e('Unexpected error: $e', error: e, stackTrace: stackTrace);
      return <CategoryModel>[];
    }
  }

  /// Получить продукты по категории
  Future<List<ProductModel>> getProductsByCategory(String citySlug, String category) async {
    await ensureInitialized();

    try {
      Response<dynamic> response = await dio.get(
        '/catalog/products',
        queryParameters: <String, dynamic>{'category': category},
        options: Options(
          headers: <String, dynamic>{'City': citySlug},
          // Можно переопределить настройки кэша для конкретного запроса
          // extra: {...}
        ),
      );

      if (response.data == null || !response.data.containsKey('data')) {
        logger.w('Некорректный формат ответа для $category');
        return <ProductModel>[];
      }

      List<dynamic> data = response.data['data'];
      logger.i('Получены продукты для категории $category: ${data.length}');

      return data.take(5).map((dynamic json) => ProductModel.fromJson(json)).toList();
    } on DioException catch (e, stackTrace) {
      _logDioError(e, stackTrace);
      return <ProductModel>[];
    } catch (e, stackTrace) {
      logger.e('Unexpected error: $e', error: e, stackTrace: stackTrace);
      return <ProductModel>[];
    }
  }

  /// Получить все продукты по всем категориям
  Future<Map<String, List<ProductModel>>> getAllProducts(String citySlug) async {
    await ensureInitialized();

    try {
      List<CategoryModel> categories = await getCategoryProducts();
      Map<String, List<ProductModel>> result = <String, List<ProductModel>>{};

      logger.i('Загрузка продуктов для ${categories.length} категорий');

      for (CategoryModel category in categories) {
        if (category.name.toLowerCase() == 'свечи') continue;

        List<ProductModel> products = await getProductsByCategory(citySlug, category.slug);
        if (products.length > 3) {
          result[category.name] = products;
          logger.i('Добавлены ${products.length} продуктов в категорию ${category.name}');
        }
      }

      logger.i('Загружены продукты для ${result.length} категорий');
      return result;
    } on DioException catch (e, stackTrace) {
      _logDioError(e, stackTrace);
      return <String, List<ProductModel>>{};
    } catch (e, stackTrace) {
      logger.e('Unexpected error: $e', error: e, stackTrace: stackTrace);
      return <String, List<ProductModel>>{};
    }
  }

  /// Очистить кэш
  Future<void> clearCache() async {
    await ensureInitialized();
    await _cacheStore.clean();
    logger.i('Кэш очищен');
  }

  /// Очистить кэш для конкретного запроса
  Future<void> invalidateCacheForRequest(String path,
      {Map<String, dynamic>? queryParams, String? citySlug}) async {
    await ensureInitialized();

    final uri = Uri.parse('${dio.options.baseUrl}$path');
    final request = RequestOptions(
      path: path,
      queryParameters: queryParams,
      headers: citySlug != null ? {'City': citySlug} : null,
    );

    // Используем тот же keyBuilder, что и в опциях кэша
    final cityHeader = request.headers['City'] ?? 'default_city';
    final cacheKey = '${request.method}_${uri}_$cityHeader';

    await _cacheStore.delete(cacheKey);
    logger.i('Кэш для $path ($citySlug) инвалидирован');
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
