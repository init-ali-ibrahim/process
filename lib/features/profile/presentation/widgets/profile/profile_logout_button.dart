// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:process/core/util/logger.dart';
// import 'package:process/features/profile/presentation/riverpod/profile_riverpod.dart';
//
// class ProfileLogoutButton extends ConsumerWidget {
//   const ProfileLogoutButton({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: 40,
//       child: TextButton(
//         onPressed: () async {
//           try {
//             await ref.read(profileProvider.notifier).logout();
//             if (mounted) {
//               ref.refresh(profileProvider);
//             }
//           } catch (e) {
//             logger.e('e: $e');
//           }
//         },
//         style: TextButton.styleFrom(
//           elevation: 1.5,
//           backgroundColor: Colors.white,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(12),
//             ),
//           ),
//           shadowColor: Colors.grey.withOpacity(0.3),
//         ),
//         child: const Text(
//           'Выйти',
//           style: TextStyle(color: Colors.red),
//         ),
//       ),
//     );
//   }
// }