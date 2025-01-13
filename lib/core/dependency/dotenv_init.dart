import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:process/core/util/logger.dart';

class DotEnvInit {
  static Future<void> setup() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      logger.w("_loadEnvVariables() bad: $e !");
    }
  }
}
