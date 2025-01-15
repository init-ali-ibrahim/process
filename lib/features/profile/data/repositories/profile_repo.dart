
import 'package:process/features/profile/data/data_sources/profile_service.dart';

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
    required String middle_name,
    required String email,
    required String phone,
    required String password,
    required String password_confirm,
  }) async {
    return await service.registerUser(
      first_name: first_name,
      last_name: last_name,
      middle_name: middle_name,
      email: email,
      phone: phone,
      password: password,
      password_confirm: password_confirm,
    );
  }
}