import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:process/core/util/logger.dart';

class DotEnvSetup {
  static Future<void> call() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (e) {
      logger.w(e);
    }
  }
}
