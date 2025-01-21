import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:process/core/util/logger.dart';
import 'package:process/features/profile/data/models/user_model.dart';

class ProfileService {
  final Dio dio = Dio();
  final storage = const FlutterSecureStorage();

  Future<void> loginUser({
    required String phone,
    required String password,
  }) async {
    const baseUrl = 'https://admin.samalcakes.kz/api/v1/auth/login';

    final Map<String, dynamic> body = {
      "phone": phone,
      "password": password,
    };

    final Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.post(
        baseUrl,
        data: jsonEncode(body),
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final token = data['token'];
        await storage.write(key: 'token', value: token);
      } else {
        logger.e('e: ${response.statusCode}');
        throw Exception('e: ${response.statusCode}');
      }
    } on DioException catch (e) {
      logger.e('e: ${e.response}');
      throw Exception('e: ${e.message}');
    }
  }

  Future<void> registerUser({
    required String first_name,
    required String last_name,
    required String email,
    required String phone,
    required String password,
    required String password_confirm,
  }) async {
    const baseUrl = 'https://admin.samalcakes.kz/api/v1/auth/register';

    final Map<String, dynamic> body = {
      "name": first_name,
      "last_name": last_name,
      "phone": phone,
      "email": email,
      "password": password,
      "password_confirmation": password_confirm,
    };

    final Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.post(
        baseUrl,
        data: jsonEncode(body),
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final token = data['token'];
        await storage.write(key: 'token', value: token);
      } else {
        logger.e('e: ${response.statusCode}');
        throw Exception('e: ${response.statusCode}');
      }
    } on DioException catch (e) {
      logger.e('e: ${e.response}');
      throw Exception('e: ${e.message}');
    }
  }

  Future<UserModel?> getUser() async {
    const baseUrl = 'https://admin.samalcakes.kz/api/v1/auth/check';

    final token = await storage.read(key: 'token');
    if (token == null) {
      return null;
    }
    final Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await dio.post(
        baseUrl,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        return UserModel.fromJson(data['data']);
      } else {
        logger.e('e: ${response.statusCode}');
        throw Exception('e: ${response.statusCode}');
      }
    } on DioException catch (e) {
      logger.e('e: ${e.response}');
      throw Exception('e: ${e.message}');
    }
  }
}
