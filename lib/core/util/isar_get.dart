import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process/core/entities/cart_product.dart';

final isarProvider = StateProvider<Isar?>((ref) => null);

final isarInitializationProvider = FutureProvider<void>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [CartProductSchema],
    directory: dir.path,
  );

  ref.read(isarProvider.notifier).state = isar;
});