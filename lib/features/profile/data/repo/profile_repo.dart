import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/entities/user.dart';
import 'package:process/features/profile/data/service/profile_service.dart';

class ProfileRepo {
  final ProfileService service = ProfileService();

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    return await service.loginUser(
      phone: phone,
      password: password,
    );
  }

  Future<void> register({
    required String first_name,
    required String last_name,
    required String email,
    required String phone,
    required String password,
    required String password_confirm,
  }) async {
    return await service.registerUser(
      first_name: first_name,
      last_name: last_name,
      email: email,
      phone: phone,
      password: password,
      password_confirm: password_confirm,
    );
  }

  Future<User?> getUser() async{
    return await service.getUser();
  }
}

final profileRepoProvider = Provider((ref) => ProfileRepo());
