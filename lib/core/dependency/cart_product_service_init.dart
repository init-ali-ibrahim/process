import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:process/core/util/isar_get.dart';

Future cartProductServiceInitWidget({required Widget child}) async {
  final container = ProviderContainer();
  await container.read(isarInitializationProvider.future);

  return child;
}
