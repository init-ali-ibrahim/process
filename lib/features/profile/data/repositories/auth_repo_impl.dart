import 'package:process/features/profile/data/data_sources/auth_service_ds.dart';
import 'package:process/features/profile/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthServiceDataSource authService;

  AuthRepoImpl(this.authService);

  @override
  Future<void> login({
    required String phone,
    required String password,
  }) async {
    return await authService.loginUser(
      phone: phone,
      password: password,
    );
  }

  @override
  Future<void> register({
    required String first_name,
    required String last_name,
    required String middle_name,
    required String email,
    required String phone,
    required String password,
    required String password_confirm,
  }) async {
    return await authService.registerUser(
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