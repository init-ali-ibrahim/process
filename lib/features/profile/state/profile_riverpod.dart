import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:process/core/global/entities/user.dart';
import 'package:process/core/util/logger.dart';
import 'package:process/features/profile/data/repo/profile_repo.dart';

class ProfileState {
  final User? user;
  final bool isLoading;
  final String? error;

  const ProfileState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  ProfileState copyWith({
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepo repo;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  ProfileNotifier(this.repo) : super(const ProfileState()) {
    getUser();
  }

  Future<void> getUser() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      User? user = await repo.getUser();
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        user: null,
      );
    }
  }

  Future<void> logout() async {
    try {
      state = state.copyWith(isLoading: true);
      await storage.delete(key: 'token');
      state = const ProfileState(user: null, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final StateNotifierProvider<ProfileNotifier, ProfileState> profileStateProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((Ref ref) {
  ProfileRepo repo = ref.watch(profileRepoProvider);
  return ProfileNotifier(repo);
});
