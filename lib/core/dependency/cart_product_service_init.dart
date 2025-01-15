// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:process/core/util/isar_get.dart';
// import 'package:process/core/util/logger.dart';
//
// Future<Widget> cartProductServiceInitWidget({required Widget child}) async {
//   final container = ProviderContainer();
//   try {
//     final isar = await container.read(isarInitializationProvider.future);
//     logger.i('Isar initialized successfully');
//     return child;
//   } catch (e) {
//     logger.e('Failed to initialize Isar: $e');
//     rethrow;
//   }
// }
