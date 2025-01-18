import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:process/core/util/logger.dart';

class ProfileService {
  final Dio dio = Dio();

  Future<void> loginUser({
    required String phone,
    required String password,
  }) async {
    const url = 'https://go-auth.srv/api/auth/login';
    final Map<String, dynamic> body = {
      "phone": phone,
      "password": password,
    };

    logger.i(body);

    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('Data fetched successfully: ${response.data}');
      } else {
        logger.i(response.data);
        throw Exception('LoginService() loginUser() statusCode ${response.statusCode}');
      }
    } catch (e) {
      logger.i('Error in loginUser: $e');
      rethrow;
    }
  }

  ///
  ///
  ///
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
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
      "phone": phone,
      "password": password,
      "password_confirm": password_confirm,
    };

    logger.i(body);

    try {
      final response = await dio.post(
        baseUrl,
        data: jsonEncode(body),
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('good: ${response.data}');
      } else {
        logger.i(response.data);
        throw Exception('e: ${response.statusCode}');
      }
    } catch (e) {
      logger.i('e: $e');
      rethrow;
    }
  }
}
