import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:process/core/global/entities/user.dart';
import 'package:process/core/util/logger.dart';
import 'package:process/features/profile/data/service/profile_service.dart';

class ProfileRepo {
  final ProfileService service = ProfileService();
  final storage = const FlutterSecureStorage();

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    try {
      return await service.loginUser(
        phone: phone,
        password: password,
      );
    } catch (e) {
      logger.e('e: $e');
      throw Exception('e: $e');
    }
  }

  Future<void> register({
    required String first_name,
    required String last_name,
    required String email,
    required String phone,
    required String password,
    required String password_confirm,
  }) async {
    try {
      return await service.registerUser(
        first_name: first_name,
        last_name: last_name,
        email: email,
        phone: phone,
        password: password,
        password_confirm: password_confirm,
      );
    } catch (e) {
      logger.e('e: $e');
      throw Exception('e: $e');
    }
  }

  Future<User?> getUser() async {
    final token = await storage.read(key: 'token');
    if (token == null) {
      return null;
    }
    try {
      return await service.getUser();
    } catch (e) {
      logger.e('e: $e');
      throw Exception('e: $e');
    }
  }
}

final profileRepoProvider = Provider<ProfileRepo>((ref) {
  return ProfileRepo();
});
