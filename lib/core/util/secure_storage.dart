// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:initMobi/core/util/logger.dart';
//
// class SecureStorageService {
//   SecureStorageService._internal();
//   factory SecureStorageService () => _instance;
//   static final SecureStorageService _instance = SecureStorageService._internal();
//
//
//   final FlutterSecureStorage _storage = const FlutterSecureStorage();
//   final String storageAccessKey = 'accessToken';
//   final String storageRefreshKey = 'refreshToken';
//
//   Future<void> saveAccessToken(String token) async {
//     try {
//       await _storage.write(key: storageAccessKey, value: token);
//     } catch (e) {
//       logger.e(e);
//       throw Exception('e: $e');
//     }
//   }
//
//   Future<void> saveRefreshToken(String token) async {
//     try {
//       await _storage.write(key: storageRefreshKey, value: token);
//     } catch (e) {
//       logger.e(e);
//       throw Exception('e: $e');
//     }
//   }
//
//   Future<String?> getAccessToken() async {
//     final token = await _storage.read(key: storageAccessKey);
//     return token;
//   }
//
//   Future<String?> getRefreshToken() async {
//     final token = await _storage.read(key: storageRefreshKey);
//     return token;
//   }
//
//   /// clear all Flutter Secure Storage data
//   Future<void> clearTokens() async {
//     try {
//       await _storage.deleteAll();
//     } catch (e) {
//       throw Exception('Error clearing tokens: $e');
//     }
//   }
// }
