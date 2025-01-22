import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/util/logger.dart';
import 'package:process/features/profile/presentation/riverpod/profile_riverpod.dart';

class ProfileLogoutButtonWidget extends ConsumerStatefulWidget {
  const ProfileLogoutButtonWidget({super.key});

  @override
  ConsumerState<ProfileLogoutButtonWidget> createState() => _ProfileLogoutButtonState();
}

class _ProfileLogoutButtonState extends ConsumerState<ProfileLogoutButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: TextButton(
        onPressed: () async {
          try {
            await ref.read(profileProvider.notifier).logout();
            if (mounted) {
              ref.refresh(profileProvider);
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ошибка при выходе: $e')),
              );
            }
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
    );
  }
}