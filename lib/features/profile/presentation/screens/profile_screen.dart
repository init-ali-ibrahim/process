import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/features/profile/presentation/riverpod/profile_riverpod.dart';
import 'package:process/features/profile/presentation/widgets/profile/profile_appbar_widget.dart';
import 'package:process/features/profile/presentation/widgets/profile/profile_data_section_widget.dart';
import 'package:process/features/profile/presentation/widgets/profile/profile_help_section_widget.dart';
import 'package:process/features/profile/presentation/widgets/profile/profile_logout_button_widget.dart';
import 'package:process/features/profile/presentation/widgets/profile/profile_second_section_widget.dart';
import 'package:process/features/profile/presentation/widgets/profile/profile_setting_section_widget.dart';
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
              ProfileDataSectionWidget(user: user),
              const SizedBox(height: 30),
              if (user != null) const ProfileSecondSectionWidget(),
              if (user != null) const SizedBox(height: 14),
              const ProfileSettingsSectionWidget(),
              const SizedBox(height: 14),
              const ProfileHelpSectionWidget(),
              if (user != null) const SizedBox(height: 14),
              if (user != null) const ProfileLogoutButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
