import 'package:process/features/profile/data/repositories/auth_repo_impl.dart';

class LoginUseCase {
  final AuthRepoImpl repo;

  LoginUseCase(this.repo);

  Future<void> call({
    required String phone,
    required String password,
  }) async {
    return await repo.login(
      phone: phone,
      password: password,
    );
  }
}