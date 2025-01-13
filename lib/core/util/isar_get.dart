import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process/core/entities/cart_product.dart';

/// Local DB (uses the "isar" package)
final isarProvider = Provider<Future<Isar>>((ref) async {
  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
    [CartProductSchema],
    directory: dir.path,
  );

  return isar;
});