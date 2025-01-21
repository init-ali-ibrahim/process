import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/features/profile/presentation/riverpod/profile_riverpod.dart';
import 'package:process/features/profile/presentation/widgets/profile/profile_appbar_widget.dart';
import 'package:process/features/profile/presentation/widgets/profile/profile_data_section.dart';
import 'package:process/features/profile/presentation/widgets/profile/second_section.dart';
import 'package:process/features/profile/presentation/widgets/profile/settings_section.dart';
import 'package:process/core/util/logger.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final user = profileState.user;

    if (profileState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (profileState.error != null) {
      return Scaffold(
        body: Center(
          child: Text('Ошибка: ${profileState.error}'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const ProfileAppbarWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 14),
              ProfileDataSection(user: user),
              const SizedBox(height: 30),
              if (user != null) const SecondSection(),
              if (user != null) const SizedBox(height: 14),
              const SettingsSection(),


              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: TextButton(
                  onPressed: () async {
                    try {
                      await ref.read(profileProvider.notifier).logout();
                      ref.refresh(profileProvider);

                    } catch (e) {
                      logger.e('e: $e');
                    }
                  },
                  style: TextButton.styleFrom(
                    elevation: 1.5,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    shadowColor: Colors.grey.withOpacity(0.3),
                  ),
                  child: const Text(
                    'Выйти',
                    style: TextStyle(color: Colors.red),
                  ),
                ),


              ),
            ],
          ),
        ),
      ),
    );
  }
}
